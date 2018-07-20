Return-Path: <m.othacehe@gmail.com>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: jic23@jic23.retrosnub.co.uk,
	linux-iio@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	pmeerw@pmeerw.net,
	pierre-moana.levesque@parrot.com,
	Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 0/3] Add ISL29501 support.
Date: Fri, 20 Jul 2018 19:34:24 +0200
Message-Id: <20180720173427.30445-1-m.othacehe@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

Here's v6 of this serie, please find the changelog below.

Thanks,

Mathieu

v6:
* Extract floating registers support as a separated, wip patch.
* Style corrections
v5:
* Use IIO_MOD_LIGHT_CLEAR modifier for IIO_INTENSITY channel
describing ambient light intensity and remove extended_names doing so.
* Fix a possible leakage in isl29501_trigger_handler function.
v4:
* Fix build warnings and rebase on top of next-20180628
v3:
* Renamings to add isl29501 prefix
* Rename "amb" -> "light" in extended fields
* Move mutex lock/unlock to register_read and register_write functions
* Improve IIO_PHASE scale output with a better pi estimation
v2:
* Add missing eof new line
* Do not set .indexed to true for all channels
* Add a .extended to differenciate "magnitude" and "ambient_light"
  intensity channels
* Return isl29501_begin_acquisition result in isl29501_init_chip
* Fix buffer size in isl29501_trigger_handler

Mathieu Othacehe (3):
  iio: Add channel for Phase
  iio: light: isl29501: Add support for the ISL29501 ToF sensor.
  iio: light: isl29501: Add support floating registers.

 Documentation/ABI/testing/sysfs-bus-iio       |    7 +
 .../ABI/testing/sysfs-bus-iio-isl29501        |   47 +
 .../bindings/iio/light/isl29501.txt           |   13 +
 drivers/iio/industrialio-core.c               |    1 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/isl29501.c                  | 1125 +++++++++++++++++
 include/uapi/linux/iio/types.h                |    1 +
 tools/iio/iio_event_monitor.c                 |    2 +
 9 files changed, 1210 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 drivers/iio/light/isl29501.c

-- 
2.17.1
