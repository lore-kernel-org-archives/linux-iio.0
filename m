Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36133 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcFXJMK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 05:12:10 -0400
Received: by mail-lf0-f50.google.com with SMTP id q132so111931327lfe.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 02:12:09 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6 v2] iio: magn: ak8975: add Vid regulator
Date: Fri, 24 Jun 2016 11:11:52 +0200
Message-Id: <1466759516-20586-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
References: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- No changes. Numbered v2 to be part of the patch set.
ChangeLog v1->v2:
- Just obtain the other regulator exactly like the first without
  trying to be fancy.
- Rebase and rewrite on top of the patch fixing up the regulator
  usage.
---
 drivers/iio/magnetometer/ak8975.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 05e9d5041e7a..62f73d9d38b4 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -400,6 +400,19 @@ static int ak8975_power_on(struct i2c_client *client)
 			 "Failed to enable specified Vdd supply\n");
 		return ret;
 	}
+
+	data->vid = devm_regulator_get(&client->dev, "vid");
+	if (IS_ERR(data->vid)) {
+		ret = PTR_ERR(data->vid);
+	} else {
+		ret = regulator_enable(data->vid);
+	}
+	if (ret) {
+		dev_warn(&client->dev,
+			 "Failed to enable specified Vid supply\n");
+		return ret;
+	}
+	return 0;
 }
 
 /* Disable attached power regulator if any. */
@@ -408,6 +421,7 @@ static void ak8975_power_off(const struct i2c_client *client)
 	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	const struct ak8975_data *data = iio_priv(indio_dev);
 
+	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
 }
 
-- 
2.4.11

