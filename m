Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36381 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504AbbHLGBT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 02:01:19 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Tue, 11 Aug 2015 23:01:14 -0700
Message-Id: <1439359276-19028-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Changes from v4:
* moved comment to read command function
* remove un-needed buffer indexing
* renamed device and driver name to pulsedlight-lidar-lite-v2 to resolve
  confusion that v1 will likely not work with this driver

Matt Ranostay (2):
  devicetree: add PulsedLight vendor + device docs
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  | 292 +++++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c

-- 
1.9.1

