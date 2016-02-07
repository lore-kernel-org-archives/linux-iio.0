Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36514 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbcBGWWK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2016 17:22:10 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, javier@osg.samsung.com, arnd@arndb.de,
	geert@linux-m68k.org, irina.tirdea@intel.com,
	daniel.baluta@intel.com, octavia.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH 0/5] iio: hmc5843: Fix issues and move out of staging
Date: Mon,  8 Feb 2016 00:21:46 +0200
Message-Id: <1454883711-15489-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix driver issues and add completions.
Add custom attribute to display available values for bias
current, add documentation for undocumented custom attributes,
swap implementation of two functions that have been inversed,
fix checkpatch warnings and, move the driver from the staging
directory to drivers/iio/magnetometer updating corresponding
Makefile and Kconfig files.

Cristina Moraru (5):
  iio: hmc5843: Add attribute for available measurement config
  iio: hmc5843: Swap suspend and resume implementations
  iio: hmc5843: Add ABI documentation file for hmc5843
  iio: hmc5843: Fix comment style warnings
  iio: hmc5843: Move hmc5843 out of staging

 .../ABI/testing/sysfs-bus-iio-magnetometer-hmc5843 |  15 +
 drivers/iio/magnetometer/Kconfig                   |  33 +
 drivers/iio/magnetometer/Makefile                  |   4 +
 drivers/iio/magnetometer/hmc5843.h                 |  66 ++
 drivers/iio/magnetometer/hmc5843_core.c            | 693 +++++++++++++++++++++
 drivers/iio/magnetometer/hmc5843_i2c.c             | 104 ++++
 drivers/iio/magnetometer/hmc5843_spi.c             | 102 +++
 drivers/staging/iio/magnetometer/Kconfig           |  32 -
 drivers/staging/iio/magnetometer/Makefile          |   4 +-
 drivers/staging/iio/magnetometer/hmc5843.h         |  66 --
 drivers/staging/iio/magnetometer/hmc5843_core.c    | 646 -------------------
 drivers/staging/iio/magnetometer/hmc5843_i2c.c     | 104 ----
 drivers/staging/iio/magnetometer/hmc5843_spi.c     | 102 ---
 13 files changed, 1018 insertions(+), 953 deletions(-)
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

