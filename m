Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16141 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934165AbaGXSSH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Jul 2014 14:18:07 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] iio:gyro:bmg160 Gyro Sensor driver
Date: Thu, 24 Jul 2014 11:23:38 -0700
Message-Id: <1406226219-15982-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1:
- Runtime PM: Removed module parameter for delay configuration
Use RTPM autosuspend delay feature. This allows sysfs configuration of
autosuspend time.

- Trigger
As suggested, there are two triggers:
- data_ready : Trigger which will allow all gyro periodic sampled data to
be received by user space
- any-motion: When used, will configure the chipset so that data is
pushed only when there is any motion, allowing system to enter deeper idle
power states

- Events
ROC type events will send direction instead of either.
Also both events and data triggers can be enabled together.

- Addition of unbuffered TEMP read interface

- Misc error message corrections as suggested by Peter Meerwald

TBD: Add sysfs attribute to trigger to configure thresholds.
Currently the triggers don't have feature to add sysfs attributes
unlike IIO device. But this has to be a RFC patch on top. 

v0:
Base version for review

Srinivas Pandruvada (1):
  iio:gyro:bmg160 Gyro Sensor driver

 drivers/iio/gyro/Kconfig  |   11 +
 drivers/iio/gyro/Makefile |    1 +
 drivers/iio/gyro/bmg160.c | 1132 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1144 insertions(+)
 create mode 100644 drivers/iio/gyro/bmg160.c

-- 
1.7.11.7

