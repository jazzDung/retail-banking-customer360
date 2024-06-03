import React, { Component } from "react";
import DetailImage  from '../../assets/detail.jpg'

function CustomerDetail({ customers }) {
    return (
       <div className="shadow p-3 h-100 mt-20 bg-white rounded">
            <img src={DetailImage} className="h-100" />
       </div>
    );
}

export default CustomerDetail