Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] Enhance feature report APIs
Date: Wed,  7 Jan 2015 10:31:44 -0800
Message-Id: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Current get and set feature report is enhanced to have multiple
values in get and set.

Srinivas Pandruvada (4):
  HID: hid-sensor-hub: Enhance feature report API
  iio: hid_sensor_hub: update parameters to get feature report
  HID: hid-sensor-hub: Enhance feature report set API
  iio: hid_sensor_hub: update parameters to set feature report

 drivers/hid/hid-sensor-hub.c                       | 38 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 61 insertions(+), 27 deletions(-)

-- 
1.9.3
