Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59630 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbaHEVva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Aug 2014 17:51:30 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] iio:gyro:bmg160 Gyro Sensor driver
Date: Tue,  5 Aug 2014 14:57:32 -0700
Message-Id: <1407275854-29083-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v3
- Suport Only Runtime PM no fallback method. Driver will still work but
chip will be in power on mode.
- Add comment for enable disable trigger/event sequence, how they work
in reverse order using runtime pm calls

v2:
- Add device id in any-motion trigger
- Removed string comparison for trigger name to identify trigger source
- Prevent disabling any motion interrupts when both any motion trigger
and events are on, but any one of them is disabled via sysfs
- Switch on chan->type
- Created new function to raw read axis
- Explanation why need to power on for changing sampling freq and scale

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

Srinivas Pandruvada (2):
  iio:gyro:bmg160 Gyro Sensor driver
  iio:gyro:bmg160 documentation

 .../ABI/testing/sysfs-bus-iio-gyro-bmg160          |    7 +
 drivers/iio/gyro/Kconfig                           |   11 +
 drivers/iio/gyro/Makefile                          |    1 +
 drivers/iio/gyro/bmg160.c                          | 1211 ++++++++++++++++++++
 4 files changed, 1230 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160
 create mode 100644 drivers/iio/gyro/bmg160.c

-- 
1.7.11.7

