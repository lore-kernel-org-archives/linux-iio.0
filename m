Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 0/3] Introduce support for creating IIO devices via configfs
Date: Mon, 25 Apr 2016 16:15:50 +0300
Message-Id: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

For testing purposes is nice to have a quick way of creating IIO devices.
This patch series introduces support for creating IIO devices via configs
(patch 1), allowing users to register "device types". For the moment we
support "dummy" device type (patch 2).

Patch 3 introduces configfs entries documentation for easier review.

Changes since v1:
	* dropped the RFC tag
	* fix coding style issues as per Jonathan suggestion
	* fix configfs path in Documentation as per Lars observation (patch 3)
	* allocate memory for indio_dev->name (patch 1)
	* make iio_simple_dummy depend on SW_DEVICE config option in order to avoid
	compilation errors reported by kbuild robot.

Daniel Baluta (3):
  iio: Add support for creating IIO devices via configfs
  iio: dummy: Convert IIO dummy to configfs
  Documentation: iio: Add IIO software devices docs

 Documentation/ABI/testing/configfs-iio |  13 +++
 drivers/iio/Kconfig                    |   8 ++
 drivers/iio/Makefile                   |   1 +
 drivers/iio/dummy/Kconfig              |   1 +
 drivers/iio/dummy/iio_simple_dummy.c   | 102 +++++++-----------
 drivers/iio/industrialio-sw-device.c   | 182 +++++++++++++++++++++++++++++++++
 include/linux/iio/sw_device.h          |  70 +++++++++++++
 7 files changed, 312 insertions(+), 65 deletions(-)
 create mode 100644 drivers/iio/industrialio-sw-device.c
 create mode 100644 include/linux/iio/sw_device.h

-- 
2.5.0
