Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/4] blue part 8: IIO, the rest.
Date: Mon, 25 Jul 2011 14:38:56 +0100
Message-Id: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Another mixed bag of cleanups. Some can't move earlier due to
dependencies.

The ida patch depends on Rusty Russels ida_simple_get patch. I've
pulled current version of that into iio-blue.git. It'll hopefully
merge early in the next merge window.

The others are trivial bits and bobs.

Thanks,

Jonathan

Jonathan Cameron (4):
  staging:iio: use ida_simple_get and ida_simple_remove + merge ids
  staging:iio:trivial sparse related cleanups.
  staging:iio: sysfs.h remove unused val2 and dead macro.
  staging:iio:various Stop drivers putting sysfs attributes in a    
    directory named after the device.

 drivers/staging/iio/accel/sca3000_ring.c   |   68 ----------------------------
 drivers/staging/iio/adc/ad7150.c           |    2 +
 drivers/staging/iio/dac/ad5791.c           |    1 -
 drivers/staging/iio/dds/ad9852.c           |    1 -
 drivers/staging/iio/dds/ad9910.c           |    1 -
 drivers/staging/iio/dds/ad9951.c           |    1 -
 drivers/staging/iio/industrialio-core.c    |   61 ++-----------------------
 drivers/staging/iio/industrialio-trigger.c |   48 +++-----------------
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/light/tsl2583.c        |    6 +-
 drivers/staging/iio/meter/ade7854.c        |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c    |    1 -
 drivers/staging/iio/resolver/ad2s90.c      |    1 -
 drivers/staging/iio/sysfs.h                |    6 ---
 14 files changed, 18 insertions(+), 183 deletions(-)

-- 
1.7.3.4
