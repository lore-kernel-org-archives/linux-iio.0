Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6 v3] iio: magn: ak8975: add Vid regulator
Date: Wed, 29 Jun 2016 14:08:34 +0200
Message-Id: <1467202118-10386-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

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
- Rebase.
ChangeLog v1->v2:
- Just obtain the other regulator exactly like the first without
  trying to be fancy.
- Rebase and rewrite on top of the patch fixing up the regulator
  usage.
---
 drivers/iio/magnetometer/ak8975.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7f51adba7bad..af3395a0fb16 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -379,6 +379,7 @@ struct ak8975_data {
 	u8			cntl_cache;
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
+	struct regulator	*vid;
 };
 
 /* Enable attached power regulator if any. */
@@ -399,6 +400,19 @@ static int ak8975_power_on(struct i2c_client *client)
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
@@ -407,6 +421,7 @@ static void ak8975_power_off(const struct i2c_client *client)
 	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	const struct ak8975_data *data = iio_priv(indio_dev);
 
+	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
 }
 
-- 
2.4.11
