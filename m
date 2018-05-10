Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbeEJVkU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 May 2018 17:40:20 -0400
Date: Thu, 10 May 2018 22:40:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support, features and cleanups
 for the 4.18 cycle
Message-ID: <20180510224015.04e2f747@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c26dd817d99bc50acf2667ee27c39414a7a6638e:

  uapi: remove telephony headers (2018-03-15 18:19:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
4.18a

for you to fetch changes up to d58c67d1d851d40b0094b6dd8b1a27ac9076ffa2:

  iio: adc: stm32-adc: add support for STM32MP1 (2018-05-07 18:21:00 +0100)

----------------------------------------------------------------
1st round of IIO new device support, features and cleanup for the 4.18 cycle

A nice mix this time of excellent cleanups (many to send drivers
speeding toward staging graduations) and new drivers / device support.
A good part of this is Brian Masney's never ending task on the tsl2x7x
driver.  The end is in sight so hopefully we'll get that one out of
staging very soon!

New device support
* AD5686
  - Support AD5685R (was wrongly present as AD5685)
  - Support AD5672R, AD5676, AD5676, AD5684R and AD5686R 4 and 8 channel
    SPI DACs with various precisions.
  - Support AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696 and AD5696R
    I2C DACs with various percisions and numbers of channels.
* Analog front end rescale driver - New driver.
  - Support current sensing usings a shunt resistor.
  - Support simple voltage dividers.
  - support simple current sense amplifiers.
* TI dac5571
  - New driver and device bindings supporting:
    dac5571, dac6571, dac7571, dac5574, dac6574, dac7574,
    dac5573, dac6573 and dac7573
* Meson-adc
  - Support for Meson AXG with DT bindings.
* mpu6050
  - Support the mpu9255 which only requires additional WHOAMI entry and
    compatible string.
* st_lsm6dsx
  - Support for lsm330dlc combinded accelerometer and gyro sensors with
    DT bindings.
* stm32_adc
  - Add support for STM32MP1 with bindings.

Staging graduations
* adis16201 after some excelent cleanup by Himanshu Jha.
* adis16029 after some excelent cleanup by Shreeya Patel.

New features:
* ABI docs
  - Add core ABI docs for angle channels.
* inv_mpu6050
  - Provide support for the full range of interrupts the device
    supports.
* st_accel
  - Add SMO8840 ACPI ID seen in the wild on some Lenovo machines.
* stx104
  - Provide a multiple gpio get function.

Cleanups / Minor fixes
* core
  - Use new nested structure support to improve kernel-doc.
* ad2s1200
  - Use be16_to_cpup instead of opencoding.
* ad5686
  - Indentation tidy up.
  - Switch to SPDX
  - Refactor to allow various numbers of channels.
  - Refactor to separate core and SPI specific support, prior to
    addition of i2c equivalent devices.
* ad7606
  - Use drvdata directly from device rather than boucing via the
    platform_device structure.
* ad7746
  - Replace opencoded byte swapped i2c calls with _swapped variants.
  - White space and line break readability improvements.
  - Reorder includes and variable declarations where appropriate.
* ad7791
  - Changes to the AD ADC library used by this driver took in the
    sampling frequency.  This lead to be the wrong path being the one
    tied to the resulting attribute, so it didn't work, and a warning
    to be printed.
* ad7780
  - Remove apparent support for sampling frequency control on devices
    that don't support changing the sampling attributes.
* ade7854
  - Fix a read of the wrong number of bits.
  - Improve error handling on i2c read/write errors.
  - Rework i2c and spi code to reduce duplication.
* adis16201 (staging)
  - Improve meaning inherent in some macro names by adding units etc
    where relevant.
  - Adjust comments to improve detail and drop the irrelevant.
  - Rename register address definitions definitions to add a _REG
    postfix, clearly separating them from field definitions. Reorganize
    the definitions to group register address and fields.
  - Use sign_extend32 rather than open coding.
  - Reverse Xmas tree ordering where appropriate and align function args.
  - Remove unused headers.
  - Use GENMASK where appropriate instead of open coding.
* adis16209 (staging)
  - Indent field definitions to visually separate them from
    register address definitions.
  - Use reverse xmas tree ordering where appropriate.
  - Add some whitespace where it will help readability.
  - Drop some unused headers.
  - Use GENMASK where appropriate.
* ad2s1200
  - Drop unnecessary includes and reorder alphabetically.
  - Reverse xmas tree and blank line cleanups.
* atlas-ph-sensor
  - Use msleep instead of usleep_range where the precise value doesn't
    matter and the delays are long.
* bcm150
  - Drop transaction splitting as core now handles it.
* cros_ec
  - Move the shared header to the include/iio/common directory.
    This brings it inline with the other multiple type devices.
  - Use drvdata directly from device rather than boucing via the
    platform_device structure.
* hid-sensors
  - Use drvdata directly from device rather than boucing via the
    platform_device structure.
* inv_mpu6050
  - Clear out a second function definition for the same function.
  - Don't flush fifo when the iio buffer is full but just drop excess
    data.
  - Tidy up set_power_itg and ensure it is used in the right places.
  - Use set_power_itg rather than opencoding it again in the i2c mux
    control.
  - Make sure error paths disable the power if undoing power on.
  - Used managed devm_ functions during probe. Delete remove function.
  - Refactor to pull raw data read out of read_raw function.
  - Simplify data reading error paths.
  - Only enable the i2c mux for chips with the i2c aux bus (not icm20608)
  - Fix a potential deadlock due to varying lock ordering.
  - Fix an issue where first sample from gyro after enabling is unstable
    by dropping the first sample.
  - Fix an issue where the user_ctrl register is incorrectly overwritten.
  - Tidy up some grammar and spelling minor issus.
* mcp320x
  - Use vendor compatible strings.
* mcp4018
  - Switch to using i2c .probe_new.
* mcp4351
  - switch to using i2c .probe_new.
* meson-adc
  - rework handing on common ADC platform data so it can be shared
    across multiple families of SoCs.
* sca3000
  - Fix an error handling path if the ring configure fails.
* st_lsm6dsx
  - Fix a wrong fifo threshold mask (no actual effect)
* stm32-dfsdm
  - Style fixes and cleanups.
  - Check filter ID is in range and check spi-max-frequency.
* tsl2x7x (staging)
  - Drop some unnecessary function calls, unused variables and
    unnecessary local variables.
  - Fix wrong interrupt type.
  - Avoid unnecessary double clear of interrupt.
  - Simplify proximity calibration call which did various things
    unrelated to actually calibrating.
  - Separate control of the proximity and ALS interrupts.
  - Improve consistency of logging.
  - Separate ALS and proximity persistence settings as they have
    separate hardware controls.
  - Tidy up variable ordering.
  - Add Brian to copyright notice given consider work on this driver.
  - Take advantage of hardware support for I2C address auto increment.
  - Combine individuaal enable and period attributes for the two
    directions on the threshold events into a single value as the
    hardware doesn't separate them.
  - Move integration_time* attributes from light channel to
    intensity value as they effect the intensity readings directly
    and the light reading only indirectly.  Hence this better
    reflects reality. Also move the calibscale_available.
  - Avoid returning an error in the IRQ handler.
  - Hard code the reg value in _clear_interrupts as it only takes
    one value in the code.   Result is the function has little
    purpose so opencode the two remaining i2c_smbus_write_byte
    calls.
  - Drop some unnecessary checking of the chip status register.
  - Tidy up return path in _write_interrupt_config.
  - Tidy up the ID verification code.
  - Move the power and diode settings defines into the header as these
    are needed for platform data configuration.
  - Various renames and comment cleanups for consistency and clarity.
  - Use actual device defaults for default startup settings.
  - SPDX
  - Add some range sanity checking to sysfs attribute writes.
  - Don't provide event interfaces if the interrupt line isn't available.
  - Use IIO_CONST_ATTR macro for calibscale_available as it's a constant
    string.
  - Fix the integration time and lux equations.
  - Make device IDs explicit index values in the device_channel_config arra=
y.

----------------------------------------------------------------
Alexandru Ardelean (3):
      iio: adc: ad7791: remove sample freq sysfs attributes
      iio: adc: ad7791: implement IIO_CHAN_INFO_SAMP_FREQ
      iio: adc: ad7780: remove IIO_CHAN_INFO_SAMP_FREQ support

Brian Masney (31):
      staging: iio: tsl2x7x: remove unnecessary code
      staging: iio: tsl2x7x: correct interrupt handler trigger
      staging: iio: tsl2x7x: no need to clear interrupt flag when getting l=
ux
      staging: iio: tsl2x7x: simplify tsl2x7x_prox_cal()
      staging: iio: tsl2x7x: split out als and prox interrupt settings
      staging: iio: tsl2x7x: make logging consistent and correct newlines
      staging: iio: tsl2x7x: split out als and prox persistence settings
      staging: iio: tsl2x7x: remove unused variables from tsl2x7x_get_lux()
      staging: iio: tsl2x7x: remove ch0 and ch1 variables from tsl2x7x_get_=
lux()
      staging: iio: tsl2x7x: put local variables in reverse Christmas tree =
order
      staging: iio: tsl2x7x: add copyright
      staging: iio: tsl2x7x: use auto increment I2C protocol
      staging: iio: tsl2x7x: use either direction for IIO_EV_INFO_{ENABLE,P=
ERIOD}
      staging: iio: tsl2x7x: move integration_time* attributes to IIO_INTEN=
SITY channel
      staging: iio: tsl2x7x: don't return error in IRQ handler
      staging: iio: tsl2x7x: simplify tsl2x7x_clear_interrupts function
      staging: iio: tsl2x7x: remove unnecessary chip status checks in suspe=
nd/resume
      staging: iio: tsl2x7x: simplify tsl2x7x_write_interrupt_config return
      staging: iio: tsl2x7x: simplify device id verification
      staging: iio: tsl2x7x: move power and diode settings into header file
      staging: iio: tsl2x7x: rename prx to prox for consistency
      staging: iio: tsl2x7x: use device defaults for als_time, prox_time an=
d wait_time
      staging: iio: tsl2x7x: various comment cleanups
      staging: iio: tsl2x7x: rename prox_config to als_prox_config
      staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
      staging: iio: tsl2x7x: add range checking to three sysfs attributes
      staging: iio: tsl2x7x: don't setup event handlers if interrupts are n=
ot configured
      staging: iio: tsl2x7x: move calibscale_available attribute to IIO_INT=
ENSITY channel
      staging: iio: tsl2x7x: use IIO_CONST_ATTR for calibscale_available
      staging: iio: tsl2x7x: correct integration time and lux equation
      staging: iio: tsl2x7x: add device ids for code readability

Charles Keepax (1):
      iio: accel: bcm150: Remove handling for regmap raw_read_max

Christophe JAILLET (2):
      iio: sca3000: Fix an error handling path in 'sca3000_probe()'
      iio: sca3000: Handle errors returned by 'sca3000_configure_ring()' in=
 'sca3000_probe()'

David Veenstra (6):
      staging: iio: ad2s1200: Remove unneeded include
      staging: iio: ad2s1200: Sort includes alphabetically
      staging: iio: ad2s1200: Reverse Christmas tree ordering
      staging: iio: ad2s1200: Add blank lines
      staging: iio: ad2s1200: Improve readability with be16_to_cpup
      staging: iio: Documentation: Add missing sysfs docs for angle channel

Douglas Fischer (1):
      iio: imu: Add mpu9255 support to mpu6050 driver

Fabian Mewes (1):
      dt-bindings: iio: adc: mcp320x: Use vendor prefix compatible strings

Fabrice Gasnier (5):
      iio: adc: stm32-dfsdm: misc style improvements and fixes
      iio: adc: stm32-dfsdm: add check on max filter id
      iio: adc: stm32-dfsdm: add check on spi-max-frequency
      dt-bindings: iio: stm32-adc: add support for STM32MP1
      iio: adc: stm32-adc: add support for STM32MP1

Gwendal Grignou (1):
      iio: cros_ec: Move cros_ec_sensors_core.h in /include

Hans de Goede (1):
      iio: accel: st_accel: Add support for the SMO8840 ACPI id

Hern=C3=A1n Gonzalez (6):
      staging: iio: ad7746: Automatically swap values in readings/writings
      staging: iio: ad7746: Adjust arguments to match open parenthesis
      staging: iio: ad7746: Fix multiple line dereference
      staging: iio: ad7746: Reorder includes alphabetically
      staging: iio: ad7746: Reorder variable declarations
      staging: iio: ad7746: Fix bound checkings

Himanshu Jha (12):
      Staging: iio: accel: adis16201: Rename few macro definitions
      Staging: iio: accel: adis16201: Remove unnecessary comments
      Staging: iio: accel: adis16201: Add _REG suffix to registers
      Staging: iio: accel: adis16201: Group register definitions
      Staging: iio: accel: adis16201: Add comments about units in read_raw()
      Staging: iio: accel: adis16201: Use sign_extend32 function
      Staging: iio: accel: adis16201: Prefer reverse christmas tree ordering
      Staging: iio: accel: adis16201: Adjust argument to match open parenth=
eses
      Staging: iio: accel: adis16201: Remove unused headers
      Staging: iio: accel: adis16201: Use GENMASK
      Staging: iio: accel: adis16201: Fix 80 character line limit
      Staging: iio: accel: adis16201: Move adis16201 driver out of staging

Jean-Baptiste Maneyrol (12):
      iio: imu: inv_mpu6050: clean double declaration of set_power_itg
      iio: imu: inv_mpu6050: do not flush fifo when iio buffer is full
      iio: imu: inv_mpu6050: clean set_power_itg and fix usage
      iio: imu: inv_mpu6050: use set_power_itg function in i2c mux
      iio: imu: inv_mpu6050: fix error path not turning chip back off
      iio: imu: inv_mpu6050: use devm_* at init and delete remove
      iio: imu: inv_mpu6050: clean read raw by factorizing out raw data
      iio: imu: inv_mpu6050: clean read channel data error path
      iio: imu: inv_mpu6050: use i2c mux only for chip with i2c aux bus
      iio: imu: inv_mpu6050: fix possible deadlock between mutex and iio
      iio: imu: inv_mpu6050: skip first sample when gyro is on
      iio: imu: inv_mpu6050: fix user_ctrl register overwritten

John Syne (2):
      staging:iio:ade7854: Fix error handling on read/write
      staging:iio:ade7854: Fix the wrong number of bits to read

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix FIFO threshold mask for LSM6DSM/LSM6DSL
      iio: imu: st_lsm6dsx: add support to ism330dlc
      Documentation: dt: iio: imu: st_lsm6dsx: add ism330dlc sensor device =
binding

Martin Kelly (3):
      iio:imu: inv_mpu6050: support more interrupt types
      dt-bindings: iio:imu:mpu6050: support more interrupt types
      iio: imu: inv_mpu6050: minor wording fixes

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: use msleep() for long uncritical dela=
ys

Mauro Carvalho Chehab (1):
      iio: iio.h: use nested struct support on kernel-doc markup

Peter Rosin (6):
      iio: potentiometer: mcp4018: switch to using .probe_new
      iio: potentiometer: mcp4531: switch to using .probe_new
      dt-bindings: iio: afe: add binding for current-sense-shunt
      dt-bindings: iio: afe: add binding for voltage-divider
      dt-bindings: iio: afe: add binding for current-sense-amplifier
      iio: afe: rescale: new driver

Rodrigo Siqueira (6):
      staging:iio:ade7854: Rework I2C write function
      staging:iio:ade7854: Rework SPI write function
      staging:iio:ade7854: Remove write_reg_* duplications
      staging:iio:ade7854: Rework I2C read function
      staging:iio:ade7854: Rework SPI read function
      staging:iio:ade7854: Remove read_reg_* duplications

Sean Nyekjaer (2):
      iio: dac: add TI DAC5571 family support
      iio: ti-dac5571: Add DT binding documentation

Shreeya Patel (6):
      Staging: iio: adis16209: Indent the field definitions
      Staging: iio: adis16209: Prefer reverse christmas tree ordering
      Staging: iio: adis16209: Add a blank line after return statements
      Staging: iio: adis16209: Remove unused headers
      Staging: iio: adis16209: Use GENMASK
      Staging: iio: adis16209: Move adis16209 driver out of staging

Stefan Popa (7):
      iio:dac:ad5686: Style fixes no functional changes
      iio:dac:ad5686: Change license description
      iio:dac:ad5686: Add support for various number of channels
      iio:dac:ad5686: Add support for AD5685R
      iio:dac:ad5686: Add AD5672R/76/76R/84R/86R support
      iio:dac:ad5686: Refactor the driver
      iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support

William Breathitt Gray (1):
      iio: stx104: Implement get_multiple callback

Wolfram Sang (3):
      iio: common: cros_ec_sensors: simplify getting .drvdata
      iio: common: hid-sensors: simplify getting .drvdata
      staging: iio: adc: simplify getting .drvdata

Xingyu Chen (2):
      dt-bindings: iio: adc: document the Meson AXG support
      iio: adc: meson-saradc: add support for Meson AXG

Yixun Lan (1):
      iio: adc: meson-saradc: squash and share the common adc platform data

 Documentation/ABI/testing/sysfs-bus-iio            |   9 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   1 +
 .../devicetree/bindings/iio/adc/mcp320x.txt        |   2 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   6 +-
 .../bindings/iio/afe/current-sense-amplifier.txt   |  26 +
 .../bindings/iio/afe/current-sense-shunt.txt       |  41 +
 .../bindings/iio/afe/voltage-divider.txt           |  53 ++
 .../devicetree/bindings/iio/dac/ti,dac5571.txt     |  24 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  12 +-
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   1 +
 MAINTAINERS                                        |  17 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |  24 +
 drivers/iio/accel/Makefile                         |   2 +
 drivers/iio/accel/adis16201.c                      | 321 +++++++
 drivers/{staging =3D> }/iio/accel/adis16209.c        |  52 +-
 drivers/iio/accel/bmc150-accel-core.c              |  23 +-
 drivers/iio/accel/sca3000.c                        |  13 +-
 drivers/iio/accel/st_accel_i2c.c                   |   1 +
 drivers/iio/adc/ad7791.c                           |  87 +-
 drivers/iio/adc/meson_saradc.c                     |  83 +-
 drivers/iio/adc/stm32-adc-core.c                   |  66 +-
 drivers/iio/adc/stm32-adc.c                        |  47 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  13 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   5 +
 drivers/iio/adc/stx104.c                           |  11 +
 drivers/iio/afe/Kconfig                            |  19 +
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-rescale.c                      | 359 ++++++++
 drivers/iio/chemical/atlas-ph-sensor.c             |  14 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   3 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   9 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   9 +-
 drivers/iio/dac/Kconfig                            |  33 +-
 drivers/iio/dac/Makefile                           |   3 +
 drivers/iio/dac/ad5686-spi.c                       |  93 ++
 drivers/iio/dac/ad5686.c                           | 311 +++----
 drivers/iio/dac/ad5686.h                           | 121 +++
 drivers/iio/dac/ad5696-i2c.c                       |  97 +++
 drivers/iio/dac/ti-dac5571.c                       | 439 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 275 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  86 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  43 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  52 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  10 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/light/cros_ec_light_prox.c             |   3 +-
 drivers/iio/potentiometer/mcp4018.c                |  41 +-
 drivers/iio/potentiometer/mcp4531.c                | 145 ++--
 drivers/iio/pressure/cros_ec_baro.c                |   3 +-
 drivers/staging/iio/accel/Kconfig                  |  24 -
 drivers/staging/iio/accel/Makefile                 |   2 -
 drivers/staging/iio/accel/adis16201.c              | 385 ---------
 drivers/staging/iio/adc/ad7606_par.c               |   6 +-
 drivers/staging/iio/adc/ad7780.c                   |   2 +-
 drivers/staging/iio/cdc/ad7746.c                   |  44 +-
 drivers/staging/iio/light/tsl2x7x.c                | 935 +++++++++--------=
----
 drivers/staging/iio/light/tsl2x7x.h                |  91 +-
 drivers/staging/iio/meter/ade7854-i2c.c            | 238 ++----
 drivers/staging/iio/meter/ade7854-spi.c            | 268 ++----
 drivers/staging/iio/meter/ade7854.c                |  40 +-
 drivers/staging/iio/meter/ade7854.h                |  16 +-
 drivers/staging/iio/resolver/ad2s1200.c            |  35 +-
 include/linux/iio/adc/ad_sigma_delta.h             |  24 +-
 .../linux/iio/common}/cros_ec_sensors_core.h       |   3 +
 include/linux/iio/iio.h                            |  24 +-
 73 files changed, 3170 insertions(+), 2139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense=
-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense=
-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divid=
er.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
 create mode 100644 drivers/iio/accel/adis16201.c
 rename drivers/{staging =3D> }/iio/accel/adis16209.c (92%)
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-rescale.c
 create mode 100644 drivers/iio/dac/ad5686-spi.c
 create mode 100644 drivers/iio/dac/ad5686.h
 create mode 100644 drivers/iio/dac/ad5696-i2c.c
 create mode 100644 drivers/iio/dac/ti-dac5571.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c
 rename {drivers/iio/common/cros_ec_sensors =3D> include/linux/iio/common}/=
cros_ec_sensors_core.h (98%)
