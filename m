Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33384 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992640AbbHHU4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 16:56:51 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v5 0/2] iio: light: add support for APDS9960 sensor
Date: Sat,  8 Aug 2015 13:58:06 -0700
Message-Id: <1439067488-29866-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Changes from v4:
 * Remove iio_trigger_poll() and interupt handler for the triggered
   buffer 
 * Push data directly to buffers avoiding needing use a irq_work queue
 * Switch to apds9960_buffer_*disable in buffer setup ops
 * Minor comment changes

Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../ABI/testing/sysfs-bus-iio-light-apds9960       |    7 +
 .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1167 ++++++++++++++++++++
 5 files changed, 1210 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1

