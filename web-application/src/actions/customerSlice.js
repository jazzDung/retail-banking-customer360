import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import CustomerService from "../services/customer.service";

// Thunk to fetch customers
export const retrieveCustomers = createAsyncThunk(
  'customers/retrieveCustomers',
  async (params) => {
    const response = await CustomerService.get(params); 
    console.log({response})// Adjust the URL as necessary
    return response.data.results?? response.data;
  }
);

const customerSlice = createSlice({
  name: 'customers',
  initialState: {
    customers: [],
    status: 'idle',
    error: null,
  },
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(retrieveCustomers.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(retrieveCustomers.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.customers = action.payload;
      })
      .addCase(retrieveCustomers.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      });
  },
});

export default customerSlice.reducer;