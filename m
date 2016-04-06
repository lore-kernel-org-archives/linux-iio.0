Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34018 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760262AbcDFFT2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 01:19:28 -0400
Date: Tue, 5 Apr 2016 22:19:25 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 6/9] iio: accel: mxc4005: use regmap to retrieve struct device
Message-ID: <765e752b36e9b809217ed15aad75efb9593f22ce.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver includes struct regmap and struct device in its global data.
Remove the struct device and use regmap API to retrieve device info.

Patch created using Coccinelle plus manual edits.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/accel/mxc4005.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index c23f47a..013d511 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -60,7 +60,6 @@ enum mxc4005_range {
 };
 
 struct mxc4005_data {
-	struct device *dev;
 	struct mutex mutex;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
@@ -140,12 +139,13 @@ static const struct regmap_config mxc4005_regmap_config = {
 
 static int mxc4005_read_xyz(struct mxc4005_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
 			       (u8 *) data->buffer, sizeof(data->buffer));
 	if (ret < 0) {
-		dev_err(data->dev, "failed to read axes\n");
+		dev_err(dev, "failed to read axes\n");
 		return ret;
 	}
 
@@ -155,12 +155,13 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
 static int mxc4005_read_axis(struct mxc4005_data *data,
 			     unsigned int addr)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	__be16 reg;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, addr, (u8 *) &reg, sizeof(reg));
 	if (ret < 0) {
-		dev_err(data->dev, "failed to read reg %02x\n", addr);
+		dev_err(dev, "failed to read reg %02x\n", addr);
 		return ret;
 	}
 
@@ -169,13 +170,14 @@ static int mxc4005_read_axis(struct mxc4005_data *data,
 
 static int mxc4005_read_scale(struct mxc4005_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int reg;
 	int ret;
 	int i;
 
 	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &reg);
 	if (ret < 0) {
-		dev_err(data->dev, "failed to read reg_control\n");
+		dev_err(dev, "failed to read reg_control\n");
 		return ret;
 	}
 
@@ -189,6 +191,7 @@ static int mxc4005_read_scale(struct mxc4005_data *data)
 
 static int mxc4005_set_scale(struct mxc4005_data *data, int val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int reg;
 	int i;
 	int ret;
@@ -201,8 +204,7 @@ static int mxc4005_set_scale(struct mxc4005_data *data, int val)
 						 MXC4005_REG_CONTROL_MASK_FSR,
 						 reg);
 			if (ret < 0)
-				dev_err(data->dev,
-					"failed to write reg_control\n");
+				dev_err(dev, "failed to write reg_control\n");
 			return ret;
 		}
 	}
@@ -321,13 +323,14 @@ err:
 
 static int mxc4005_clr_intr(struct mxc4005_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	/* clear interrupt */
 	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
 			   MXC4005_REG_INT_CLR1_BIT_DRDYC);
 	if (ret < 0) {
-		dev_err(data->dev, "failed to write to reg_int_clr1\n");
+		dev_err(dev, "failed to write to reg_int_clr1\n");
 		return ret;
 	}
 
@@ -339,6 +342,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mxc4005_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	mutex_lock(&data->mutex);
@@ -352,7 +356,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
-		dev_err(data->dev, "failed to update reg_int_mask1");
+		dev_err(dev, "failed to update reg_int_mask1");
 		return ret;
 	}
 
@@ -381,16 +385,17 @@ static const struct iio_trigger_ops mxc4005_trigger_ops = {
 
 static int mxc4005_chip_init(struct mxc4005_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	unsigned int reg;
 
 	ret = regmap_read(data->regmap, MXC4005_REG_DEVICE_ID, &reg);
 	if (ret < 0) {
-		dev_err(data->dev, "failed to read chip id\n");
+		dev_err(dev, "failed to read chip id\n");
 		return ret;
 	}
 
-	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
+	dev_dbg(dev, "MXC4005 chip id %02x\n", reg);
 
 	return 0;
 }
@@ -415,7 +420,6 @@ static int mxc4005_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->dev = &client->dev;
 	data->regmap = regmap;
 
 	ret = mxc4005_chip_init(data);
-- 
2.1.4

