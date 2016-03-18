Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33660 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbcCRDsM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2016 23:48:12 -0400
Received: by mail-pf0-f178.google.com with SMTP id 4so17819742pfd.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Mar 2016 20:48:12 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, dcb314@hotmail.com, pmeerw@pmeerw.net,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: light: apds9960: correct FIFO check condition
Date: Thu, 17 Mar 2016 20:48:07 -0700
Message-Id: <1458272888-26146-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correct issue that the last entry in FIFO was being read twice due
to an incorrect decrement of entry count variable before condition
check.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/light/apds9960.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index f6a07dc..a6af56a 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -769,7 +769,7 @@ static void apds9960_read_gesture_fifo(struct apds9960_data *data)
 	mutex_lock(&data->lock);
 	data->gesture_mode_running = 1;
 
-	while (cnt-- || (cnt = apds9660_fifo_is_empty(data) > 0)) {
+	while (cnt || (cnt = apds9660_fifo_is_empty(data) > 0)) {
 		ret = regmap_bulk_read(data->regmap, APDS9960_REG_GFIFO_BASE,
 				      &data->buffer, 4);
 
@@ -777,6 +777,7 @@ static void apds9960_read_gesture_fifo(struct apds9960_data *data)
 			goto err_read;
 
 		iio_push_to_buffers(data->indio_dev, data->buffer);
+		cnt--;
 	}
 
 err_read:
-- 
2.7.0

