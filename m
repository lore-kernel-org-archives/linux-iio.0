Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: jlbec@evilplan.org,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	octavian.purdila@intel.com,
	pebolle@tiscali.nl,
	patrick.porlan@intel.com,
	adriana.reus@intel.com,
	constantin.musca@intel.com,
	marten@intuitiveaerial.com,
	daniel.baluta@intel.com
Subject: [PATCH v5 0/4] Add initial configfs support for IIO
Date: Mon,  4 May 2015 13:50:00 +0300
Message-Id: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset introduces IIO software triggers, offers a way of configuring
them via configfs and adds the IIO hrtimer based interrupt source to be used
with software triggers.

The arhitecture is now split in 3 parts, to remove all IIO trigger specific
parts from IIO configfs core:

(1) IIO software triggers - are independent of configfs.
(2) IIO configfs - offers a generic way of creating IIO objects. So far we can
	create software triggers.
(3) IIO hrtimer trigger - is the first interrupt source for software triggers
	(with syfs to follow). Each trigger type can implement its own set of
	attributes.

Changes since v4:
	* patch 1/4
		- fixed "new line" nit in industrialio-sw-trigger.c
		- added license header in sw_trigger.h
	* patch 2/4
		- none
	* patch 3/4 
		- none
	* patch 4/4
		- removed "Further work" chapter in iio_configfs.txt
		- added configfs-iio file in Documentation/ABI/testing

Changes since v3:
	* addressed comments from Jonathan for previous version
	* https://lkml.org/lkml/2015/4/6/111

Daniel Baluta (4):
  iio: core: Introduce IIO software triggers
  iio: core: Introduce IIO configfs support
  iio: trigger: Introduce IIO hrtimer based trigger
  iio: Documentation: Add IIO configfs documentation

 Documentation/ABI/testing/configfs-iio |  26 +++++
 Documentation/iio/iio_configfs.txt     |  63 +++++++++++
 drivers/iio/Kconfig                    |  16 +++
 drivers/iio/Makefile                   |   2 +
 drivers/iio/industrialio-configfs.c    | 117 +++++++++++++++++++
 drivers/iio/industrialio-sw-trigger.c  | 112 ++++++++++++++++++
 drivers/iio/trigger/Kconfig            |   9 ++
 drivers/iio/trigger/Makefile           |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 201 +++++++++++++++++++++++++++++++++
 include/linux/iio/sw_trigger.h         |  60 ++++++++++
 10 files changed, 608 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-iio
 create mode 100644 Documentation/iio/iio_configfs.txt
 create mode 100644 drivers/iio/industrialio-configfs.c
 create mode 100644 drivers/iio/industrialio-sw-trigger.c
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
 create mode 100644 include/linux/iio/sw_trigger.h

-- 
1.9.1
