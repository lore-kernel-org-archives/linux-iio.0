Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 11/17] iio:gp2ap020a00f: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:24 +0200
Message-Id: <1381769370-17100-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 2a65bc3..a530e77 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1483,7 +1483,6 @@ error_unlock:
 }
 
 static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
-	.preenable = &iio_sw_buffer_preenable,
 	.postenable = &gp2ap020a00f_buffer_postenable,
 	.predisable = &gp2ap020a00f_buffer_predisable,
 };
-- 
1.8.0
