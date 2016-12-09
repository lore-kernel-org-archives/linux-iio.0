Return-Path: <SRS0=W/8i=XY=gmail.com=eraretuya@kernel.org>
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
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 0/2] staging: iio: ad7606: move driver out of staging
Date: Fri,  9 Dec 2016 21:30:00 +0800
Message-Id: <cover.1481289277.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Address the last remaining TODO [1] for this driver and move it from staging
into mainline.

[1] https://marc.info/?l=linux-iio&m=147689684332118&w=2 

Change in v2:
* Address the incorrect way of implementing the scale. (Pointed out by Lars)

Eva Rachel Retuya (2):
  staging: iio: ad7606: replace range/range_available with corresponding
    scale
  staging: iio: ad7606: move out of staging

 drivers/iio/adc/Kconfig                    | 34 ++++++++++
 drivers/iio/adc/Makefile                   |  3 +
 drivers/{staging => }/iio/adc/ad7606.c     | 99 ++++++++++++++++++------------
 drivers/{staging => }/iio/adc/ad7606.h     |  1 +
 drivers/{staging => }/iio/adc/ad7606_par.c |  0
 drivers/{staging => }/iio/adc/ad7606_spi.c |  0
 drivers/staging/iio/adc/Kconfig            | 34 ----------
 drivers/staging/iio/adc/Makefile           |  4 --
 8 files changed, 98 insertions(+), 77 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7606.c (86%)
 rename drivers/{staging => }/iio/adc/ad7606.h (98%)
 rename drivers/{staging => }/iio/adc/ad7606_par.c (100%)
 rename drivers/{staging => }/iio/adc/ad7606_spi.c (100%)

-- 
2.7.4
