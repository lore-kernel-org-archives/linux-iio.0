Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	broonie@opensource.wolfsonmicro.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] iio - first play with regmap
Date: Mon,  5 Sep 2011 17:33:14 +0100
Message-Id: <1315240395-6623-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This is my first real play with regmap.  Tried it with the
lis3l02dq driver because it is somewhere in the middle complexity
wise with some awkward corners.

All comments welcome.  This needs my iio-blue tree
(temporarily hosted at)
 http://www-sigproc.eng.cam.ac.uk/~jic23/iio/.git master

and Mark Browns

regmap/for-next on git.kernel.org.

This device doesn't do bulk reads nicely so that discussion isn't
relevant.  We have introduced a few copies in the buffered path
but got cleaner code in exchange. Such is life.

Thanks,

Jonathan

Jonathan Cameron (1):
  staging:iio:accel:lis3l02dq use regmap.

 drivers/staging/iio/accel/Kconfig          |    1 +
 drivers/staging/iio/accel/lis3l02dq.h      |    9 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |  221 ++++++++++++++++------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |  115 ++++-----------
 4 files changed, 162 insertions(+), 184 deletions(-)

-- 
1.7.3.4
