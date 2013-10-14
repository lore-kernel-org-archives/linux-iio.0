Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/17] staging:iio:lis3l02dq: Remove redundant call to iio_sw_buffer_preenable().
Date: Mon, 14 Oct 2013 18:49:25 +0200
Message-Id: <1381769370-17100-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 2d559ba..79cefe0 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -382,7 +382,6 @@ error_ret:
 }
 
 static const struct iio_buffer_setup_ops lis3l02dq_buffer_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &lis3l02dq_buffer_postenable,
 	.predisable = &lis3l02dq_buffer_predisable,
 };
-- 
1.8.0
