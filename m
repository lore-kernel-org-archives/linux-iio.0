Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54281 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab3HST62 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 15:58:28 -0400
Message-ID: <521286F4.1020702@kernel.org>
Date: Mon, 19 Aug 2013 21:58:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers and cleanups for 3.12 - set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9c6cd3b39048c8bbb83c5cd936f4dffc847321c6:

  android/sync: use get_unused_fd_flags(O_CLOEXEC) instead of get_unused_fd() (2013-08-15 17:27:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.12b

for you to fetch changes up to cc566fd5e52d64554d294b4d36f9d593cbe797d5:

  iio: dac: max517: Use devm_iio_device_alloc (2013-08-19 20:38:50 +0100)

----------------------------------------------------------------
Second round of new drivers, features and cleanups for IIO in the 3.12 cycle.

New driver:

1) tmp006 IR thermopile driver.  This is an unusual temperature sensor
   and was taken in to IIO with the knowledge and agreement of a hwmon
   maintainer.
   It measures remote temperature using infrared emissions.
   I guess taking this may mean we have to fight off submissions of
   devices much more suited to hwmon but such is life and we end up
   doing this from time to time already.

2) twl6030 adc driver.

Cleanups:

1) More devm_* cleanups following on from the introduction of
   devm_iio_device_alloc.  Mostly an heroic effort from
   Sachin Kamat!

2) Introduce devm_iio_trigger_alloc etc to handle trigger
   allocation and deallocation in a managed fashion.  There
   aren't as many instances of triggers as devices, but this
   will allow futher reduction in error patch complexity in
   some of our most complex drivers making it a very good thing.
3) Trivial removal of unused defines in adjd_s311

4) Drop some write_raw_get_fmt callbacks where they were only
   returning the default value.

5) Change mxs-lradc realbits to 12.  Whilst an 18bit register
   is used on the device, in its current mode only 12 bits of
   useful data are returned.  For now the packing is unchanged
   in the buffer and this change mainly effects the input support
   in the driver.

----------------------------------------------------------------
Hector Palacios (1):
      iio: mxs-lradc: change the realbits to 12

Jacek Anaszewski (1):
      iio: trigger: implement devm_iio_trigger_alloc/devm_iio_triger_free

Oleksandr Kozaruk (2):
      iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
      iio: adc: twl6030-gpadc: Use devm_* API family

Peter Meerwald (4):
      iio: Add tmp006 IR temperature sensor
      iio: Restore alphabetic order in Makefile
      iio: Remove unnecessary _write_raw_get_fmt() in several hid-sensor drivers
      iio: adjd_s311: Cleanup unused #defines

Sachin Kamat (23):
      iio: gyro: adis16080: Use devm_iio_device_alloc
      iio: gyro: adis16130: Use devm_iio_device_alloc
      iio: gyro: adis16136: Use devm_iio_device_alloc
      iio: gyro: adis16260: Use devm_iio_device_alloc
      iio: hid-sensor-gyro-3d: Use devm_iio_device_alloc
      iio: gyro: adxrs450: Use devm_iio_device_alloc
      iio: gyro: itg3200_core: Use devm_iio_device_alloc
      iio: gyro: st_gyro: Use devm_iio_device_alloc
      iio: gyro: adis16060_core: Use devm_iio_device_alloc
      iio: dac: ad5064: Use devm_* APIs
      iio: dac: ad5360: Use devm_* APIs
      iio: dac: ad5380: Use devm_* APIs
      iio: dac: ad5421: Use devm_* APIs
      iio: dac: ad5446: Use devm_* APIs
      iio: dac: ad5449: Use devm_* APIs
      iio: dac: ad5504: Use devm_* APIs
      iio: dac: ad5624r_spi: Use devm_* APIs
      iio: dac: ad5686: Use devm_* APIs
      iio: dac: ad5755: Use devm_iio_device_alloc
      iio: dac: ad5764: Use devm_* APIs
      iio: dac: ad5791: Use devm_* APIs
      iio: dac: ad7303: Use devm_* APIs
      iio: dac: max517: Use devm_iio_device_alloc

 Documentation/driver-model/devres.txt         |    2 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    3 +-
 drivers/iio/accel/hid-sensor-accel-3d.c       |    8 -
 drivers/iio/adc/Kconfig                       |   14 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/twl6030-gpadc.c               | 1013 +++++++++++++++++++++++++
 drivers/iio/dac/ad5064.c                      |   21 +-
 drivers/iio/dac/ad5360.c                      |   15 +-
 drivers/iio/dac/ad5380.c                      |   18 +-
 drivers/iio/dac/ad5421.c                      |   19 +-
 drivers/iio/dac/ad5446.c                      |   19 +-
 drivers/iio/dac/ad5449.c                      |   15 +-
 drivers/iio/dac/ad5504.c                      |   31 +-
 drivers/iio/dac/ad5624r_spi.c                 |   22 +-
 drivers/iio/dac/ad5686.c                      |   17 +-
 drivers/iio/dac/ad5755.c                      |   14 +-
 drivers/iio/dac/ad5764.c                      |   20 +-
 drivers/iio/dac/ad5791.c                      |   35 +-
 drivers/iio/dac/ad7303.c                      |   31 +-
 drivers/iio/dac/max517.c                      |   17 +-
 drivers/iio/gyro/adis16080.c                  |   21 +-
 drivers/iio/gyro/adis16130.c                  |   23 +-
 drivers/iio/gyro/adis16136.c                  |   10 +-
 drivers/iio/gyro/adis16260.c                  |   16 +-
 drivers/iio/gyro/adxrs450.c                   |   15 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |   25 +-
 drivers/iio/gyro/itg3200_core.c               |   15 +-
 drivers/iio/gyro/st_gyro_core.c               |    1 -
 drivers/iio/gyro/st_gyro_i2c.c                |   15 +-
 drivers/iio/gyro/st_gyro_spi.c                |   15 +-
 drivers/iio/industrialio-trigger.c            |   72 +-
 drivers/iio/light/adjd_s311.c                 |   28 +-
 drivers/iio/light/hid-sensor-als.c            |    8 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |    8 -
 drivers/iio/temperature/Kconfig               |   16 +
 drivers/iio/temperature/Makefile              |    5 +
 drivers/iio/temperature/tmp006.c              |  291 +++++++
 drivers/staging/iio/adc/mxs-lradc.c           |   12 +-
 drivers/staging/iio/gyro/adis16060_core.c     |   17 +-
 include/linux/iio/iio.h                       |   29 +
 41 files changed, 1576 insertions(+), 402 deletions(-)
 create mode 100644 drivers/iio/adc/twl6030-gpadc.c
 create mode 100644 drivers/iio/temperature/Kconfig
 create mode 100644 drivers/iio/temperature/Makefile
 create mode 100644 drivers/iio/temperature/tmp006.c
