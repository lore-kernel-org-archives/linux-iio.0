Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41610 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927AbcGELzr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:47 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 1/9] staging: iio: isl29018: Prefix #defines
Date: Tue,  5 Jul 2016 13:55:36 +0200
Message-Id: <1467719744-19450-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29018.c |   61 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 76d9f74..0599337 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -32,25 +32,25 @@
 #include <linux/iio/sysfs.h>
 #include <linux/acpi.h>
 
-#define CONVERSION_TIME_MS		100
+#define ISL29018_CONV_TIME_MS		100
 
 #define ISL29018_REG_ADD_COMMAND1	0x00
-#define COMMMAND1_OPMODE_SHIFT		5
-#define COMMMAND1_OPMODE_MASK		(7 << COMMMAND1_OPMODE_SHIFT)
-#define COMMMAND1_OPMODE_POWER_DOWN	0
-#define COMMMAND1_OPMODE_ALS_ONCE	1
-#define COMMMAND1_OPMODE_IR_ONCE	2
-#define COMMMAND1_OPMODE_PROX_ONCE	3
+#define ISL29018_CMD1_OPMODE_SHIFT	5
+#define ISL29018_CMD1_OPMODE_MASK	(7 << ISL29018_CMD1_OPMODE_SHIFT)
+#define ISL29018_CMD1_OPMODE_POWER_DOWN	0
+#define ISL29018_CMD1_OPMODE_ALS_ONCE	1
+#define ISL29018_CMD1_OPMODE_IR_ONCE	2
+#define ISL29018_CMD1_OPMODE_PROX_ONCE	3
 
-#define ISL29018_REG_ADD_COMMANDII	0x01
-#define COMMANDII_RESOLUTION_SHIFT	2
-#define COMMANDII_RESOLUTION_MASK	(0x3 << COMMANDII_RESOLUTION_SHIFT)
+#define ISL29018_REG_ADD_COMMAND2	0x01
+#define ISL29018_CMD2_RESOLUTION_SHIFT	2
+#define ISL29018_CMD2_RESOLUTION_MASK	(0x3 << ISL29018_CMD2_RESOLUTION_SHIFT)
 
-#define COMMANDII_RANGE_SHIFT		0
-#define COMMANDII_RANGE_MASK		(0x3 << COMMANDII_RANGE_SHIFT)
+#define ISL29018_CMD2_RANGE_SHIFT	0
+#define ISL29018_CMD2_RANGE_MASK	(0x3 << ISL29018_CMD2_RANGE_SHIFT)
 
-#define COMMANDII_SCHEME_SHIFT		7
-#define COMMANDII_SCHEME_MASK		(0x1 << COMMANDII_SCHEME_SHIFT)
+#define ISL29018_CMD2_SCHEME_SHIFT	7
+#define ISL29018_CMD2_SCHEME_MASK	(0x1 << ISL29018_CMD2_SCHEME_SHIFT)
 
 #define ISL29018_REG_ADD_DATA_LSB	0x02
 #define ISL29018_REG_ADD_DATA_MSB	0x03
@@ -127,9 +127,9 @@ static int isl29018_set_integration_time(struct isl29018_chip *chip,
 	if (i >= ARRAY_SIZE(isl29018_int_utimes[chip->type]))
 		return -EINVAL;
 
-	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
-				 COMMANDII_RESOLUTION_MASK,
-				 i << COMMANDII_RESOLUTION_SHIFT);
+	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMAND2,
+				 ISL29018_CMD2_RESOLUTION_MASK,
+				 i << ISL29018_CMD2_RESOLUTION_SHIFT);
 	if (ret < 0)
 		return ret;
 
@@ -163,9 +163,9 @@ static int isl29018_set_scale(struct isl29018_chip *chip, int scale, int uscale)
 	if (i >= ARRAY_SIZE(isl29018_scales[chip->int_time]))
 		return -EINVAL;
 
-	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
-				 COMMANDII_RANGE_MASK,
-				 i << COMMANDII_RANGE_SHIFT);
+	ret = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMAND2,
+				 ISL29018_CMD2_RANGE_MASK,
+				 i << ISL29018_CMD2_RANGE_SHIFT);
 	if (ret < 0)
 		return ret;
 
@@ -183,13 +183,13 @@ static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mode)
 
 	/* Set mode */
 	status = regmap_write(chip->regmap, ISL29018_REG_ADD_COMMAND1,
-			      mode << COMMMAND1_OPMODE_SHIFT);
+			      mode << ISL29018_CMD1_OPMODE_SHIFT);
 	if (status) {
 		dev_err(dev,
 			"Error in setting operating mode err %d\n", status);
 		return status;
 	}
-	msleep(CONVERSION_TIME_MS);
+	msleep(ISL29018_CONV_TIME_MS);
 	status = regmap_read(chip->regmap, ISL29018_REG_ADD_DATA_LSB, &lsb);
 	if (status < 0) {
 		dev_err(dev,
@@ -213,7 +213,8 @@ static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
 	int lux_data;
 	unsigned int data_x_range;
 
-	lux_data = isl29018_read_sensor_input(chip, COMMMAND1_OPMODE_ALS_ONCE);
+	lux_data = isl29018_read_sensor_input(chip,
+					      ISL29018_CMD1_OPMODE_ALS_ONCE);
 
 	if (lux_data < 0)
 		return lux_data;
@@ -230,7 +231,8 @@ static int isl29018_read_ir(struct isl29018_chip *chip, int *ir)
 {
 	int ir_data;
 
-	ir_data = isl29018_read_sensor_input(chip, COMMMAND1_OPMODE_IR_ONCE);
+	ir_data = isl29018_read_sensor_input(chip,
+					     ISL29018_CMD1_OPMODE_IR_ONCE);
 
 	if (ir_data < 0)
 		return ir_data;
@@ -249,16 +251,16 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 	struct device *dev = regmap_get_device(chip->regmap);
 
 	/* Do proximity sensing with required scheme */
-	status = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMANDII,
-				    COMMANDII_SCHEME_MASK,
-				    scheme << COMMANDII_SCHEME_SHIFT);
+	status = regmap_update_bits(chip->regmap, ISL29018_REG_ADD_COMMAND2,
+				    ISL29018_CMD2_SCHEME_MASK,
+				    scheme << ISL29018_CMD2_SCHEME_SHIFT);
 	if (status) {
 		dev_err(dev, "Error in setting operating mode\n");
 		return status;
 	}
 
 	prox_data = isl29018_read_sensor_input(chip,
-					       COMMMAND1_OPMODE_PROX_ONCE);
+					       ISL29018_CMD1_OPMODE_PROX_ONCE);
 	if (prox_data < 0)
 		return prox_data;
 
@@ -267,7 +269,8 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 		return 0;
 	}
 
-	ir_data = isl29018_read_sensor_input(chip, COMMMAND1_OPMODE_IR_ONCE);
+	ir_data = isl29018_read_sensor_input(chip,
+					     ISL29018_CMD1_OPMODE_IR_ONCE);
 
 	if (ir_data < 0)
 		return ir_data;
-- 
1.7.10.4

