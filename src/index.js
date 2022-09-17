import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './assets/scss/base.scss';
import 'antd/dist/antd.min.css'
import '@quasar/extras/ionicons-v4/ionicons-v4.css'

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
