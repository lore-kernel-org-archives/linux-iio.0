Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59059 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab3B0Ujk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:39:40 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/67] IIO break info_mask into a pair of masks
Date: Wed, 27 Feb 2013 20:38:06 +0000
Message-Id: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

This has been on my todo list for a while.  I'm not sure how we ever ended
up with the mess that is the current info_mask bitmap of which properties
exist for a given channel.  Anyhow currently you have two types of bit
in there, IIO_CHAN_INFO_SHARED_BIT (even) and IIO_CHAN_INFO_SEPARATE_BIT (odd).
Whether we have odd or even elements is used to indicate whether we
want an associated attribute specific to the channel, or one that is shared.
E.g.

in_accel_x_scale (for just the x accel channel)
or
in_accel_scale (for all accel channels)

in_illuminance0_calibbias
or
in_illuminance_calibbias

This led to a horrible mess in iio.h where we had macros for each
option of every element added to the info_mask.  Also, a while
back it became apparent that sometimes we have attributes shared across
all channels irrespective of their type (sampling_frequency for example).
Now the obvious solution to this would be to add a third type of info_mask
element, but then things are getting rather silly.

Hence the proposed solution.  Have separate info_mask elements for each of the
two types of bit we had previously (others may follow).

Advantages:

1) More consise naming of elements
2) Drop all those hideous macros
3) More space (admitedly there are lots of other ways we could have
gotten that).

Can't immediately think of any disadvantages other than the fact that
we now have so many drivers this was rather time consuming to actually
put together and almost certainly has some errors somewhere. 

Jonathan

Jonathan Cameron (67):
  iio: Add broken out info_mask fields for shared_by_type and separate
  iio:adc:max1363 move to info_mask_(shared_by_type/separate)
  staging:iio:dummy move to info_mask_(shared_by_type/separate)
  iio:hid_sensors move to info_mask_(shared_by_type/separate)
  iio:accel:kxsd9 move to info_mask_(shared_by_type/separate)
  iio:st_sensors move to info_mask_(shared_by_type/separate)
  iio:adc:ad_sigma_delta move to info_mask_(shared_by_type/separate)
  iio:adc:ad7266 move to info_mask_(shared_by_type/separate)
  iio:adc:ad7298 move to info_mask_(shared_by_type/separate)
  iio:adc:ad7476 move to info_mask_(shared_by_type/separate)
  iio:adc:ad7887 move to info_mask_(shared_by_type/separate)
  iio:adc:at91_adc move to info_mask_(shared_by_type/separate)
  iio:adc:lp8778_adc move to info_mask_(shared_by_type/separate)
  iio:adc:ti-adc081 move to info_mask_(shared_by_type/separate)
  iio:adc:ti_am335x_adc move to info_mask_(shared_by_type/separate)
  iio:adc:viperboard_adc move to info_mask_(shared_by_type/separate)
  iio:amplifiers:ad8366 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5064 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5360 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5380 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5421 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5446 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5449 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5504 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5624r move to info_mask_(shared_by_type/separate)
  iio:dac:ad5686 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5755 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5764 move to info_mask_(shared_by_type/separate)
  iio:dac:ad5791 move to info_mask_(shared_by_type/separate)
  iio:dac:max517 move to info_mask_(shared_by_type/separate)
  iio:dac:mcp4725 move to info_mask_(shared_by_type/separate)
  iio:freq:ad9523 move to info_mask_(shared_by_type/separate)
  iio:gyro:adis16080 move to info_mask_(shared_by_type/separate)
  iio:gyro:adis16136 move to info_mask_(shared_by_type/separate)
  iio:gyro:adxrs450 move to info_mask_(shared_by_type/separate)
  iio:gyro:itg3200_core move to info_mask_(shared_by_type/separate)
  iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
  iio:imu:adis16480 move to info_mask_(shared_by_type/separate)
  iio:imu:mpu6050 move to info_mask_(shared_by_type/separate)
  iio:light:adjd_s311 move to info_mask_(shared_by_type/separate)
  iio:light:lm3533 move to info_mask_(shared_by_type/separate)
  iio:light:tsl2563 move to info_mask_(shared_by_type/separate)
  iio:light:vcnl4000 move to info_mask_(shared_by_type/separate)
  staging:iio:accel:adis move to info_mask_(shared_by_type/separate)
  staging:iio:accel:adis16220 move to
    info_mask_(shared_by_type/separate)
  staging:iio:accel:lis3l02dq move to
    info_mask_(shared_by_type/separate)
  staging:iio:accel:sca3000 move to info_mask_(shared_by_type/separate)
  staging:iio:adc:ad7280a move to info_mask_(shared_by_type/separate)
  staging:iio:ad7291 move to info_mask_(shared_by_type/separate)
  staging:iio:ad7606 move to info_mask_(shared_by_type/separate)
  staging:iio:adc:ad799x move to info_mask_(shared_by_type/separate)
  staging:iio:cdc:ad7152 move to info_mask_(shared_by_type/separate)
  staging:iio:cdc:ad7152 move to info_mask_(shared_by_type/separate)
  staging:iio:cdc:ad7746 move to info_mask_(shared_by_type/separate)
  staging:iio:gyro:adis16060 move to info_mask_(shared_by_type/separate)
  staging:iio:gyro:adis16130 move to info_mask_(shared_by_type/separate)
  staging:iio:impedance:ad5933 move to
    info_mask_(shared_by_type/separate)
  staging:iio:light:isl29018 move to info_mask_(shared_by_type/separate)
  staging:iio:isl29028 move to info_mask_(shared_by_type/separate)
  staging:iio:light:tsl2x7x move to info_mask_(shared_by_type/separate)
  staging:iio:mag:ak8975 move to info_mask_(shared_by_type/separate)
  staging:iio:hmc5843 move to info_mask_(shared_by_type/separate)
  staging:iio:meter:ade7758 move to info_mask_(shared_by_type/separate)
  staging:iio:resolver:ad2s1200 move to
    info_mask_(shared_by_type/separate)
  staging:iio:resolver:ad2s1210 move to
    info_mask_(shared_by_type/separate)
  staging:iio:ad2s90 move to info_mask_(shared_by_type/separate)
  iio:core drop info_mask from struct iio_info

 drivers/iio/accel/hid-sensor-accel-3d.c         | 24 ++++----
 drivers/iio/accel/kxsd9.c                       |  6 +-
 drivers/iio/adc/ad7266.c                        | 12 ++--
 drivers/iio/adc/ad7298.c                        | 10 ++--
 drivers/iio/adc/ad7476.c                        | 10 ++--
 drivers/iio/adc/ad7887.c                        |  8 +--
 drivers/iio/adc/at91_adc.c                      |  4 +-
 drivers/iio/adc/lp8788_adc.c                    |  4 +-
 drivers/iio/adc/max1363.c                       |  9 +--
 drivers/iio/adc/ti-adc081c.c                    |  4 +-
 drivers/iio/adc/ti_am335x_adc.c                 |  2 +-
 drivers/iio/adc/viperboard_adc.c                |  2 +-
 drivers/iio/amplifiers/ad8366.c                 |  2 +-
 drivers/iio/dac/ad5064.c                        |  4 +-
 drivers/iio/dac/ad5360.c                        | 10 ++--
 drivers/iio/dac/ad5380.c                        |  8 +--
 drivers/iio/dac/ad5421.c                        | 10 ++--
 drivers/iio/dac/ad5446.c                        |  4 +-
 drivers/iio/dac/ad5449.c                        |  4 +-
 drivers/iio/dac/ad5504.c                        |  4 +-
 drivers/iio/dac/ad5624r_spi.c                   |  4 +-
 drivers/iio/dac/ad5686.c                        |  6 +-
 drivers/iio/dac/ad5755.c                        | 10 ++--
 drivers/iio/dac/ad5764.c                        | 10 ++--
 drivers/iio/dac/ad5791.c                        |  6 +-
 drivers/iio/dac/max517.c                        |  4 +-
 drivers/iio/dac/mcp4725.c                       |  4 +-
 drivers/iio/frequency/ad9523.c                  |  8 +--
 drivers/iio/gyro/adis16080.c                    | 22 +++----
 drivers/iio/gyro/adis16136.c                    | 13 ++--
 drivers/iio/gyro/adxrs450.c                     | 22 +++----
 drivers/iio/gyro/hid-sensor-gyro-3d.c           | 24 ++++----
 drivers/iio/gyro/itg3200_core.c                 | 13 ++--
 drivers/iio/imu/adis16400_core.c                | 44 +++++++-------
 drivers/iio/imu/adis16480.c                     | 32 +++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      | 10 ++--
 drivers/iio/industrialio-core.c                 | 27 ++++++---
 drivers/iio/light/adjd_s311.c                   |  4 +-
 drivers/iio/light/hid-sensor-als.c              |  8 +--
 drivers/iio/light/lm3533-als.c                  |  6 +-
 drivers/iio/light/tsl2563.c                     | 10 ++--
 drivers/iio/light/vcnl4000.c                    |  6 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c   | 24 ++++----
 drivers/staging/iio/accel/adis16201_core.c      |  8 +--
 drivers/staging/iio/accel/adis16203_core.c      |  2 +-
 drivers/staging/iio/accel/adis16204_core.c      |  8 +--
 drivers/staging/iio/accel/adis16209_core.c      |  4 +-
 drivers/staging/iio/accel/adis16220_core.c      | 21 +++----
 drivers/staging/iio/accel/adis16240_core.c      |  9 +--
 drivers/staging/iio/accel/lis3l02dq_core.c      | 11 ++--
 drivers/staging/iio/accel/sca3000_core.c        |  5 +-
 drivers/staging/iio/adc/ad7280a.c               | 12 ++--
 drivers/staging/iio/adc/ad7291.c                | 10 ++--
 drivers/staging/iio/adc/ad7606_core.c           |  4 +-
 drivers/staging/iio/adc/ad799x_core.c           | 76 ++++++++++++------------
 drivers/staging/iio/cdc/ad7150.c                |  8 +--
 drivers/staging/iio/cdc/ad7152.c                | 32 +++++-----
 drivers/staging/iio/cdc/ad7746.c                | 48 +++++++--------
 drivers/staging/iio/gyro/adis16060_core.c       | 11 ++--
 drivers/staging/iio/gyro/adis16130_core.c       |  4 +-
 drivers/staging/iio/gyro/adis16260_core.c       |  4 +-
 drivers/staging/iio/iio_simple_dummy.c          | 33 +++++------
 drivers/staging/iio/impedance-analyzer/ad5933.c |  8 +--
 drivers/staging/iio/light/isl29018.c            |  8 +--
 drivers/staging/iio/light/isl29028.c            | 10 ++--
 drivers/staging/iio/light/tsl2x7x_core.c        | 40 ++++++-------
 drivers/staging/iio/magnetometer/ak8975.c       |  4 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |  4 +-
 drivers/staging/iio/meter/ade7758_core.c        | 60 +++++++++----------
 drivers/staging/iio/resolver/ad2s1200.c         |  4 +-
 drivers/staging/iio/resolver/ad2s1210.c         |  4 +-
 drivers/staging/iio/resolver/ad2s90.c           |  2 +-
 include/linux/iio/adc/ad_sigma_delta.h          |  6 +-
 include/linux/iio/common/st_sensors.h           |  4 +-
 include/linux/iio/iio.h                         | 79 +++----------------------
 include/linux/iio/imu/adis.h                    | 34 +++++------
 76 files changed, 478 insertions(+), 557 deletions(-)

-- 
1.8.1.1

