import 'package:flutter2_template/env.dart';

const ENV_IS_DEV = ENV == "DEV";

// 开发环境
const SERVER_HOST_DEV = 'http://192.168.220.229:3000';

// 生产环境
// 生产环境地址禁止随意修改！！！
const SERVER_HOST_PROD = '';




const SERVER_API_URL = ENV_IS_DEV ? SERVER_HOST_DEV : SERVER_HOST_PROD;

const PUSH_PREFIX = ENV_IS_DEV ? "test_" : "prod_";

// Sentry dns
const SENTRY_SERVER_API_URL = '';