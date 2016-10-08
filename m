Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v3 0/2] staging: iio: ad7606: oversampling_ratio clean-up
Date: Sat,  8 Oct 2016 14:50:03 +0800
Message-Id: <cover.1475907512.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Implement the oversampling_ratio attribute using standard global define
as well as fix bug about incorrect setting of oversampling pins

Changes in v3:
* Add follow-up patch fixing bug about incorrect setting of oversampling
  pins
* Add Fixes tag

Changes in v2:
* Add Lars' Acked-by tag
* Update dev_err() to use proper arguments

Eva Rachel Retuya (2):
  staging: iio: ad7606: implement IIO_CHAN_INFO_OVERSAMPLING_RATIO
  staging: iio: ad7606: fix improper setting of oversampling pins

 drivers/staging/iio/adc/ad7606_core.c | 67 ++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

-- 
2.7.4
