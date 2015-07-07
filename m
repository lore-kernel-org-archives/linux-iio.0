Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34859 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbGGDVO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2015 23:21:14 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	marex@denx.de, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/2] iio: light: add support for APDS9660 sensor
Date: Mon,  6 Jul 2015 20:22:12 -0700
Message-Id: <1436239334-15782-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../ABI/testing/sysfs-bus-iio-light-apds9960       |  125 ++
 .../devicetree/bindings/iio/light/apds9960.txt     |   19 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1219 ++++++++++++++++++++
 5 files changed, 1376 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1

