Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 2/5] iio: gyro: adis16260: Remove redundant break
Date: Wed, 11 Sep 2013 15:50:26 +0530
Message-Id: <1378894829-8173-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'break' after return is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adis16260.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 0654116..22b6fb8 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -239,7 +239,6 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = 250000 / 1453; /* 25 C = 0x00 */
 		return IIO_VAL_INT;
-- 
1.7.9.5
