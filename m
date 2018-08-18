Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34438 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeHRFOd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Aug 2018 01:14:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so4489703plo.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Aug 2018 19:08:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id z11-v6sm5106444pff.162.2018.08.17.19.08.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 19:08:42 -0700 (PDT)
From: Jiecheng Wu <jasonwood2031@gmail.com>
To: linux-iio@vger.kernel.org
Subject: [PATCH] hmc5843_i2c.c: fix missing return value check of devm_regmap_init_i2c()
Date: Sat, 18 Aug 2018 10:08:33 +0800
Message-Id: <20180818020833.14376-1-jasonwood2031@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Function hmc5843_i2c_probe() defined in drivers/iio/magnetometer/hmc5843_i2c.c calls devm_regmap_init_i2c() to initialise managed register map. As the return value of devm_regmap_init_i2c() will be an ERR_PTR() on error, the return value must be checked against NULL.
---
 drivers/iio/magnetometer/hmc5843_i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f44..4911cf8 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/device.h>
 
 #include "hmc5843.h"
 
@@ -58,8 +59,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
-	return hmc5843_common_probe(&cli->dev,
-			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
+	struct regmap *regmap;
+	regmap = devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&cli->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+	return hmc5843_common_probe(&cli->dev, regmap,
 			id->driver_data, id->name);
 }
 
-- 
2.6.4
