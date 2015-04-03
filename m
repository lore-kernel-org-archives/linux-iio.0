Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com
Subject: [PATCH v2 0/3]  Add initial configfs support for IIO
Date: Fri,  3 Apr 2015 18:57:57 +0300
Message-Id: <1428076680-28005-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds initial support for configfs in IIO.

Patch 1:
	* adds configfs infrastructure creating an "iio" configfs
        subystem + an initial "triggers" group.
Patch 2:
	* adds the first "real" trigger type - hrtimer.
Patch 3:
	* adds Documentation

Changes since v1 are listed in each individual patch.

Daniel Baluta (3):
  iio: configfs: Add configfs support to IIO
  iio: trigger: Add support for highres timer trigger type
  iio: Documentation: Add documentation for IIO configfs

 Documentation/iio/iio_configfs.txt       |  82 +++++++++
 drivers/iio/Kconfig                      |   8 +
 drivers/iio/Makefile                     |   1 +
 drivers/iio/industrialio-configfs.c      | 291 +++++++++++++++++++++++++++++++
 drivers/iio/trigger/Kconfig              |   9 +
 drivers/iio/trigger/Makefile             |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c   | 154 ++++++++++++++++
 include/linux/iio/iio_configfs_trigger.h |  41 +++++
 8 files changed, 588 insertions(+)
 create mode 100644 Documentation/iio/iio_configfs.txt
 create mode 100644 drivers/iio/industrialio-configfs.c
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
 create mode 100644 include/linux/iio/iio_configfs_trigger.h

-- 
1.9.1
