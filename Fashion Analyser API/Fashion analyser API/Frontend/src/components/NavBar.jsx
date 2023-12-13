import './NavBar.css'
import './Home.css'
import React from 'react'

function NavBar() {
  const name = "PSIT";
  const clickHandler = () => {
    console.log('button clicked');
  }
  return (
    <>
       <h1>this is {name} from NavBar.jsx</h1>
       <h2>this is {console.log('hello')} from NavBar.jsx</h2>
       <button onClick={clickHandler}>click me</button>
    </>
  )
}

export default NavBar
