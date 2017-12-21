Return-Path: <SRS0=2qIu=DR=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2 3/7] iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
Date: Thu, 21 Dec 2017 19:31:34 +0100
In-Reply-To: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <a2462dde-0ef0-4e43-8342-6a7521b6f96f@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Although the datasheet states the CNVR flag is cleared by reading the
BUS_VOLTAGE register, it is actually cleared by reading any of the
voltage/current/power registers.

The behaviour has been confirmed by TI support:
http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p/647053/2378282

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

Changes in v2: None

 drivers/iio/adc/ina2xx-adc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 8c8120406f52..b027d485398b 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -705,7 +705,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	int bit, ret, i = 0;
 	s64 time_a, time_b;
 	unsigned int alert;
-	int cnvr_need_clear = 0;
 
 	time_a = iio_get_time_ns(indio_dev);
 
@@ -730,7 +729,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 				ret = regmap_read(chip->regmap,
 						  INA2XX_BUS_VOLTAGE, &alert);
 				alert &= INA219_CNVR;
-				cnvr_need_clear = alert;
 			}
 
 			if (ret < 0)
@@ -752,18 +750,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 			return ret;
 
 		data[i++] = val;
-
-		if (INA2XX_SHUNT_VOLTAGE + bit == INA2XX_POWER)
-			cnvr_need_clear = 0;
-	}
-
-	/* Dummy read on INA219 power register to clear CNVR flag */
-	if (cnvr_need_clear && chip->config->chip_id == ina219) {
-		unsigned int val;
-
-		ret = regmap_read(chip->regmap, INA2XX_POWER, &val);
-		if (ret < 0)
-			return ret;
 	}
 
 	time_b = iio_get_time_ns(indio_dev);
-- 
2.15.1
