Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35931 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbHEEjy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 00:39:54 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de, jic23@kernel.org, lars@metafoo.de,
	vladimir.barinov@cogentembedded.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Tue,  4 Aug 2015 21:41:14 -0700
Message-Id: <1438749676-28781-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Changes from v3:
* removed rogue stray newline
* made buffer parameter 16 bytes to fit alignment

Matt Ranostay (2):
  devicetree: add PulsedLight vendor + device docs
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/lidar.c                      | 294 +++++++++++++++++++++
 5 files changed, 309 insertions(+)
 create mode 100644 drivers/iio/proximity/lidar.c

-- 
1.9.1

