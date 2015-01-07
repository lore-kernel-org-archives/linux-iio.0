Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jkosina@suse.cz,
	jic23@kernel.org,
	a.zummo@towertech.it
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	holler@ahsoftware.de,
	rtc-linux@googlegroups.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/9] Asynchronous attribute reads
Date: Wed,  7 Jan 2015 10:47:54 -0800
Message-Id: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Patches related to asynchronous attribute reads. This series
enhances core and driver using this API.

Srinivas Pandruvada (9):
  HID: hid-sensor-hub: Extend API for async reads
  iio: hid-sensor-accel-3d: Adjust parameter for attribute read
  iio: hid-sensor-gyro-3d: Adjust parameter for attribute read
  iio: hid-sensor-als: Adjust parameter for attribute read
  iio: hid-sensor-prox: Adjust parameter for attribute read
  iio: hid-sensor-magn-3d: Adjust parameter for attribute read
  iio: hid-sensor-incl-3d: Adjust parameter for attribute read
  iio: hid-sensor-press: Adjust parameter for attribute read
  drivers/rtc/rtc-hid-sensor-time.c: Adjust parameter for attribute read

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
