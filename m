Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57430 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbHLSfh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 14:35:37 -0400
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL v2] Second set of new drivers, functionality and cleanup for
 IIO in the 4.3 cycle (+ some fixes)
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CB91F8.4040505@kernel.org>
Date: Wed, 12 Aug 2015 19:35:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit b8d1f261fe7e4967593a5637d62991b6197a03f8:

  staging: dgap: remove duplicate code (2015-07-16 10:19:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.3b-2

for you to fetch changes up to 41d903c00051d8f31c98a8136edbac67e6f8688f:

  iio: event: Remove negative error code from iio_event_poll (2015-08-12 19:26:39 +0100)

----------------------------------------------------------------
Second set of new device support, features and cleanup for the 4.3 cycle.
Take 2 also includes a fix set that was too late for the 4.2 cycle.

As we had a lot of tools and docs work in this set, I have broken those
out into their own categories in this description.

Fixes from the pull request '4th set of IIO fixes for the 4.2 cycle'.
* Poll functions for both event chardev and the buffer one were returning
  negative error codes (via a positive value).
* A recent change to lsiio adding some error handling that was wrong and
  stopped the tool working.
* bmg160 was missing some dependencies in Kconfig
* berlin2-adc had a misshandled register (wrote a value rather than a bitmap)

New device support
* TI opt3001 light sensor
* TXC PA12 ALS and proximity sensor.
* mcp3301 ADC support (in mcp320x driver)
* ST lsm303agr accelerometer and magnetometer drivers (plus some st-sensors
  common support to allow different WHOAMI register addresses, devices with
  fixed scale and allow interrupt equiped magnetometers).
* ADIS16305, ADIS16367, ADIS16445IMUs (in the adis16400 driver)
* ADIS16266 gyro (in the adis16260 driver)
* ADIS16137 gyro (in the adis16136 driver)

New functionality
* mmc35240 DT bindings.
* Inverse unit conversion macros to aid handing of values written to sysfs
  attributes.

Core cleanup
* Forward declaration of struct iio_trigger to avoid a compile warning.

Driver cleanup / fixes
* mxs-lradc
  - Clarify which parts are supported.
  - Fix spelling erorrs.
  - Missing/extra includes
  - reorder includes
  - add datasheet name listings for all usable channels (to allow them
    to be bound by name from consumer drivers)
* acpi-als - add some function prefixes as per general iio style.
* bmc150_magn - replace a magic value with the existing define.
* vf610 - determine possible sample frequencies taking into account the
  electrical characteristics (defining a minimum sample time)
* dht11
  - whitespace
  - additional docs
  - avoid mulitple assignments in one line
  - Use the new funciton ktime_get_resolution_ns to cleanup a nasty trick
    previously used for timing.
* Fix all drivers that consider 0 a valid IRQ for historical reasons.
* Export I2C module alias info where previously missing (to allow autoprobing)
* Export OF module alias info where previously missing.
* mmc35240 - switch some variables into arrays to improve readability.
* mlx90614 - define some magic numbers for readability.
* bmc150_magn
  - expand area locked by a mutex to cover all the use of the
    data->buffer.
  - use descriptive naming for a mask instead of a magic value.
* berin2-adc
  - pass up an error code rather that a generic error
  - constify the iio_chan_spec
  - some other little tidy ups.
* stk8312
  - fix a dependency on triggered buffers in kconfig
  - add a check for invalid attribute values
  - improve error handling by returning error codes where possible and
    return immediately where relevant
  - rework macro defs to use GENMASK etc
  - change some variable types to reduce unnecessary casting
  - clean up code style
  - drop a local buffer copy for bulk reads and use the one in data->buffer
     instead.
* adis16400 - the adis16448 gyroscope scale was wrong.
* adis16480 - some more wrong scales for various parts.
* adis16300 - has an undocumented product id and serial number registers so
  use them.
* iio_simple_dummy - fix some wrong code indentation.
* bmc150-accel - use the chip ID to detect the chip present rather than
  verifying the expected part was there.  This was in response to a wrong
  ACPI entry on the WinBook TW100.
* mma8452
  - fix _get_hp_filter_index
  - drop a double include
  - pass up an error code rather than rewriting it
  - range check input values to attribute writes
  - register defs tidy up using GENMASK and reordering them to be easier to
    follow.
  - various coding style cleanups
  - put the Kconfig entry in the write place (alphabetically).

Tools related
* Tools cleanup - drop an explicity NULL comparison, some unnecessary braces,
  use the ARRAY_SIZE macro, send error messages to stderr instead of dropping
  them in the middle of normal output.
* Fix tools to allow that scale and offset attributes are optional.
* More tools fixes including allowing true 32bit data (previously an overflow
  prevented more than 31bits)
* Drop a stray header guard that ended up in a c file.
* Make calc_digits static as it isn't exported or in the header.
* Set ci_array pointer to NULL after free as a protection against non safe
  usage of the tools core code.  Also convert a double pointer to a single
  one as the extra level of indirection was unnecessary.

Docs
* DocBook introduction by Daniel Baluta.  Glad we are beginning to
  draw together some more introductory docs to suplement the various
  tools / examples.
* Drop bytes_per_datum sysfs attribute docs as it no longer exists.
* A whole load of missing / fixing of kernel-doc for the core of IIO.
* Document the trigger name sysfs attribute in the ABI docs.
* Minor typos in the ABI docs related to power down modes.

----------------------------------------------------------------
Adriana Reus (1):
      iio: light: Add support for TXC PA12 als and proximity sensor

Andrea Galbusera (1):
      iio: adc: mcp320x: Add support for mcp3301

Andreas Dannenberg (1):
      iio: light: add support for TI's opt3001 light sensor

Bastien Nocera (2):
      iio:accel:bmc150-accel: Move bmc150_accel_chip_init()
      iio:accel:bmc150-accel: Use the chip ID to detect sensor variant

Cristina Opriceana (14):
      iio: Documentation: Remove bytes_per_datum attribute
      tools: iio: Remove explicit NULL comparison
      tools: iio: Remove unnecessary braces
      tools: iio: Add ARRAY_SIZE macro
      tools: iio: Send error messages to stderr
      iio: core: Add function params for kernel docs
      iio: buffer: Fix kernel docs warnings
      iio: event: Add missing fields in kernel docs
      include: linux: iio: Fix function parameter name in kernel doc
      include: linux: iio: Add missing kernel doc field
      iio: Documentation: Add trigger name attribute ABI documentation
      iio: trigger: Add missing fields in kernel docs
      iio: industrialio-buffer: Fix iio_buffer_poll return value
      iio: event: Remove negative error code from iio_event_poll

Crt Mori (1):
      iio: mlx90614: Define magic numbers

Daniel Baluta (1):
      DocBook: Add initial documentation for IIO

Giuseppe Barba (5):
      iio: st-sensors: add configuration for WhoAmI address
      iio: st-sensors: add support for single full scale device
      iio: st_magn: Add irq trigger handling
      iio: st-accel: add support for lsm303agr accelerometer
      iio: st-magn: add support for lsm303agr magnetometer

Harald Geyer (4):
      iio: dht11: whitespace changes to make checkpatch.pl --strict happy
      iio: dht11: add comment to make checkpatch.pl --strict happy
      iio: dht11: avoid multiple assignments to make checkpatch.pl --strict happy
      iio: dht11: Use new function ktime_get_resolution_ns()

Hartmut Knaack (23):
      iio:light:acpi-als: add missing prefixes
      iio:magnetometer:bmc150_magn: replace magic value
      iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
      iio:magnetometer:bmc150_magn: use descriptive name for mask
      iio:adc:berlin2-adc: pass up real error code
      iio:adc:berlin2-adc: constify iio_chan_spec
      iio:adc:berlin2-adc: use short operator format
      iio:adc:berlin2-adc: use channel-array size directly
      iio:accel:stk8312: add triggered buffer dependency
      iio:accel:stk8312: check for invalid value
      iio:accel:stk8312: improve error handling
      iio:accel:stk8312: rework macro definitions
      iio:accel:stk8312: use appropriate variable types
      iio:accel:stk8312: code style cleanup
      iio:accel:stk8312: drop local buffer
      iio:accel:mma8452: fix _get_hp_filter_index
      iio:accel:mma8452: drop double include
      iio:accel:mma8452: pass up real error code
      iio:accel:mma8452: check values to be written
      iio:accel:mma8452: rework register definitions
      iio:accel:mma8452: coding style cleanup
      iio:accel:mma8452: reorder Kconfig entry
      iio:adc:berlin2-adc: Fix register definition

Irina Tirdea (4):
      iio: magn: bmc150_magn: add locking comment for runtime resume
      iio: magn: bmc150_magn: do not set power state twice when setting trigger state
      tools: iio: fix mask for 32 bit sensor data
      tools: iio: print error message when buffer enable fails

Jandy Gou (2):
      iio: magnetometer: mmc35240: Add DT binding
      iio: magnetometer: mmc35240: Add DT binding doc

Javier Martinez Canillas (2):
      iio: Export I2C module alias information in missing drivers
      iio: Export OF module alias information in missing drivers

Joo Aun Saw (5):
      tools: iio: make scale and offset files optional
      tools: iio: iio_utils: remove unnecessary define guard
      tools: iio: iio_utils: Make calc_digits static
      tools: iio: Set caller's ci_array pointer to NULL after free
      tools: iio: remove unnecessary double pointer

Lars Svensson (1):
      staging: iio_simple_dummy: Fix indentation errors

Lars-Peter Clausen (9):
      iio: adis16400: Fix adis16448 gyroscope scale
      iio: Add inverse unit conversion macros
      iio: adis16480: Fix scale factors
      iio: adis16400: adis16300 has product ID and serial number
      iio: adis16400: Add ADIS16305 support
      iio: adis16260: Add ADIS16266 support
      iio: adis16400: Add ADIS16367 support
      iio: adis16400: Add ADIS16445 support
      iio: adis16136: Add ADIS16137 support

Linus Walleij (1):
      iio: lsiio: fix error code handling error

Markus Pargmann (1):
      iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER are required

Octavian Purdila (1):
      iio: fix drivers that consider 0 as a valid IRQ in client->irq

Pengyu Ma (1):
      iio: declare struct to fix warning

Sanchayan Maity (1):
      iio: adc: vf610: Determine sampling frequencies by using minimum sample time

Stefan Wahren (6):
      iio: mxs-lradc: clarify supported devices
      iio: mxs-lradc: fix some spelling errors
      iio: mxs-lradc: add missing include
      iio: mxs-lradc: remove unnecessary header includes
      iio: mxs-lradc: reorder header includes
      iio: mxs-lradc: add datasheet name for every usable channel

Teodora Baluta (1):
      iio: mmc35240: minor change to improve code readibility

Vladimir Barinov (1):
      iio: Fix typos in ABI documentation

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |   9 +
 Documentation/DocBook/Makefile                     |   2 +-
 Documentation/DocBook/iio.tmpl                     | 697 ++++++++++++++++++
 .../devicetree/bindings/iio/adc/mcp320x.txt        |   1 +
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   5 +
 .../bindings/iio/magnetometer/mmc35240.txt         |  13 +
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 .../bindings/staging/iio/adc/mxs-lradc.txt         |   2 +-
 drivers/iio/accel/Kconfig                          |  26 +-
 drivers/iio/accel/bmc150-accel.c                   | 156 ++--
 drivers/iio/accel/kxcjk-1013.c                     |   2 +-
 drivers/iio/accel/mma8452.c                        | 217 +++---
 drivers/iio/accel/mma9553.c                        |   2 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |   6 +
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   1 +
 drivers/iio/accel/stk8312.c                        | 107 +--
 drivers/iio/accel/stk8ba50.c                       |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/berlin2-adc.c                      |  22 +-
 drivers/iio/adc/mcp320x.c                          |  16 +-
 drivers/iio/adc/vf610_adc.c                        |  79 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  52 +-
 drivers/iio/gyro/Kconfig                           |   3 +-
 drivers/iio/gyro/adis16136.c                       |   6 +
 drivers/iio/gyro/adis16260.c                       | 137 +++-
 drivers/iio/gyro/st_gyro_core.c                    |   3 +
 drivers/iio/humidity/dht11.c                       |  65 +-
 drivers/iio/imu/adis16400_core.c                   |  46 +-
 drivers/iio/imu/adis16480.c                        |  39 +-
 drivers/iio/imu/kmx61.c                            |   8 +-
 drivers/iio/industrialio-buffer.c                  |  17 +-
 drivers/iio/industrialio-core.c                    |  25 +-
 drivers/iio/industrialio-event.c                   |   8 +-
 drivers/iio/industrialio-trigger.c                 |  27 +-
 drivers/iio/light/Kconfig                          |  21 +
 drivers/iio/light/Makefile                         |   2 +
 drivers/iio/light/acpi-als.c                       |  18 +-
 drivers/iio/light/cm32181.c                        |   1 +
 drivers/iio/light/cm3232.c                         |   1 +
 drivers/iio/light/cm36651.c                        |   1 +
 drivers/iio/light/gp2ap020a00f.c                   |   1 +
 drivers/iio/light/opt3001.c                        | 804 +++++++++++++++++++++
 drivers/iio/light/pa12203001.c                     | 483 +++++++++++++
 drivers/iio/light/stk3310.c                        |   1 +
 drivers/iio/magnetometer/bmc150_magn.c             |  24 +-
 drivers/iio/magnetometer/mmc35240.c                |  33 +-
 drivers/iio/magnetometer/st_magn.h                 |   3 +
 drivers/iio/magnetometer/st_magn_buffer.c          |   7 +
 drivers/iio/magnetometer/st_magn_core.c            |  98 ++-
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
 drivers/iio/magnetometer/st_magn_spi.c             |   1 +
 drivers/iio/pressure/st_pressure_core.c            |   3 +
 drivers/iio/temperature/mlx90614.c                 |  20 +-
 drivers/staging/iio/adc/mxs-lradc.c                | 122 ++--
 drivers/staging/iio/iio_simple_dummy_events.c      |   4 +-
 include/linux/iio/common/st_sensors.h              |   2 +
 include/linux/iio/consumer.h                       |   2 +-
 include/linux/iio/iio.h                            |  17 +
 include/linux/iio/sysfs.h                          |   3 +-
 include/linux/iio/trigger.h                        |   3 +
 tools/iio/generic_buffer.c                         |  48 +-
 tools/iio/iio_event_monitor.c                      |  17 +-
 tools/iio/iio_utils.c                              | 136 ++--
 tools/iio/iio_utils.h                              |   4 +-
 tools/iio/lsiio.c                                  |  16 +-
 68 files changed, 3150 insertions(+), 576 deletions(-)
 create mode 100644 Documentation/DocBook/iio.tmpl
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
 create mode 100644 drivers/iio/light/opt3001.c
 create mode 100644 drivers/iio/light/pa12203001.c
