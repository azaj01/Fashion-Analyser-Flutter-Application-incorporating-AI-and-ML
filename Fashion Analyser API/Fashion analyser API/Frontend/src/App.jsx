import './App.css';
import NavBar from './components/NavBar' ;
import Datatypes from './components/Datatypes';
function App() {
  const name = "Kavya"
  return (
    <div className="App">
      <NavBar/>
      <Datatypes/>
      <p> this is what App.jsx returns! name {name}</p>
    </div>
  );
}

export default App;
