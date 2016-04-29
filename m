Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41401 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbcD2NcO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 09:32:14 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/2] Add support for the Bosch BMA220 accelerometer
Date: Fri, 29 Apr 2016 16:32:53 +0300
Message-Id: <1461936775-16419-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the Bosch Sensortec BMA220 accelerometer.
Patch 1 adds basic support, raw readings and ACPI detection.
Patch 2 adds triggered buffer support.

v3:
Added link to datasheet.

v2 change log:
patch 1:
- addressed Peter's comments
- added the bma220_init function that handles chip id
  checking and waking up the device at probing time

patch 2:
- addressed Peter's comments

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

