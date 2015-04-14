Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19552 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbbDNJbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Apr 2015 05:31:41 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] Add support for Sensortek STK3310
Date: Tue, 14 Apr 2015 12:32:39 +0300
Message-Id: <1429003962-13922-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches include an iio driver for the Sensortek STK3310
ambient light and proximity sensor. The STK3311 model is also
supported.

Datasheet:
http://www.datasheetspdf.com/datasheet/STK3310.html

Patches are as following:

1. basic functionality:
- raw readings of light and proximity data
- configuration of parameters like gain and integration time

2. power management:
- suspend and resume functions

3. interrupt support:
- interrupt support for proximity events
- enabling/disabling interrupts (events) via sysfs
- setting proximity thresholds

Regards,
Tiberiu

Tiberiu Breana (3):
  iio: light: Add support for Sensortek STK3310
  iio: light: Add Power Management for STK3310
  iio: light: Add threshold interrupt support for STK3310

 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/stk3310.c | 818 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 830 insertions(+)
 create mode 100644 drivers/iio/light/stk3310.c

-- 
1.9.1

