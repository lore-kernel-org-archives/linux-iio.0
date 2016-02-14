Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35679 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbcBNWih (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 17:38:37 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de,
	irina.tirdea@intel.com, k.kozlowski@samsung.com,
	broonie@kernel.org, afd@ti.com, javier@osg.samsung.com,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH v2 0/3] iio: hmc5843: Fix issues and move out of staging
Date: Mon, 15 Feb 2016 00:37:36 +0200
Message-Id: <1455489459-20422-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix driver issues and add completions.
Add custom attribute to display available values for bias
current, changed implementation to iio_enum in order to make
it more suggestive to the user, add documentation for undocumented
custom attributes and move the driver from the staging directory to
drivers/iio/magnetometer updating corresponding Makefile and Kconfig
files.

Cristina Moraru (3):
  iio: hmc5843: Add attributes for measurement config of bias current
  iio: hmc5843: Add ABI documentation file for hmc5843
  iio: hmc5843: Move hmc5843 out of staging

 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 |  15 +
 drivers/iio/magnetometer/Kconfig                   |  33 +
 drivers/iio/magnetometer/Makefile                  |   4 +
 drivers/iio/magnetometer/hmc5843.h                 |  65 ++
 drivers/iio/magnetometer/hmc5843_core.c            | 686 +++++++++++++++++++++
 drivers/iio/magnetometer/hmc5843_i2c.c             | 103 ++++
 drivers/iio/magnetometer/hmc5843_spi.c             | 100 +++
 drivers/staging/iio/magnetometer/Kconfig           |  32 -
 drivers/staging/iio/magnetometer/Makefile          |   4 +-
 drivers/staging/iio/magnetometer/hmc5843.h         |  65 --
 drivers/staging/iio/magnetometer/hmc5843_core.c    | 645 -------------------
 drivers/staging/iio/magnetometer/hmc5843_i2c.c     | 103 ----
 drivers/staging/iio/magnetometer/hmc5843_spi.c     | 100 ---
 13 files changed, 1007 insertions(+), 948 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-magnetometer-hmc5843
 create mode 100644 drivers/iio/magnetometer/hmc5843.h
 create mode 100644 drivers/iio/magnetometer/hmc5843_core.c
 create mode 100644 drivers/iio/magnetometer/hmc5843_i2c.c
 create mode 100644 drivers/iio/magnetometer/hmc5843_spi.c
 delete mode 100644 drivers/staging/iio/magnetometer/hmc5843.h
 delete mode 100644 drivers/staging/iio/magnetometer/hmc5843_core.c
 delete mode 100644 drivers/staging/iio/magnetometer/hmc5843_i2c.c
 delete mode 100644 drivers/staging/iio/magnetometer/hmc5843_spi.c

-- 
1.9.1

