Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932149AbeCKORh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Mar 2018 10:17:37 -0400
Date: Sun, 11 Mar 2018 14:17:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second set of new drivers and cleanups for IIO in the 4.17
 cycle.
Message-ID: <20180311141733.31e977eb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 721dfe4133a9a41e4b4a74e5b41089b7dac8f539:

  staging: speakup: remove space after a cast (2018-02-23 09:54:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.17b

for you to fetch changes up to 9aa5134ac486b48c4c8ac14571e6034131f040f8:

  staging:iio:ad2s1210: Remove old_data from ad2s1210_state (2018-03-10 17:21:23 +0000)

----------------------------------------------------------------
Second set of new device support, features and cleanup for IIO in the 4.17 cycle

The uptick in staging cleanup is partly due to GSoC Applications
process being underway and one of Daniel's tasks being to try
cleaning up an IIO driver to move out of staging.
Naturally there is some normal staging cleanup progress in here
as well.

New device support
* Microchip mcp4018
  - New driver supproting MCP4017, MCP4018 and MCP4019 digital pots.
* On Semiconductor lv0104cs
  - New driver to support this ambient light sensor.

Cleanup
* axp20x_adc
  - remove a !! in favour of clear ternary operator.
* ad2s1210 (staging cleanup)
  - Reorganise to avoid ending a line with [
  - Remove some unnecessary defines.
  - Remove unsed variable.
* ad5380
  - Replace magic 0 with IIO_CHAN_INFO_RAW
* ad5764
  - Replace magic 0 with IIO_CHA_INFO_RAW
* ad7150 (staging cleanup)
  - Align arguements with parenthesis.
* ad7152 (staging cleanup)
  - Align arguements.
* ad7746 (staging cleanup)
  - Align arguements.
* ad7816
  - Remove pointless void pointer cast.
* ade7753
  - Replace IIO_DEV_ATTR_CH_OFF with equivalent to avoid confusing
    checkpatch (this macro didn't really help anyway).  Also drop the
    macro from the meter.h header.
* ade7754 (staging cleanup)
  - Add names to funciton definition arguements.
  - Align arguements with open parenthesis where possible.
* ade7758 (staging cleanup)
  - Remove __func__ from dev_dbg statements as provided by dynamic
    debug anyway.
  - Align arguements with open parenthesis where possible.
* ade7759 (staging cleanup)
  - Replace IIO_DEV_ATTR_CH_OFF with equiavalent to avoid confusing
    checkpatch.
* adis16201 (staging cleanup)
  - Headers in alphabetical order.
  - Blank lines before returns.
* adis16209 (staging cleanup)
  - Headers in alphabetical order
  - Change some definition names to make them more meaningful (2 rounds
    of this).
  - Add explicit _REG prefix to register names to make them
    obviously different from fields within those registers.
  - Remove some superflous comments and group definitions better.
  - Use a switch statement to make it semantically obvious that we
    only have two options (rather than an unlimited 'else').
  - Use sign_extent32 instead of open coding.
* adt7316 (staging cleanup)
  - Move an export next to symbol.
* bmc150
  - drop redundant __func__ in dynamic debug.
* ccs811
  - Rename varaible to better reflect what it does.
* cros_ec
  - Reduce sampling frequency before suspending to avoid preventing
    suspend.
* dummy
  - Correct whitespace in Kconfig.
  - Add extra description in Kconfig.
* ds1803
  - Remove a VLA which we always know is 2 long.
* hid-sensor-accel
  - Replace magic number 0 by IIO_CHAN_INFO_RAW.
* hid-sensor-gyro
  - Replace magic number 0 by IIO_CHAN_INFO_RAW.
* hid-sensor-light
  - Replace magic number 0 by IIO_CHAN_INFO_RAW.
* hid-sensor-magn
  - Replace magic number 0 by IIO_CHAN_INFO_RAW.
* lm3533
  - Replace magic number 0 by IIO_CHAN_INFO_RAW
* mlx90632
  - Squash a smatch warning - no runtime effect.
* stm32_dfsdm:
  - Cleanup the dt bindings.
* sx9500
  - Add GPIO ACPI mapping table to behave correctly when firmware
    doesn't provide the mapping.
* tsl2x7x (staging cleanup)
  - Fix the proximity sensor functionality.
  - Remove platform data provided power functions.  There are much
    better ways to do this these days.
  - Introduce some common functions to avoid various repititions.
  - Stop using mutex_trylock when mutex_lock and wait a bit is fine.
  - Improve error handling in various places.
  - Drop some 'Camel case' (which wasn't actually strickly camel case
    but was a bit odd.
  - Drop some _available sysfs attributes for things that don't exist
    (for particular supported parts).

----------------------------------------------------------------
Andy Shevchenko (2):
      iio: accel: bmc150: Remove redundant __func__ in dev_dbg()
      iio: proximity: sx9500: Add GPIO ACPI mapping table

Arushi Singhal (1):
      staging: iio: Remove unnecessary cast on void pointer

Brian Masney (11):
      staging: iio: tsl2x7x: remove power functions from tsl2X7X_platform_data
      staging: iio: tsl2x7x: add common function for clearing interrupts
      staging: iio: tsl2x7x: add common function for reading chip status
      staging: iio: tsl2x7x: add common function for writing to the control register
      staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
      staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
      staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from checkpatch
      staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
      staging: iio: tsl2x7x: add missing error checks
      staging: iio: tsl2x7x: remove unnecessary sysfs attribute
      staging: iio: tsl2x7x: make proximity sensor function correctly

Dan Carpenter (1):
      iio temperature/mlx90632: silence a static checker warning

David Veenstra (2):
      Staging: iio: adt7316: Move symbol export to definition
      Staging: iio: ad7746: Adjust arguments to match open parenthesis

Fabrice Gasnier (1):
      dt-bindings: iio: adc: stm32-dfsdm: fix types, add missing pinctrl

Gwendal Grignou (1):
      iio: cros_ec: Relax sampling frequency before suspending

HariPrasath Elango (1):
      staging: iio: meter: Remove reduntant __func__ from debug print

Himanshu Jha (3):
      Staging: iio: accel: adis16201: Prefer alphabetical sequence of header files
      Staging: iio: accel: adis16201: Add a blank space before returns
      iio: potentiometer: ds1803: Remove VLA usage

Jeff LaBundy (1):
      iio: light: lv0104cs: Add support for LV0104CS light sensor

Peter Rosin (1):
      iio: potentiometer: mcp4018: driver for Microchip digital potentiometers

Quentin Schulz (1):
      iio: adc: axp20x_adc: remove !! in favor of ternary condition

Richard Lai (1):
      iio: chemical: ccs811: Renamed resistance member in ccs811_reading struct

Rodrigo Siqueira (11):
      staging:iio:meter: Add name to function definition arguments
      iio: dummy: Add correct tabs and spaces to Kconfig
      iio:dummy: Add extra paragraphs on Kconfig
      iio:magnetometer: Replace magic number 0 by IIO_CHAN_INFO_RAW
      staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
      staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
      staging:iio:meter: Aligns open parenthesis
      iio: Replace occurrences of magic number 0 by IIO_CHAN_INFO_RAW
      staging:iio:ad2s1210: Remove end of line with '['
      staging:iio:ad2s1210: Remove unused #define directive
      staging:iio:ad2s1210: Remove old_data from ad2s1210_state

Shreeya Patel (7):
      Staging: iio: adis16209: Arrange headers in alphabetical order
      Staging: iio: adis16209: Change the definition name
      Staging: iio: adis16209: Add _REG postfix for registers
      Staging: iio: adis16209: Remove and add some comments and group the definitions
      Staging: iio: adis16209: Change some macro names
      Staging: iio: adis16209: Adjust a switch statement
      Staging: iio: adis16209: Use sign_extend32 function

Tom Lebreux (2):
      staging:iio:ad7152: Align arguments to match open parenthesis
      staging:iio:ad7150: Align arguments to match open parenthesis

 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |   8 +-
 MAINTAINERS                                        |   3 +-
 drivers/iio/accel/bmc150-accel-core.c              |   6 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   2 +-
 drivers/iio/adc/axp20x_adc.c                       |   8 +-
 drivers/iio/chemical/ccs811.c                      |   6 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   1 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  49 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  |   2 +
 drivers/iio/dac/ad5380.c                           |   2 +-
 drivers/iio/dac/ad5764.c                           |   2 +-
 drivers/iio/dummy/Kconfig                          |  27 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   2 +-
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cros_ec_light_prox.c             |   1 +
 drivers/iio/light/hid-sensor-als.c                 |   2 +-
 drivers/iio/light/lm3533-als.c                     |   2 +-
 drivers/iio/light/lv0104cs.c                       | 531 +++++++++++++++++++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   2 +-
 drivers/iio/potentiometer/Kconfig                  |  11 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ds1803.c                 |   2 +-
 drivers/iio/potentiometer/mcp4018.c                | 194 ++++++++
 drivers/iio/proximity/sx9500.c                     |  25 +-
 drivers/iio/temperature/mlx90632.c                 |   2 +
 drivers/staging/iio/accel/adis16201.c              |  10 +-
 drivers/staging/iio/accel/adis16209.c              | 272 +++++------
 drivers/staging/iio/adc/ad7816.c                   |   2 +-
 drivers/staging/iio/addac/adt7316.c                |   3 +-
 drivers/staging/iio/cdc/ad7150.c                   |   5 +-
 drivers/staging/iio/cdc/ad7152.c                   |   6 +-
 drivers/staging/iio/cdc/ad7746.c                   |  12 +-
 drivers/staging/iio/light/tsl2x7x.c                | 290 +++++------
 drivers/staging/iio/light/tsl2x7x.h                |   6 +-
 drivers/staging/iio/meter/ade7753.c                |  18 +-
 drivers/staging/iio/meter/ade7754.c                |   6 +-
 drivers/staging/iio/meter/ade7758_trigger.c        |   8 +-
 drivers/staging/iio/meter/ade7759.c                |  18 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |  28 +-
 drivers/staging/iio/meter/ade7854-spi.c            |  60 +--
 drivers/staging/iio/meter/ade7854.h                |  28 +-
 drivers/staging/iio/meter/meter.h                  |   3 -
 drivers/staging/iio/resolver/ad2s1210.c            |  20 +-
 44 files changed, 1236 insertions(+), 461 deletions(-)
 create mode 100644 drivers/iio/light/lv0104cs.c
 create mode 100644 drivers/iio/potentiometer/mcp4018.c
