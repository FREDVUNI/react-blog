import './App.css';
import Navigation from './components/Navigation';
import {BrowserRouter as Router,Routes,Route} from 'react-router-dom'
import Home from './pages/Home'
import Contact from './pages/Contact'
import Blog from './pages/Blog'
import Login from './pages/Login'

function App() {
  let user = {
    firstName:"Fred",
    lastName:"vuni"
  }
  return (
    <>
      <Router>
        <Navigation user={user}/>
        <Routes>
          <Route path="/" element={<Home/>}/>
          <Route path="/contact" element={<Contact/>}/>
          <Route path="/blog" element={<Blog/>}/>
          <Route path="/login" element={<Login/>}/>
        </Routes>
      </Router>
    </>
  );
}

export default App;
