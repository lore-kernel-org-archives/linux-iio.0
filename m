Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34796 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbHCE0h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 00:26:37 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de, jic23@kernel.org, lars@metafoo.de,
	vladimir.barinov@cogentembedded.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Sun,  2 Aug 2015 21:27:54 -0700
Message-Id: <1438576076-7890-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PulsedLight "blue label" v2 LIDAR sensor can be polled over 100HZ with
the sysfs + hrtimer iio trigger, or using single raw measurment.

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Changesfrom v1:
* Add check for invalid signal return
* Removed un-nedded IIO_CHAN_INFO_CALIBBIAS software biasing
* Mark i2c buffer cacheline aligned
* Added IIO_CHAN_INFO_SCALE for centimeter scale
* Minor tab alignment changes

Matt Ranostay (2):
  devicetree: add PulsedLight vendor prefix
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/lidar.c                      | 284 +++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/iio/proximity/lidar.c

-- 
1.9.1

