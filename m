Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-014.synserver.de ([212.40.185.14]:1080 "EHLO
	smtp-out-011.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753632Ab3IRUBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 16:01:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/10] iio:buffer_cb: Add missing iio_buffer_init()
Date: Wed, 18 Sep 2013 22:02:48 +0200
Message-Id: <1379534574-11213-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-1-git-send-email-lars@metafoo.de>
References: <1379534574-11213-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make sure to properly initialize the IIO buffer data structure.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer_cb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
index 578f719..841fec1 100644
--- a/drivers/iio/buffer_cb.c
+++ b/drivers/iio/buffer_cb.c
@@ -41,6 +41,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 		goto error_ret;
 	}
 
+	iio_buffer_init(&cb_buff->buffer);
+
 	cb_buff->private = private;
 	cb_buff->cb = cb;
 	cb_buff->buffer.access = &iio_cb_access;
-- 
1.8.0

