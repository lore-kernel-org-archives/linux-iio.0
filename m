Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 0/3] iio: chemical: add Atlas pH-SM sensor support
Date: Tue, 15 Dec 2015 01:26:11 -0800
Message-Id: <1450171574-3283-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes from v1:
* Add triggered buffer support 
* Rework runtime PM functionality
* Add more verbosity to the sysfs-bus-iio documentation
* Correct buffer size with padding bytes

IMPORTANT NOTE: Hasn't been tested on actual hardware yet

Matt Ranostay (3):
  devicetree: add Atlas Scientific LLC vendor prefix
  iio: ph: add IIO_PH channel type
  iio: chemical: add Atlas pH-SM sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  22 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/chemical/Kconfig                       |  13 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/atlas-ph-sensor.c             | 431 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/uapi/linux/iio/types.h                     |   1 +
 8 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 drivers/iio/chemical/atlas-ph-sensor.c

-- 
1.9.1
