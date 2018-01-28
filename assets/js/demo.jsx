import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';
import _ from 'lodash/fp'

export default function run_demo(root) {
  ReactDOM.render(<Demo/>, root);
}

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clicks: 0,
      letters: this.randomizeLetters(),
      completed: [],
      checkIndex: undefined,
      confirmIndex: undefined,
    };
    this.toggle = this.toggle.bind(this);
    this.afterToggle = this.afterToggle.bind(this);
    this.reset = this.reset.bind(this);
  }

  reset() {
    this.setState({
      clicks: 0,
      completed: [],
      checkIndex: undefined,
      confirmIndex: undefined,
      letters: this.randomizeLetters(),
    })
  }

  randomizeLetters() {
    const letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    return _.shuffle(letters.concat(letters));
  }

  afterToggle() {
    const { confirmIndex, checkIndex, letters, completed } = this.state;
    const interval = setInterval(() => {
      this.setState({
        completed: letters[confirmIndex] === letters[checkIndex]
          ? completed.concat([letters[checkIndex]])
          : completed,
        checkIndex: undefined,
        confirmIndex: undefined,
      });
    }, 1000);
    setTimeout(() => clearInterval(interval), 1000)
  }

  toggle(i) {
    const { clicks, confirmIndex, checkIndex } = this.state;
    if (_.isUndefined(checkIndex)) {
      this.setState({
        checkIndex: i,
        clicks: clicks + 1,
      })
    } else if (_.isUndefined(confirmIndex)) {
      this.setState({
        confirmIndex: i,
        clicks: clicks + 1,
      }, this.afterToggle);
    }
  }

  render() {
    const { letters, clicks, completed, checkIndex, confirmIndex } = this.state;
    return (
      <div className="memory-game">
        <div>clicks {clicks}</div>
        <Button onClick={this.reset}>Reset</Button>
        <div className="memory-game-grid">
          {this.state.letters.map((letter, i) =>
            <Side
              letter={letter}
              key={i}
              i={i}
              visible={checkIndex === i || confirmIndex === i}
              completed={completed.includes(letter)}
              toggle={this.toggle}
            />
          )}
        </div>
      </div>
    );
  }
}

function Side(props) {
  const { visible, completed, i, letter, toggle } = props
  return (
    <div className="memory-game-tile">
      {visible
        ? letter
        : completed
          ? 'complete'
          : <Button onClick={() => toggle(i)}>Click Me</Button>
      }
    </div>
  )
}

