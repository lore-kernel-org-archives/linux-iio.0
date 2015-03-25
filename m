Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com,
	daniel.baluta@intel.com
Subject: [PATCH 0/3] Add configfs support for software triggers in IIO
Date: Wed, 25 Mar 2015 19:00:29 +0200
Message-Id: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds initial support for configfs in IIO. It is structured in 
the following way:

	* patch 1 - adds configfs infrastructure creating an "iio" configfs
	subystem + an initial "triggers" group.
	* patch 2 - adds the first "real" trigger type - hrtimer.
	* patch 3 - adds Documentation

Daniel Baluta (3):
  iio: configfs: Add configfs support to IIO
  iio: trigger: Add support for highres timer trigger
  iio: Documentation: Add initial documentaton for IIO

 Documentation/iio/iio_configfs.txt       |  74 ++++++++
 drivers/iio/Kconfig                      |   8 +
 drivers/iio/Makefile                     |   1 +
 drivers/iio/industrialio-configfs.c      | 301 +++++++++++++++++++++++++++++++
 drivers/iio/trigger/Kconfig              |   8 +
 drivers/iio/trigger/Makefile             |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c   | 146 +++++++++++++++
 include/linux/iio/iio_configfs_trigger.h |  49 +++++
 8 files changed, 589 insertions(+)
 create mode 100644 Documentation/iio/iio_configfs.txt
 create mode 100644 drivers/iio/industrialio-configfs.c
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
 create mode 100644 include/linux/iio/iio_configfs_trigger.h

-- 
1.9.1
