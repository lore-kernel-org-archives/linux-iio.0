Return-Path: <SRS0=4Pt3=X2=gmail.com=eraretuya@kernel.org>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	daniel.baluta@gmail.com,
	amsfield22@gmail.com,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v3 0/2] staging: iio: ad7606: move driver out of staging
Date: Sun, 11 Dec 2016 10:47:47 +0800
Message-Id: <cover.1481424136.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Address the last remaining TODO [1] for this driver and move it from staging
into mainline.

[1] https://marc.info/?l=linux-iio&m=147689684332118&w=2 

Change in v3:
* Fix incorrect type of 'scale'. (Pointed out by kbuild test robot)

Change in v2:
* Address the incorrect way of implementing the scale. (Pointed out by Lars)

Eva Rachel Retuya (2):
  staging: iio: ad7606: replace range/range_available with corresponding
    scale
  staging: iio: ad7606: move out of staging

 drivers/iio/adc/Kconfig                    |  34 ++++++++++
 drivers/iio/adc/Makefile                   |   3 +
 drivers/{staging => }/iio/adc/ad7606.c     | 100 ++++++++++++++++++-----------
 drivers/{staging => }/iio/adc/ad7606.h     |   1 +
 drivers/{staging => }/iio/adc/ad7606_par.c |   0
 drivers/{staging => }/iio/adc/ad7606_spi.c |   0
 drivers/staging/iio/adc/Kconfig            |  34 ----------
 drivers/staging/iio/adc/Makefile           |   4 --
 8 files changed, 99 insertions(+), 77 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7606.c (86%)
 rename drivers/{staging => }/iio/adc/ad7606.h (98%)
 rename drivers/{staging => }/iio/adc/ad7606_par.c (100%)
 rename drivers/{staging => }/iio/adc/ad7606_spi.c (100%)

-- 
2.7.4
