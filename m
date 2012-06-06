Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10646 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab2FFPuc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Jun 2012 11:50:32 -0400
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH, 0/7] HID Sensor Driver
Date: Wed,  6 Jun 2012 08:39:17 -0700
Message-Id: <1338997164-5077-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This submits a set of patches to enable USB HID Sensor driver.
It is implemented as a HID driver and exports sensor interface
via Linux IIO interfaces. This implements a basic usage id processing
for Accelerometer 3D, Gyro 3D, Magnetometer 3D and ALS.

Srinivas pandruvada (5):
  HID-Sensors: Common attributes and interfaces
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyro 3D
  HID-Sensors: Added Compass 3D
  HID-Sensors: Added ALS

srinivas pandruvada (2):
  HID-Sensors: Add Intel HID sensor
  HID-Sensors: Sensor framework

 drivers/hid/hid-core.c                             |    6 +
 drivers/hid/hid-ids.h                              |    5 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/hid-sensors/Kconfig                |   19 +
 drivers/staging/hid-sensors/Makefile               |   16 +
 drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  387 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-als.c       |  326 +++++++++
 .../staging/hid-sensors/hid-sensor-attributes.c    |  203 ++++++
 .../staging/hid-sensors/hid-sensor-attributes.h    |   67 ++
 .../staging/hid-sensors/hid-sensor-compass-3d.c    |  385 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c   |  384 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |  709 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-ids.h       |  117 ++++
 drivers/staging/hid-sensors/hid-sensor-interface.h |   93 +++
 drivers/staging/hid-sensors/hid-sensor-ring.c      |  104 +++
 drivers/staging/hid-sensors/hid-sensor-trigger.c   |   81 +++
 17 files changed, 2905 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/Kconfig
 create mode 100644 drivers/staging/hid-sensors/Makefile
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-accel-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-als.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-compass-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-hub.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ids.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-interface.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ring.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c

-- 
1.7.7.6

