Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/17] staging:iio:simple-dummy: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:27 +0200
Message-Id: <1381769370-17100-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index 2612e87..46c134b 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -99,14 +99,6 @@ done:
 
 static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
 	/*
-	 * iio_sw_buffer_preenable:
-	 * Generic function for equal sized ring elements + 64 bit timestamp
-	 * Assumes that any combination of channels can be enabled.
-	 * Typically replaced to implement restrictions on what combinations
-	 * can be captured (hardware scan modes).
-	 */
-	.preenable = &iio_sw_buffer_preenable,
-	/*
 	 * iio_triggered_buffer_postenable:
 	 * Generic function that simply attaches the pollfunc to the trigger.
 	 * Replace this to mess with hardware state before we attach the
-- 
1.8.0
