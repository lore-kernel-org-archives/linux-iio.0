Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org,
	jkosina@suse.cz
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] Enhance feature report APIs
Date: Sun, 11 Jan 2015 17:55:12 -0800
Message-Id: <1421027714-25726-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Current get and set feature report is enhanced to have multiple
values in get and set.

v1
Squashed into two patches one for get and one for set feature report
for bisectability.

v0
Separate patches for each driver/modules

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Enhance get feature report API
  HID: hid-sensor-hub: Enhance feature report set API

 drivers/hid/hid-sensor-hub.c                       | 38 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 61 insertions(+), 27 deletions(-)

-- 
1.9.3
