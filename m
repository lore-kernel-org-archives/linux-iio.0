Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42462 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934338AbcKMUEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 15:04:55 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 3rd set of new drivers, features and cleanups for IIO in the
 4.10 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f02cb1e1-dc13-8bcc-f12e-1ef10a1ddc82@kernel.org>
Date: Sun, 13 Nov 2016 20:04:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 993403b9798123db4eb9d9bba1ab41f388dc1ea1:

  staging: lustre: fixed shadowed variable in socklnd_cb.c (2016-11-07 11:40:49 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.10c

for you to fetch changes up to f44d5c8ac3993421370fc00951abd5864ca71689:

  staging: iio: tsl2583: move out of staging (2016-11-13 13:07:33 +0000)

----------------------------------------------------------------
Third set of IIO new device support, features and cleanup for the 4.10 cycle.

Includes Peter Rosin's interesting drivers for a comparator. First complex
use we have had with an analog front end made from discrete components.

Brian Masney's work on moving the tsl2583 driver out of staging also
feature extensively!

New Drivers
* DAC based on a digital potentiometer
  - New driver for the use of a dpot as a DAC. Includes bindings and Axentia
  entry in vendor prefixes.
* Envelope detector baed on DAC and a comparator including device tree
  bindings.

Staging Graduation
* tsl2583.

Core new features
- Core provision for _available attributes.   This one had been stalled for
  a long time until Peter picked it up and ran with it!
- In kernel interface helpers to retrieve available info from channels.

Driver new features
* mcp4531
  - Add range of available raw values (used for the dpot dac driver).

Driver cleanups and fixes for issues introduced
* ad7766
  - Testing the wrong variable following devm_regulator_bulk_get introduced
  with the driver earlier in this cycle.
* ad9832
  - Fix a wrong ordering in the probe introduced in the previous set of
    patches.  A use before allocation bug.
* cros_ec_sensors
  - Testing for an error in a u8 will never work.
* mpu3050
  - Remove duplicate initializer for the module owner.
  - Add missing i2c dependency.
  - Inform the i2c mux core how it is used - step one in implifying device
  tree bindings.
* st-sensors
  - Get rid of large number of uninformative defines in favour of putting the
  constants where they are relevant. It is clear what they are from where
  they are used.
* tsl2583
  - Fix unused function warning when CONFIG_PM disabled and remove the
  ifdefs in favour of __maybe_unused.
  - Refactor taos_chip_on  to only read relevant registers.
  - Make sure calibscale and integration time are being set.
  - Verify chip is in ready to be used before calibration.
  - Remove some repeated checks for chip status (it's protected by a mutex
  so can't change until it's released)
  - Change current state storage from a tristate enum to a boolean seeing as
  only two values are actually used now.
  - Drop a redundant write to the control regiser in taos_probe (it's a noop)
  - Drop the FSF mailing address.
  - Clean up logging to not use hard coded function names (use __func__
  instead).
  - Cleanup up variable and function name prefixes.
  - Alignment of #define fixes.
  - Fix comparison between signed and unsigned integer warnings.
  - Add some newlines in favour of readability.
  - Combine the two sysfs ABI docs that somehow ended up in different places.
  - Fix multiline comment syntax.
  - Move a code block to inside an else statement as it makes more sense there.
  - Change tsl2583_als_calibrate to return 0 rather than a value nothing
  reads.
  - Drop some pointless brackets
  - Don't assume 32bit unsigned int.
  - Change to a per device instance lux table.
  - Add missing tsl2583 to the list of supported devices in the intro comments.
  - Improve commment on clearing of interrupts.
  - Drop some uninformative comments.
  - Drop a memset call that doesn't do anything useful any more.
  - Don't initialize some return variables that are always set.
  - Add Brian Masney as a module author after all these changes.

----------------------------------------------------------------
Arnd Bergmann (4):
      staging: iio: ad9832: allocate data before using
      staging: iio: tsl2583: fix unused function warning
      iio: gyro: mpu3050: remove duplicate initializer
      iio: gyro: mpu3050: add I2C dependency

Brian Masney (28):
      staging: iio: tsl2583: split out functionality of taos_chip_on()
      staging: iio: tsl2583: fix issue with changes to calibscale and int_time not being set on the chip
      staging: iio: tsl2583: check if chip is in a working state in in_illuminance_calibrate_store
      staging: iio: tsl2583: remove unnecessary chip status check in taos_get_lux
      staging: iio: tsl2583: remove unnecessary chip status checks in suspend/resume
      staging: iio: tsl2583: change current chip state from a tristate to a bool
      staging: iio: tsl2583: remove redundant write to the control register in taos_probe()
      staging: iio: tsl2583: remove the FSF's mailing address
      staging: iio: tsl2583: cleaned up logging
      staging: iio: tsl2583: unify function and variable prefix to tsl2583_
      staging: iio: tsl2583: fix alignment of #define values
      staging: iio: tsl2583: fix comparison between signed and unsigned integers
      staging: iio: tsl2583: change newlines to improve readability
      staging: iio: tsl2583: combine sysfs documentation
      staging: iio: tsl2583: fix multiline comment syntax
      staging: iio: tsl2583: updated code comment to match what the code does
      staging: iio: tsl2583: moved code block inside else statement
      staging: iio: tsl2583: change tsl2583_als_calibrate() to return 0 on success
      staging: iio: tsl2583: remove unnecessary parentheses
      staging: iio: tsl2583: don't assume an unsigned int is 32 bits
      staging: iio: tsl2583: move from a global to a per device lux table
      staging: iio: tsl2583: add tsl2583 to list of supported devices in the header
      staging: iio: tsl2583: clarified comment about clearing interrupts
      staging: iio: tsl2583: remove comment for tsl2583_probe()
      staging: iio: tsl2583: remove unnecessary memset call
      staging: iio: tsl2583: remove unnecessary variable initialization
      staging: iio: tsl2583: add copyright and MODULE_AUTHOR
      staging: iio: tsl2583: move out of staging

Colin Ian King (1):
      iio: cros_ec_sensors_core: fix unsigned compared less than zero on status

Dan Carpenter (1):
      iio:adc: ad7766: testing the wrong variable in probe

Jonathan Cameron (1):
      iio:core: add a callback to allow drivers to provide _available attributes

Linus Walleij (3):
      iio: gyro: st_gyro: inline per-sensor data
      iio: magn: st_magn: inline per-sensor data
      iio: pressure: st_pressure: inline per-sensor data

Peter Rosin (8):
      iio: imu: inv_mpu6050: inform the i2c mux core about how it is used
      iio: inkern: add helpers to query available values from channels
      iio: mcp4531: provide range of available raw values
      dt-bindings: add axentia to vendor-prefixes
      dt-bindings: iio: document dpot-dac bindings
      iio: dpot-dac: DAC driver based on a digital potentiometer
      dt-bindings: iio: document envelope-detector bindings
      iio: envelope-detector: ADC driver based on a DAC and a comparator

 .../testing/sysfs-bus-iio-adc-envelope-detector    |  36 ++
 .../ABI/testing/sysfs-bus-iio-dac-dpot-dac         |   8 +
 .../ABI/testing}/sysfs-bus-iio-light-tsl2583       |  14 +-
 .../testing/sysfs-bus-iio-potentiometer-mcp4531    |   8 +
 .../bindings/iio/adc/envelope-detector.txt         |  54 ++
 .../devicetree/bindings/iio/dac/dpot-dac.txt       |  41 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  17 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7766.c                           |   4 +-
 drivers/iio/adc/envelope-detector.c                | 422 +++++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   8 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/dpot-dac.c                         | 266 ++++++++++
 drivers/iio/gyro/Kconfig                           |   1 +
 drivers/iio/gyro/mpu3050-core.c                    |   1 -
 drivers/iio/gyro/st_gyro_core.c                    | 205 +++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   2 +-
 drivers/iio/industrialio-core.c                    | 259 +++++++--
 drivers/iio/inkern.c                               | 104 ++++
 drivers/iio/light/Kconfig                          |   7 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/{staging => }/iio/light/tsl2583.c          | 581 +++++++++++----------
 drivers/iio/magnetometer/st_magn_core.c            | 376 +++++--------
 drivers/iio/potentiometer/mcp4531.c                | 104 ++--
 drivers/iio/pressure/st_pressure_core.c            | 257 ++++-----
 .../light/sysfs-bus-iio-light-tsl2583              |   6 -
 drivers/staging/iio/frequency/ad9832.c             |  14 +-
 drivers/staging/iio/light/Kconfig                  |   7 -
 drivers/staging/iio/light/Makefile                 |   1 -
 include/linux/iio/consumer.h                       |  28 +
 include/linux/iio/iio.h                            |  46 ++
 include/linux/iio/types.h                          |   5 +
 35 files changed, 1960 insertions(+), 946 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
 rename {drivers/staging/iio/Documentation => Documentation/ABI/testing}/sysfs-bus-iio-light-tsl2583 (74%)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 drivers/iio/adc/envelope-detector.c
 create mode 100644 drivers/iio/dac/dpot-dac.c
 rename drivers/{staging => }/iio/light/tsl2583.c (59%)
 delete mode 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
