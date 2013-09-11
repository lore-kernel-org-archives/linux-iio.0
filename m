Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 4/5] iio: dac: ad5686: Remove redundant break
Date: Wed, 11 Sep 2013 15:50:28 +0530
Message-Id: <1378894829-8173-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'break' after return is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5686.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 57825ea..3e1080f 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -213,7 +213,6 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-		break;
 	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->vref_mv * 100000)
 			>> (chan->scan_type.realbits);
-- 
1.7.9.5
