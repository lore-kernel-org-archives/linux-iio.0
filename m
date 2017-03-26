Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49606 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZLLd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 07:11:33 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark.Rutland@arm.com, robh+dt@kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] iio:imu:mpu6050 update bindings and add mpu9250 support.
Date: Sun, 26 Mar 2017 12:10:58 +0100
Message-Id: <20170326111100.2571-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bindings for this driver are somewhat lagging the current situation.
I have update the existing binding for i2c parts, but not added the spi
binding as yet.  That can follow later.

The main purpose of this series was to add explicit support for the mpu9250,
mostly to avoid the log message that the whoami value does match.
It's also more inituitive to support the part explicitly than to rely on
people reading the datasheet to see they actually have an mpu6500 and ak8975 in
a SIP.

If no one else does the SPI binding doc in the near future I'll get to it
eventually.

Jonathan

Jonathan Cameron (2):
  iio:imu:mpu6050 update i2c bindings to reflect i2c-gate and supported
    parts
  iio:imu:mpu6050 add explicit mpu9250 support

 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 23 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  1 +
 5 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.12.0

