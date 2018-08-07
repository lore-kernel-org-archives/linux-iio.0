Return-Path: <SRS0=wQlq=KW=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<eraretuya@gmail.com>
CC: <dan.carpenter@oracle.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH] iio: adxl345: move null check for i2c id at start of probe
Date: Tue, 7 Aug 2018 17:06:05 +0300
Message-ID: <20180807140605.19156-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").

This was found via static checker.
After looking into the code a bit, it's unlikely that there will be a NULL
dereference if the `id` object in that specific code path.
However, it's safe to add a NULL (paranoid) check just to make sure and
remove any uncertainties.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl345_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 785c89de91e7..f22f71315a0c 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,6 +27,9 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 {
 	struct regmap *regmap;
 
+	if (!id)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
@@ -35,7 +38,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 	}
 
 	return adxl345_core_probe(&client->dev, regmap, id->driver_data,
-				  id ? id->name : NULL);
+				  id->name);
 }
 
 static int adxl345_i2c_remove(struct i2c_client *client)
-- 
2.17.1
