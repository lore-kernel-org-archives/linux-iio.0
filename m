Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1047 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172Ab3IOQua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:50:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 21/27] iio:gp2ap020a00f: Use iio_push_to_buffers_with_timestamp()
Date: Sun, 15 Sep 2013 18:51:14 +0200
Message-Id: <1379263880-18405-21-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

