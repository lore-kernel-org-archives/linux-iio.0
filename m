Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald <pmeerw@pmeerw.net>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>, Cristina Moraru
	<cristina.moraru09@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>, Julia
 Lawall <Julia.Lawall@lip6.fr>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v3 1/3] iio:magnetometer:ak8975: fix missing regulator_disable
Date: Thu, 17 Mar 2016 17:43:26 +0100
Message-ID: <058df1d45949ea5ee606d9b872acb0f2771a5f99.1458231723.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1458231723.git.gregor.boirie@parrot.com>
References: <cover.1458231723.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Ensure optional regulator is properly disabled when present.

Fixes: 63d5d525cbbc ("iio:magnetometer:ak8975: power regulator support")
Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/ak8975.c | 78 ++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 72c03d9..48d127a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -370,8 +370,40 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	struct regulator	*vdd;
 };
 
+/* Enable attached power regulator if any. */
+static int ak8975_power_on(struct i2c_client *client)
+{
+	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR_OR_NULL(data->vdd)) {
+		ret = PTR_ERR(data->vdd);
+		if (ret == -ENODEV)
+			ret = 0;
+	} else {
+		ret = regulator_enable(data->vdd);
+	}
+
+	if (ret)
+		dev_err(&client->dev, "failed to enable Vdd supply: %d\n", ret);
+	return ret;
+}
+
+/* Disable attached power regulator if any. */
+static void ak8975_power_off(const struct i2c_client *client)
+{
+	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	const struct ak8975_data *data = iio_priv(indio_dev);
+
+	if (!IS_ERR_OR_NULL(data->vdd))
+		regulator_disable(data->vdd);
+}
+
 /*
  * Return 0 if the i2c device is the one we expect.
  * return a negative error number otherwise
@@ -380,23 +412,8 @@ static int ak8975_who_i_am(struct i2c_client *client,
 			   enum asahi_compass_chipset type)
 {
 	u8 wia_val[2];
-	struct regulator *vdd = devm_regulator_get_optional(&client->dev,
-							    "vdd");
 	int ret;
 
-	/* Enable attached regulator if any. */
-	if (!IS_ERR(vdd)) {
-		ret = regulator_enable(vdd);
-		if (ret) {
-			dev_err(&client->dev, "Failed to enable Vdd supply\n");
-			return ret;
-		}
-	} else {
-		ret = PTR_ERR(vdd);
-		if (ret != -ENODEV)
-			return ret;
-	}
-
 	/*
 	 * Signature for each device:
 	 * Device   |  WIA1      |  WIA2
@@ -804,10 +821,15 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 
 	data->def = &ak_def_array[chipset];
+
+	err = ak8975_power_on(client);
+	if (err)
+		return err;
+
 	err = ak8975_who_i_am(client, data->def->type);
 	if (err < 0) {
 		dev_err(&client->dev, "Unexpected device\n");
-		return err;
+		goto power_off;
 	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
@@ -815,7 +837,7 @@ static int ak8975_probe(struct i2c_client *client,
 	err = ak8975_setup(client);
 	if (err < 0) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
-		return err;
+		goto power_off;
 	}
 
 	mutex_init(&data->lock);
@@ -825,7 +847,26 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
-	return devm_iio_device_register(&client->dev, indio_dev);
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto power_off;
+
+	return 0;
+
+power_off:
+	ak8975_power_off(client);
+	return err;
+}
+
+static int ak8975_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	ak8975_power_off(client);
+
+	return 0;
 }
 
 static const struct i2c_device_id ak8975_id[] = {
@@ -859,6 +900,7 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
+	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);
-- 
2.1.4
