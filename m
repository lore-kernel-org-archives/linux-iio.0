Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53416 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757101AbaD1XsI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Apr 2014 19:48:08 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/6] Quaternion support
Date: Mon, 28 Apr 2014 16:51:41 -0700
Message-Id: <1398729107-16748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v7:
Scan element format with repeats is changed to:
[be|le]:[s|u]bits/storagebitsXr[>>shift]
Here r is specifying how may times, real/storage bits are repeating.

v6:
Minor changes suggested by Peter Meerwald

v5:
Only change is for aligning function paramaters as suggested by Joe Perches

Srinivas Pandruvada (6):
  devres: introduce API "devm_kmemdup
  IIO: core: Introduce read_raw_multi
  IIO: core: Modify scan element type
  IIO: core: Add quaternion modifier
  iio: hid-sensors: Added device rotation support
  iio: Added ABI description for quaternion

 Documentation/ABI/testing/sysfs-bus-iio       |  12 +
 Documentation/driver-model/devres.txt         |   1 +
 drivers/base/devres.c                         |  21 ++
 drivers/iio/iio_core.h                        |   2 +-
 drivers/iio/industrialio-buffer.c             |  41 ++-
 drivers/iio/industrialio-core.c               |  66 +++--
 drivers/iio/industrialio-event.c              |   6 +-
 drivers/iio/inkern.c                          |  16 +-
 drivers/iio/orientation/Kconfig               |  12 +
 drivers/iio/orientation/Makefile              |   1 +
 drivers/iio/orientation/hid-sensor-rotation.c | 348 ++++++++++++++++++++++++++
 include/linux/device.h                        |   2 +
 include/linux/hid-sensor-ids.h                |   1 +
 include/linux/iio/iio.h                       |  24 ++
 include/linux/iio/types.h                     |   2 +
 15 files changed, 522 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iio/orientation/hid-sensor-rotation.c

-- 
1.7.11.7

