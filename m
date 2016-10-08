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
Subject: [PATCH v4 1/2] staging: iio: ad7606: fix improper setting of oversampling pins
Date: Sun,  9 Oct 2016 00:05:39 +0800
Message-Id: <b1ac6778d27e1406a8fd83b329266fce6144248e.1475942324.git.eraretuya@gmail.com>
In-Reply-To: <cover.1475942324.git.eraretuya@gmail.com>
References: <cover.1475942324.git.eraretuya@gmail.com>
In-Reply-To: <cover.1475942324.git.eraretuya@gmail.com>
References: <cover.1475942324.git.eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The oversampling ratio is controlled using the oversampling pins,
OS [2:0] with OS2 being the MSB control bit, and OS0 the LSB control
bit.

The gpio connected to the OS2 pin is not being set correctly, only OS0
and OS1 pins are being set. Fix the typo to allow proper control of the
oversampling pins.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Fixes: b9618c0 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f79ee61..cbd6bc5 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -189,7 +189,7 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
 	gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
-	gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
+	gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
 	st->oversampling = lval;
 	mutex_unlock(&indio_dev->mlock);
 
-- 
2.7.4
