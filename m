Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbdIXQva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 12:51:30 -0400
Date: Sun, 24 Sep 2017 17:51:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, features and cleanup for
 IIO in the 4.15 cycle.
Message-ID: <20170924175127.7521f222@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a575de2da5e20c31f4ffcb1df555c199ad77fc20:

  staging: rtlwifi: Reviewers fixes (2017-08-20 11:13:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.15a

for you to fetch changes up to a6786847407f81885d9d3d498d3b341ce478a709:

  iio: imu: st_lsm6dsx: remove rounding configuration (2017-09-24 16:50:24 +0100)

----------------------------------------------------------------
Round one of new device support, features and cleanup for IIO in the 4.15 cycle.

Note there is a misc driver drop in here given we have support
in IIO and the feeling is no one will care.

A large part of this series is a boiler plate removal series avoiding
the need to explicitly provide THIS_MODULE in various locations.
It's very dull but touches all drivers.

New device support
* ad5446
  - add ids to support compatible parts DAC081S101, DAC101S101,
    DAC121S101.
  - add the dac7512 id and drop the misc driver as feeling is no
    one is using it (was introduced for a board that is long obsolete)
* mt6577
  - add bindings for mt2712 which is fully compatible with other
    supported parts.
* st_pressure
  - add support for LPS33HW and LPS35HW with bindings (ids mostly).

New features
* ccs811
  - Add support for the data ready trigger.
* mma8452
  - remove artifical restriction on supporting multiple event types
    at the same time.
* tcs3472
  - support out of threshold events

Core and tree wide cleanup
* Use macro magic to remove the need to provide THIS_MODULE as part of
  struct iio_info or struct iio_trigger_ops.  This is similar to
  work done in a number of other subsystems (e.g. i2c, spi).

  All drivers are fixed and then the fields in these structures are
  removed.

  This will cause build failures for out of tree drivers and any
  new drivers that cross with this work going into the kernel.

  Note mostly done with a coccinelle patch, included in the series
  on the mailing list but not merged as the fields no longer exist
  in the structures so the any hold outs will cause a build failure.

Cleanups
* ads1015
  - avoid writing config register when it doesn't change.
  - add 10% to conversion wait time as it seems it is sometimes
    a little small.
* ade7753
  - replace use of core mlock with a local lock.  This is part of a
    long term effort to make the use of mlock opaque and single
    purpose.
* ade7759
  - expand the use of buf_lock to cover previous mlock cases.  This
    is a slightly nicer solution to the same issue as in ade7753.
* cros_ec
  - drop an unused variable
* inv_mpu6050
  - add a missing break in a switch for consistency - not actual
    bug,
  - make some local arrays static to save on object code size.
* max5481
  - drop manual setting of the spi module owner as handled by the
    spi core.
* max5487
  - drop manual setting of the spi module owner as handled by the
    spi core.
* max9611
  - drop explicit setting of the i2c module owner as handled by
    the i2c core.
* mcp320x
  - speed up reads on single channel devices,
  - drop unused of_device_id data elements,
  - document the struct mcp320x,
  - improve binding docs to reflect restrictions on spi setup and
    to make it explicit that the reference regulator is needed.
* mma8452
  - symbolic to octal permissions,
  - unsigned to unsigned int.
* st_lsm6dsx
  - avoid setting odr values multiple times,
  - drop config of LIR as it is only ever set to the existing
    defaults,
  - drop rounding configuration as it only ever matches the defaults.
* ti-ads8688
  - drop manual setting of the spi module owner as handled by the
    spi core.
* tsl2x7x
  - constify the i2c_device_id,
  - cleanup limit checks to avoid static checker warnings (and generally
    have nicer code).

----------------------------------------------------------------
Akinobu Mita (1):
      iio: light: tcs3472: support out-of-threshold events

Arvind Yadav (1):
      staging: iio: tsl2x7x: constify i2c_device_id

Colin Ian King (1):
      iio: imu: inv_mpu6050: make arrays hz and d static

Dan Carpenter (1):
      staging: iio: tsl2x7x: clean up limit checks

Gustavo A. R. Silva (2):
      iio: multiplexer: add NULL check on devm_kzalloc() and devm_kmemdup() return values
      iio: imu: inv_mpu6050: fix missing break in switch

Harinath Nampally (3):
      iio: accel: mma8452: improvements to handle multiple events
      iio: accel: mma8452: Fix code style warning
      iio: accel: mma8452: Fix code style warning for unsigned int declarations

Himanshi Jain (1):
      staging: iio: ade7753: replace mlock with driver private lock

Jonathan Cameron (45):
      iio: Use macro magic to avoid manual assign of driver_module
      iio: triggers: Use macros to avoid boilerplate assignment of owner.
      iio:trigger: Remove necessity to have a trig->ops structure.
      iio:adc: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:accel: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:amplifiers:ad8366 drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:chemical: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:common: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:counter:104-quad-8 drop assign iio_info.driver_module
      iio:dac: drop assignment of iio_info.driver_module
      iio:dummy: drop assignment of iio_info.driver_module
      iio:frequency: drop assign iio_info.driver_module
      iio:gyro: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:health: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:humidity: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:imu: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:light: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:magnetometer: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:orientation: drop assign iio_info.driver_module
      iio:dpot: drop assign iio_info.driver_module
      iio:potentiostat:lmp91000 drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:pressure: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:proximity: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:temperature: drop assignment of iio_info.driver_module
      iio:triggers: drop assign iio_info.driver_module and iio_trigger_ops.owner
      staging:iio:accel: drop assignment of iio_info.driver_module
      staging:iio:adc: drop assign iio_info.driver_module
      staging:iio:cdc: drop assign iio_info.driver_module
      staging:iio:frequency: drop assign iio_info.driver_module
      staging:iio:gyro:adis16060 drop assign iio_info.driver_module
      staging:iio:ad5933: drop assign iio_info.driver_module
      staging:iio:meter: drop assign iio_info.driver_module and iio_trigger_ops.owner
      iio:resolver: drop assignment of iio_info.driver_module
      staging:trigger: drop assignment of iio_trigger_ops.owner
      staging:iio:light:tsl2x7x drop assignment of driver_module
      input: tsc2007 - drop the driver_module assignment in iio interface.
      platform/x86: toshiba_acpi: drop assignment of iio_info.driver_module
      iio: multiplexer: drop the manual assignment of THIS_MODULE
      iio: drop iio_info.driver_module and iio_trigger_ops.owner.
      iio:adc:max9611: Drop explicit setting of the i2c module owner.
      iio:adc:ti-ads8688: Drop manual setting of the driver owner field.
      iio:potentiometer:max5481 drop explicit setting of the owner module.
      iio:potentiometer:max5487: Drop explicit setting of module owner
      staging:iio:docs: drop reference to setting trig_ops->owner
      staging:iio:docs: drop setting of THIS_MODULE from staging docs.

Katie Dunne (1):
      Staging: iio: meter: ade7759: update locking method for write frequency

Ladislav Michl (2):
      iio: adc: ti-ads1015: write config register only on change
      iio: adc: ti-ads1015: add 10% to conversion wait time

Lorenzo Bianconi (5):
      iio: pressure: add support to LPS33HW and LPS35HW
      dt-bindings: iio: pressure: add LPS33HW and LPS35HW device bindings
      iio: imu: st_lsm6dsx: set sensor->odr value just in st_lsm6dsx_write_raw()
      iio: imu: st_lsm6dsx: remove LIR configuration
      iio: imu: st_lsm6dsx: remove rounding configuration

Lukas Wunner (6):
      iio: dac: ad5446: Add IDs of compatible Texas Instruments chips
      drivers: misc: ti_dac7512: Remove duplicate driver
      iio: adc: mcp320x: Speed up readout of single-channel ADCs
      iio: adc: mcp320x: Drop unnecessary of_device_id attributes
      iio: adc: mcp320x: Document struct mcp320x
      dt-bindings: iio: adc: mcp320x: Update for mcp3550/1/3

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Add support for data ready trigger

Paolo Cretaro (1):
      iio: cros_ec: Remove unused variable

Zhiyong Tao (2):
      dt-bindings: adc: mt2712: add binding documention
      iio: adc: mt2712: Add compatible node for mt2712.

 .../devicetree/bindings/iio/adc/mcp320x.txt        |  14 +
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |   1 +
 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 arch/arm/configs/pxa_defconfig                     |   3 +-
 arch/arm/configs/raumfeld_defconfig                |   3 +-
 drivers/iio/accel/adxl345_core.c                   |   1 -
 drivers/iio/accel/bma180.c                         |   2 -
 drivers/iio/accel/bma220_spi.c                     |   1 -
 drivers/iio/accel/bmc150-accel-core.c              |   3 -
 drivers/iio/accel/da280.c                          |   1 -
 drivers/iio/accel/da311.c                          |   1 -
 drivers/iio/accel/dmard06.c                        |   1 -
 drivers/iio/accel/dmard09.c                        |   1 -
 drivers/iio/accel/dmard10.c                        |   1 -
 drivers/iio/accel/hid-sensor-accel-3d.c            |   1 -
 drivers/iio/accel/kxcjk-1013.c                     |   2 -
 drivers/iio/accel/kxsd9.c                          |   1 -
 drivers/iio/accel/mc3230.c                         |   1 -
 drivers/iio/accel/mma7455_core.c                   |   1 -
 drivers/iio/accel/mma7660.c                        |   1 -
 drivers/iio/accel/mma8452.c                        | 375 ++++++++++++---------
 drivers/iio/accel/mma9551.c                        |   1 -
 drivers/iio/accel/mma9553.c                        |   1 -
 drivers/iio/accel/mxc4005.c                        |   2 -
 drivers/iio/accel/mxc6255.c                        |   1 -
 drivers/iio/accel/sca3000.c                        |   1 -
 drivers/iio/accel/st_accel_core.c                  |   2 -
 drivers/iio/accel/stk8312.c                        |   2 -
 drivers/iio/accel/stk8ba50.c                       |   2 -
 drivers/iio/adc/ad7266.c                           |   1 -
 drivers/iio/adc/ad7291.c                           |   1 -
 drivers/iio/adc/ad7298.c                           |   1 -
 drivers/iio/adc/ad7476.c                           |   1 -
 drivers/iio/adc/ad7766.c                           |   2 -
 drivers/iio/adc/ad7791.c                           |   2 -
 drivers/iio/adc/ad7793.c                           |   2 -
 drivers/iio/adc/ad7887.c                           |   1 -
 drivers/iio/adc/ad7923.c                           |   1 -
 drivers/iio/adc/ad799x.c                           |   3 -
 drivers/iio/adc/ad_sigma_delta.c                   |   1 -
 drivers/iio/adc/aspeed_adc.c                       |   1 -
 drivers/iio/adc/at91-sama5d2_adc.c                 |   2 -
 drivers/iio/adc/at91_adc.c                         |   2 -
 drivers/iio/adc/axp20x_adc.c                       |   2 -
 drivers/iio/adc/axp288_adc.c                       |   1 -
 drivers/iio/adc/bcm_iproc_adc.c                    |   1 -
 drivers/iio/adc/berlin2-adc.c                      |   1 -
 drivers/iio/adc/cc10001_adc.c                      |   1 -
 drivers/iio/adc/cpcap-adc.c                        |   1 -
 drivers/iio/adc/da9150-gpadc.c                     |   1 -
 drivers/iio/adc/dln2-adc.c                         |   6 -
 drivers/iio/adc/envelope-detector.c                |   1 -
 drivers/iio/adc/exynos_adc.c                       |   1 -
 drivers/iio/adc/hi8435.c                           |   1 -
 drivers/iio/adc/hx711.c                            |   1 -
 drivers/iio/adc/imx7d_adc.c                        |   1 -
 drivers/iio/adc/ina2xx-adc.c                       |   2 -
 drivers/iio/adc/lp8788_adc.c                       |   1 -
 drivers/iio/adc/lpc18xx_adc.c                      |   1 -
 drivers/iio/adc/lpc32xx_adc.c                      |   1 -
 drivers/iio/adc/ltc2471.c                          |   1 -
 drivers/iio/adc/ltc2485.c                          |   1 -
 drivers/iio/adc/ltc2497.c                          |   1 -
 drivers/iio/adc/max1027.c                          |   2 -
 drivers/iio/adc/max11100.c                         |   1 -
 drivers/iio/adc/max1118.c                          |   1 -
 drivers/iio/adc/max1363.c                          |   2 -
 drivers/iio/adc/max9611.c                          |   2 -
 drivers/iio/adc/mcp320x.c                          | 121 +++----
 drivers/iio/adc/mcp3422.c                          |   1 -
 drivers/iio/adc/men_z188_adc.c                     |   1 -
 drivers/iio/adc/meson_saradc.c                     |   1 -
 drivers/iio/adc/mt6577_auxadc.c                    |   2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |   2 -
 drivers/iio/adc/nau7802.c                          |   1 -
 drivers/iio/adc/palmas_gpadc.c                     |   1 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   1 -
 drivers/iio/adc/qcom-spmi-iadc.c                   |   1 -
 drivers/iio/adc/qcom-spmi-vadc.c                   |   1 -
 drivers/iio/adc/rcar-gyroadc.c                     |   1 -
 drivers/iio/adc/rockchip_saradc.c                  |   1 -
 drivers/iio/adc/spear_adc.c                        |   1 -
 drivers/iio/adc/stm32-adc.c                        |   1 -
 drivers/iio/adc/stx104.c                           |   1 -
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   1 -
 drivers/iio/adc/ti-adc081c.c                       |   1 -
 drivers/iio/adc/ti-adc0832.c                       |   1 -
 drivers/iio/adc/ti-adc084s021.c                    |   1 -
 drivers/iio/adc/ti-adc108s102.c                    |   1 -
 drivers/iio/adc/ti-adc12138.c                      |   1 -
 drivers/iio/adc/ti-adc128s052.c                    |   1 -
 drivers/iio/adc/ti-adc161s626.c                    |   1 -
 drivers/iio/adc/ti-ads1015.c                       |  22 +-
 drivers/iio/adc/ti-ads7950.c                       |   1 -
 drivers/iio/adc/ti-ads8688.c                       |   2 -
 drivers/iio/adc/ti-tlc4541.c                       |   1 -
 drivers/iio/adc/ti_am335x_adc.c                    |   1 -
 drivers/iio/adc/twl4030-madc.c                     |   1 -
 drivers/iio/adc/twl6030-gpadc.c                    |   1 -
 drivers/iio/adc/vf610_adc.c                        |   1 -
 drivers/iio/adc/viperboard_adc.c                   |   1 -
 drivers/iio/adc/xilinx-xadc-core.c                 |   2 -
 drivers/iio/amplifiers/ad8366.c                    |   1 -
 drivers/iio/chemical/ams-iaq-core.c                |   1 -
 drivers/iio/chemical/atlas-ph-sensor.c             |   2 -
 drivers/iio/chemical/ccs811.c                      |  87 ++++-
 drivers/iio/chemical/vz89x.c                       |   1 -
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   1 -
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   1 -
 drivers/iio/counter/104-quad-8.c                   |   1 -
 drivers/iio/dac/Kconfig                            |   3 +-
 drivers/iio/dac/ad5064.c                           |   1 -
 drivers/iio/dac/ad5360.c                           |   1 -
 drivers/iio/dac/ad5380.c                           |   1 -
 drivers/iio/dac/ad5421.c                           |   1 -
 drivers/iio/dac/ad5446.c                           |  14 +-
 drivers/iio/dac/ad5449.c                           |   1 -
 drivers/iio/dac/ad5504.c                           |   1 -
 drivers/iio/dac/ad5592r-base.c                     |   1 -
 drivers/iio/dac/ad5624r_spi.c                      |   1 -
 drivers/iio/dac/ad5686.c                           |   1 -
 drivers/iio/dac/ad5755.c                           |   1 -
 drivers/iio/dac/ad5761.c                           |   1 -
 drivers/iio/dac/ad5764.c                           |   1 -
 drivers/iio/dac/ad5791.c                           |   1 -
 drivers/iio/dac/ad7303.c                           |   1 -
 drivers/iio/dac/ad8801.c                           |   1 -
 drivers/iio/dac/cio-dac.c                          |   1 -
 drivers/iio/dac/dpot-dac.c                         |   1 -
 drivers/iio/dac/lpc18xx_dac.c                      |   1 -
 drivers/iio/dac/ltc2632.c                          |   1 -
 drivers/iio/dac/m62332.c                           |   1 -
 drivers/iio/dac/max517.c                           |   1 -
 drivers/iio/dac/max5821.c                          |   1 -
 drivers/iio/dac/mcp4725.c                          |   1 -
 drivers/iio/dac/mcp4922.c                          |   1 -
 drivers/iio/dac/stm32-dac.c                        |   1 -
 drivers/iio/dac/vf610_dac.c                        |   1 -
 drivers/iio/dummy/iio_simple_dummy.c               |   1 -
 drivers/iio/frequency/ad9523.c                     |   1 -
 drivers/iio/frequency/adf4350.c                    |   1 -
 drivers/iio/gyro/adis16080.c                       |   1 -
 drivers/iio/gyro/adis16130.c                       |   1 -
 drivers/iio/gyro/adis16136.c                       |   1 -
 drivers/iio/gyro/adis16260.c                       |   1 -
 drivers/iio/gyro/adxrs450.c                        |   1 -
 drivers/iio/gyro/bmg160_core.c                     |   2 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   1 -
 drivers/iio/gyro/itg3200_buffer.c                  |   1 -
 drivers/iio/gyro/itg3200_core.c                    |   1 -
 drivers/iio/gyro/mpu3050-core.c                    |   2 -
 drivers/iio/gyro/st_gyro_core.c                    |   2 -
 drivers/iio/health/afe4403.c                       |   2 -
 drivers/iio/health/afe4404.c                       |   2 -
 drivers/iio/health/max30100.c                      |   1 -
 drivers/iio/health/max30102.c                      |   1 -
 drivers/iio/humidity/am2315.c                      |   1 -
 drivers/iio/humidity/dht11.c                       |   1 -
 drivers/iio/humidity/hdc100x.c                     |   1 -
 drivers/iio/humidity/hid-sensor-humidity.c         |   1 -
 drivers/iio/humidity/hts221_buffer.c               |   1 -
 drivers/iio/humidity/hts221_core.c                 |   1 -
 drivers/iio/humidity/htu21.c                       |   1 -
 drivers/iio/humidity/si7005.c                      |   1 -
 drivers/iio/humidity/si7020.c                      |   1 -
 drivers/iio/imu/adis16400_core.c                   |   1 -
 drivers/iio/imu/adis16480.c                        |   1 -
 drivers/iio/imu/adis_trigger.c                     |   1 -
 drivers/iio/imu/bmi160/bmi160_core.c               |   1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  13 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   1 -
 drivers/iio/imu/kmx61.c                            |   3 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  20 +-
 drivers/iio/industrialio-core.c                    |  35 +-
 drivers/iio/industrialio-trigger.c                 |  35 +-
 drivers/iio/light/acpi-als.c                       |   1 -
 drivers/iio/light/adjd_s311.c                      |   1 -
 drivers/iio/light/al3320a.c                        |   1 -
 drivers/iio/light/apds9300.c                       |   2 -
 drivers/iio/light/apds9960.c                       |   1 -
 drivers/iio/light/bh1750.c                         |   1 -
 drivers/iio/light/bh1780.c                         |   1 -
 drivers/iio/light/cm32181.c                        |   1 -
 drivers/iio/light/cm3232.c                         |   1 -
 drivers/iio/light/cm3323.c                         |   1 -
 drivers/iio/light/cm3605.c                         |   1 -
 drivers/iio/light/cm36651.c                        |   1 -
 drivers/iio/light/cros_ec_light_prox.c             |   1 -
 drivers/iio/light/gp2ap020a00f.c                   |   2 -
 drivers/iio/light/hid-sensor-als.c                 |   1 -
 drivers/iio/light/hid-sensor-prox.c                |   1 -
 drivers/iio/light/isl29018.c                       |   2 -
 drivers/iio/light/isl29028.c                       |   1 -
 drivers/iio/light/isl29125.c                       |   1 -
 drivers/iio/light/jsa1212.c                        |   1 -
 drivers/iio/light/lm3533-als.c                     |   1 -
 drivers/iio/light/ltr501.c                         |   4 -
 drivers/iio/light/max44000.c                       |   1 -
 drivers/iio/light/opt3001.c                        |   1 -
 drivers/iio/light/pa12203001.c                     |   1 -
 drivers/iio/light/rpr0521.c                        |   2 -
 drivers/iio/light/si1145.c                         |   3 -
 drivers/iio/light/stk3310.c                        |   1 -
 drivers/iio/light/tcs3414.c                        |   1 -
 drivers/iio/light/tcs3472.c                        | 263 ++++++++++++++-
 drivers/iio/light/tsl2563.c                        |   2 -
 drivers/iio/light/tsl2583.c                        |   1 -
 drivers/iio/light/tsl4531.c                        |   1 -
 drivers/iio/light/us5182d.c                        |   1 -
 drivers/iio/light/vcnl4000.c                       |   1 -
 drivers/iio/light/veml6070.c                       |   1 -
 drivers/iio/light/vl6180.c                         |   1 -
 drivers/iio/magnetometer/ak8974.c                  |   1 -
 drivers/iio/magnetometer/ak8975.c                  |   1 -
 drivers/iio/magnetometer/bmc150_magn.c             |   2 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   1 -
 drivers/iio/magnetometer/hmc5843_core.c            |   1 -
 drivers/iio/magnetometer/mag3110.c                 |   1 -
 drivers/iio/magnetometer/mmc35240.c                |   1 -
 drivers/iio/magnetometer/st_magn_core.c            |   2 -
 drivers/iio/multiplexer/iio-mux.c                  |   7 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   1 -
 drivers/iio/orientation/hid-sensor-rotation.c      |   1 -
 drivers/iio/potentiometer/ds1803.c                 |   1 -
 drivers/iio/potentiometer/max5481.c                |   2 -
 drivers/iio/potentiometer/max5487.c                |   2 -
 drivers/iio/potentiometer/mcp4131.c                |   1 -
 drivers/iio/potentiometer/mcp4531.c                |   1 -
 drivers/iio/potentiometer/tpl0102.c                |   1 -
 drivers/iio/potentiostat/lmp91000.c                |   2 -
 drivers/iio/pressure/abp060mg.c                    |   1 -
 drivers/iio/pressure/bmp280-core.c                 |   1 -
 drivers/iio/pressure/cros_ec_baro.c                |   3 -
 drivers/iio/pressure/hid-sensor-press.c            |   1 -
 drivers/iio/pressure/hp03.c                        |   1 -
 drivers/iio/pressure/hp206c.c                      |   1 -
 drivers/iio/pressure/mpl115.c                      |   1 -
 drivers/iio/pressure/mpl3115.c                     |   1 -
 drivers/iio/pressure/ms5611_core.c                 |   1 -
 drivers/iio/pressure/ms5637.c                      |   1 -
 drivers/iio/pressure/st_pressure.h                 |   4 +
 drivers/iio/pressure/st_pressure_core.c            |   4 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  10 +
 drivers/iio/pressure/st_pressure_spi.c             |  10 +
 drivers/iio/pressure/t5403.c                       |   1 -
 drivers/iio/pressure/zpa2326.c                     |   2 -
 drivers/iio/proximity/as3935.c                     |   2 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 -
 drivers/iio/proximity/srf04.c                      |   1 -
 drivers/iio/proximity/srf08.c                      |   2 -
 drivers/iio/proximity/sx9500.c                     |   2 -
 drivers/iio/temperature/hid-sensor-temperature.c   |   1 -
 drivers/iio/temperature/maxim_thermocouple.c       |   1 -
 drivers/iio/temperature/mlx90614.c                 |   1 -
 drivers/iio/temperature/tmp006.c                   |   1 -
 drivers/iio/temperature/tmp007.c                   |   1 -
 drivers/iio/temperature/tsys01.c                   |   1 -
 drivers/iio/temperature/tsys02d.c                  |   1 -
 drivers/iio/trigger/iio-trig-hrtimer.c             |   1 -
 drivers/iio/trigger/iio-trig-interrupt.c           |   1 -
 drivers/iio/trigger/iio-trig-loop.c                |   1 -
 drivers/iio/trigger/iio-trig-sysfs.c               |   1 -
 drivers/iio/trigger/stm32-timer-trigger.c          |   2 -
 drivers/input/touchscreen/tsc2007_iio.c            |   1 -
 drivers/misc/Kconfig                               |  10 -
 drivers/misc/Makefile                              |   1 -
 drivers/misc/ti_dac7512.c                          | 103 ------
 drivers/platform/x86/toshiba_acpi.c                |   1 -
 drivers/staging/iio/Documentation/device.txt       |   3 -
 drivers/staging/iio/Documentation/trigger.txt      |   4 -
 drivers/staging/iio/accel/adis16201.c              |   1 -
 drivers/staging/iio/accel/adis16203.c              |   1 -
 drivers/staging/iio/accel/adis16209.c              |   1 -
 drivers/staging/iio/accel/adis16240.c              |   1 -
 drivers/staging/iio/adc/ad7192.c                   |   2 -
 drivers/staging/iio/adc/ad7280a.c                  |   1 -
 drivers/staging/iio/adc/ad7606.c                   |   4 -
 drivers/staging/iio/adc/ad7780.c                   |   1 -
 drivers/staging/iio/adc/ad7816.c                   |   1 -
 drivers/staging/iio/addac/adt7316.c                |   2 -
 drivers/staging/iio/cdc/ad7150.c                   |   1 -
 drivers/staging/iio/cdc/ad7152.c                   |   1 -
 drivers/staging/iio/cdc/ad7746.c                   |   1 -
 drivers/staging/iio/frequency/ad9832.c             |   1 -
 drivers/staging/iio/frequency/ad9834.c             |   2 -
 drivers/staging/iio/gyro/adis16060_core.c          |   1 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   1 -
 drivers/staging/iio/light/tsl2x7x.c                |  19 +-
 drivers/staging/iio/light/tsl2x7x.h                |  11 +-
 drivers/staging/iio/meter/ade7753.c                |   8 +-
 drivers/staging/iio/meter/ade7754.c                |   1 -
 drivers/staging/iio/meter/ade7758_core.c           |   1 -
 drivers/staging/iio/meter/ade7758_trigger.c        |   1 -
 drivers/staging/iio/meter/ade7759.c                |  28 +-
 drivers/staging/iio/meter/ade7854.c                |   1 -
 drivers/staging/iio/resolver/ad2s1200.c            |   1 -
 drivers/staging/iio/resolver/ad2s1210.c            |   1 -
 drivers/staging/iio/resolver/ad2s90.c              |   1 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   1 -
 include/linux/iio/iio.h                            |  34 +-
 include/linux/iio/trigger.h                        |  21 +-
 301 files changed, 791 insertions(+), 831 deletions(-)
 delete mode 100644 drivers/misc/ti_dac7512.c
