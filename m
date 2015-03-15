Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34902 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbbCOUof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2015 16:44:35 -0400
Message-ID: <5505EF30.5020205@kernel.org>
Date: Sun, 15 Mar 2015 20:44:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, cleanups and functionality for the 4.1 cycle.
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 178cf7de6f1d3b95407f5a76af249fc924d42576:

  Merge 3.19-rc7 into staging-next (2015-02-02 08:41:02 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.1a

for you to fetch changes up to c0644160a8b5e56b3c3896d77ac3d50d41fa9336:

  iio: pressure: add support for MS5611 pressure and temperature sensor (2015-03-15 11:47:46 +0000)

----------------------------------------------------------------
First set of new drivers, cleanups and functionality for IIO in the 4.1 cycle.

New drivers
* CM3323 color sensor.
* MS5611 pressure and temperature sensor.

New functionality
* mup6050 - create mux clients for devices described via ACPI. The reasoning
     and approach taken in this patch are complex.  Basically there is no
     otherway of finding out what is there than by some esoteric look ups in
     the ACPI data.
* cm3232 - PM support
* itg3200 - suspend/resume support
* mcp320x - add more ADCs to the kconfig to reflect what the driver supports
     (this patch and the bindings got left behind when the support was added
      a while back).

Docs / utils
* ti-adc128s052 - DT bindings.
* mcp3422 - DT bindings.
* mcp320x - DT bindings
* ABI docs for event threshold scale attributes, in_magn_offset, proximity
  scan_element and thresh falling/rising values for accelerometers.  All
  elements long in use that have slipped by being explicitly documented.
* Tidy up the tools previously in drivers/staging/iio/Documentation and move
  them out to /tools/iio. Yet another move that should have happened long ago.
  This time Roberta Dobrescu did the leg work.  Thanks!

Core Cleanups
* Export userspace IIO headers.  We should have done the appropriate header
  splitting a long time ago. Thanks to Daniel for sorting this out.

* Refactor the registring of attributes for buffers to move all non-custom
  ones to a vector allowing easier additions to the current set in the future.

Driver Cleanups
* gpiod related cleanups.  Make use of the additional parameter to specify
  	initial direciton to avoid extra code.
* bmc150 - Various refactorings to reduce code repitition and prepare for
           hardware buffer support.  Some of these cleanups are good even
	   without the new functionality.
* kmx61 - direct use of index to an array avoiding a structure element which
          was always the index to an element in an array of that structure.
* vf610 - avoid incorrect type for return from wait_for_completion_timeout.
* gp2ap020a00f - use put_unaligned_le32 for slight code simplification.
* ade7754 - improve error handling including suppressing some build warnings.
* ade7759 - improve error handling including suppressing some build warnings.
* hmc5843 - Long line and indentation fixes. Also some constifying of various
      constant data.
* ade7854 - 80+ character line splitting.
* ad2s1210 - fix wrong printf format string.
* mxs-lradc - fix wrong printf format string.
* ade7954-i2c - code alignment fixes and other trivial but worthwhile bits.
* periodic rtc trigger - make the frequency type an unsigned int as it
  is always treated as such.
* jsa1212 - constify struct regmap_config as it is constant.
* ad7793 - typo in the MODULE_DESCRIPTION
* mma9551 - check gpiod_to_irq errors.  Note that this doesn't actually cause
    any trouble but is worth tidying up as obviously incorrect.
* mlx90614 - refactor the register symbols to make it clear which reads are to
    RAM not PROM.

----------------------------------------------------------------
Angelo Compagnucci (2):
      iio: ti-adc128s052: Add DT binding documentation
      iio: mcp3422: Add DT binding documentation

Daniel Baluta (3):
      iio: imu: kmx61: Drop odr_bits from kmx61_samp_freq_table
      iio: Export userspace IIO headers
      iio: light: Add support for Capella CM3323 color sensor

Darshana Padmadas (1):
      iio: Add ABI documentation for in_magn offset value

Devendra Naga (2):
      iio: meter: ade7754: add error handling in _reset and _stop_device
      iio: meter: ade7759: add error handling in _reset and _stop_device

Haneen Mohammed (2):
      iio: Add ABI documentation for proximity scan_elements
      iio : Add ABI documentation for thresh falling/rising value in accel

Kevin Tsai (1):
      iio: light: Added PM support for Capella CM3232 ambient light sensor driver.

Krzysztof Kozlowski (2):
      staging:iio:hmc5843: Constify register tables and struct regmap_config
      iio: jsa1212: Constify struct regmap_config

Martin Fuzzey (1):
      iio: doc: Describe scale attributes for event thresholds

Masanari Iida (1):
      iio:adc: Fix typo in MODULE_DESCRIPTION in ad7793.c

NeilBrown (1):
      iio: gyro: itg3200: add suspend/resume support.

Nicholas Mc Guire (1):
      iio: vf610_adc: cleanup wait_for_completion return handling

Octavian Purdila (6):
      iio: buffer: refactor buffer attributes setup
      iio: bmc150: refactor slope duration and threshold update
      iio: bmc150: refactor interrupt enabling
      iio: bmc150: exit early if event / trigger state is not changed
      iio: bmc150: introduce bmc150_accel_interrupt
      iio: bmc150: introduce bmc150_accel_trigger

Rickard Strandqvist (3):
      staging: iio: resolver: ad2s1210: Change type in printf format string
      staging: iio: adc: mxs-lradc: Change type in printf format string
      staging: iio: trigger: iio-trig-periodic-rtc: Change frequency type to unsigned int

Roberta Dobrescu (6):
      iio: accel: mma9551: Check gpiod_to_irq return value
      staging: iio: Documentation: iio_event_monitor: Include linux/iio/types.h
      staging: iio: Documentation: Introduce iio_utils.c
      iio: Move iio userspace applications out of staging
      tools: iio: Define _GNU_SOURCE in Makefile
      tools: iio: lsiio: Remove unused variables

Srinivas Pandruvada (1):
      iio: imu: inv_mpu6050: Create mux clients for ACPI

Søren Andersen (2):
      iio: adc: Kconfig mcp320x change description Add more ADCs
      dt-bindings Help for MCP ADCs

Tolga Ceylan (4):
      Staging:iio:hmc5843:Coding Style Correction
      Staging:iio:ade7854 Coding style correction
      Staging: iio: meter: ade7854-i2c: code style improvements
      Staging: iio: meter: ade7854-i2c: code style improvements

Tomasz Duszynski (1):
      iio: pressure: add support for MS5611 pressure and temperature sensor

Uwe Kleine-König (1):
      iio: improve usage of gpiod API

Vaishali Thakkar (1):
      iio: gp2ap020a00f: Use put_unaligned_le32

Vianney le Clément de Saint-Marcq (1):
      iio: mlx90614: Refactor register symbols

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +
 .../devicetree/bindings/iio/adc/mcp320x.txt        |  30 ++
 .../devicetree/bindings/iio/adc/mcp3422.txt        |  17 +
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  18 +
 MAINTAINERS                                        |   1 +
 drivers/iio/accel/bmc150-accel.c                   | 591 +++++++++++----------
 drivers/iio/accel/kxcjk-1013.c                     |   6 +-
 drivers/iio/accel/mma9551.c                        |   9 +-
 drivers/iio/accel/mma9553.c                        |   6 +-
 drivers/iio/adc/Kconfig                            |   5 +-
 drivers/iio/adc/ad7793.c                           |   2 +-
 drivers/iio/adc/vf610_adc.c                        |   5 +-
 drivers/iio/gyro/bmg160.c                          |   6 +-
 drivers/iio/gyro/itg3200_core.c                    |  29 +-
 drivers/iio/imu/inv_mpu6050/Makefile               |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         | 211 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   7 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   3 +
 drivers/iio/imu/kmx61.c                            |  70 +--
 drivers/iio/industrialio-buffer.c                  |  31 +-
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm3232.c                         |  36 ++
 drivers/iio/light/cm3323.c                         | 286 ++++++++++
 drivers/iio/light/gp2ap020a00f.c                   |   6 +-
 drivers/iio/light/jsa1212.c                        |   2 +-
 drivers/iio/pressure/Kconfig                       |  27 +
 drivers/iio/pressure/Makefile                      |   3 +
 drivers/iio/pressure/ms5611.h                      |  44 ++
 drivers/iio/pressure/ms5611_core.c                 | 215 ++++++++
 drivers/iio/pressure/ms5611_i2c.c                  | 128 +++++
 drivers/iio/pressure/ms5611_spi.c                  | 127 +++++
 drivers/iio/proximity/sx9500.c                     |   6 +-
 drivers/iio/temperature/mlx90614.c                 |   8 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   2 +-
 drivers/staging/iio/magnetometer/hmc5843_i2c.c     |  42 +-
 drivers/staging/iio/magnetometer/hmc5843_spi.c     |   8 +-
 drivers/staging/iio/meter/ade7754.c                |  15 +-
 drivers/staging/iio/meter/ade7759.c                |  14 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |  39 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   4 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |  12 +-
 include/linux/iio/events.h                         |  30 +-
 include/linux/iio/types.h                          |  78 +--
 include/uapi/linux/Kbuild                          |   1 +
 include/uapi/linux/iio/Kbuild                      |   3 +
 include/uapi/linux/iio/events.h                    |  42 ++
 include/uapi/linux/iio/types.h                     |  92 ++++
 tools/iio/Makefile                                 |  16 +
 .../Documentation => tools/iio}/generic_buffer.c   |   3 +-
 .../iio}/iio_event_monitor.c                       |   4 +-
 .../iio_utils.h => tools/iio/iio_utils.c           |  50 +-
 tools/iio/iio_utils.h                              |  71 +++
 .../iio/Documentation => tools/iio}/lsiio.c        |   5 -
 54 files changed, 1905 insertions(+), 598 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp320x.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
 create mode 100644 drivers/iio/light/cm3323.c
 create mode 100644 drivers/iio/pressure/ms5611.h
 create mode 100644 drivers/iio/pressure/ms5611_core.c
 create mode 100644 drivers/iio/pressure/ms5611_i2c.c
 create mode 100644 drivers/iio/pressure/ms5611_spi.c
 create mode 100644 include/uapi/linux/iio/Kbuild
 create mode 100644 include/uapi/linux/iio/events.h
 create mode 100644 include/uapi/linux/iio/types.h
 create mode 100644 tools/iio/Makefile
 rename {drivers/staging/iio/Documentation => tools/iio}/generic_buffer.c (99%)
 rename {drivers/staging/iio/Documentation => tools/iio}/iio_event_monitor.c (99%)
 rename drivers/staging/iio/Documentation/iio_utils.h => tools/iio/iio_utils.c (91%)
 create mode 100644 tools/iio/iio_utils.h
 rename {drivers/staging/iio/Documentation => tools/iio}/lsiio.c (97%)
