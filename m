Return-Path: <jic23@kernel.org>
Message-ID: <51461EAB.1070707@kernel.org>
Date: Sun, 17 Mar 2013 19:51:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/67 V2] IIO break info_mask into a pair of masks
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Whole series (and the two catching missed drivers) applied to togreg branch of
iio.git

On 03/02/2013 04:16 PM, Jonathan Cameron wrote:
> As Lars-Peter noticed, I was being an idiot and the original set would
> never have worked.  Actually it turned out that they would have also
> gotten the handling of shared and separate the wrong way around and there
> were a few other minor issues elsewhere.
> 
> Now a lot of people were kind enough to take a look at the original patches
> and provide Acks on the mistaken assumption that the basic principle worked.
> (given the cc list would have been huge many people probably never saw
> anything other than the individual driver patches which in of themselves
> appeared sane).
> If people do not reply this time around I'll assume their acks are good
> for this set and apply them.  (Of course if anyone want so re ack the
> corrected patches that is great as well!).  Any tested-by's would also
> be great as right now I've only actually tested with one driver.
> 
> Well that was an 'interesting' way to start off this cycle :(
> 
> Version 1 message:
> 
> Hi All,
> 
> This has been on my todo list for a while.  I'm not sure how we ever ended
> up with the mess that is the current info_mask bitmap of which properties
> exist for a given channel.  Anyhow currently you have two types of bit
> in there, IIO_CHAN_INFO_SHARED_BIT (even) and IIO_CHAN_INFO_SEPARATE_BIT (odd).
> Whether we have odd or even elements is used to indicate whether we
> want an associated attribute specific to the channel, or one that is shared.
> E.g.
> 
> in_accel_x_scale (for just the x accel channel)
> or
> in_accel_scale (for all accel channels)
> 
> in_illuminance0_calibbias
> or
> in_illuminance_calibbias
> 
> This led to a horrible mess in iio.h where we had macros for each
> option of every element added to the info_mask.  Also, a while
> back it became apparent that sometimes we have attributes shared across
> all channels irrespective of their type (sampling_frequency for example).
> Now the obvious solution to this would be to add a third type of info_mask
> element, but then things are getting rather silly.
> 
> Hence the proposed solution.  Have separate info_mask elements for each of the
> two types of bit we had previously (others may follow).
> 
> Advantages:
> 
> 1) More consise naming of elements
> 2) Drop all those hideous macros
> 3) More space (admitedly there are lots of other ways we could have
> gotten that).
> 
> Can't immediately think of any disadvantages other than the fact that
> we now have so many drivers this was rather time consuming to actually
> put together and almost certainly has some errors somewhere. 
> 
> Jonathan
> 
> Jonathan Cameron (67):
>   iio: Add broken out info_mask fields for shared_by_type and separate
>   iio:adc:max1363 move to info_mask_(shared_by_type/separate)
>   staging:iio:dummy move to info_mask_(shared_by_type/separate)
>   iio:hid_sensors move to info_mask_(shared_by_type/separate)
>   iio:accel:kxsd9 move to info_mask_(shared_by_type/separate)
>   iio:st_sensors move to info_mask_(shared_by_type/separate)
>   iio:adc:ad_sigma_delta move to info_mask_(shared_by_type/separate)
>   iio:adc:ad7266 move to info_mask_(shared_by_type/separate)
>   iio:adc:ad7298 move to info_mask_(shared_by_type/separate)
>   iio:adc:ad7476 move to info_mask_(shared_by_type/separate)
>   iio:adc:ad7887 move to info_mask_(shared_by_type/separate)
>   iio:adc:at91_adc move to info_mask_(shared_by_type/separate)
>   iio:adc:lp8778_adc move to info_mask_(shared_by_type/separate)
>   iio:adc:ti-adc081 move to info_mask_(shared_by_type/separate)
>   iio:adc:ti_am335x_adc move to info_mask_(shared_by_type/separate)
>   iio:adc:viperboard_adc move to info_mask_(shared_by_type/separate)
>   iio:amplifiers:ad8366 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5064 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5360 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5380 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5421 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5446 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5449 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5504 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5624r move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5686 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5755 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5764 move to info_mask_(shared_by_type/separate)
>   iio:dac:ad5791 move to info_mask_(shared_by_type/separate)
>   iio:dac:max517 move to info_mask_(shared_by_type/separate)
>   iio:dac:mcp4725 move to info_mask_(shared_by_type/separate)
>   iio:freq:ad9523 move to info_mask_(shared_by_type/separate)
>   iio:gyro:adis16080 move to info_mask_(shared_by_type/separate)
>   iio:gyro:adis16136 move to info_mask_(shared_by_type/separate)
>   iio:gyro:adxrs450 move to info_mask_(shared_by_type/separate)
>   iio:gyro:itg3200_core move to info_mask_(shared_by_type/separate)
>   iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
>   iio:imu:adis16480 move to info_mask_(shared_by_type/separate)
>   iio:imu:mpu6050 move to info_mask_(shared_by_type/separate)
>   iio:light:adjd_s311 move to info_mask_(shared_by_type/separate)
>   iio:light:lm3533 move to info_mask_(shared_by_type/separate)
>   iio:light:tsl2563 move to info_mask_(shared_by_type/separate)
>   iio:light:vcnl4000 move to info_mask_(shared_by_type/separate)
>   staging:iio:accel:adis move to info_mask_(shared_by_type/separate)
>   staging:iio:accel:adis16220 move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:accel:lis3l02dq move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:accel:sca3000 move to info_mask_(shared_by_type/separate)
>   staging:iio:adc:ad7280a move to info_mask_(shared_by_type/separate)
>   staging:iio:adc:ad7291 move to info_mask_(shared_by_type/separate)
>   staging:iio:adc:ad7606 move to info_mask_(shared_by_type/separate)
>   staging:iio:adc:ad799x move to info_mask_(shared_by_type/separate)
>   staging:iio:cdc:ad7150 move to info_mask_(shared_by_type/separate)
>   staging:iio:cdc:ad7152 move to info_mask_(shared_by_type/separate)
>   staging:iio:cdc:ad7746 move to info_mask_(shared_by_type/separate)
>   staging:iio:gyro:adis16060 move to info_mask_(shared_by_type/separate)
>   staging:iio:gyro:adis16130 move to info_mask_(shared_by_type/separate)
>   staging:iio:impedance:ad5933 move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:light:isl29018 move to info_mask_(shared_by_type/separate)
>   staging:iio:light:isl29028 move to info_mask_(shared_by_type/separate)
>   staging:iio:light:tsl2x7x move to info_mask_(shared_by_type/separate)
>   staging:iio:mag:ak8975 move to info_mask_(shared_by_type/separate)
>   staging:iio:magnetometer:hmc5843 move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:meter:ade7758 move to info_mask_(shared_by_type/separate)
>   staging:iio:resolver:ad2s1200 move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:resolver:ad2s1210 move to
>     info_mask_(shared_by_type/separate)
>   staging:iio:resolver:ad2s90 move to
>     info_mask_(shared_by_type/separate)
>   iio:core drop info_mask from struct iio_info
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c         | 24 ++++----
>  drivers/iio/accel/kxsd9.c                       |  6 +-
>  drivers/iio/adc/ad7266.c                        | 12 ++--
>  drivers/iio/adc/ad7298.c                        | 10 ++--
>  drivers/iio/adc/ad7476.c                        | 10 ++--
>  drivers/iio/adc/ad7887.c                        |  8 +--
>  drivers/iio/adc/at91_adc.c                      |  4 +-
>  drivers/iio/adc/lp8788_adc.c                    |  4 +-
>  drivers/iio/adc/max1363.c                       |  9 +--
>  drivers/iio/adc/ti-adc081c.c                    |  4 +-
>  drivers/iio/adc/ti_am335x_adc.c                 |  2 +-
>  drivers/iio/adc/viperboard_adc.c                |  2 +-
>  drivers/iio/amplifiers/ad8366.c                 |  2 +-
>  drivers/iio/dac/ad5064.c                        |  4 +-
>  drivers/iio/dac/ad5360.c                        | 10 ++--
>  drivers/iio/dac/ad5380.c                        |  8 +--
>  drivers/iio/dac/ad5421.c                        | 10 ++--
>  drivers/iio/dac/ad5446.c                        |  4 +-
>  drivers/iio/dac/ad5449.c                        |  4 +-
>  drivers/iio/dac/ad5504.c                        |  4 +-
>  drivers/iio/dac/ad5624r_spi.c                   |  4 +-
>  drivers/iio/dac/ad5686.c                        |  6 +-
>  drivers/iio/dac/ad5755.c                        | 10 ++--
>  drivers/iio/dac/ad5764.c                        | 10 ++--
>  drivers/iio/dac/ad5791.c                        |  6 +-
>  drivers/iio/dac/max517.c                        |  4 +-
>  drivers/iio/dac/mcp4725.c                       |  4 +-
>  drivers/iio/frequency/ad9523.c                  |  8 +--
>  drivers/iio/gyro/adis16080.c                    | 22 +++----
>  drivers/iio/gyro/adis16136.c                    | 13 ++--
>  drivers/iio/gyro/adxrs450.c                     | 22 +++----
>  drivers/iio/gyro/hid-sensor-gyro-3d.c           | 24 ++++----
>  drivers/iio/gyro/itg3200_core.c                 | 13 ++--
>  drivers/iio/imu/adis16400_core.c                | 47 +++++++--------
>  drivers/iio/imu/adis16480.c                     | 32 +++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      | 10 ++--
>  drivers/iio/industrialio-core.c                 | 27 ++++++---
>  drivers/iio/light/adjd_s311.c                   |  4 +-
>  drivers/iio/light/hid-sensor-als.c              |  8 +--
>  drivers/iio/light/lm3533-als.c                  |  6 +-
>  drivers/iio/light/tsl2563.c                     | 10 ++--
>  drivers/iio/light/vcnl4000.c                    |  6 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c   | 24 ++++----
>  drivers/staging/iio/accel/adis16201_core.c      |  8 +--
>  drivers/staging/iio/accel/adis16203_core.c      |  2 +-
>  drivers/staging/iio/accel/adis16204_core.c      |  8 +--
>  drivers/staging/iio/accel/adis16209_core.c      |  4 +-
>  drivers/staging/iio/accel/adis16220_core.c      | 26 ++++----
>  drivers/staging/iio/accel/adis16240_core.c      |  9 +--
>  drivers/staging/iio/accel/lis3l02dq_core.c      | 11 ++--
>  drivers/staging/iio/accel/sca3000_core.c        |  5 +-
>  drivers/staging/iio/adc/ad7280a.c               | 12 ++--
>  drivers/staging/iio/adc/ad7291.c                | 10 ++--
>  drivers/staging/iio/adc/ad7606_core.c           |  4 +-
>  drivers/staging/iio/adc/ad799x_core.c           | 76 ++++++++++++------------
>  drivers/staging/iio/cdc/ad7150.c                |  8 +--
>  drivers/staging/iio/cdc/ad7152.c                | 32 +++++-----
>  drivers/staging/iio/cdc/ad7746.c                | 48 +++++++--------
>  drivers/staging/iio/gyro/adis16060_core.c       | 11 ++--
>  drivers/staging/iio/gyro/adis16130_core.c       |  4 +-
>  drivers/staging/iio/gyro/adis16260_core.c       |  4 +-
>  drivers/staging/iio/iio_simple_dummy.c          | 33 +++++------
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 10 ++--
>  drivers/staging/iio/light/isl29018.c            |  8 +--
>  drivers/staging/iio/light/isl29028.c            | 10 ++--
>  drivers/staging/iio/light/tsl2x7x_core.c        | 40 ++++++-------
>  drivers/staging/iio/magnetometer/ak8975.c       |  4 +-
>  drivers/staging/iio/magnetometer/hmc5843.c      |  4 +-
>  drivers/staging/iio/meter/ade7758_core.c        | 60 +++++++++----------
>  drivers/staging/iio/resolver/ad2s1200.c         |  4 +-
>  drivers/staging/iio/resolver/ad2s1210.c         |  4 +-
>  drivers/staging/iio/resolver/ad2s90.c           |  2 +-
>  include/linux/iio/adc/ad_sigma_delta.h          |  6 +-
>  include/linux/iio/common/st_sensors.h           |  5 +-
>  include/linux/iio/iio.h                         | 79 +++----------------------
>  include/linux/iio/imu/adis.h                    | 34 +++++------
>  76 files changed, 489 insertions(+), 557 deletions(-)
> 
