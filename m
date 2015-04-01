Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37554 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbbDAPvX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 11:51:23 -0400
Received: by wiaa2 with SMTP id a2so71981230wia.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 08:51:22 -0700 (PDT)
Date: Wed, 1 Apr 2015 18:50:17 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: ltr501: Powerdown device on error
Message-ID: <ba26e935b4fce83d6463762491960f0e6e13f498.1427903144.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Power down device when an error occurs  in order to avoid wasting
power. Move powerdown function up to be seen by the new call and
align parameters for the ltr501_write_contr() call.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
Changes in v2:
 - align parameters in the ltr501_write_contr() function call
 - update commit message to include this change

 drivers/iio/light/ltr501.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 62b7072..78b8783 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -333,6 +333,13 @@ static int ltr501_init(struct ltr501_data *data)
 		data->ps_contr);
 }
 
+static int ltr501_powerdown(struct ltr501_data *data)
+{
+	return ltr501_write_contr(data->client,
+				  data->als_contr & ~LTR501_CONTR_ACTIVE,
+				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
+}
+
 static int ltr501_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -370,7 +377,7 @@ static int ltr501_probe(struct i2c_client *client,
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		ltr501_trigger_handler, NULL);
 	if (ret)
-		return ret;
+		goto powerdown_on_error;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -380,16 +387,11 @@ static int ltr501_probe(struct i2c_client *client,
 
 error_unreg_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
+powerdown_on_error:
+	ltr501_powerdown(data);
 	return ret;
 }
 
-static int ltr501_powerdown(struct ltr501_data *data)
-{
-	return ltr501_write_contr(data->client,
-		data->als_contr & ~LTR501_CONTR_ACTIVE,
-		data->ps_contr & ~LTR501_CONTR_ACTIVE);
-}
-
 static int ltr501_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-- 
1.9.1

