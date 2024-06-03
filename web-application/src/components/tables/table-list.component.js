import React, { Component } from "react";
import { Link } from "react-router-dom";

function TableList() {
    const tables = [
        {
            name: 'fact_customer',
            fullName: 'dwh.fact_customer'
        },
        {
            name: 'fact_savings',
            fullName: 'dwh_savings.fact_savings'
        },
        {
            name: 'fact_loans',
            fullName: 'dwh_loan.fact_loans'
        },
        {
            name: 'fact_accounts',
            fullName: 'dwh.fact_accounts'
        },
        {
            name: 'fact_period_customer_daily',
            fullName: 'dwh.fact_period_customer_daily'
        },
        {
            name: 'fact_saving_accounts',
            fullName: 'dwh.fact_saving_accounts'
        }
    ]

    return (
        <div className="flex flex-col h-full ">
            <header className="z-10 items-start px-9 pt-9 pb-2.5 text-2xl font-bold text-black max-md:px-5 max-md:max-w-full">
                Tables
            </header>

            <div className="shrink-0 h-0.5 bg-black bg-opacity-10 w-[95%] self-center " />

            <div className="self-center mt-3.5 w-[95%]"></div>
            <div className="row self-center mt-3.5 w-[95%]">
                {
                    tables.map(table =>
                        <div className="col-3 mt-5">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">{table.name}</h5>
                                    <p class="card-text">{table.fullName}</p>
                                    <Link to={"/customers"} className="btn btn-primary">
                                        Detail
                                    </Link>
                                </div>
                            </div>
                        </div>
                    )
                }

            </div>
            </div>


    );
}

export default TableList
