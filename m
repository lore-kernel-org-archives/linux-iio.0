Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:38408 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbeBZBGS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Feb 2018 20:06:18 -0500
From: Tom Lebreux <tomlebreux@cock.li>
Subject: GSoC IIO project: Tom Lebreux
To: linux-iio@vger.kernel.org
Message-ID: <e2b17a85-9b0d-c4b2-abf8-c02bbb55ff35@cock.li>
Date: Sun, 25 Feb 2018 20:06:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduction and Task 01

Hi,

my name is Tom Lebreux and I am a finishing my second year 
of university in Computer Science. 

I am interested in contributing to the linux kernel and
working with hardware. I think this GSoC project is a
great opportunity to learn.

I have been having fun learning about the IIO subsystem while
messing around with the dummy driver. I think the dummy driver
and its tasks give a good first overview of the subsystem and
its functionality.

Task 01 solution:

$ grep IIO .config
# CONFIG_SENSORS_IIO_HWMON is not set                                            
# IIO staging drivers                                                            
CONFIG_IIO=y                                                                     
CONFIG_IIO_BUFFER=y                                                              
# CONFIG_IIO_BUFFER_CB is not set                                                
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set                                       
CONFIG_IIO_KFIFO_BUF=y                                                           
CONFIG_IIO_CONFIGFS=y                                                            
CONFIG_IIO_TRIGGER=y                                                             
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2                                               
CONFIG_IIO_SW_DEVICE=y                                                           
# CONFIG_IIO_SW_TRIGGER is not set                                               
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set                                     
# CONFIG_IIO_ST_ACCEL_3AXIS is not set                                           
# Hid Sensor IIO Common                                                          
# CONFIG_IIO_SSP_SENSORHUB is not set                                            
# IIO dummy driver                                                               
CONFIG_IIO_DUMMY_EVGEN=m                                                         
CONFIG_IIO_SIMPLE_DUMMY=m                                                        
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y                                                 
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y                                                 
# CONFIG_IIO_ST_GYRO_3AXIS is not set                                            
# CONFIG_IIO_ST_LSM6DSX is not set                                               
# CONFIG_IIO_ST_MAGN_3AXIS is not set                                            
# CONFIG_IIO_MUX is not set                                                      
# CONFIG_IIO_INTERRUPT_TRIGGER is not set                                        
# CONFIG_IIO_SYSFS_TRIGGER is not set                                            
# CONFIG_IIO_ST_PRESS is not set
