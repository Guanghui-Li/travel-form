import React from "react";
import ReactDOM from "react-dom";
import App from './routes';

document.addEventListener("DOMContentLoaded", () => {
    const authorization_form = document.querySelector("#reimbursement_form");

    ReactDOM.render(<App />, reimbursement_form);
});