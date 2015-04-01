Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38053 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbDALCw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 07:02:52 -0400
Received: by wibgn9 with SMTP id gn9so61512032wib.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 04:02:51 -0700 (PDT)
Date: Wed, 1 Apr 2015 14:01:51 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
	daniel.baluta@gmail.com
Subject: [PATCH 2/2] iio: light: ltr501: Powerdown device on error
Message-ID: <1abedb2004323a23e8dd120abf761f3488c8e9f6.1427797741.git.cristina.opriceana@gmail.com>
References: <cover.1427797741.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1427797741.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Power down device when an error occurs  in order to avoid wasting
power. Also move powerdown function up to be seen by the new call.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/light/ltr501.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 62b7072..29ca4b8 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -333,6 +333,13 @@ static int ltr501_init(struct ltr501_data *data)
 		data->ps_contr);
 }
 
+static int ltr501_powerdown(struct ltr501_data *data)
+{
+	return ltr501_write_contr(data->client,
+		data->als_contr & ~LTR501_CONTR_ACTIVE,
+		data->ps_contr & ~LTR501_CONTR_ACTIVE);
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

