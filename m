Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	jlbec@evilplan.org,
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
Subject: [PATCH v6 0/4] Add initial configfs support for IIO
Date: Fri,  8 May 2015 16:33:41 +0300
Message-Id: <1431092025-14355-1-git-send-email-daniel.baluta@intel.com>
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

Changes since v5: (after Lars comments)
	* the most important change is that we moved sampling_frequency attribute
	from configfs to trigger's directory in /sys.
	* couple of const added to strings
	* documentation to public API in sw_trigger.h
	* replace pr_err with WARN_ONCE in trigger_make_group to avoid spamming
	kernel log, but without leaving user clueless in case of errors.
	* we still need to decide if we get a real gain by adding min/max limits
	for sampling frequency in /config dir. Anyhow, this can be done in a later
	patch.
	* fix race in hrtimer_remove

Changes since v4:
	* patch 1/4
		- fixed "new line" nit in industrialio-sw-trigger.c
		- added license header in sw_trigger.ho
	* patch 2/4
		- none
	* patch 3/4 
		- none
	* patch 4/4
		- removed "Further work" chapter in iio_configfs.txt
		- added configfs-iio file in Documentation/ABI/testing

Daniel Baluta (4):
  iio: core: Introduce IIO software triggers
  iio: core: Introduce IIO configfs support
  iio: trigger: Introduce IIO hrtimer based trigger
  iio: Documentation: Add IIO configfs documentation

 Documentation/ABI/testing/configfs-iio |  20 ++++
 Documentation/iio/iio_configfs.txt     |  58 ++++++++++
 drivers/iio/Kconfig                    |  16 +++
 drivers/iio/Makefile                   |   2 +
 drivers/iio/industrialio-configfs.c    | 117 ++++++++++++++++++++
 drivers/iio/industrialio-sw-trigger.c  | 115 +++++++++++++++++++
 drivers/iio/trigger/Kconfig            |  10 ++
 drivers/iio/trigger/Makefile           |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 194 +++++++++++++++++++++++++++++++++
 include/linux/iio/sw_trigger.h         |  85 +++++++++++++++
 10 files changed, 619 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-iio
 create mode 100644 Documentation/iio/iio_configfs.txt
 create mode 100644 drivers/iio/industrialio-configfs.c
 create mode 100644 drivers/iio/industrialio-sw-trigger.c
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
 create mode 100644 include/linux/iio/sw_trigger.h

-- 
1.9.1
