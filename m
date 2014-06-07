Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43264 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbaFGPbr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 03/13] iio:adc:ad799x: Drop I2C access helper functions
Date: Sat,  7 Jun 2014 17:31:27 +0200
Message-Id: <1402155097-435-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 119 +++++++++++------------------------------------
 1 file changed, 26 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b250651..d1ba99b 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -175,65 +175,6 @@ out:
 	return IRQ_HANDLED;
 }
 
-/*
- * ad799x register access by I2C
- */
-static int ad799x_i2c_read16(struct ad799x_state *st, u8 reg, u16 *data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_read_word_swapped(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = (u16)ret;
-
-	return 0;
-}
-
-static int ad799x_i2c_read8(struct ad799x_state *st, u8 reg, u8 *data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_read_byte_data(client, reg);
-	if (ret < 0) {
-		dev_err(&client->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = (u8)ret;
-
-	return 0;
-}
-
-static int ad799x_i2c_write16(struct ad799x_state *st, u8 reg, u16 data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_word_swapped(client, reg, data);
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
-static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8 data)
-{
-	struct i2c_client *client = st->client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_byte_data(client, reg, data);
-	if (ret < 0)
-		dev_err(&client->dev, "I2C write error\n");
-
-	return ret;
-}
-
 static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
@@ -249,7 +190,7 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 	switch (st->id) {
 	case ad7997:
 	case ad7998:
-		return ad799x_i2c_write16(st, AD7998_CONF_REG,
+		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
 			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
 	default:
 		break;
@@ -260,9 +201,7 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 
 static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 {
-	u16 rxbuf;
 	u8 cmd;
-	int ret;
 
 	switch (st->id) {
 	case ad7991:
@@ -283,11 +222,7 @@ static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 		return -EINVAL;
 	}
 
-	ret = ad799x_i2c_read16(st, cmd, &rxbuf);
-	if (ret < 0)
-		return ret;
-
-	return rxbuf;
+	return i2c_smbus_read_word_swapped(st->client, cmd);
 }
 
 static int ad799x_read_raw(struct iio_dev *indio_dev,
@@ -332,6 +267,7 @@ static const unsigned int ad7998_frequencies[] = {
 	[AD7998_CYC_TCONF_1024]	= 488,
 	[AD7998_CYC_TCONF_2048]	= 244,
 };
+
 static ssize_t ad799x_read_frequency(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -339,15 +275,11 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	int ret;
-	u8 val;
-	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &val);
-	if (ret)
+	int ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+	if (ret < 0)
 		return ret;
 
-	val &= AD7998_CYC_MASK;
-
-	return sprintf(buf, "%u\n", ad7998_frequencies[val]);
+	return sprintf(buf, "%u\n", ad7998_frequencies[ret & AD7998_CYC_MASK]);
 }
 
 static ssize_t ad799x_write_frequency(struct device *dev,
@@ -360,18 +292,17 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 
 	long val;
 	int ret, i;
-	u8 t;
 
 	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &t);
-	if (ret)
+	ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+	if (ret < 0)
 		goto error_ret_mutex;
 	/* Wipe the bits clean */
-	t &= ~AD7998_CYC_MASK;
+	ret &= ~AD7998_CYC_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ad7998_frequencies); i++)
 		if (val == ad7998_frequencies[i])
@@ -380,13 +311,17 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 		ret = -EINVAL;
 		goto error_ret_mutex;
 	}
-	t |= i;
-	ret = ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
+
+	ret = i2c_smbus_write_byte_data(st->client, AD7998_CYCLE_TMR_REG,
+		ret | i);
+	if (ret < 0)
+		goto error_ret_mutex;
+	ret = len;
 
 error_ret_mutex:
 	mutex_unlock(&indio_dev->mlock);
 
-	return ret ? ret : len;
+	return ret;
 }
 
 static int ad799x_read_event_config(struct iio_dev *indio_dev,
@@ -427,7 +362,8 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
+	ret = i2c_smbus_write_word_swapped(st->client,
+		ad799x_threshold_reg(chan, dir, info),
 		(val & RES_MASK(chan->scan_type.realbits))
 			<< chan->scan_type.shift);
 	mutex_unlock(&indio_dev->mlock);
@@ -444,15 +380,14 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	u16 valin;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_read16(st, ad799x_threshold_reg(chan, dir, info),
-		&valin);
+	ret = i2c_smbus_read_word_swapped(st->client,
+		ad799x_threshold_reg(chan, dir, info));
 	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
-	*val = (valin >> chan->scan_type.shift) &
+	*val = (ret >> chan->scan_type.shift) &
 		RES_MASK(chan->scan_type.realbits);
 
 	return IIO_VAL_INT;
@@ -462,20 +397,18 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct ad799x_state *st = iio_priv(private);
-	u8 status;
 	int i, ret;
 
-	ret = ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status);
-	if (ret)
+	ret = i2c_smbus_read_byte_data(st->client, AD7998_ALERT_STAT_REG);
+	if (ret <= 0)
 		goto done;
 
-	if (!status)
+	if (i2c_smbus_write_byte_data(st->client, AD7998_ALERT_STAT_REG,
+		AD7998_ALERT_STAT_CLEAR) < 0)
 		goto done;
 
-	ad799x_i2c_write8(st, AD7998_ALERT_STAT_REG, AD7998_ALERT_STAT_CLEAR);
-
 	for (i = 0; i < 8; i++) {
-		if (status & (1 << i))
+		if (ret & (1 << i))
 			iio_push_event(indio_dev,
 				       i & 0x1 ?
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-- 
1.9.1

