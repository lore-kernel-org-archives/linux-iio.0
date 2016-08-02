Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35007 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcHBF1g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2016 01:27:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so11671329pfg.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Aug 2016 22:27:36 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: ams-iaq-core: update driver name and DT match table
Date: Mon,  1 Aug 2016 21:25:16 -0700
Message-Id: <1470111916-9104-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DT match name should be similar to the i2c device table entry, and also
make the iio name match the driver name versus the i2c device location.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/ams-iaq-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 41a8e6f2e31d..4c7d1f918d34 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -27,6 +27,8 @@
 #define AMS_IAQCORE_VOC_RESISTANCE_IDX	1
 #define AMS_IAQCORE_VOC_TVOC_IDX	2
 
+#define AMS_IAQCORE_DRVNAME		"ams-iaq-core"
+
 struct ams_iaqcore_reading {
 	__be16 co2_ppm;
 	u8 status;
@@ -164,7 +166,7 @@ static int ams_iaqcore_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ams_iaqcore_info,
-	indio_dev->name = dev_name(&client->dev);
+	indio_dev->name = AMS_IAQCORE_DRVNAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = ams_iaqcore_channels;
@@ -180,14 +182,14 @@ static const struct i2c_device_id ams_iaqcore_id[] = {
 MODULE_DEVICE_TABLE(i2c, ams_iaqcore_id);
 
 static const struct of_device_id ams_iaqcore_dt_ids[] = {
-	{ .compatible = "ams,iaq-core" },
+	{ .compatible = "ams,ams-iaq-core" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ams_iaqcore_dt_ids);
 
 static struct i2c_driver ams_iaqcore_driver = {
 	.driver = {
-		.name	= "ams-iaq-core",
+		.name = AMS_IAQCORE_DRVNAME,
 		.of_match_table = of_match_ptr(ams_iaqcore_dt_ids),
 	},
 	.probe = ams_iaqcore_probe,
-- 
2.7.4

