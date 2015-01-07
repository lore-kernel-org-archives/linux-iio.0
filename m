Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] HID Sensor hub driver fixes
Date: Wed,  7 Jan 2015 10:14:42 -0800
Message-Id: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Address two bug fixes in the existing code.

Srinivas Pandruvada (2):
  HID: hid-sensor-hub: Correct documentation
  HID: sensor-hub: correct dyn_callback_lock IRQ-safe change

 drivers/hid/hid-sensor-hub.c   | 8 +++++---
 include/linux/hid-sensor-hub.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
1.9.3
