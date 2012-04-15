Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55495 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab2DOQlc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 12:41:32 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/16 V3] IIO: Make the value attribute optional for channels
Date: Sun, 15 Apr 2012 17:41:15 +0100
Message-Id: <1334508091-24027-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

This series both gets rid of some special case code (which is always
nice) and makes it optional to have raw and/or processed access to the
value of a particular channel.  Quite a few devices will give you information
about a given channel without allowing you to read it's value.  Examples
include devices that just do interrupts on threshold crossings, and
variable gain amplifiers (one of those from Michael Hennerich kicked this
whole set off).

Anyhow, only changes from v2 are a couple of formatting fixes and the addition
of isl29028 changes which were posted separately and have been acked.

Note that this patch will cause breakage in any drivers that don't take
it into account.  I will email everyone I know with a driver under review
to make sure they are aware of it.  The annoying bit is it may not cause
build breakage so it may not be obvious.

Thanks to Lars-Peter for the suggestion of a neater solution than the
one I proposed in V1 and also for review and filling in a few devices
drivers that I'd somehow missed entirely (including our stub example
driver -- oops).

Jonathan

Previous messages:

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

Jonathan Cameron (14):
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
  staging:iio:isl29028 Add IIO_CHAN_INFO_RAW/PROCESSED entries
  staging:iio: Make read / write attributes for channel values
    optional.
  staging:iio: drop procesed_val element of chan_spec.

Lars-Peter Clausen (2):
  staging:iio: Add IIO_CHAN_INFO_RAW entries to the dummy driver
  staging:iio:meter Add IIO_CHAN_INFO_RAW entries to all drivers.

 drivers/staging/iio/accel/adis16201_core.c      |   25 +++--
 drivers/staging/iio/accel/adis16203_core.c      |   17 ++--
 drivers/staging/iio/accel/adis16204_core.c      |   17 ++--
 drivers/staging/iio/accel/adis16209_core.c      |   24 +++--
 drivers/staging/iio/accel/adis16220_core.c      |   15 ++-
 drivers/staging/iio/accel/adis16240_core.c      |   18 ++--
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
 drivers/staging/iio/adc/ad7793.c                |   38 ++++---
 drivers/staging/iio/adc/ad7887_core.c           |    8 +-
 drivers/staging/iio/adc/ad799x_core.c           |   40 +++++++-
 drivers/staging/iio/adc/lpc32xx_adc.c           |   15 +--
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
 drivers/staging/iio/iio.h                       |   18 ++--
 drivers/staging/iio/iio_simple_dummy.c          |   19 +++-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   11 ++-
 drivers/staging/iio/imu/adis16400_core.c        |  121 +++++++++++++++--------
 drivers/staging/iio/industrialio-core.c         |   24 +----
 drivers/staging/iio/light/isl29018.c            |    9 +-
 drivers/staging/iio/light/isl29028.c            |   11 ++-
 drivers/staging/iio/light/tsl2563.c             |   11 ++-
 drivers/staging/iio/magnetometer/ak8975.c       |    5 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    5 +-
 drivers/staging/iio/meter/ade7758_core.c        |   45 ++++++---
 drivers/staging/iio/resolver/ad2s1200.c         |    2 +
 drivers/staging/iio/resolver/ad2s1210.c         |    2 +
 drivers/staging/iio/resolver/ad2s90.c           |    1 +
 54 files changed, 484 insertions(+), 266 deletions(-)

-- 
1.7.9.4

