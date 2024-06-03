import React, { Component } from "react";
import { BrowserRouter , Routes, Route, Link } from "react-router-dom";
import "./App.css";
import "tailwindcss/tailwind.css"
import TutorialsList from "./components/customers/customer-list.component";
import TableList from "./components/tables/table-list.component";
import CustomerDetail from "./components/customers/customer-detail.component";

class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <div className="container h-100">
          <Routes>
            <Route exact path="/" element={<TableList/>} />
            <Route exact path="/customers" element={<TutorialsList/>} />
            <Route exact path="/detail" element={<CustomerDetail/>} />
          </Routes>
        </div>
      </BrowserRouter>
    );
  }
}

export default App;
