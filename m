Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:52571 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3L2LtO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Dec 2013 06:49:14 -0500
Received: from [192.168.0.80] ([188.102.214.102]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LtUHA-1VGZvo2i9M-010xQi for
 <linux-iio@vger.kernel.org>; Sun, 29 Dec 2013 12:49:13 +0100
Message-ID: <52C00C37.2080009@gmx.de>
Date: Sun, 29 Dec 2013 12:49:11 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH]staging:iio:ad799x make use of platform_data optional
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Setting Vref with platform_data is a neat feature, though it is not essential
for operating these devices. So make the use of platform_data optional and set
default value of 1000 mV if nothing else is defined.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 9428be8..e32a555 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -545,10 +545,12 @@ static int ad799x_probe(struct i2c_client *client,
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
-	if (!pdata)
-		return -EINVAL;
-
-	st->int_vref_mv = pdata->vref_mv;
+	if ((!pdata) || (!pdata->vref_mv)) {
+		dev_warn(&client->dev,
+			 "No platform data found, setting Vref to 1000 mV\n");
+		st->int_vref_mv = 1000;
+	} else
+		st->int_vref_mv = pdata->vref_mv;
 
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
