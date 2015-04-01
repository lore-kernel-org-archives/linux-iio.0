Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34482 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbbDALCN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 07:02:13 -0400
Received: by wixo5 with SMTP id o5so27027854wix.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 04:02:12 -0700 (PDT)
Date: Wed, 1 Apr 2015 14:01:11 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
	daniel.baluta@gmail.com
Subject: [PATCH 1/2] iio: magnetometer: mag3110: Place driver on standby on
 error
Message-ID: <33355f963dc3956b6b75c6915b1e3f616c4411c1.1427797741.git.cristina.opriceana@gmail.com>
References: <cover.1427797741.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1427797741.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Place driver on standby mode on error in order to prevent wasting
power. Move standby function above to be seen by the new call.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/magnetometer/mag3110.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index e3106b4..261d517 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -321,6 +321,12 @@ static const struct iio_info mag3110_info = {
 
 static const unsigned long mag3110_scan_masks[] = {0x7, 0xf, 0};
 
+static int mag3110_standby(struct mag3110_data *data)
+{
+	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+		data->ctrl_reg1 & ~MAG3110_CTRL_AC);
+}
+
 static int mag3110_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -360,12 +366,12 @@ static int mag3110_probe(struct i2c_client *client,
 	ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
 	if (ret < 0)
-		return ret;
+		goto standby_on_error;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mag3110_trigger_handler, NULL);
 	if (ret < 0)
-		return ret;
+		goto standby_on_error;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -374,15 +380,11 @@ static int mag3110_probe(struct i2c_client *client,
 
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+standby_on_error:
+	mag3110_standby(iio_priv(indio_dev));
 	return ret;
 }
 
-static int mag3110_standby(struct mag3110_data *data)
-{
-	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
-		data->ctrl_reg1 & ~MAG3110_CTRL_AC);
-}
-
 static int mag3110_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-- 
1.9.1

