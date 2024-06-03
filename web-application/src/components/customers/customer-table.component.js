import React, { Component } from "react";
import CustomerRow from "./customer-row.component";

function CustomerTable({ customers }) {
    return (
        <div className="card shadow-lg p-3 bg-white rounded h-100 p-5">
            <div className="card-body  h-100">
                <table className="table">
                    <thead>
                        <tr>
                            <th scope="col">Customer Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Birthday</th>
                            <th scope="col">Address</th>
                            <th scope="col">Register date</th>
                            <th scope="col">First loan date</th>
                        </tr>
                    </thead>
                    <tbody>
                        {customers?.map((item) => (
                            <CustomerRow key={item.customer_id} item={item} />
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default CustomerTable