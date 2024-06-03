import React, { Component } from "react";
import { Link } from "react-router-dom";

function CustomerRow({ item }) {
  const {
    customer_id, full_name, date_of_birth,
    address, customer_register_date, total_interest } = item

    const formatDate = (dateString) => {
      if(!dateString) return dateString;

      const date = new Date(dateString);
      const day = date.getDate().toString().padStart(2, '0');
      const month = (date.getMonth() + 1).toString().padStart(2, '0');
      const year = date.getFullYear();
    
      return `${day}/${month}/${year}`;
    };

  return (
    <tr>
      <td>
        <Link to={"/detail"} className="btn btn-link">
          {customer_id}
        </Link>
      </td>
      <td>{full_name}</td>
      <td>{formatDate(date_of_birth)}</td>
      <td>{address}</td>
      <td>{formatDate(customer_register_date)}</td>
      <td>{total_interest}</td>
    </tr>
  );
}

export default CustomerRow