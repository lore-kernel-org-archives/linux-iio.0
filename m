Return-Path: <SRS0=iv4G=JL=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>
CC: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] iio: ad9523: Fix displayed phase
Date: Mon, 25 Jun 2018 11:03:07 +0300
Message-ID: <20180625080307.14754-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Fix the displayed phase for the ad9523 driver. Currently the most
significant decimal place is dropped and all other digits are shifted one
to the left. This is due to a multiplication by 10, which is not necessary,
so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

v1 -> v2:
* added Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ddb6a334ae68..d5b2c231a661 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -642,7 +642,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
 			AD9523_CLK_DIST_DIV_REV(ret);
 		*val = code / 1000000;
-		*val2 = (code % 1000000) * 10;
+		*val2 = code % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
-- 
2.17.1
