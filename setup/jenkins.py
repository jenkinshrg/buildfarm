#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
from selenium import webdriver

driver = webdriver.PhantomJS(service_log_path=os.ttyname(sys.stdout.fileno()))
driver.get("http://localhost:8080/configureSecurity/")
driver.implicitly_wait(10)
element = driver.find_element_by_id('cb14')
element.click()
element = driver.find_element_by_css_selector("input[type='radio'][value='fixed']")
element.click()
element = driver.find_element_by_id('slaveAgentPortId')
element.clear()
element.send_keys("9000")
element = driver.find_element_by_id('yui-gen6-button')
element.click()
driver.quit()
