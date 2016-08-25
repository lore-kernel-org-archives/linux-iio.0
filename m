Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34202 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbcHYGpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 02:45:40 -0400
Received: by mail-pa0-f65.google.com with SMTP id hh10so2580411pac.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2016 23:44:59 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 3/4] iio: chemical: vz89x: prevent corrupted buffer from being read
Date: Wed, 24 Aug 2016 23:44:49 -0700
Message-Id: <1472107490-11924-4-git-send-email-mranostay@gmail.com>
In-Reply-To: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
References: <1472107490-11924-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 289d2919deea..cd3870ead3fd 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -55,6 +55,7 @@ struct vz89x_data {
 	struct mutex lock;
 	int (*xfer)(struct vz89x_data *data, u8 cmd);
 
+	bool is_valid;
 	unsigned long last_update;
 	u8 buffer[VZ89TE_REG_MEASUREMENT_RD_SIZE];
 };
@@ -229,7 +230,10 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 
 	/* sensor can only be polled once a second max per datasheet */
 	if (!time_after(jiffies, data->last_update + HZ))
-		return 0;
+		return data->is_valid ? 0 : -EAGAIN;
+
+	data->is_valid = false;
+	data->last_update = jiffies;
 
 	ret = data->xfer(data, chip->cmd);
 	if (ret < 0)
@@ -239,7 +243,7 @@ static int vz89x_get_measurement(struct vz89x_data *data)
 	if (ret)
 		return -EAGAIN;
 
-	data->last_update = jiffies;
+	data->is_valid = true;
 
 	return 0;
 }
-- 
2.7.4

