Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33049 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbbHDEWh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 00:22:37 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de, jic23@kernel.org, lars@metafoo.de,
	vladimir.barinov@cogentembedded.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Mon,  3 Aug 2015 21:23:55 -0700
Message-Id: <1438662237-19991-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PulsedLight "blue label" v2 LIDAR sensor can be polled over 100HZ with
the sysfs + hrtimer iio trigger, or using single raw measurment.

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Changes from v2:
* Add of_match_table for dt lookup 
* Return error if timeout happens in reading measurement
* Document why i2c_smbus_read_byte_data can't be used
* Add pulsedlight,lidar to trivial-devices.txt

Matt Ranostay (2):
  devicetree: add PulsedLight vendor + device docs
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/lidar.c                      | 295 +++++++++++++++++++++
 5 files changed, 310 insertions(+)
 create mode 100644 drivers/iio/proximity/lidar.c

-- 
1.9.1

