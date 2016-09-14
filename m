Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/2] Add IIO support for counter devices
Date: Wed, 14 Sep 2016 15:24:09 -0400
Message-Id: <cover.1473877757.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes in v2:
  - New IIO constants have been reduced to three: IIO_COUNT, IIO_INDEX,
    and IIO_CHAN_INFO_PRESET
  - 104-QUAD-8 specific flags, modes, and configurations have been
    broken out and exposed via ext_info elements

This patchset adds new IIO channel type and info constants to facilitate
support for counter devices. In addition, a new "counter" subdirectory
is created to house drivers for these counter devices.

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patch introduces the counter
subdirectory and several IIO constants for supporting quadrature encoder
counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_PRESET: Counter preset value

Specifically, this patchset introduces a driver to support the ACCES
104-QUAD-8 device, a general purpose quadrature encoder
counter/interface board capable of monitoring the outputs of eight
encoders.

William Breathitt Gray (2):
  iio: Implement counter channel type and info constants
  iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8

 MAINTAINERS                      |   6 +
 drivers/iio/Kconfig              |   1 +
 drivers/iio/Makefile             |   1 +
 drivers/iio/counter/104-quad-8.c | 697 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/counter/Kconfig      |  22 ++
 drivers/iio/counter/Makefile     |   7 +
 drivers/iio/industrialio-core.c  |   3 +
 include/linux/iio/iio.h          |   1 +
 include/uapi/linux/iio/types.h   |   2 +
 9 files changed, 740 insertions(+)
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

-- 
2.7.3
