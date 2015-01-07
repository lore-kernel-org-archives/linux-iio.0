Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] Core driver enhancements
Date: Wed,  7 Jan 2015 10:24:09 -0800
Message-Id: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Enhance core to support next generation of hub devices for fast response
and fusion sensors.

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Allow parallel synchronous reads
  HID: hid-sensor-hub: Add collection device

 drivers/hid/hid-sensor-hub.c   | 140 +++++++++++++++++++++++++----------------
 include/linux/hid-sensor-hub.h |  24 +++++++
 include/linux/hid-sensor-ids.h |   2 +
 3 files changed, 113 insertions(+), 53 deletions(-)

-- 
1.9.3
