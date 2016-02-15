Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34985 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbcBOC7N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 21:59:13 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so80823281pfc.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2016 18:59:13 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: use regmap_bulk_read
Date: Sun, 14 Feb 2016 18:59:07 -0800
Message-Id: <1455505147-2261-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replaced i2c_smbus_read_i2c_block_data() with regmap_bulk_read()
function call. This is to make the driver code more consistent.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 06cd49c..93fcea9 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -180,10 +180,10 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_i2c_block_data(data->client, ATLAS_REG_PH_DATA,
-				sizeof(data->buffer[0]), (u8 *) &data->buffer);
+	ret = regmap_bulk_read(data->regmap, ATLAS_REG_PH_DATA,
+			      (u8 *) &data->buffer, sizeof(data->buffer[0]));
 
-	if (ret > 0)
+	if (!ret)
 		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 				iio_get_time_ns());
 
-- 
2.7.0

