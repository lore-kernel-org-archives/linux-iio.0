Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35362 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbJ0DSJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2015 23:18:09 -0400
Received: by pasz6 with SMTP id z6so207341870pas.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2015 20:18:09 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 1/1] iio: lidar: return -EINVAL on invalid signal
Date: Mon, 26 Oct 2015 20:18:23 -0700
Message-Id: <1445915903-23418-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1445915903-23418-1-git-send-email-mranostay@gmail.com>
References: <1445915903-23418-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Returning zero from the measurment function has the side effect of
corrupting the triggered buffer readings, better to use -EINVAL than
a zero measurement reading.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 961f9f99..e544fcf 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -130,10 +130,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		if (ret < 0)
 			break;
 
-		/* return 0 since laser is likely pointed out of range */
+		/* return -EINVAL since laser is likely pointed out of range */
 		if (ret & LIDAR_REG_STATUS_INVALID) {
 			*reg = 0;
-			ret = 0;
+			ret = -EINVAL;
 			break;
 		}
 
@@ -197,7 +197,7 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
 	if (!ret) {
 		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 						   iio_get_time_ns());
-	} else {
+	} else if (ret != -EINVAL) {
 		dev_err(&data->client->dev, "cannot read LIDAR measurement");
 	}
 
-- 
1.9.1

