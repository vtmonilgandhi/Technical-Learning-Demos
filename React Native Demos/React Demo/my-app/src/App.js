import React from 'react';
import logo from './logo.svg';
import './App.css';
/*
function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}
*/

// Like Button Demo

class App extends React.Component { 
  constructor(props) {
    super(props)
    this.state = {liked: false}
    this.handleClick = this.handleClick.bind(this)
  }

  handleClick(event) {
    this.setState(
      {liked: !this.state.liked}
    )
  }

  render() {

    var text = this.state.liked ? 'like' : 'have not liked !'
    return(
      <p>
        You {text} this. Click to toggle.
      </p>
    );
  }
}

export default App;

