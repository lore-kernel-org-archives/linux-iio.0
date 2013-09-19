Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 18/24] iio:gp2ap020a00f: Use iio_push_to_buffers_with_timestamp()
Date: Thu, 19 Sep 2013 14:59:55 +0200
Message-Id: <1379595601-26448-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-1-git-send-email-lars@metafoo.de>
References: <1379595601-26448-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Makes the code a bit shorter and less ugly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/iio/light/gp2ap020a00f.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 62809b5..b1e4615 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -988,13 +988,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 		}
 	}
 
-	if (indio_dev->scan_timestamp) {
-		s64 *timestamp = (s64 *)((u8 *)priv->buffer +
-						ALIGN(d_size, sizeof(s64)));
-		*timestamp = pf->timestamp;
-	}
-
-	iio_push_to_buffers(indio_dev, priv->buffer);
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
+		pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0
