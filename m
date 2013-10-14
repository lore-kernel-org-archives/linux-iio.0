Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/17] iio:triggered-buffer: Remove redundant call to iio_sw_buffer_preenable().
Date: Mon, 14 Oct 2013 18:49:21 +0200
Message-Id: <1381769370-17100-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-triggered-buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index c1cb1f9..d6f54930 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -17,7 +17,6 @@
 #include <linux/iio/trigger_consumer.h>
 
 static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
-- 
1.8.0
