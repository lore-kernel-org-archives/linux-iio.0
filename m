Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60220 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbbALB54 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 11 Jan 2015 20:57:56 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, jkosina@suse.cz, a.zummo@towertech.it
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	holler@ahsoftware.de, rtc-linux@googlegroups.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] Asynchronous attribute reads
Date: Sun, 11 Jan 2015 17:57:05 -0800
Message-Id: <1421027826-25785-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v1
Squashed into a single patch for bisectability.

v0
Separate patches for each driver/module

Srinivas Pandruvada (1):
  HID: hid-sensor-hub: Extend API for async reads

 drivers/hid/hid-sensor-hub.c                  | 15 ++++++++++++++-
 drivers/iio/accel/hid-sensor-accel-3d.c       |  3 ++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 ++-
 drivers/iio/light/hid-sensor-als.c            |  3 ++-
 drivers/iio/light/hid-sensor-prox.c           |  3 ++-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 ++-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  3 ++-
 drivers/iio/pressure/hid-sensor-press.c       |  3 ++-
 drivers/rtc/rtc-hid-sensor-time.c             |  2 +-
 include/linux/hid-sensor-hub.h                | 19 +++++++++++++------
 10 files changed, 42 insertions(+), 15 deletions(-)

-- 
1.9.3

