/**
 * Copyright (c) 2023, WSO2 LLC (http://www.wso2.com) All Rights Reserved.
 *
 * WSO2 LLC licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import './App.css';
import React from 'react';
import { AuthProvider } from "@asgardeo/auth-react";
import CustomRouter from './routes';

function App() {
  const asgardioConfig = {
    signInRedirectURL: "http://localhost:3000",
    signOutRedirectURL: "http://localhost:3000",
    clientID: "s0PYeIeVCb1fVPPVMfBLMde7tNka",
    baseUrl: "https://api.asgardeo.io/t/orgsd",
    scope: ["openid", "email", "profile", "order_insert", "order_read", "cargo_insert", "cargo_read"]
  };

  return (
    <AuthProvider config={asgardioConfig}>
      <CustomRouter />
    </AuthProvider>
  );
}

export default App;