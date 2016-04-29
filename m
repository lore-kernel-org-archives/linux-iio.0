Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9218 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbcD2LHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 07:07:22 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] Add support for the Bosch BMA220 accelerometer
Date: Fri, 29 Apr 2016 14:07:54 +0300
Message-Id: <1461928076-22076-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the Bosch Sensortec BMA220 accelerometer.
Patch 1 adds basic support, raw readings and ACPI detection.
Patch 2 adds triggered buffer support.

Tiberiu Breana (2):
  iio: accel: Add support for Bosch BMA220
  iio: accel: Add triggered buffer support for BMA220

 drivers/iio/accel/Kconfig      |  10 ++
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma220_spi.c | 302 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 drivers/iio/accel/bma220_spi.c

-- 
1.9.1

