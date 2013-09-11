Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 3/5] iio: gyro: adxrs450: Remove redundant break
Date: Wed, 11 Sep 2013 15:50:27 +0530
Message-Id: <1378894829-8173-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'break' after return is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adxrs450.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 6dab299..c1f40ef 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -354,7 +354,6 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
 		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
 		if (ret)
-- 
1.7.9.5
