Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34137 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbHQRaR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 13:30:17 -0400
Received: by pdbfa8 with SMTP id fa8so57966209pdb.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2015 10:30:17 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v7 0/2] iio: light: add support for APDS9960 sensor
Date: Mon, 17 Aug 2015 10:30:14 -0700
Message-Id: <1439832616-18615-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for the APDS9960 ALS + proximity + gesture
sensor.

Included support for the various adjustable settings and controls:
 * Falling and rising ALS + proximity thresholds events
 * Gain controls
 * ALS time integration

Changes from v6:
 * Remove timestamp data from buffer push since it is useless from a
   hardware buffer
 * Removed non-existant gesture trigger ABI documentation
 * Fixed irq number check

Matt Ranostay (2):
  iio: light: DT binding docs for APDS9960 driver
  iio: light: add APDS9960 ALS + promixity driver

 .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       | 1135 ++++++++++++++++++++
 4 files changed, 1171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 drivers/iio/light/apds9960.c

-- 
1.9.1

