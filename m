Received: from ilama.link.melty.land (mail.melty.land [45.77.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A41D61BC
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773599020; cv=none; b=lWV/4oUHRRzYkV0CYId+wovxy2XfHVuHstF7tfUIF9qj6fqfqdoRWFt4bcEl/0SV5QfBnnwe5tLkulkQ4FsQP5wreiMTvrvKoIfJylMWARZ91L5/5YE7IHnaWgElkl2BraeXJrr2ondoxh2iclyfqBejD5KLaYBbZBRqcweF6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773599020; c=relaxed/simple;
	bh=wqODPaJA3f/EvU265jyKR/7EtO6nlCji3DnkVU+csls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT6GCtERk3gpMDECgtRKamsxl8xP6mzky/D3riUe1nDWvIlixGaNVFDiWGlZuWi1clUEKY+mzHLMHYbAH9L436CpT19F1U7m3W8e2Rz4ugyMUm+cziEpqi97Sk6xOygES+YJ1+uBFBSjGpGRl2ar1kAmt+AM090FM5cpuHmxDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz; spf=pass smtp.mailfrom=chuang.cz; dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b=Y0vrKqD7; arc=none smtp.client-ip=45.77.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chuang.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b="Y0vrKqD7"
Received: from hawthorn.lan (unknown [IPv6:240e:3b1:d0b1:ff90:d706:1c39:3aea:659c])
	by ilama.link.melty.land (Postfix) with ESMTPSA id 8A5AFA7A0EA;
	Mon, 16 Mar 2026 02:23:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chuang.cz; s=default;
	t=1773599011; bh=wqODPaJA3f/EvU265jyKR/7EtO6nlCji3DnkVU+csls=;
	h=From:To:Cc:Subject:Date;
	b=Y0vrKqD7b9NeR2aBE9lxsHbq/G9JrzyQSEpZkfmbIfSXrgrQE+R4VzbmM0NP7KRW5
	 5EPufmYmEnNAd5w2KA/ghZqyDZP6EbbGh/nrXz+rn1tkerdDvvvRLzIDI6kPWVZtFj
	 NLLLXhTVJ38BKckHq1D6JcCdckJNMY56LNhnt4kQ=
From: Chuang Zhu <git@chuang.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marc Titinger <mtitinger@baylibre.com>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Chuang Zhu <git@chuang.cz>
Subject: [PATCH v3] iio: adc: ina2xx: add INA236 support
Date: Mon, 16 Mar 2026 02:23:04 +0800
Message-ID: <20260315182304.613783-1-git@chuang.cz>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calibration divisor is not directly specified in the datasheet, but can be calculated:

I = Current_LSB * Current
Current = ShuntVoltage * CAL / calibration_divisor
CAL = 0.00512 / (Current_LSB * Rshunt)
ShuntVoltage = Vshunt / ShuntVoltage_LSB

=> I = (0.00512 / (calibration_divisor*ShuntVoltage_LSB)) * (Vshunt / Rshunt)

Ohm's law, I = Vshunt / Rshunt
=> 0.00512 / (calibration_divisor*ShuntVoltage_LSB) = 1

ShuntVoltage_LSB = 2.5 uV = 0.0000025 V
=> calibration_divisor = 2048

Signed-off-by: Chuang Zhu <git@chuang.cz>
---
 drivers/iio/adc/ina2xx-adc.c | 57 ++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 857e1b69d6cd..6a4ee833d12c 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -121,7 +121,7 @@ static const struct regmap_config ina2xx_regmap_config = {
 	.volatile_reg = ina2xx_is_volatile_reg,
 };
 
-enum ina2xx_ids { ina219, ina226 };
+enum ina2xx_ids { ina219, ina226, ina236 };
 
 struct ina2xx_config {
 	const char *name;
@@ -175,6 +175,16 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.power_lsb_factor = 25,
 		.chip_id = ina226,
 	},
+	[ina236] = {
+		.name = "ina236",
+		.config_default = INA226_CONFIG_DEFAULT,
+		.calibration_value = 2048,
+		.shunt_voltage_lsb = 2500,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1600,
+		.power_lsb_factor = 32,
+		.chip_id = ina236,
+	},
 };
 
 static int ina2xx_read_raw(struct iio_dev *indio_dev,
@@ -499,20 +509,26 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chip->config->chip_id == ina226) {
+		switch (chip->config->chip_id) {
+		case ina226:
+		case ina236:
 			if (chan->address == INA2XX_SHUNT_VOLTAGE)
 				ret = ina226_set_int_time_vshunt(chip, val2,
 								 &tmp);
 			else
 				ret = ina226_set_int_time_vbus(chip, val2,
 							       &tmp);
-		} else {
+			break;
+		case ina219:
 			if (chan->address == INA2XX_SHUNT_VOLTAGE)
 				ret = ina219_set_int_time_vshunt(chip, val2,
 								 &tmp);
 			else
 				ret = ina219_set_int_time_vbus(chip, val2,
 							       &tmp);
+			break;
+		default:
+			ret = -EINVAL;
 		}
 		break;
 
@@ -727,14 +743,20 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
 	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
 	 * resp. the BUS_VOLTAGE register (INA219).
 	 */
-	if (chip->config->chip_id == ina226) {
+	switch (chip->config->chip_id) {
+	case ina226:
+	case ina236:
 		ret = regmap_read(chip->regmap,
 				  INA226_MASK_ENABLE, &alert);
 		alert &= INA226_CVRF;
-	} else {
+		break;
+	case ina219:
 		ret = regmap_read(chip->regmap,
 				  INA2XX_BUS_VOLTAGE, &alert);
 		alert &= INA219_CNVR;
+		break;
+	default:
+		ret = -EINVAL;
 	}
 
 	if (ret < 0)
@@ -998,16 +1020,22 @@ static int ina2xx_probe(struct i2c_client *client)
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
-	if (type == ina226) {
+	switch (type) {
+	case ina226:
+	case ina236:
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
 		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
 		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
-	} else {
+		break;
+	case ina219:
 		chip->avg = 1;
 		ina219_set_int_time_vbus(chip, INA219_DEFAULT_IT, &val);
 		ina219_set_int_time_vshunt(chip, INA219_DEFAULT_IT, &val);
 		ina219_set_vbus_range_denom(chip, INA219_DEFAULT_BRNG, &val);
 		ina219_set_vshunt_pga_gain(chip, INA219_DEFAULT_PGA, &val);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = ina2xx_init(chip, val);
@@ -1017,14 +1045,20 @@ static int ina2xx_probe(struct i2c_client *client)
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (type == ina226) {
+	switch (type) {
+	case ina226:
+	case ina236:
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
 		indio_dev->info = &ina226_info;
-	} else {
+		break;
+	case ina219:
 		indio_dev->channels = ina219_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
+		break;
+	default:
+		return -EINVAL;
 	}
 	indio_dev->name = id ? id->name : chip->config->name;
 
@@ -1057,6 +1091,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
+	{ "ina236", ina236 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -1082,6 +1117,10 @@ static const struct of_device_id ina2xx_of_match[] = {
 		.compatible = "ti,ina231",
 		.data = (void *)ina226
 	},
+	{
+		.compatible = "ti,ina236",
+		.data = (void *)ina236
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
-- 
2.51.2

