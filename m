Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33582 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbHROkq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2015 10:40:46 -0400
Received: by pdrh1 with SMTP id h1so69627367pdr.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2015 07:40:46 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v6 0/2] iio: proximity: add PulsedLight LIDAR sensor support
Date: Tue, 18 Aug 2015 07:40:36 -0700
Message-Id: <1439908838-6945-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for this range finding LIDAR module, and reports
distance back in meters to centimeter resolution with +/- 2.5 CM of accuracy
at ~40 meters.

Changes from v5:
* Use indio_dev->mlock mutex to be sure of buffer enabled state
  and removed data->lock
* Changed CONFIG_LIDAR to CONFIG_LIDAR_LITE_V2
* Changed lidar to lidar-lite-v2 in i2c module lookup table 

Matt Ranostay (2):
  devicetree: add PulsedLight vendor + device docs
  iio: proximity: add support for PulsedLight LIDAR

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  | 288 +++++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c

-- 
1.9.1

