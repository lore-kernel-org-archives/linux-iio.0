Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34648 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcFPP67 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2016 11:58:59 -0400
Received: by mail-lf0-f48.google.com with SMTP id j7so43560631lfg.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2016 08:58:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: ak8975: add Vid regulator
Date: Thu, 16 Jun 2016 17:58:35 +0200
Message-Id: <1466092715-20106-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AK8975 has two power sources: Vdd (analog voltage supply)
and Vid (digital voltage supply). Optionally also obtain the Vid
supply regulator and enable it.

If an error occurs when enabling one of the regulators: bail out.

Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Richard Leitner <dev@g0hl1n.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Just obtain the other regulator exactly like the first without
  trying to be fancy.
---
 drivers/iio/magnetometer/ak8975.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 609a2c401b5d..e0e43f497f40 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -379,6 +379,7 @@ struct ak8975_data {
 	u8			cntl_cache;
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
+	struct regulator	*vid;
 };
 
 /* Enable attached power regulator if any. */
@@ -396,10 +397,26 @@ static int ak8975_power_on(struct i2c_client *client)
 	} else {
 		ret = regulator_enable(data->vdd);
 	}
+	if (ret) {
+		dev_warn(&client->dev,
+			 "Failed to enable specified Vdd supply\n");
+		return ret;
+	}
 
-	if (ret)
-		dev_err(&client->dev, "failed to enable Vdd supply: %d\n", ret);
-	return ret;
+	data->vid = devm_regulator_get(&client->dev, "vid");
+	if (IS_ERR_OR_NULL(data->vid)) {
+		ret = PTR_ERR(data->vdd);
+		if (ret == -ENODEV)
+			ret = 0;
+	} else {
+		ret = regulator_enable(data->vdd);
+	}
+	if (ret) {
+		dev_warn(&client->dev,
+			 "Failed to enable specified Vid supply\n");
+		return ret;
+	}
+	return 0;
 }
 
 /* Disable attached power regulator if any. */
-- 
2.4.11

