Return-Path: <amsfield22@gmail.com>
From: Alison Schofield <amsfield22@gmail.com>
To: outreachy-kernel@googlegroups.com,
	daniel.baluta@intel.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] staging: iio: isl29018: use regmap to retrieve struct device
Date: Mon, 22 Feb 2016 12:34:32 -0800
Message-Id: <1456173272-5217-1-git-send-email-amsfield22@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove struct device from drivers global data and use regmap
API to retrieve device info instead.

This replacement can be done for drivers that include regmap
in their global data.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/staging/iio/light/isl29018.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 03dbfb6..76d9f74 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -100,7 +100,6 @@ static const struct isl29018_scale {
 };
 
 struct isl29018_chip {
-	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		lock;
 	int			type;
@@ -180,30 +179,31 @@ static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
 	int status;
 	unsigned int lsb;
 	unsigned int msb;
+	struct device *dev = regmap_get_device(chip->regmap);
 
 	/* Set mode */
 	status = regmap_write(chip->regmap, ISL29018_REG_ADD_COMMAND1,
 			      mode << COMMMAND1_OPMODE_SHIFT);
 	if (status) {
-		dev_err(chip->dev,
+		dev_err(dev,
 			"Error in setting operating mode err %d\n", status);
 		return status;
 	}
 	msleep(CONVERSION_TIME_MS);
 	status = regmap_read(chip->regmap, ISL29018_REG_ADD_DATA_LSB, &lsb);
 	if (status < 0) {
-		dev_err(chip->dev,
+		dev_err(dev,
 			"Error in reading LSB DATA with err %d\n", status);
 		return status;
 	}
 
 	status = regmap_read(chip->regmap, ISL29018_REG_ADD_DATA_MSB, &msb);
 	if (status < 0) {
-		dev_err(chip->dev,
+		dev_err(dev,
 			"Error in reading MSB DATA with error %d\n", status);
 		return status;
 	}
-	dev_vdbg(chip->dev, "MSB 0x%x and LSB 0x%x\n", msb, lsb);
+	dev_vdbg(dev, "MSB 0x%x and LSB 0x%x\n", msb, lsb);
 
 	return (msb << 8) | lsb;
 }
@@ -246,13 +246,14 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 	int status;
 	int prox_data = -1;
 	int ir_data = -1;
+	struct device *dev = regmap_get_device(chip->regmap);
 
 	/* Do proximity sensing with required scheme */
 	status = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
 				    COMMANDII_SCHEME_MASK,
 				    scheme << COMMANDII_SCHEME_SHIFT);
 	if (status) {
-		dev_err(chip->dev, "Error in setting operating mode\n");
+		dev_err(dev, "Error in setting operating mode\n");
 		return status;
 	}
 
@@ -525,10 +526,11 @@ static int isl29035_detect(struct isl29018_chip *chip)
 {
 	int status;
 	unsigned int id;
+	struct device *dev = regmap_get_device(chip->regmap);
 
 	status = regmap_read(chip->regmap, ISL29035_REG_DEVICE_ID, &id);
 	if (status < 0) {
-		dev_err(chip->dev,
+		dev_err(dev,
 			"Error reading ID register with error %d\n",
 			status);
 		return status;
@@ -553,6 +555,7 @@ enum {
 static int isl29018_chip_init(struct isl29018_chip *chip)
 {
 	int status;
+	struct device *dev = regmap_get_device(chip->regmap);
 
 	if (chip->type == isl29035) {
 		status = isl29035_detect(chip);
@@ -582,7 +585,7 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 	 */
 	status = regmap_write(chip->regmap, ISL29018_REG_TEST, 0x0);
 	if (status < 0) {
-		dev_err(chip->dev, "Failed to clear isl29018 TEST reg.(%d)\n",
+		dev_err(dev, "Failed to clear isl29018 TEST reg.(%d)\n",
 			status);
 		return status;
 	}
@@ -593,7 +596,7 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 	 */
 	status = regmap_write(chip->regmap, ISL29018_REG_ADD_COMMAND1, 0);
 	if (status < 0) {
-		dev_err(chip->dev, "Failed to clear isl29018 CMD1 reg.(%d)\n",
+		dev_err(dev, "Failed to clear isl29018 CMD1 reg.(%d)\n",
 			status);
 		return status;
 	}
@@ -604,14 +607,14 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 	status = isl29018_set_scale(chip, chip->scale.scale,
 				    chip->scale.uscale);
 	if (status < 0) {
-		dev_err(chip->dev, "Init of isl29018 fails\n");
+		dev_err(dev, "Init of isl29018 fails\n");
 		return status;
 	}
 
 	status = isl29018_set_integration_time(chip,
 			isl29018_int_utimes[chip->type][chip->int_time]);
 	if (status < 0) {
-		dev_err(chip->dev, "Init of isl29018 fails\n");
+		dev_err(dev, "Init of isl29018 fails\n");
 		return status;
 	}
 
@@ -728,7 +731,6 @@ static int isl29018_probe(struct i2c_client *client,
 	chip = iio_priv(indio_dev);
 
 	i2c_set_clientdata(client, indio_dev);
-	chip->dev = &client->dev;
 
 	if (id) {
 		name = id->name;
@@ -751,7 +753,7 @@ static int isl29018_probe(struct i2c_client *client,
 				chip_info_tbl[dev_id].regmap_cfg);
 	if (IS_ERR(chip->regmap)) {
 		err = PTR_ERR(chip->regmap);
-		dev_err(chip->dev, "regmap initialization failed: %d\n", err);
+		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
 		return err;
 	}
 
-- 
2.1.4
