Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38943 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbaBKVun (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2014 16:50:43 -0500
Message-ID: <52FA9B54.5020607@kernel.org>
Date: Tue, 11 Feb 2014 21:51:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-iio@vger.kernel.org
Subject: [PULL]  IIO new drivers, features and cleanups for 3.15 - set 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


The following changes since commit 4c45b1a80ee9c85aee13445b85fd55541ec26d27:

   ion: Add carveout and chunk heaps to dummy driver (2014-01-09 21:16:40 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.15a

for you to fetch changes up to 7da773e61831d677bfbe2bfcf10d39430f5a5bc2:

   iio: imu: inv_mpu6050: Fix typo and formatting (2014-02-08 12:29:40 +0000)

----------------------------------------------------------------
First set of new drivers and cleanups for IIO in the 3.15 cycle.

New drivers:
* si7005 relative humidity and temperature sensor
* Lite-on ltr501 ambient light and proximity sensor

Cleanups
* Clean up some dead comments in max1363
* Drop some obsolete variables in adjd_s311 and tcs3472 left over from
   the introduction of iio_push_to_buffers_with_timestamp.
* Drop some unneeded linux/init.h includes
* Squish a sparse warning in mpl3115 by correctly specifying a be32 variable.
* A number of cleanups and fixes for sca3000
* Drop an unneed checks in mxs-lradc, ad7303 and adis16400.
* Drop a platform_set_drvdata in viperboard after the only use of it was
   removed during a devm conversion.
* Add a missing device name for ak8975 to comply with the ABI.
* Put mpu6050 into the IMU menu as it slipped out into the main menu.
* Fix a typo and some comment formatting in mpu6050.
* Document at91 ADC clock properties.

----------------------------------------------------------------
Alexandre Belloni (1):
       iio: mxs-lradc: remove useless check

Beomho Seo (1):
       iio: ak8975: Add device name

Boris BREZILLON (1):
       iio: at91: document ADC clock properties

Dan Carpenter (2):
       iio:imu:adis16400 remove an unneeded check
       iio: dac: ad7303: remove an unneeded check

Johannes Thumshirn (1):
       iio: adc: viperboard: Drop platform_set_drvdata call

Manuel Stahl (2):
       iio: imu: mpu6050: Move config entry into IMU menu
       iio: imu: inv_mpu6050: Fix typo and formatting

Paul Gortmaker (1):
       iio: delete non-required instances of include <linux/init.h>

Peter Meerwald (11):
       iio: Add si7005 relative humidity and temperature sensor driver
       iio: Remove obsolete variable in adjd_s311 driver
       iio: Remove obsolete variable in tcs3472 driver
       iio:pressure:mpl3115: Fix sparse cast to restricted __be32 warning
       iio: Add Lite-On ltr501 ambient light / proximity sensor driver
       staging:iio:accel:sca3000: Fix kerneldoc
       staging:iio:accel:sca3000: Fix format of comments
       staging:iio:accel:sca3000: Event_attribute_group seems to be missing for _info_with_temp
       staging:iio:accel:sca3000: Channels missing in temp_output case
       staging:iio:accel:sca3000: Move temperature attribute to channels
       staging:iio:accel:sca3000: Cleanup sca3000.h

Vivien Didelot (1):
       iio:adc:max1363 clear list of missing features

  .../devicetree/bindings/arm/atmel-adc.txt          |   5 +
  drivers/iio/adc/max1363.c                          |  10 +-
  drivers/iio/adc/ti_am335x_adc.c                    |   1 -
  drivers/iio/adc/twl6030-gpadc.c                    |   1 -
  drivers/iio/adc/viperboard_adc.c                   |   2 -
  drivers/iio/dac/ad7303.c                           |   2 +-
  drivers/iio/dac/max517.c                           |   1 -
  drivers/iio/dac/mcp4725.c                          |   1 -
  drivers/iio/humidity/Kconfig                       |  10 +
  drivers/iio/humidity/Makefile                      |   1 +
  drivers/iio/humidity/si7005.c                      | 189 +++++++++
  drivers/iio/imu/Kconfig                            |   4 +-
  drivers/iio/imu/adis16400_core.c                   |   2 +-
  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   3 +-
  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  38 +-
  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   1 -
  drivers/iio/light/Kconfig                          |  12 +
  drivers/iio/light/Makefile                         |   1 +
  drivers/iio/light/adjd_s311.c                      |   3 -
  drivers/iio/light/ltr501.c                         | 445 +++++++++++++++++++++
  drivers/iio/light/tcs3472.c                        |   2 -
  drivers/iio/magnetometer/ak8975.c                  |   1 +
  drivers/iio/pressure/mpl3115.c                     |   2 +-
  drivers/staging/iio/accel/sca3000.h                |  26 +-
  drivers/staging/iio/accel/sca3000_core.c           | 172 ++++----
  drivers/staging/iio/adc/mxs-lradc.c                |   4 -
  26 files changed, 781 insertions(+), 158 deletions(-)
  create mode 100644 drivers/iio/humidity/si7005.c
  create mode 100644 drivers/iio/light/ltr501.c
