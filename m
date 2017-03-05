Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60868 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbdCEPap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 10:30:45 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] First round of IIO new device support, features and cleanups
 for the 4.12 cycle.
Message-ID: <0ea4ab1f-0e64-a7ab-b31a-4fc51ecee2ee@kernel.org>
Date: Sun, 5 Mar 2017 15:20:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0f06feba91580df799c48bed753a7400a43d05f7:

  staging: bcm2835: cleanup: remove deprecated <asm/uaccess.h> include (2017-02-03 13:01:39 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.12a

for you to fetch changes up to 2df79e1bddc46ea6ce9746a171220c3f68e378da:

  staging: iio: accel: Rename source files and update Makefile (2017-03-05 11:25:25 +0000)

----------------------------------------------------------------
First set of IIO new device support, features and cleanup for the 4.12 cycle.

Quite a bit of outreachy activity here with a driver from a current intern
and a number of cleanup patches as part of the next round.

Getting a pull request in early this cycle as it's looking like another large
cycle for IIO.

New device support
* adxl345
  - initial device support. Note, once complete support is done the intent
    is to superceded the driver in input/misc.
  - bindings.
  - conversion from i2c direct calls to regmap and driver split.
  - spi support.
* chromeos light and proximity.
  - new driver.
* devantech srf04 ultrasonic ranger
  - new driver with device tree bindings.
* hid temperature
  - new driver for environemntal temperature support from hid devices.
* max30102 oximeter
  - new driver with device tree bindings.
* st lsm6dsx
  - refactor and addition of device support for lsm6dsl and lsm6ds3h.

Staging graduation
* isl29028 including copyright notice update to reflect Brian's work.
* lpc32xx_adc.
* spear adc. It's not perfect and there are some datasheet disagreements, but
  it works and is good enough to graduate.

New features
* documentation
  - abi docs for in_proximity_sampling_frequency_available.
  - generalise counting direction ABI docs as a second driver is going to
  use them.
* hid-sensor-prox
  - Add support for HID_USAGE_SENSOR_HUMAN_PRESENCE if used on a particular
  device.
* isl29028
  - runtime pm.
* meson-saradc
  - switch from polling to interrupt mode and improved read_raw_sample function
  to avoid unnecessary loop.
* tmp007
  - interrupt and threshold event support.

Cleanups and minor fixes
* ad2s1210
  - permissions to octal.
* ad7192
  - permissions to octal.
  - use BIT macro.
* ad9832
  - merge header definitions into source file.
* ad9834
  - merge header definitions into source file.
* ade7753
  - merge header definitions into source file.
  - cleanup include ordering.
* ade7854
  - simplify return logic.
* adis16201
  - merge header definitions into source file.
  - rename _core.c to .c as there is nothing else.
* adis16203
  - merge header definitions into source file.
  - rename _core.c to .c as there is nothing else.
* adis16209
  - merge header definitions into source file.
  - rename _core.c to .c as there is nothing else.
* adis16240
  - permissions to octal.
  - merge header definitions into source file.
  - rename _core.c to .c as there is nothing else.
* adt7136
  - permissions to octal.
* cio-dac
  - set missing parent device.
* documentation
  - update version numbers on sysfs ABI for counter bits that didn't quite.
  make 4.9.
* isl29028
  - mdelay to msleep.
  - incorrrect sleep time when taking first proximity reading.
* lmp91000
  - set missing parent device.
* lpc32xx
  - Consistent prefixes for defines.
  - rename local state structure to _state.
* max30100
  - set missing parent device.
* max30102
  - set missing parent device.
* maxim-thermocouple
  - set missing parent device.
* meter driver header
  - permissions to octal.
* pulsedlight-lidar-lite-v2
  - set missing parent device.
* quad-8
  - set missing parent device.
* st104
  - set missing parent device.

Other
* Mailmap
  - update Matt Ranostay's email address to the Konsolko one.

----------------------------------------------------------------
Andreas Klinger (2):
      iio: distance: add dt binding for devantech-srf04
      iio: distance: add devantech us ranger srf04

Artur Lorincz (1):
      iio: adc: ad7192: fixed symbolic permission references 'S_IRUGO | S_IWUSR'

Benjamin Gaignard (1):
      iio: Generalize counting direction modes

Brian Masney (5):
      staging: iio: isl29028: change mdelay() to msleep()
      staging: iio: isl29028: fix incorrect sleep time when taking initial proximity reading
      staging: iio: isl29028: use the runtime power management for system sleep
      staging: iio: isl29028: add copyright
      iio: Documentation: add ABI documentation for in_proximity_sampling_frequency_available

Derek Robson (3):
      Staging: iio: resolver: ad2s1210.c - style fix
      Staging: iio: meter: meter.h - style fix
      Staging: iio: impedance-analyzer: ad5933.c - style fix

Eva Rachel Retuya (5):
      iio: accel: Add driver for the Analog Devices ADXL345 3-axis accelerometer
      dt-bindings: iio: accel: Document ADXL345 accelerometer binding
      iio: accel: adxl345: Use I2C regmap instead of direct I2C access
      iio: accel: adxl345: Split driver into core and I2C
      iio: accel: adxl345: Add SPI support

Gargi Sharma (1):
      staging: iio: compress return logic

Gwendal Grignou (1):
      iio: cros_ec_light_prox: add ChromeOS EC Light and Proximity Sensors

Heiner Kallweit (2):
      iio: adc: meson-saradc: switch from polling to interrupt mode
      iio: adc: meson-saradc: improve meson_sar_adc_read_raw_sample

Jonathan Cameron (4):
      staging:iio:adc:spear Move out of staging.
      staging:iio:adc:lpc32xx Apply consistent prefix to local defines
      staging:iio:adc:lpc32xx rename local state structure to _state
      staging:iio:adc:lpc32xx Move out of staging.

Katie Dunne (2):
      staging: iio: meter: ade7753: Move header content to implementation file
      staging: iio: meter: ade7753: Clean up includes

Lars-Peter Clausen (8):
      iio: stx104: Set parent device
      iio: quad-8: Set parent device
      iio: cio-dac: Set parent device
      iio: max30100: Set parent device
      iio: max30102: Set parent device
      iio: lmp91000: Set parent device
      iio: pulsedlight-lidar-lite-v2: Set parent device
      iio: maxim_thermocouple: Set parent device

Lorenzo Bianconi (5):
      iio: imu: st_lsm6dsx: add support to multiple devices with the same settings
      iio: imu: st_lsm6dsx: add support to lsm6dsl
      Documentation: dt: iio: imu: st_lsm6dsx: add lsm6dsl sensor device binding
      iio: imu: st_lsm6dsx: add support to lsm6ds3h
      Documentation: dt: iio: imu: st_lsm6dsx: add lsm6ds3h sensor device binding

Manivannan Sadhasivam (1):
      iio:temperature:tmp007: Add irq and threshold events support

Matt Ranostay (3):
      mailmap: Change email to new Konsulko email
      devicetree: add documentation for MAX30102 oximeter
      iio: health: add MAX30102 oximeter driver support

Michael S. Hansen (1):
      iio: addac: adt7136: Fix style to use octal file permissions.

Narcisa Ana Maria Vasile (5):
      staging: iio: ad9832: Moved contents of the header to the source file
      staging: iio: ad9834: Moved contents of the header to the source file
      staging: iio: adis16209: Move contents of the header to the source file
      staging: iio: adis16240: Move contents of the header to the source file
      staging: iio: accel: Rename source files and update Makefile

Song Hongyan (2):
      hid: hid-sensor-prox: Add more data field for hysteresis parsing
      iio: hid: Add temperature sensor support

Varsha Rao (1):
      staging: iio: adis16203: Move header file content to source file.

William Breathitt Gray (2):
      Documentation: iio: Fix KernelVersion in counter sysfs ABI documentation
      Documentation: iio: 104-quad-8: Fix KernelVersion in sysfs ABI documentation

sayli karnik (2):
      staging: iio: adis16240_core: Replace symbolic permission with octal permission
      staging: iio: ad7152: Use BIT() macro for left shifting 1

simran singhal (1):
      staging: iio: accel: adis16201: Move header file content to source file

 .mailmap                                           |   1 +
 Documentation/ABI/testing/sysfs-bus-iio            |  19 +-
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |  24 +-
 .../devicetree/bindings/iio/accel/adxl345.txt      |  38 ++
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   2 +
 .../devicetree/bindings/iio/health/max30102.txt    |  30 ++
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   2 +
 .../bindings/iio/proximity/devantech-srf04.txt     |  28 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/accel/Kconfig                          |  31 ++
 drivers/iio/accel/Makefile                         |   3 +
 drivers/iio/accel/adxl345.h                        |  18 +
 drivers/iio/accel/adxl345_core.c                   | 179 ++++++++
 drivers/iio/accel/adxl345_i2c.c                    |  73 ++++
 drivers/iio/accel/adxl345_spi.c                    |  81 ++++
 drivers/iio/adc/Kconfig                            |  23 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/{staging => }/iio/adc/lpc32xx_adc.c        | 100 +++--
 drivers/iio/adc/meson_saradc.c                     |  90 +++-
 drivers/{staging => }/iio/adc/spear_adc.c          |   0
 drivers/iio/adc/stx104.c                           |   1 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   3 +
 drivers/iio/counter/104-quad-8.c                   |   1 +
 drivers/iio/dac/cio-dac.c                          |   1 +
 drivers/iio/health/Kconfig                         |  13 +
 drivers/iio/health/Makefile                        |   1 +
 drivers/iio/health/max30100.c                      |   1 +
 drivers/iio/health/max30102.c                      | 486 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  40 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |  10 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |  10 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cros_ec_light_prox.c             | 289 ++++++++++++
 drivers/iio/light/hid-sensor-prox.c                |   7 +
 drivers/iio/potentiostat/lmp91000.c                |   1 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 +
 drivers/iio/proximity/srf04.c                      | 304 +++++++++++++
 drivers/iio/temperature/Kconfig                    |  14 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/hid-sensor-temperature.c   | 311 +++++++++++++
 drivers/iio/temperature/maxim_thermocouple.c       |   1 +
 drivers/iio/temperature/tmp007.c                   | 277 +++++++++++-
 drivers/staging/iio/accel/Makefile                 |   7 -
 .../iio/accel/{adis16201_core.c => adis16201.c}    | 140 +++++-
 drivers/staging/iio/accel/adis16201.h              | 144 ------
 .../iio/accel/{adis16203_core.c => adis16203.c}    | 136 +++++-
 drivers/staging/iio/accel/adis16203.h              | 125 ------
 .../iio/accel/{adis16209_core.c => adis16209.c}    | 140 +++++-
 drivers/staging/iio/accel/adis16209.h              | 144 ------
 .../iio/accel/{adis16240_core.c => adis16240.c}    | 177 +++++++-
 drivers/staging/iio/accel/adis16240.h              | 179 --------
 drivers/staging/iio/adc/Kconfig                    |  22 -
 drivers/staging/iio/adc/Makefile                   |   2 -
 drivers/staging/iio/adc/ad7192.c                   |   8 +-
 drivers/staging/iio/addac/adt7316.c                | 108 ++---
 drivers/staging/iio/cdc/ad7152.c                   |   8 +-
 drivers/staging/iio/frequency/ad9832.c             |  92 ++++
 drivers/staging/iio/frequency/ad9832.h             |  92 ----
 drivers/staging/iio/frequency/ad9834.c             |  72 +++
 drivers/staging/iio/frequency/ad9834.h             |  72 ---
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  16 +-
 drivers/staging/iio/light/isl29028.c               |  37 +-
 drivers/staging/iio/meter/ade7753.c                |  82 +++-
 drivers/staging/iio/meter/ade7753.h                |  72 ---
 drivers/staging/iio/meter/ade7854.c                |   4 +-
 drivers/staging/iio/meter/meter.h                  |  60 +--
 drivers/staging/iio/resolver/ad2s1210.c            |  24 +-
 include/linux/hid-sensor-ids.h                     |   4 +
 74 files changed, 3403 insertions(+), 1128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/max30102.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
 create mode 100644 drivers/iio/accel/adxl345.h
 create mode 100644 drivers/iio/accel/adxl345_core.c
 create mode 100644 drivers/iio/accel/adxl345_i2c.c
 create mode 100644 drivers/iio/accel/adxl345_spi.c
 rename drivers/{staging => }/iio/adc/lpc32xx_adc.c (68%)
 rename drivers/{staging => }/iio/adc/spear_adc.c (100%)
 create mode 100644 drivers/iio/health/max30102.c
 create mode 100644 drivers/iio/light/cros_ec_light_prox.c
 create mode 100644 drivers/iio/proximity/srf04.c
 create mode 100644 drivers/iio/temperature/hid-sensor-temperature.c
 rename drivers/staging/iio/accel/{adis16201_core.c => adis16201.c} (64%)
 delete mode 100644 drivers/staging/iio/accel/adis16201.h
 rename drivers/staging/iio/accel/{adis16203_core.c => adis16203.c} (64%)
 delete mode 100644 drivers/staging/iio/accel/adis16203.h
 rename drivers/staging/iio/accel/{adis16209_core.c => adis16209.c} (63%)
 delete mode 100644 drivers/staging/iio/accel/adis16209.h
 rename drivers/staging/iio/accel/{adis16240_core.c => adis16240.c} (62%)
 delete mode 100644 drivers/staging/iio/accel/adis16240.h
 delete mode 100644 drivers/staging/iio/meter/ade7753.h
