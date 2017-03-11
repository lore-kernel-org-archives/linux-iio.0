Return-Path: <SRS0=n5Lp=2U=gmail.com=singhalsimran0@kernel.org>
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH 00/10] staging: iio: Remove exceptional & on functions name
Date: Sat, 11 Mar 2017 09:06:31 +0530
Message-Id: <1489203401-17518-1-git-send-email-singhalsimran0@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch-series removes exceptional & on functions name.

simran singhal (10):
  staging: iio: ad7192: Remove exceptional & on function name
  staging: iio: ad7780: Remove exceptional & on function name
  staging: iio: cdc: ad7746: Remove exceptional & on function name
  staging: iio: cdc: ad7152: Remove exceptional & on function name
  staging: iio: adis16240: Remove exceptional & on function name
  staging: iio: adis16201: Remove exceptional & on function name
  staging: iio: adis16209: Remove exceptional & on function name
  staging: iio: adis16203: Remove exceptional & on function name
  staging: iio: resolver: Remove exceptional & on function name
  staging: iio: gyro: Remove exceptional & on function name

 drivers/staging/iio/accel/adis16201.c     |  4 ++--
 drivers/staging/iio/accel/adis16203.c     |  4 ++--
 drivers/staging/iio/accel/adis16209.c     |  4 ++--
 drivers/staging/iio/accel/adis16240.c     |  4 ++--
 drivers/staging/iio/adc/ad7192.c          | 12 ++++++------
 drivers/staging/iio/adc/ad7780.c          |  2 +-
 drivers/staging/iio/cdc/ad7152.c          |  6 +++---
 drivers/staging/iio/cdc/ad7746.c          |  4 ++--
 drivers/staging/iio/gyro/adis16060_core.c |  2 +-
 drivers/staging/iio/resolver/ad2s1200.c   |  2 +-
 drivers/staging/iio/resolver/ad2s90.c     |  2 +-
 11 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.7.4
