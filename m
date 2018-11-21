Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730053AbeKVHLG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Nov 2018 02:11:06 -0500
Date: Wed, 21 Nov 2018 20:35:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First round of new device support, features, cleanups etc
 for IIO in the 4.21 cycle.
Message-ID: <20181121203510.001def75@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e24c1f8658c94c8d74f6d9f36066a6c573117e85:

  staging: rtl8712: add SPDX identifiers (2018-10-03 11:36:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
4.21a

for you to fetch changes up to 00426e99789357dbff7e719a092ce36a3ce49d94:

  Staging: iio: adt7316: Add an extra check for 'ret' equals to 0 (2018-11-=
17 16:59:56 +0000)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 4.21 =
cycle

Along with the headline feature of 5 new drivers, we have the
substantial addition of auxilliary sensor support on the lsm6sdx
parts for ST.  There has also been a good set of staging cleanup
in this period with more underway.

An ever increasing number of devices supported with just a new
ID which is a good sign that at least some manufacturers are
continuing to stabilise their interfaces.

New device support,
* ad7124
  - New driver supporting Analog Devices' ad7124-4 and ad7124-8 parts
    with the inevitable DT binding.
* ad7949
  - New driver supporting Analog Devices' ad7949, AD7682 and AD7689 ADCs.
* rm3100
  - New driver supporting PNIs RM3100 magnometer with bindings and
    vendor prefix.
* ti-dac7311
  - New driver supporting DAC7311, DAC6311 and DAC5311 TI DACs, with
    DT bindings.
* vcnl5035
  - New driver supporting the light sensor part of the VCNL4035, with
    DT bindings

Features,
* bindings
  - Add a generic ADC channel binding as we keep reinventing this
    wheel.
* adc128s052
  - Add IDs for additional pin compatible parts.
  - Add APCI ID seen on E3940 UP squared boards.
* ad_sigma_delta
  - Allow for custom data register overiding default.
* kxcjk1013
  - Add KIOX0009 ACPI ID as seen on the Acer One 10.
* lsm6dsx
  - Rework leading to...
  - External sensor support using the built in I2C master.
  - Initial support for a slave lis2mdl magnetometer.
* meson-saradc
  - Add temperature sensor support and bindings.
* st_magn
  - New ID for lsm9dsl_magn with bindings
  - New ID for lis3de accelerometer
* tpl0102
  - Add supprot for IIO_AVAIL_RANGE to report the range available
    from this device to userspace and in kernel users.

Cleanups and minor fixes
* tools
  - Allow outside specification of CFLAGS
* ad2s90
  - Handle and spi_read error.
  - Handle spi_setup failure
  - Drop a pointless assignment.
  - Prevent a potentail race by moving device registration to after
    all other setup.
  - Add missing scale attribute.
  - Add a sanity check on channel type before trying to read it.
* ad2s1210
  - Move to modern gpio descriptors.
  - Drop a gpioin flag which made no sense as far as we can tell.
  - Add dt table (bindings doc to follow when this is ready for
    moving out of staging).
* ad5933
  - Drop camel-case naming of ext_clk_hz.
  - White space fixes.
* ad7150
  - Local variable to shorten overly long line.
  - Alignment and line break fixes.
* ad7280a
  - Handle an error path that was previously ignored.
  - Use crc8.h to build the crc table replacing custom code.
  - Avoid unecessary cast.
  - Power down the device if an error happens in probe
  - Use devm routines to simplify probe and remove.
* ad7606
  - Alignment fixes.
* ad7780
  - This worked as long as by coincidence an uninitialized value
    was 0.  Lets not rely on that.
  - Ensure gain update is only used with the ad778x chips that
    actually support it.
  - Tidy up pattern mask generation.
  - Read regulator when scale is requested (which should be infrequent)
    as it might have changed from initialization.
* ad7816
  - Move to modern gpio descriptors
  - Don't use a busy_pin for ad7818 as there isn't one.
  - Ensure RD/WR and CONVST pins are outputs (previously they
    were brought up as inputs which doesn't seem to make any sense)
  - DT id table.
* adc128s052
  - SPDX
* adt7316
  - Alignment fix.
  - Fix data reading.  When using I2C the driver never actually
    used the value read.  This has been broken a very long time
    hence no rush to fix it now + the driver is undergoing a lot
    of cleanup.
  - Sanity check that the i2c read didn't fail to actually read
    anything.
* dpot-dac
  - Mark a switch full through with slightly different text so that
    gcc doesn't warn on it.
* gyro-adc
  - Fix a wrong file in the MAINTAINERS entry and add binding doc to the
    listed files.
* ina2xx
  - Add some early returns to clarify error paths in switch.
* lsm6dsx
  - MAINTAINERS entry.
* max11100
  - SPDX
* max9611
  - SPDX
* mcp4131
  - use of_device_get_match_data in preference to spi_get_device_id
    approach.
* rcar-adc
  - SPDX
* sc27xx
  - Add ADC conversion timeout support to avoid possible fault.
* ssp_sensors
  - Don't free managed resources manually.
* st-magn
  - Add a comment to avoid future confusion over when to use -magn
    postfix (on multi chip in package parts)
  - Add BDU register for LIS3MDL where it seems to have been missed.
* st-sensors
  - Minor spelling, grammar etc fixes.
* tpl0102
  - Use a pointer rather than an index of an array to improve conciseness.

----------------------------------------------------------------
Alexandru Ardelean (1):
      staging: iio: ad5933: rename ext_clk_Hz -> ext_clk_hz

Charles-Antoine Couret (4):
      iio:adc:ad7949: Add AD7949 ADC driver family
      dt-bindings: iio: adc: Add AD7949 device tree bindings in documentati=
on
      iio:dac:ti-dac7311 Add driver for Texas Instrument DAC7311
      dt-bindings: iio: dac: Add ti,dac7311 device tree bindings in documen=
tation

Colin Ian King (1):
      iio: adc: ina2xx: add in early -EINVAL returns in case statements

Dan O'Donovan (1):
      iio: adc128s052: use SPDX-License-Identifier

Freeman Liu (1):
      iio: adc: sc27xx: Add ADC data conversion timeout

Giuliano Belinassi (2):
      staging: iio: ad7780: check if ad778x before gain update
      staging: iio: ad7780: generates pattern_mask from PAT bits

Gustavo A. R. Silva (1):
      iio: dpot-dac: mark expected switch fall-through with text GCC expect=
s.

Hans de Goede (1):
      iio: accel: kxcjk1013: Add KIOX0009 ACPI Hardware-ID

Heiko Stuebner (1):
      iio: st-accel: add support for lis3de

Javier Arteaga (1):
      iio: adc128s052: Add pin-compatible IDs

Jiri Olsa (1):
      tools iio: Override CFLAGS assignments

Kuninori Morimoto (3):
      iio: adc: max9611: convert to SPDX identifiers
      iio: adc: max11100: convert to SPDX identifiers
      iio: adc: rcar-gyroadc: convert to SPDX identifiers

Lars-Peter Clausen (1):
      iio: ad_sigma_delta: Allow to provide custom data register address

Lorenzo Bianconi (10):
      iio: imu: st_lsm6dsx: introduce locked read/write utility routines
      iio: imu: st_lsm6dsx: reload trimming parameter at bootstrap
      iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
      iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
      iio: imu: st_lsm6dsx: introduce st_lsm6dsx_sensor_set_enable routine
      iio: imu: st_lsm6dsx: add i2c embedded controller support
      iio: imu: st_lsm6dsx: add st_lsm6dsx_push_tagged_data routine
      iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
      dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors
      iio: imu: st_lsm6dsx: add entry in MAINTAINERS file

Marcelo Schmitt (1):
      Staging:iio:adc:ad7606: Match parenthesis alignment

Marek Vasut (1):
      iio: adc: Fix Renesas GyroADC MAINTAINERS entry

Martin Blumenstingl (2):
      dt-bindings: iio: adc: meson-saradc: add temperature sensor support
      iio: adc: meson-saradc: add support for the chip's temperature sensor

Martin Kelly (5):
      iio: st_sensors: miscellaneous cleanup
      iio: magnetometer: add clarifying comment
      iio:magnetometer: st_magn: add LSM9DS1 support
      iio:magnetometer: st_magn: add BDU settings
      dt-bindings: iio: magn: add LSM9DS1 bindings

Matheus Tavares (6):
      staging: iio: ad2s1210: fix 'assignment operator' style checks
      staging:iio:ad2s90: Make read_raw return spi_read's error code
      staging:iio:ad2s90: Make probe handle spi_setup failure
      staging:iio:ad2s90: Remove always overwritten assignment
      staging:iio:ad2s90: Move device registration to the end of probe
      staging:iio:ad2s90: Check channel type at read_raw

Matt Ranostay (2):
      iio: potentiometer: tpl0102: switch to using pointer to chip config
      iio: potentiometer: tpl0102: add IIO_AVAIL_RANGE support

Nicola Lunghi (1):
      iio: adc128s052: add ACPI _HID AANT1280

Nishad Kamdar (7):
      staging: iio: ad7816: Switch to the gpio descriptor interface
      staging: iio: ad2s1210: Switch to the gpio descriptor interface
      staging: iio: ad2s1210: Drop the gpioin flag.
      staging: iio: ad2s1210: Add device tree table.
      staging: iio: ad7816: Do not use busy_pin in case of AD7818
      staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
      staging: iio: ad7816: Add device tree table.

Parthiban Nallathambi (2):
      iio: light: Add support for vishay vcnl4035
      iio: light: Add device tree binding for vishay vcnl4035

Renato Lui Geh (4):
      staging: iio: adt7316: fix parenthesis alignment
      staging: iio: ad7780: fix offset read value
      staging: iio: ad7780: update voltage on read
      staging: iio: ad7780: remove unnecessary stashed voltage value

Shreeya Patel (2):
      Staging: iio: adt7316: Fix i2c data reading, set the data field
      Staging: iio: adt7316: Add an extra check for 'ret' equals to 0

Slawomir Stepien (8):
      staging: iio: cdc: ad7150: use value copy to shorten the line length
      staging: iio: cdc: ad7150: fix misaligned lines
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()
      staging: iio: adc: ad7280a: use crc8.h API to build crc table
      staging: iio: adc: ad7280a: don't cast type inside switch expression
      staging: iio: adc: ad7280a: power down the device on error in probe
      staging: iio: adc: ad7280a: use devm_* APIs
      iio: potentiometer: mcp4131: use of_device_get_match_data()

Song Qiang (3):
      dt-bindings: Add PNI to the vendor prefixes
      iio: magnetometer: Add DT support for PNI RM3100
      iio: magnetometer: Add driver support for PNI RM3100

Stefan Popa (3):
      dt-bindings: iio: adc: Add common ADCs properties to a separate file
      iio: adc: Add ad7124 support
      dt-bindings: iio: adc: Add docs for ad7124

Uwe Kleine-K=C3=B6nig (1):
      iio: ssp_sensors: don't manually free devm managed resources

Victor Colombo (3):
      staging: iio: ad5933: Remove unnecessary space on casting
      staging: iio: ad5933: Remove unnecessary blank line
      staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_=
raw

 .../devicetree/bindings/iio/adc/ad7949.txt         |  16 +
 Documentation/devicetree/bindings/iio/adc/adc.txt  |  23 +
 .../devicetree/bindings/iio/adc/adi,ad7124.txt     |  75 ++
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   6 +
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |   9 +-
 .../devicetree/bindings/iio/dac/ti,dac7311.txt     |  23 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   1 +
 .../devicetree/bindings/iio/light/vcnl4035.txt     |  18 +
 .../bindings/iio/magnetometer/pni,rm3100.txt       |  20 +
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |  26 +-
 drivers/iio/accel/Kconfig                          |   2 +-
 drivers/iio/accel/kxcjk-1013.c                     |   1 +
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |   1 +
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   5 +
 drivers/iio/adc/Kconfig                            |  21 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/ad7124.c                           | 684 ++++++++++++++++++
 drivers/iio/adc/ad7949.c                           | 347 +++++++++
 drivers/iio/adc/ad_sigma_delta.c                   |  22 +-
 drivers/iio/adc/ina2xx-adc.c                       |   2 +
 drivers/iio/adc/max11100.c                         |   5 +-
 drivers/iio/adc/max9611.c                          |   5 +-
 drivers/iio/adc/meson_saradc.c                     | 229 +++++-
 drivers/iio/adc/rcar-gyroadc.c                     |  11 +-
 drivers/iio/adc/sc27xx_adc.c                       |  12 +-
 drivers/iio/adc/ti-adc128s052.c                    |  37 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  20 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   3 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   4 +-
 drivers/iio/dac/Kconfig                            |   9 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/dpot-dac.c                         |   4 +-
 drivers/iio/dac/ti-dac7311.c                       | 338 +++++++++
 drivers/iio/imu/st_lsm6dsx/Makefile                |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 167 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 165 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 283 +++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       | 777 +++++++++++++++++=
++++
 drivers/iio/light/Kconfig                          |  13 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/vcnl4035.c                       | 676 ++++++++++++++++++
 drivers/iio/magnetometer/Kconfig                   |  29 +
 drivers/iio/magnetometer/Makefile                  |   4 +
 drivers/iio/magnetometer/rm3100-core.c             | 616 ++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c              |  54 ++
 drivers/iio/magnetometer/rm3100-spi.c              |  64 ++
 drivers/iio/magnetometer/rm3100.h                  |  17 +
 drivers/iio/magnetometer/st_magn.h                 |   1 +
 drivers/iio/magnetometer/st_magn_core.c            |  11 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
 drivers/iio/magnetometer/st_magn_spi.c             |   7 +
 drivers/iio/potentiometer/mcp4131.c                |  11 +-
 drivers/iio/potentiometer/tpl0102.c                |  42 +-
 drivers/staging/iio/adc/Kconfig                    |   1 +
 drivers/staging/iio/adc/ad7280a.c                  | 165 ++---
 drivers/staging/iio/adc/ad7606.c                   |   2 +-
 drivers/staging/iio/adc/ad7780.c                   |  72 +-
 drivers/staging/iio/adc/ad7816.c                   | 113 +--
 drivers/staging/iio/addac/adt7316-i2c.c            |   6 +
 drivers/staging/iio/addac/adt7316.c                | 462 ++++++------
 drivers/staging/iio/addac/adt7316.h                |   2 +-
 drivers/staging/iio/cdc/ad7150.c                   |   9 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  11 +-
 drivers/staging/iio/resolver/ad2s1210.c            | 140 ++--
 drivers/staging/iio/resolver/ad2s1210.h            |  20 -
 drivers/staging/iio/resolver/ad2s90.c              |  53 +-
 include/linux/iio/adc/ad_sigma_delta.h             |   3 +
 include/linux/iio/common/st_sensors.h              |   2 +-
 include/linux/platform_data/st_sensors_pdata.h     |   2 +
 tools/iio/Makefile                                 |   2 +-
 74 files changed, 5240 insertions(+), 763 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,=
rm3100.txt
 create mode 100644 drivers/iio/adc/ad7124.c
 create mode 100644 drivers/iio/adc/ad7949.c
 create mode 100644 drivers/iio/dac/ti-dac7311.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
 create mode 100644 drivers/iio/light/vcnl4035.c
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.h
