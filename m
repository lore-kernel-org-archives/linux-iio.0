Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 0/3] Add MMA9553 driver & PM support for MMA9551
Date: Tue, 27 Jan 2015 20:41:51 +0200
Message-Id: <1422384114-23392-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This set of patches adds support for Freescale MMA9553L Intelligent
Pedometer Platform
(http://www.freescale.com/files/sensors/doc/ref_manual/MMA9553LSWRM.pdf).

Changes in v3:
 - replaced  IIO_CHAN_INFO_FILTER_OUTLIERS_THRESH with
IIO_CHAN_INFO_DEBOUNCE_COUNT and IIO_CHAN_INFO_FILTER_OUTLIERS_PERIOD with
IIO_CHAN_INFO_DEBOUNCE_TIME.
 - changed the calibheight unit from centimeters to meters
 - renamed the register macrodefinitions to make it clear which is the adress
and which is the mask
 - removed IIO_CHAN_INFO_DEBOUNCE_COUNT and added the code to the mma9553 driver

Changes in v2:
 - removed IIO_CHAN_INFO_CALIBGENDER and used extended attribute
enum interface instead
 - renamed IIO_CALORIES channel to IIO_ENERGY
 - replaced IIO_SPEED with IIO_VELOCITY and IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z
 - introduced IIO_EV_TYPE_CHANGE to use for step detector instead of
IIO_EV_TYPE_INSTANCE
 - introduce IIO_CHAN_INFO_FILTER_OUTLIERS_THRESH and
IIO_CHAN_INFO_FILTER_OUTLIERS_PERIOD
 - add kernel-doc comments to functions exported in mma9551_core.c
 - updated ABI documentation to include all exported attributes in mma9553
 - updated mma9553 driver code according to comments from Jonathan

Irina Tirdea (3):
  iio: core: Introduce IIO_CHAN_INFO_DEBOUNCE_COUNT and _TIME
  iio: Documentation: Fix calibheight unit
  iio: add driver for Freescale MMA9553

 Documentation/ABI/testing/sysfs-bus-iio |   66 +-
 drivers/iio/accel/Kconfig               |   10 +
 drivers/iio/accel/Makefile              |    1 +
 drivers/iio/accel/mma9551_core.c        |  183 +++++
 drivers/iio/accel/mma9551_core.h        |   17 +-
 drivers/iio/accel/mma9553.c             | 1334 +++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |    2 +
 include/linux/iio/iio.h                 |    2 +
 8 files changed, 1609 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iio/accel/mma9553.c

-- 
1.9.1
