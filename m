Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 0/2] Add IIO support for counter devices
Date: Wed, 21 Sep 2016 16:15:45 -0400
Message-Id: <cover.1474487854.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Changes in v4:
  - Append documentation for new IIO counter attributes to end of
    Documentation/ABI/testing/sysfs-bus-iio file
  - Return raw index input value for IIO_CHAN_INFO_RAW of IIO_INDEX;
    previously, index function (IDX) operation signal was returned
  - Remove borrow, carry, compare, and sign attributes; the main utility
    of these toggle flags can be provided seamlessly to the user via a
    count range extension
  - Extend range of counter to 25-bit; borrow XOR carry effectively
    doubles count range
  - Rename "error" attribute to more specific "noise_error"
  - Default to binary encoding for counter count value and remove
    encoding attribute
  - Refactor quadrature_mode attribute to simply enable quadrature clock
    mode and add IIO_CHAN_INFO_SCALE count option to select the encoder
    phase division (1 = full-cycle, 2 = half-cycle, 4 = quarter-cycle)
    processed by the counter; RFC: would it be better to turn this scale
    attribute into a "quadrature_phase" ext_info with an IIO_ENUM to
    select between the different quadrature cycle processing modes
  - Rename "index_function" attribute to "synchronous_mode" for clarity;
    the index input on the 104-QUAD-8 is wired to the index function
    (IDX) "LCNTR/LOL" pin on the LS7266R1 chips, meaning the function
    selected via preset_enable (Load Counter or Load Output Latch) is
    performed non-sychronously/synchronously with the quadrature clock
    when the index input goes to active level
  - Add documentation for 104-QUAD-8 IIO sysfs attributes at
    Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8

This patchset adds new IIO channel type and info constants to facilitate
support for counter devices. In addition, a new "counter" subdirectory
is created to house drivers for these counter devices.

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patchset introduces several IIO
constants for supporting quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Counter device index value
  IIO_CHAN_INFO_PRESET: Counter preset value

Specifically, this patchset introduces a driver to support the ACCES
104-QUAD-8 device, a general purpose quadrature encoder
counter/interface board capable of monitoring the outputs of eight
encoders.

William Breathitt Gray (2):
  iio: Implement counter channel type and info constants
  iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-iio            |  28 +
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   | 124 +++++
 MAINTAINERS                                        |   6 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/counter/104-quad-8.c                   | 582 +++++++++++++++++++++
 drivers/iio/counter/Kconfig                        |  24 +
 drivers/iio/counter/Makefile                       |   7 +
 drivers/iio/industrialio-core.c                    |   3 +
 include/linux/iio/iio.h                            |   1 +
 include/uapi/linux/iio/types.h                     |   2 +
 11 files changed, 779 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

-- 
2.7.3
