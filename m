Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/22] staging:iio:ad7192: Fix setting ACX
Date: Fri, 10 Aug 2012 18:36:23 +0200
Message-Id: <1344616596-8026-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Write to the correct register when setting the ACX bit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d65feda..5565268 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -754,7 +754,7 @@ static ssize_t ad7192_set(struct device *dev,
 		else
 			st->mode &= ~AD7192_MODE_ACX;
 
-		ad7192_write_reg(st, AD7192_REG_GPOCON, 3, st->mode);
+		ad7192_write_reg(st, AD7192_REG_MODE, 3, st->mode);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.10.4
