Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	borneo.antonio@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] hid: sensor-hub: Enhance feature report APIs
Date: Fri, 16 Jan 2015 16:39:23 -0800
Message-Id: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Current get and set feature report is enhanced to have multiple
values in get and set.

v2
As suggested by Antonio Borneo, using DIV_ROUND_UP

v1
Squashed into two patches one for get and one for set feature report
for bisectability.

v0
Separate patches for each driver/modules

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Enhance get feature report API
  HID: hid-sensor-hub: Enhance feature report set API

 drivers/hid/hid-sensor-hub.c                       | 37 +++++++++++++++++++---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
 include/linux/hid-sensor-hub.h                     | 13 +++++---
 4 files changed, 60 insertions(+), 27 deletions(-)

-- 
1.9.1
