Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43059 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbaFVT6C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Jun 2014 15:58:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: kristina.martsenko@gmail.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/7] Move more drivers to using samp_freq element of info_mask.
Date: Sun, 22 Jun 2014 20:59:39 +0100
Message-Id: <1403467186-26639-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is all part of a slow campaign to use the (relatively new) core
support for info_mask elements applying to all channels.

The advantages are:

1) This element of device configuration is exposed for in kernel consumers
   of IIO channels to use.
2) Reduced code repitition.

Note this process is a precursor to reintroducing the patch set
for core handing of _available attributes as posted a while back.
At the time it was observed that this cleanup was in fact separate
from that new functionality and made sense to do first.

Lots more drivers to do (if anyone else wants to do any then
let me know).

Note, this will clash with the st magnetometer driver work from
Reyad Attiyat. One of use will end up with an easy rebase depending
on what order the patches hit in (or I'll sort it out at merge time).

Jonathan

Jonathan Cameron (7):
  iio:st sensors: remove custom sampling frequence attribute in favour
    of core support.
  iio: gyro: itg3200 switch sampling frequency attr to core support.
  iio: imu: mpu6050 switch sampling frequency attr to core support.
  iio: gyro: adis16136 switch sampling frequency attr to core support.
  iio: adis: Switch sampling frequency attr to core support.
  iio: imu: adis16400 switch sampling frequency attr to core support.
  iio: imu: adis16480 switch sampling frequency attr to core support

 drivers/iio/accel/st_accel_core.c               |  12 +-
 drivers/iio/common/st_sensors/st_sensors_core.c |  29 -----
 drivers/iio/gyro/adis16136.c                    |  58 ++-------
 drivers/iio/gyro/adis16260.c                    | 124 ++++++++------------
 drivers/iio/gyro/itg3200_core.c                 | 101 +++++++---------
 drivers/iio/gyro/st_gyro_core.c                 |  12 +-
 drivers/iio/imu/adis16400_core.c                |  78 ++++---------
 drivers/iio/imu/adis16480.c                     |  82 ++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      | 149 +++++++++---------------
 drivers/iio/magnetometer/st_magn_core.c         |  12 +-
 drivers/iio/pressure/st_pressure_core.c         |  27 ++++-
 drivers/staging/iio/accel/adis16201_core.c      |  14 +--
 drivers/staging/iio/accel/adis16203_core.c      |  11 +-
 drivers/staging/iio/accel/adis16204_core.c      |  12 +-
 drivers/staging/iio/accel/adis16209_core.c      |  18 +--
 drivers/staging/iio/accel/adis16240_core.c      |  12 +-
 include/linux/iio/common/st_sensors.h           |  12 +-
 include/linux/iio/imu/adis.h                    |  33 +++---
 18 files changed, 311 insertions(+), 485 deletions(-)

-- 
2.0.0

