Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33414 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbbGHFPg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jul 2015 01:15:36 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	marex@denx.de, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/2] iio: light: add support for APDS9660 sensor
Date: Tue,  7 Jul 2015 22:16:33 -0700
Message-Id: <1436332595-9745-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Changes from v1:
 * Reworded sysfs-bus-iio-apds9960 to be more clear about gesture features
 * Changed gain setting from IIO_CHAN_INFO_CALIBSCALE to IIO_CHAN_INFO_SCALE
 * Removed superfluous information in iio_chan_spec channels
 * Fixed likely buffer overrun issue
 * Make mutex and gain + it setting logic more clear
 * Fixed typos in comments

Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../ABI/testing/sysfs-bus-iio-light-apds9960       |  128 +++
 .../devicetree/bindings/iio/light/apds9960.txt     |   19 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1214 ++++++++++++++++++++
 5 files changed, 1374 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1

