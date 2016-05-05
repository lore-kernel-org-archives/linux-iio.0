Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58193 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbcEEPsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 May 2016 11:48:14 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 0/2] Add support for the Bosch BMA220 accelerometer
Date: Thu,  5 May 2016 18:48:54 +0300
Message-Id: <1462463336-16108-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the Bosch Sensortec BMA220 accelerometer.
Patch 1 adds basic support, raw readings and ACPI detection.
Patch 2 adds triggered buffer support.

Change log:
v4:
- addressed Jonathan's comments
- added the bma220_deinit function for suspending the device
- the SPI tx/rx buffers are now cacheline aligned and part of
  the driver's private data

v3:
- added link to datasheet.

v2:
- addressed Peter's comments
- added the bma220_init function that handles chip id
  checking and waking up the device at probing time

Tiberiu Breana (2):
  iio: accel: Add support for Bosch BMA220
  iio: accel: Add triggered buffer support for BMA220

 drivers/iio/accel/Kconfig      |  10 ++
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma220_spi.c | 319 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 drivers/iio/accel/bma220_spi.c

-- 
1.9.1

