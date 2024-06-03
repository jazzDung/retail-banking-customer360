import axios from "axios";

export default axios.create({
  baseURL: "http://k8s-apiserve-apiserve-03159dafcc-74596ca9fbb60af8.elb.us-east-1.amazonaws.com/api/",
});