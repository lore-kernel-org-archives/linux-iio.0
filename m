Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28331 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbcCINan (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Mar 2016 08:30:43 -0500
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] Add support for MAX31722/MAX31723 temperature sensors
Date: Wed,  9 Mar 2016 15:30:50 +0200
Message-Id: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set adds support for the MAX31722/MAX31723 temperature sensors /
thermostats.
Patch 1 adds basic support and power management.
Patch 2 adds threshold interrupt support.

Tiberiu Breana (2):
  iio: temperature: Add support for MAX31722/MAX31723 temperature
    sensors
  iio: temperature: Add threshold interrupt support for max31722

 drivers/iio/temperature/Kconfig    |  12 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max31722.c | 673 +++++++++++++++++++++++++++++++++++++
 3 files changed, 686 insertions(+)
 create mode 100644 drivers/iio/temperature/max31722.c

-- 
1.9.1

