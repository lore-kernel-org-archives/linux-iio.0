Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35679 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbeGTSYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jul 2018 14:24:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so10608112wma.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Jul 2018 10:34:49 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: jic23@jic23.retrosnub.co.uk, linux-iio@vger.kernel.org
Cc: jonathan.cameron@huawei.com, pmeerw@pmeerw.net,
        pierre-moana.levesque@parrot.com,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 3/3] iio: light: isl29501: Add support floating registers.
Date: Fri, 20 Jul 2018 19:34:27 +0200
Message-Id: <20180720173427.30445-4-m.othacehe@gmail.com>
In-Reply-To: <20180720173427.30445-1-m.othacehe@gmail.com>
References: <20180720173427.30445-1-m.othacehe@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is work in progress. A new IIO ABI allowing floating value read and
write through sysfs has to be defined first.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/isl29501.c | 121 ++++++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/isl29501.c b/drivers/iio/light/isl29501.c
index ea4a2ced1004..8698b7caee9b 100644
--- a/drivers/iio/light/isl29501.c
+++ b/drivers/iio/light/isl29501.c
@@ -112,11 +112,17 @@ struct isl29501_private {
 
 enum isl29501_register_name {
 	REG_DISTANCE,
+	REG_AMPLITUDE,
 	REG_PHASE,
+	REG_I_RAW,
+	REG_Q_RAW,
 	REG_TEMPERATURE,
 	REG_AMBIENT_LIGHT,
 	REG_GAIN,
+	REG_I_BIAS,
+	REG_Q_BIAS,
 	REG_GAIN_BIAS,
+	REG_AMPL_BIAS,
 	REG_PHASE_EXP,
 	REG_CALIB_PHASE_TEMP_A,
 	REG_CALIB_PHASE_TEMP_B,
@@ -133,6 +139,7 @@ enum isl29501_register_name {
 struct isl29501_register_desc {
 	u8 msb;
 	u8 lsb;
+	u8 exp;
 };
 
 static const struct isl29501_register_desc isl29501_registers[] = {
@@ -140,10 +147,25 @@ static const struct isl29501_register_desc isl29501_registers[] = {
 		.msb = ISL29501_DISTANCE_MSB_DATA,
 		.lsb = ISL29501_DISTANCE_LSB_DATA,
 	},
+	[REG_AMPLITUDE] = {
+		.msb = ISL29501_MAGNITUDE_MSB,
+		.lsb = ISL29501_MAGNITUDE_LSB,
+		.exp = ISL29501_MAGNITUDE_EXPONENT,
+	},
 	[REG_PHASE] = {
 		.msb = ISL29501_PHASE_MSB,
 		.lsb = ISL29501_PHASE_LSB,
 	},
+	[REG_I_RAW] = {
+		.msb = ISL29501_I_RAW_MSB,
+		.lsb = ISL29501_I_RAW_LSB,
+		.exp = ISL29501_I_RAW_EXPONENT,
+	},
+	[REG_Q_RAW] = {
+		.msb = ISL29501_Q_RAW_MSB,
+		.lsb = ISL29501_Q_RAW_LSB,
+		.exp = ISL29501_Q_RAW_EXPONENT,
+	},
 	[REG_TEMPERATURE] = {
 		.lsb = ISL29501_DIE_TEMPERATURE,
 	},
@@ -154,10 +176,25 @@ static const struct isl29501_register_desc isl29501_registers[] = {
 		.msb = ISL29501_GAIN_MSB,
 		.lsb = ISL29501_GAIN_LSB,
 	},
+	[REG_I_BIAS] = {
+		.msb = ISL29501_CROSSTALK_I_MSB,
+		.lsb = ISL29501_CROSSTALK_I_LSB,
+		.exp = ISL29501_CROSSTALK_I_EXPONENT,
+	},
+	[REG_Q_BIAS] = {
+		.msb = ISL29501_CROSSTALK_Q_MSB,
+		.lsb = ISL29501_CROSSTALK_Q_LSB,
+		.exp = ISL29501_CROSSTALK_Q_EXPONENT,
+	},
 	[REG_GAIN_BIAS] = {
 		.msb = ISL29501_CROSSTALK_GAIN_MSB,
 		.lsb = ISL29501_CROSSTALK_GAIN_LSB,
 	},
+	[REG_AMPL_BIAS] = {
+		.msb = ISL29501_MAGNITUDE_REF_MSB,
+		.lsb = ISL29501_MAGNITUDE_REF_LSB,
+		.exp = ISL29501_MAGNITUDE_REF_EXP,
+	},
 	[REG_PHASE_EXP] = {
 		.lsb = ISL29501_PHASE_EXPONENT,
 	},
@@ -199,7 +236,7 @@ static int isl29501_register_read(struct isl29501_private *isl29501,
 				  u32 *val)
 {
 	const struct isl29501_register_desc *reg = &isl29501_registers[name];
-	u8 msb = 0, lsb = 0;
+	u8 msb = 0, lsb = 0, exp = 0;
 	s32 ret;
 
 	mutex_lock(&isl29501->lock);
@@ -216,9 +253,16 @@ static int isl29501_register_read(struct isl29501_private *isl29501,
 			goto err;
 		lsb = ret;
 	}
+
+	if (reg->exp) {
+		ret = i2c_smbus_read_byte_data(isl29501->client, reg->exp);
+		if (ret < 0)
+			goto err;
+		exp = ret;
+	}
 	mutex_unlock(&isl29501->lock);
 
-	*val = (msb << 8) + lsb;
+	*val = ((msb << 8) + lsb) << exp;
 
 	return 0;
 err:
@@ -238,9 +282,14 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 	if (!reg->msb && value > U8_MAX)
 		return -ERANGE;
 
-	if (value > U16_MAX)
+	if (!reg->exp && value > U16_MAX)
 		return -ERANGE;
 
+	if (reg->exp) {
+		/* TODO: Implement float write */
+		return -EINVAL;
+	}
+
 	if (!reg->msb) {
 		lsb = value & 0xFF;
 	} else {
@@ -519,6 +568,28 @@ static const struct iio_chan_spec isl29501_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				BIT(IIO_CHAN_INFO_SCALE),
 	},
+	{
+		.type = IIO_INTENSITY,
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.scan_index = -1,
+		.modified = 1,
+		.channel2 = IIO_MOD_I,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.scan_index = -1,
+		.modified = 1,
+		.channel2 = IIO_MOD_Q,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
 	{
 		.type = IIO_CURRENT,
 		.scan_index = -1,
@@ -633,13 +704,23 @@ static int isl29501_get_raw(struct isl29501_private *isl29501,
 
 		return IIO_VAL_INT;
 	case IIO_INTENSITY:
-		ret = isl29501_register_read(isl29501,
-					     REG_AMBIENT_LIGHT,
-					     raw);
-		if (ret < 0)
-			return ret;
+		switch (chan->channel2) {
+		case IIO_NO_MOD:
+		case IIO_MOD_I:
+		case IIO_MOD_Q:
+			/* TODO: implement float read */
+			return -EINVAL;
+		case IIO_MOD_LIGHT_CLEAR:
+			ret = isl29501_register_read(isl29501,
+						     REG_AMBIENT_LIGHT,
+						     raw);
+			if (ret < 0)
+				return ret;
 
-		return IIO_VAL_INT;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_PHASE:
 		ret = isl29501_register_read(isl29501, REG_PHASE, raw);
 		if (ret < 0)
@@ -684,6 +765,8 @@ static int isl29501_get_scale(struct isl29501_private *isl29501,
 
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_INTENSITY:
+		if (chan->channel2 != IIO_MOD_LIGHT_CLEAR)
+			return -EINVAL;
 		/* light = raw_light * 35 / 10000 (mA) */
 		*val = 35;
 		*val2 = 10000;
@@ -729,6 +812,16 @@ static int isl29501_get_calibbias(struct isl29501_private *isl29501,
 		return isl29501_register_read(isl29501,
 					      REG_DISTANCE_BIAS,
 					      bias);
+	case IIO_INTENSITY:
+		switch (chan->channel2) {
+		case IIO_NO_MOD:
+		case IIO_MOD_I:
+		case IIO_MOD_Q:
+			/* TODO: Implement float read */
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
 	case IIO_TEMP:
 		return isl29501_register_read(isl29501,
 					      REG_TEMPERATURE_BIAS,
@@ -858,6 +951,16 @@ static int isl29501_set_calibbias(struct isl29501_private *isl29501,
 		return isl29501_register_write(isl29501,
 					      REG_DISTANCE_BIAS,
 					      bias);
+	case IIO_INTENSITY:
+		switch (chan->channel2) {
+		case IIO_NO_MOD:
+		case IIO_MOD_I:
+		case IIO_MOD_Q:
+			/* TODO: Implement float read */
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
 	case IIO_TEMP:
 		return isl29501_register_write(isl29501,
 					       REG_TEMPERATURE_BIAS,
-- 
2.17.1

