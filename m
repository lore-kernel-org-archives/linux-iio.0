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
Subject: [PATCH 3/6 v3] iio: magn: ak8975: refactor regulator handlers
Date: Wed, 29 Jun 2016 14:08:35 +0200
Message-Id: <1467202118-10386-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Move the regulator_get() calls directly into the probe() function,
keep only the power_on()/power_off() functions to flick the
regulators on/off.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase
ChangeLog v1->v2:
- Fix missed conversions that happened to end up in a later
  patch in the series, mea culpa.
---
 drivers/iio/magnetometer/ak8975.c | 43 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index af3395a0fb16..f72f51d1f3f5 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -383,32 +383,19 @@ struct ak8975_data {
 };
 
 /* Enable attached power regulator if any. */
-static int ak8975_power_on(struct i2c_client *client)
+static int ak8975_power_on(const struct ak8975_data *data)
 {
-	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak8975_data *data = iio_priv(indio_dev);
 	int ret;
 
-	data->vdd = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd)) {
-		ret = PTR_ERR(data->vdd);
-	} else {
-		ret = regulator_enable(data->vdd);
-	}
+	ret = regulator_enable(data->vdd);
 	if (ret) {
-		dev_warn(&client->dev,
+		dev_warn(&data->client->dev,
 			 "Failed to enable specified Vdd supply\n");
 		return ret;
 	}
-
-	data->vid = devm_regulator_get(&client->dev, "vid");
-	if (IS_ERR(data->vid)) {
-		ret = PTR_ERR(data->vid);
-	} else {
-		ret = regulator_enable(data->vid);
-	}
+	ret = regulator_enable(data->vid);
 	if (ret) {
-		dev_warn(&client->dev,
+		dev_warn(&data->client->dev,
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
@@ -416,11 +403,8 @@ static int ak8975_power_on(struct i2c_client *client)
 }
 
 /* Disable attached power regulator if any. */
-static void ak8975_power_off(const struct i2c_client *client)
+static void ak8975_power_off(const struct ak8975_data *data)
 {
-	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	const struct ak8975_data *data = iio_priv(indio_dev);
-
 	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
 }
@@ -936,7 +920,15 @@ static int ak8975_probe(struct i2c_client *client,
 
 	data->def = &ak_def_array[chipset];
 
-	err = ak8975_power_on(client);
+	/* Fetch the regulators */
+	data->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd))
+		return PTR_ERR(data->vdd);
+	data->vid = devm_regulator_get(&client->dev, "vid");
+	if (IS_ERR(data->vid))
+		return PTR_ERR(data->vid);
+
+	err = ak8975_power_on(data);
 	if (err)
 		return err;
 
@@ -981,17 +973,18 @@ static int ak8975_probe(struct i2c_client *client,
 cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 power_off:
-	ak8975_power_off(client);
+	ak8975_power_off(data);
 	return err;
 }
 
 static int ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	ak8975_power_off(client);
+	ak8975_power_off(data);
 
 	return 0;
 }
-- 
2.4.11
