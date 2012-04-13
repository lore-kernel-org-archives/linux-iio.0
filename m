Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/13 V2] IIO: Make the value attribute optional for channels
Date: Fri, 13 Apr 2012 11:04:18 +0100
Message-Id: <1334311471-23054-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is as per Lars-Peter's suggestion + actually covers 'all' (I hope)
of the drivers rather than missing cdc and impedance directories.

So now we have IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED.

This lets us drop a chunk of special case logic and generally cleans
things up.  On top of this allows channels with no reading or writing
abilities which was the original point.

Jonathan

original patch message was:

Dear All,

This came out of a discussion about Michael's variable gain amplifier
driver the other day.  We have devices that have a channel that we
can't actually read, but know other things about. (there are other
cases that we have previously fudged around).

Anyhow, here is the promised series making the value optional.
Has recieved limited testing and I may well have fried someones
driver so please do take a look and test test test!

Dependent on the IIO_CHAN removal series.

Note I'll probably handle this set a little differently from
usual and send the first 9 to Greg asap, but hold the 10th
that actually makes them active until I'm sure there aren't
any drivers going to cross with it and end up broken.

Jonathan

Jonathan Cameron (13):
  staging:iio: add a raw and processed elements to info_mask
  staging:iio:accel Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:adc Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:dac Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:gyro Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:imu Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:light Add IIO_CHAN_INFO_RAW/PROCESSED entries to all
    drivers.
  staging:iio:magnetometer Add IIO_CHAN_INFO_RAW entries to all
    drivers.
  staging:iio:resolver Add IIO_CHAN_INFO_RAW entries to all drivers.
  staging:iio:impedance Add IIO_CHAN_INFO_RAW/PROCESSED entries to all
    drivers.
  staging:iio:cdc Add IIO_CHAN_INFO_RAW/PROCESSED entries to all
    drivers.
  staging:iio: Make read / write attributes for channel values
    optional.
  staging:iio: drop procesed_val element of chan_spec.

 drivers/staging/iio/accel/adis16201_core.c      |   25 +++--
 drivers/staging/iio/accel/adis16203_core.c      |   17 ++-
 drivers/staging/iio/accel/adis16204_core.c      |   17 ++-
 drivers/staging/iio/accel/adis16209_core.c      |   24 +++--
 drivers/staging/iio/accel/adis16220_core.c      |   15 ++-
 drivers/staging/iio/accel/adis16240_core.c      |   18 +++-
 drivers/staging/iio/accel/kxsd9.c               |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |    5 +-
 drivers/staging/iio/accel/sca3000_core.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |   11 ++-
 drivers/staging/iio/adc/ad7280a.c               |    7 +-
 drivers/staging/iio/adc/ad7291.c                |    8 +-
 drivers/staging/iio/adc/ad7298_core.c           |    8 +-
 drivers/staging/iio/adc/ad7476_core.c           |    5 +-
 drivers/staging/iio/adc/ad7606_core.c           |   19 ++--
 drivers/staging/iio/adc/ad7780.c                |    8 +-
 drivers/staging/iio/adc/ad7793.c                |   38 +++++---
 drivers/staging/iio/adc/ad7887_core.c           |    8 +-
 drivers/staging/iio/adc/ad799x_core.c           |   40 +++++++-
 drivers/staging/iio/adc/lpc32xx_adc.c           |   15 ++--
 drivers/staging/iio/adc/max1363_core.c          |    5 +-
 drivers/staging/iio/adc/spear_adc.c             |    5 +-
 drivers/staging/iio/cdc/ad7150.c                |    8 +-
 drivers/staging/iio/cdc/ad7152.c                |   14 ++-
 drivers/staging/iio/cdc/ad7746.c                |   25 +++--
 drivers/staging/iio/dac/ad5064.c                |    7 +-
 drivers/staging/iio/dac/ad5360.c                |    7 +-
 drivers/staging/iio/dac/ad5380.c                |    7 +-
 drivers/staging/iio/dac/ad5421.c                |    7 +-
 drivers/staging/iio/dac/ad5446.c                |    5 +-
 drivers/staging/iio/dac/ad5504.c                |    7 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |    5 +-
 drivers/staging/iio/dac/ad5686.c                |    7 +-
 drivers/staging/iio/dac/ad5764.c                |    7 +-
 drivers/staging/iio/dac/ad5791.c                |    7 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    6 +-
 drivers/staging/iio/gyro/adis16130_core.c       |    2 +
 drivers/staging/iio/gyro/adis16260_core.c       |   15 ++-
 drivers/staging/iio/gyro/adxrs450_core.c        |   14 ++-
 drivers/staging/iio/iio.h                       |   22 +++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |   11 ++-
 drivers/staging/iio/imu/adis16400_core.c        |  121 +++++++++++++++--------
 drivers/staging/iio/industrialio-core.c         |   24 +----
 drivers/staging/iio/light/isl29018.c            |    9 +-
 drivers/staging/iio/light/tsl2563.c             |   11 ++-
 drivers/staging/iio/magnetometer/ak8975.c       |    5 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    5 +-
 drivers/staging/iio/resolver/ad2s1200.c         |    2 +
 drivers/staging/iio/resolver/ad2s1210.c         |    2 +
 drivers/staging/iio/resolver/ad2s90.c           |    1 +
 51 files changed, 436 insertions(+), 243 deletions(-)
