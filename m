Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:32953 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaGMS54 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 14:57:56 -0400
Message-ID: <53C2D73A.4090208@kernel.org>
Date: Sun, 13 Jul 2014 20:00:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.17 - set 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 14b596c9d80bf63da3f0fcbddfd67eb62197afb4:

   staging: cxt1e1: remove driver (2014-07-01 09:05:33 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.17c

for you to fetch changes up to 90c5f2d1b8212dde11a3dcc9e87ba3593beeb3ac:

   staging:iio:adc:Kconfig: Let MXS_LRADC depend on HAS_IOMEM (2014-07-13 19:44:02 +0100)

----------------------------------------------------------------
3rd round of IIO new drivers, cleanups and functionality for the 3.17 cycle.

New drivers
* isl29125 digital color light sensor driver
* TAOS/AMS tcs3414 digital color sensor

Staging graduation
* ad7291 ADC driver.

New functionality
* st_sensors - device tree support and bindings
* mma8452 - device tree support

Cleanups
* Drop redundant variables in a number of drivers.
* Reorder a structure definition to ealy wiht a warning about static
   not being at the beginning in the hid-sensors driver.
* Switch a few more drivers away from using explicit sampling_frequency
   attribute to providing this through the core.
* Make hid_sensor_get_reporting_interval static as only used within a single
   file.
* Drop a redundant check for negative values in an unsigned variable from
   ad9832
* Drop some duplicate case labels in the event monitor example code.
* Use devm_ioremap_resource to simplify error handling.
* Use devm_kzalloc within the blackfin timer driver to simplify error
   handling and removal.
* A number of cleanups of the ad7291 from Hartmut Knaack in response
   to a patch moving it out of staging.
* Core support for the period info element about events.  It has been
   in the abi for a while, but not added until now to the newer handling
   of information related to events.
* Add HAS_IOMEM dependency to mxs_lradc to avoid build issues when testing
   enabled.

----------------------------------------------------------------
Chen Gang (1):
       staging:iio:adc:Kconfig: Let MXS_LRADC depend on HAS_IOMEM

Daniel Baluta (2):
       iio: hid-sensors: make hid_sensor_get_reporting_interval static
       staging: iio: remove duplicate case labels

Hartmut Knaack (5):
       staging:iio:ad7291 remove double define
       staging:iio:ad7291 fix coding style
       staging:iio:ad7291 cleanup defines
       staging:iio:ad7291 faciliate ad7291_read_event_config()
       staging:iio:ad7291 define alert register bits

Himangi Saraogi (2):
       staging: iio: Introduce the use of devm_ioremap_resource
       iio:trigger: Introduce the use of devm_kzalloc

Jonathan Cameron (5):
       iio:st sensors: remove custom sampling frequence attribute in favour of core support.
       iio: gyro: itg3200 switch sampling frequency attr to core support.
       iio: adis: Switch sampling frequency attr to core support.
       iio: imu: adis16400 switch sampling frequency attr to core support.
       iio: imu: adis16480 switch sampling frequency attr to core support

Lars-Peter Clausen (1):
       staging:iio:ad7291: Move out of staging

Linus Walleij (3):
       iio: st_sensors: get platform data from device tree
       iio: st_sensors: add device tree bindings
       iio: st_sensors: add devicetree probing support

Martin Fuzzey (1):
       iio: mma8452: add DT support

Peter Meerwald (2):
       iio: Add Intersil isl29125 digital color light sensor driver
       iio: Add driver for AMS/TAOS tcs3414 digital color sensor

Sachin Kamat (7):
       iio: adis16400: Remove unused variable
       iio: ad5624r_spi: Remove redundant variable
       iio: ad5504: Remove redundant variable
       iio: ad5686: Remove redundant variable
       iio: xilinx-xadc: Remove unused variable
       iio: hid-sensors: Fix compilation warning
       staging: iio: ad9832: Remove redundant check

Srinivas Pandruvada (1):
       iio: core : events ABI for specifying period

  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
  .../devicetree/bindings/iio/st-sensors.txt         |  54 +++
  drivers/iio/accel/mma8452.c                        |   6 +
  drivers/iio/accel/st_accel_core.c                  |  12 +-
  drivers/iio/accel/st_accel_i2c.c                   |  51 +++
  drivers/iio/adc/Kconfig                            |  10 +
  drivers/iio/adc/Makefile                           |   1 +
  drivers/{staging => }/iio/adc/ad7291.c             | 107 +++---
  drivers/iio/adc/xilinx-xadc-events.c               |   6 -
  .../iio/common/hid-sensors/hid-sensor-attributes.c |   5 +-
  drivers/iio/common/st_sensors/st_sensors_core.c    |  64 ++--
  drivers/iio/common/st_sensors/st_sensors_i2c.c     |  30 ++
  drivers/iio/dac/ad5504.c                           |   5 +-
  drivers/iio/dac/ad5624r_spi.c                      |   5 +-
  drivers/iio/dac/ad5686.c                           |   3 +-
  drivers/iio/gyro/adis16260.c                       | 124 +++----
  drivers/iio/gyro/itg3200_core.c                    | 101 +++--
  drivers/iio/gyro/st_gyro_core.c                    |  12 +-
  drivers/iio/gyro/st_gyro_i2c.c                     |  39 ++
  drivers/iio/imu/adis16400_buffer.c                 |   3 +-
  drivers/iio/imu/adis16400_core.c                   |  78 ++--
  drivers/iio/imu/adis16480.c                        |  82 ++---
  drivers/iio/industrialio-event.c                   |   1 +
  drivers/iio/light/Kconfig                          |  24 ++
  drivers/iio/light/Makefile                         |   2 +
  drivers/iio/light/isl29125.c                       | 347 ++++++++++++++++++
  drivers/iio/light/tcs3414.c                        | 405 +++++++++++++++++++++
  drivers/iio/magnetometer/st_magn_core.c            |  12 +-
  drivers/iio/magnetometer/st_magn_i2c.c             |  23 ++
  drivers/iio/pressure/st_pressure_core.c            |  27 +-
  drivers/iio/pressure/st_pressure_i2c.c             |  23 ++
  .../staging/iio/Documentation/iio_event_monitor.c  |   2 -
  drivers/staging/iio/accel/adis16201_core.c         |  14 +-
  drivers/staging/iio/accel/adis16203_core.c         |  11 +-
  drivers/staging/iio/accel/adis16204_core.c         |  12 +-
  drivers/staging/iio/accel/adis16209_core.c         |  18 +-
  drivers/staging/iio/accel/adis16240_core.c         |  12 +-
  drivers/staging/iio/adc/Kconfig                    |   9 +-
  drivers/staging/iio/adc/Makefile                   |   1 -
  drivers/staging/iio/adc/ad7606_par.c               |  37 +-
  drivers/staging/iio/frequency/ad9832.c             |   2 +-
  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |  31 +-
  include/linux/iio/common/st_sensors.h              |  12 +-
  include/linux/iio/common/st_sensors_i2c.h          |  11 +
  include/linux/iio/imu/adis.h                       |  33 +-
  include/linux/iio/types.h                          |   1 +
  .../adc => include/linux/platform_data}/ad7291.h   |   0
  47 files changed, 1390 insertions(+), 479 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
  rename drivers/{staging => }/iio/adc/ad7291.c (89%)
  create mode 100644 drivers/iio/light/isl29125.c
  create mode 100644 drivers/iio/light/tcs3414.c
  rename {drivers/staging/iio/adc => include/linux/platform_data}/ad7291.h (100%)
