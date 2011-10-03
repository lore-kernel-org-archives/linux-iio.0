Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/6] iio:trivial dev_info rename +  remove unneeded existence checks
Date: Mon,  3 Oct 2011 16:08:10 +0100
Message-Id: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

The trigger patches should be trivial and obvious.

The dev_info / indio_dev was entirely my fault as I introduced both
names a long time ago.  For a while drivers were at least internally
consistent, but with all the recent tree wide changes this is no
where near true.  Hence I did a word count, established dev_info
is no where near as common and hence have replaced all instances
in IIO with indio_dev (except for a few drivers for various reasons).

Should have done this a long time ago.  Sorry for the churn of the
tree that will result.

Note this is on top of all patches I have currently published.

Jonathan

Jonathan Cameron (6):
  staging:iio:triggers Remove unecessary existence checks and return
    val
  staging:iio:industrialio-trigger.c Trivial code style brackets fix
  staging:iio:core:naming: dev_info to indio_dev for consistency
  staging:iio:accel:sca3000 dev_info to indio_dev renaming.
  staging:iio:adc:naming: dev_info to indio_dev for consistency
  staging:iio:dac/dds/impedance dev_info to indio_dev for consistency

 drivers/staging/iio/accel/sca3000_core.c        |   16 +-
 drivers/staging/iio/adc/ad7150.c                |    4 +-
 drivers/staging/iio/adc/ad7192.c                |    4 +-
 drivers/staging/iio/adc/ad7280a.c               |   60 +++---
 drivers/staging/iio/adc/ad7291.c                |   12 +-
 drivers/staging/iio/adc/ad7298_core.c           |   12 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    4 +-
 drivers/staging/iio/adc/ad7476_core.c           |   12 +-
 drivers/staging/iio/adc/ad7816.c                |   34 ++--
 drivers/staging/iio/adc/ad7887_core.c           |   10 +-
 drivers/staging/iio/adc/ad799x_core.c           |   38 ++--
 drivers/staging/iio/buffer_generic.h            |    4 +-
 drivers/staging/iio/dac/ad5446.c                |   36 ++--
 drivers/staging/iio/dac/max517.c                |    8 +-
 drivers/staging/iio/dds/ad9832.c                |    8 +-
 drivers/staging/iio/dds/ad9834.c                |   28 ++--
 drivers/staging/iio/iio.h                       |   30 ++--
 drivers/staging/iio/iio_core_trigger.h          |   16 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   44 +++---
 drivers/staging/iio/industrialio-buffer.c       |   78 ++++----
 drivers/staging/iio/industrialio-core.c         |  218 +++++++++++-----------
 drivers/staging/iio/industrialio-trigger.c      |   62 +++----
 22 files changed, 365 insertions(+), 373 deletions(-)

-- 
1.7.3.4
