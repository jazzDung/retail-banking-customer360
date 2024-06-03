import { combineReducers } from "redux";
import customerReducer from "./customer.reducer";

export default combineReducers({
  customer: customerReducer,
});
