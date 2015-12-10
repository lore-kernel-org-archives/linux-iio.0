Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v1 0/3] iio: chemical: add Atlas pH-SM sensor support
Date: Thu, 10 Dec 2015 00:10:45 -0800
Message-Id: <1449735048-16668-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

* Initial revision of a driver that enables support for the Atlas
  Scientific pH-SM chemical sensor
* Add new IIO_PH iio_chan_type
* Add Atlas Scientific LLC devicetree vendor id

NOTE: Not tested on actual hardware yet. Hence the RFC prefix, just want
      early feedback.

Matt Ranostay (3):
  devicetree: add Atlas Scientific LLC vendor prefix
  iio: ph: add IIO_PH channel type
  iio: chemical: add Atlas pH-SM sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   6 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 385 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 8 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c

-- 
1.9.1
