Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35490 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbcFPPf5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2016 11:35:57 -0400
Received: by mail-lf0-f42.google.com with SMTP id l188so40670188lfe.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2016 08:35:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] iio: ak8975: add Vid regulator, use optional API
Date: Thu, 16 Jun 2016 17:35:49 +0200
Message-Id: <1466091349-10307-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AK8975 has two power sources: Vdd (analog voltage supply)
and Vid (digital voltage supply). Optionally also obtain the Vid
supply regulator and enable it.

This also switches the AK8975 regulator to use the optional
regulator API instead of using the much-disliked IS_ERR_OR_NULL()
macro.

If an error occurs when enabling one of the regulators: bail out.

Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Richard Leitner <dev@g0hl1n.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 609a2c401b5d..cb8e79532854 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -379,6 +379,7 @@ struct ak8975_data {
 	u8			cntl_cache;
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
+	struct regulator	*vid;
 };
 
 /* Enable attached power regulator if any. */
@@ -388,18 +389,25 @@ static int ak8975_power_on(struct i2c_client *client)
 	struct ak8975_data *data = iio_priv(indio_dev);
 	int ret;
 
-	data->vdd = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR_OR_NULL(data->vdd)) {
-		ret = PTR_ERR(data->vdd);
-		if (ret == -ENODEV)
-			ret = 0;
-	} else {
+	data->vdd = devm_regulator_get_optional(&client->dev, "vdd");
+	if (!IS_ERR(data->vdd)) {
 		ret = regulator_enable(data->vdd);
+		if (ret) {
+			dev_warn(&client->dev,
+				 "Failed to enable specified Vdd supply\n");
+			return ret;
+		}
 	}
-
-	if (ret)
-		dev_err(&client->dev, "failed to enable Vdd supply: %d\n", ret);
-	return ret;
+	data->vid = devm_regulator_get_optional(&client->dev, "vid");
+	if (!IS_ERR(data->vid)) {
+		ret = regulator_enable(data->vid);
+		if (ret) {
+			dev_warn(&client->dev,
+				 "Failed to enable specified Vid supply\n");
+			return ret;
+		}
+	}
+	return 0;
 }
 
 /* Disable attached power regulator if any. */
-- 
2.4.11

