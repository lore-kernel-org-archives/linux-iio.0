Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 0/2] staging: iio: ad7606: regulator clean-up
Date: Thu, 20 Oct 2016 21:08:21 +0800
Message-Id: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset is dependent on Lars' recently submitted patchset:
[PATCH 00/13] staging:iio:ad7606: Towards moving out of staging
https://marc.info/?l=linux-iio&m=147689684332118&w=2

Address the regulator handling previously mentioned on the above link.
Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD7606_7606-6_7606-4.pdf

Eva Rachel Retuya (2):
  staging: iio: ad7606: set proper supply name to devm_regulator_get()
  staging: iio: ad7606: rework regulator handling

 drivers/staging/iio/adc/ad7606.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.7.4
