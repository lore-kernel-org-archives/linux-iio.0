Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/2] Add IIO support for counter devices
Date: Wed,  7 Sep 2016 13:55:01 -0400
Message-Id: <cover.1473265537.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds new IIO channel type and info constants to facilitate
support for counter devices. In addition, a new "counter" subdirectory
is created to house drivers for these counter devices.

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. The following IIO enumeration constants
are introduced to support quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)

  IIO_CHAN_INFO_FLAGS: Counter flag states (e.g. underflows, overflows,
                       errors, etc.)
  IIO_CHAN_INFO_DIRECTION: Set high when counting up and reset low when
                           counting down
  IIO_CHAN_INFO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_MODE: Count value encoding, counter range setting,
                      quadrature phase mode, etc.
  IIO_CHAN_INFO_PRESET: Counter preset value
  IIO_CHAN_INFO_PRESET_EN: Set high to preset counter on signal (e.g.
                           index input at active level)

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
 drivers/iio/counter/104-quad-8.c | 265 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/counter/Kconfig      |  23 ++++
 drivers/iio/counter/Makefile     |   7 ++
 drivers/iio/industrialio-core.c  |   7 ++
 include/linux/iio/iio.h          |   6 +
 include/uapi/linux/iio/types.h   |   1 +
 9 files changed, 317 insertions(+)
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

-- 
2.7.3
