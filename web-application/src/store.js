import customerReducer from './actions/customerSlice';
import { configureStore } from '@reduxjs/toolkit'
const store = configureStore({
  reducer: {
    customers: customerReducer,
  },
});

export default store;