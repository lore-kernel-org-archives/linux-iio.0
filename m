Received: from ilama.link.melty.land (mail.melty.land [45.77.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34640F8DA
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085079; cv=none; b=EH/eaIqIf56xt16j03ZAMUHA5NL9RaeALr8QSUcoxQP86CtpEDeCdNZYjbCOcfUeBBUBeoqRdql18i4OtrVmgZnBOj0c4UYKuuGsbMUZ9B5CxbCYKCuuTbYQ2CfV/HCiVdTC7PCdwNGNPTxE0/CiEfMqkK3QFLwE0ja1Qwi8xGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085079; c=relaxed/simple;
	bh=v1j1iua1wCZEZfJA6ozTETwJJAGkI6lKLERU9nywzus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWBWZKe1sV4Q2pruAOXVYoUf+VuhOz6zzwIMbBqKeXobSyNXy9vwSKIZbiVuWU32pQl4h0wx581rLw4vCf2vIjAOD6PxB4B090DSlGdSUAEu1OW0D00QwHajaYmxsVPSmLN4F0y7Rkc2cXKi4Q1AmPhyNA+4gzk7jnlhoO48p6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz; spf=pass smtp.mailfrom=chuang.cz; dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b=lFXrtinB; arc=none smtp.client-ip=45.77.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chuang.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b="lFXrtinB"
Received: from hawthorn (hawthorn.chuang [192.168.174.5])
	by ilama.link.melty.land (Postfix) with ESMTPSA id 6FDC1A19D51;
	Tue, 10 Mar 2026 03:37:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chuang.cz; s=default;
	t=1773085076; bh=v1j1iua1wCZEZfJA6ozTETwJJAGkI6lKLERU9nywzus=;
	h=From:To:Cc:Subject:Date;
	b=lFXrtinB167seh3RE4xwYTlPZlaUQIFX4HW+9TdGZ5cNrk49FZMXWQbl9cBkDv/c9
	 YmsBdptL1+gu5weGZu+ez59zFD3ZWClNAd3olJYRjy8Z608QPO2KdF5MIn689J6G4P
	 Q3+j8SMSQL0wMXOXh3P8bn9J3qF1zCTip6+eD0Ic=
From: Chuang Zhu <git@chuang.cz>
To: linux-iio@vger.kernel.org
Cc: Marc Titinger <mtitinger@baylibre.com>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Chuang Zhu <git@chuang.cz>
Subject: [PATCH v2] iio: adc: ina2xx: add INA236 support
Date: Tue, 10 Mar 2026 03:37:42 +0800
Message-ID: <20260309193742.479883-1-git@chuang.cz>
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
 drivers/iio/adc/ina2xx-adc.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 857e1b69d6cd4..4e421f91f707f 100644
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
@@ -499,7 +509,7 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chip->config->chip_id == ina226) {
+		if (chip->config->chip_id != ina219) {
 			if (chan->address == INA2XX_SHUNT_VOLTAGE)
 				ret = ina226_set_int_time_vshunt(chip, val2,
 								 &tmp);
@@ -727,7 +737,7 @@ static int ina2xx_conversion_ready(struct iio_dev *indio_dev)
 	 * For now, we do an extra read of the MASK_ENABLE register (INA226)
 	 * resp. the BUS_VOLTAGE register (INA219).
 	 */
-	if (chip->config->chip_id == ina226) {
+	if (chip->config->chip_id != ina219) {
 		ret = regmap_read(chip->regmap,
 				  INA226_MASK_ENABLE, &alert);
 		alert &= INA226_CVRF;
@@ -998,7 +1008,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
-	if (type == ina226) {
+	if (type != ina219) {
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
 		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
 		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
@@ -1017,7 +1027,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (type == ina226) {
+	if (type != ina219) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
 		indio_dev->info = &ina226_info;
@@ -1057,6 +1067,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
+	{ "ina236", ina236 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -1082,6 +1093,10 @@ static const struct of_device_id ina2xx_of_match[] = {
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

