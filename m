Return-Path: <SRS0=w+w6=JZ=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 9 Jul 2018 14:06:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: at91-sama5d2_adc: fix up casting in
 at91_adc_read_info_raw()
Message-ID: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This code is problematic because we're supposed to be writing an int but
we instead write to only the high 16 bits.  This doesn't work on big
endian systems, and there is a potential that the bottom 16 bits are
used without being initialized.

Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e02f7d1c86bc..d5ea84cf6460 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1296,6 +1296,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	u32 cor = 0;
+	u16 tmp_val;
 	int ret;
 
 	/*
@@ -1309,7 +1310,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 
 		ret = at91_adc_read_position(st, chan->channel,
-					     (u16 *)val);
+					     &tmp_val);
+		*val = tmp_val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
@@ -1322,7 +1324,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 
 		ret = at91_adc_read_pressure(st, chan->channel,
-					     (u16 *)val);
+					     &tmp_val);
+		*val = tmp_val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
