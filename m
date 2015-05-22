Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp107.biz.mail.bf1.yahoo.com ([98.139.244.55]:33498 "EHLO
	smtp107.biz.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755924AbbEVAcF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 May 2015 20:32:05 -0400
From: Kevin Tsai <ktsai@capellamicro.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 4/6] iio: light: Updated Vishay Capella cm32181 ambient light sensor driver. - Replaced als_it_bits and als_it_value by cm32181_als_it_scale.
Date: Thu, 21 May 2015 17:30:43 -0700
Message-Id: <1432254645-5349-4-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432254645-5349-1-git-send-email-ktsai@capellamicro.com>
References: <1432254645-5349-1-git-send-email-ktsai@capellamicro.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
---
Replaced als_it_bits and als_it_value by cm32181_als_it_scale.

 drivers/iio/light/cm32181.c | 95 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 9bc3e1f..54bf0cb 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -53,12 +53,25 @@
 #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
 #define	CM32181_CALIBSCALE_DEFAULT	1000
 #define CM32181_CALIBSCALE_RESOLUTION	1000
-#define MLUX_PER_LUX			1000
+#define CM32181_MLUX_PER_LUX		1000
 
 static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
 static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
 	800000};
 
+static const struct {
+	int val;
+	int val2;
+	u16 it;
+} cm32181_als_it_scales[] = {
+	{0, 25000, 12},	/* 0.025000 */
+	{0, 50000, 8},	/* 0.050000 */
+	{0, 100000, 0},	/* 0.100000 */
+	{0, 200000, 1},	/* 0.200000 */
+	{0, 400000, 2},	/* 0.400000 */
+	{0, 800000, 3},	/* 0.800000 */
+};
+
 struct cm32181_als_info {
 	u8 hw_id;
 	u16 reg_cmd;
@@ -129,15 +142,16 @@ static int cm32181_reg_init(struct cm32181_chip *chip)
 }
 
 /**
- * cm32181_read_als_it() - Get sensor integration time (ms)
+ * cm32181_read_als_it() - Get sensor integration time
  * @chip:	pointer of struct cm32181_chip
- * @val2:	pointer of int to load the als_it value.
+ * @val:	pointer of int to load the integration (sec)
+ * @val2:	pointer of int to load the integration time (microsecond)
  *
  * Report the current integartion time by millisecond.
  *
  * Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
  */
-static int cm32181_read_als_it(struct cm32181_chip *chip, int *val2)
+static int cm32181_read_als_it(struct cm32181_chip *chip, int *val, int *val2)
 {
 	u16 als_it;
 	int i;
@@ -145,9 +159,10 @@ static int cm32181_read_als_it(struct cm32181_chip *chip, int *val2)
 	als_it = chip->conf_regs[CM32181_REG_ADDR_CMD];
 	als_it &= CM32181_CMD_ALS_IT_MASK;
 	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
-	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
-		if (als_it == als_it_bits[i]) {
-			*val2 = als_it_value[i];
+	for (i = 0; i < ARRAY_SIZE(cm32181_als_it_scales); i++) {
+		if (als_it == cm32181_als_it_scales[i].it) {
+			*val = cm32181_als_it_scales[i].val;
+			*val2 = cm32181_als_it_scales[i].val2;
 			return IIO_VAL_INT_PLUS_MICRO;
 		}
 	}
@@ -158,15 +173,44 @@ static int cm32181_read_als_it(struct cm32181_chip *chip, int *val2)
 /**
  * cm32181_write_als_it() - Write sensor integration time
  * @chip:	pointer of struct cm32181_chip.
- * @val:	integration time by millisecond.
+ * @val:	integration time in second.
+ * @val2:	integration time in microsecond.
  *
  * Convert integration time (ms) to sensor value.
  *
  * Return: i2c_smbus_write_word_data command return value.
  */
-static int cm32181_write_als_it(struct cm32181_chip *chip, int val)
+static int cm32181_write_als_it(struct cm32181_chip *chip, int val, int val2)
 {
 	struct i2c_client *client = chip->client;
+	u16 als_it, cmd;
+	int i;
+	s32 ret;
+
+	for (i = 0; i < ARRAY_SIZE(cm32181_als_it_scales); i++) {
+		if (val == cm32181_als_it_scales[i].val &&
+			val2 == cm32181_als_it_scales[i].val2) {
+
+			als_it = cm32181_als_it_scales[i].it;
+			als_it <<= CM32181_CMD_ALS_IT_SHIFT;
+
+			cmd = chip->conf_regs[CM32181_REG_ADDR_CMD];
+			cmd &= ~CM32181_CMD_ALS_IT_MASK;
+			cmd |= als_it;
+			ret = i2c_smbus_write_word_data(client,
+						CM32181_REG_ADDR_CMD,
+						cmd);
+			if (ret < 0)
+				return ret;
+
+			chip->conf_regs[CM32181_REG_ADDR_CMD] = cmd;
+			return 0;
+		}
+	}
+	return -EINVAL;
+
+/*
+	struct i2c_client *client = chip->client;
 	u16 als_it;
 	int ret, i, n;
 
@@ -190,6 +234,7 @@ static int cm32181_write_als_it(struct cm32181_chip *chip, int val)
 	mutex_unlock(&chip->lock);
 
 	return ret;
+*/
 }
 
 /**
@@ -204,26 +249,29 @@ static int cm32181_write_als_it(struct cm32181_chip *chip, int val)
 static int cm32181_get_lux(struct cm32181_chip *chip)
 {
 	struct i2c_client *client = chip->client;
+	struct cm32181_als_info *als_info = chip->als_info;
 	int ret;
+	int val, val2;
 	int als_it;
-	unsigned long lux;
+	u64 lux;
 
-	ret = cm32181_read_als_it(chip, &als_it);
+	ret = cm32181_read_als_it(chip, &val, &val2);
 	if (ret < 0)
 		return -EINVAL;
+	als_it = val * 1000000 + val2;
 
-	lux = CM32181_MLUX_PER_BIT;
-	lux *= CM32181_MLUX_PER_BIT_BASE_IT;
-	lux /= als_it;
+	lux = (__force u64)als_info->mlux_per_bit;
+	lux *= als_info->mlux_per_bit_base_it;
+	lux = div_u64(lux, als_it);
 
 	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
 	if (ret < 0)
 		return ret;
 
 	lux *= ret;
-	lux *= chip->als_info->calibscale;
-	lux /= CM32181_CALIBSCALE_RESOLUTION;
-	lux /= MLUX_PER_LUX;
+	lux *= als_info->calibscale;
+	lux = div_u64(lux, CM32181_CALIBSCALE_RESOLUTION);
+	lux = div_u64(lux, CM32181_MLUX_PER_LUX);
 
 	if (lux > 0xFFFF)
 		lux = 0xFFFF;
@@ -250,7 +298,7 @@ static int cm32181_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
-		ret = cm32181_read_als_it(chip, val2);
+		ret = cm32181_read_als_it(chip, val, val2);
 		return ret;
 	}
 
@@ -269,7 +317,7 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
 		chip->als_info->calibscale = val;
 		return val;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = cm32181_write_als_it(chip, val2);
+		ret = cm32181_write_als_it(chip, val, val2);
 		return ret;
 	}
 
@@ -289,12 +337,21 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
 static ssize_t cm32181_get_it_available(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
+	int i, len;
+
+	for (i = 0, len = 0; i < ARRAY_SIZE(cm32181_als_it_scales); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
+			cm32181_als_it_scales[i].val,
+			cm32181_als_it_scales[i].val2);
+	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
+/*
 	int i, n, len;
 
 	n = ARRAY_SIZE(als_it_value);
 	for (i = 0, len = 0; i < n; i++)
 		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
 	return len + sprintf(buf + len, "\n");
+*/
 }
 
 static const struct iio_chan_spec cm32181_channels[] = {
-- 
1.8.3.1

