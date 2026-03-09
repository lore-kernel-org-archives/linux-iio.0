Received: from ilama.link.melty.land (mail.melty.land [45.77.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA040F8DF
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085062; cv=none; b=ISs6Y3HezjoppnK9/ZLYnYlgV5ZDaXikwAIjRp/1OaIlTcUhrDO5VAPwGxPSivDOC9hoxKDMTmuPMIs/uYWawEw4SlXHzyWCd6GOXGEKmkuiXuwQkE8CIQZR1MLGGOjcmFCTsH8wP2zSVvoqW7uyKZGXtuSqpkH2oDaIDHlYutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085062; c=relaxed/simple;
	bh=kiSIWQIAmw2OlE6S6XMc508Z99ZfCXkZsKxX51xnAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnIF89H1cL2hw1mSygBhGxFsXRY2dnQzUmI0PbNTIcPSOldBxYk7KYCDlwoWhFGK4yCZVjcRpCcILdP9Lr1Uduj0HU0ConRBr+UGmbUVxiUONFbrEBRflOPI7CgdY7zfzmRhUHLpADEfsO/uBScYXTMLT+nr3DAQoU9Kl1OqWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz; spf=pass smtp.mailfrom=chuang.cz; dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b=vID3GPAp; arc=none smtp.client-ip=45.77.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chuang.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chuang.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chuang.cz header.i=@chuang.cz header.b="vID3GPAp"
Received: from hawthorn (hawthorn.chuang [192.168.174.5])
	by ilama.link.melty.land (Postfix) with ESMTPSA id 6BC22A19D35;
	Tue, 10 Mar 2026 03:30:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chuang.cz; s=default;
	t=1773084637; bh=kiSIWQIAmw2OlE6S6XMc508Z99ZfCXkZsKxX51xnAaA=;
	h=From:To:Cc:Subject:Date;
	b=vID3GPApEIEdMdsBjzy3bcFNeKn5JEISvHd01lO6rkDVIXdY8WyiOy7adwlPoeaV0
	 80/aCqWpFAFqyHM1Ei7sv5Xt0IAelp/t5srWgoZ+TV8+igjiF0hSsdyyK3DT/2qB86
	 m/mWJtoVJR1i9VPARRddk08n5G7i6BNyX0AHeNfM=
From: Chuang Zhu <git@chuang.cz>
To: linux-iio@vger.kernel.org
Cc: Marc Titinger <mtitinger@baylibre.com>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Chuang Zhu <git@chuang.cz>
Subject: [PATCH] iio: adc: ina2xx: add INA236 support
Date: Tue, 10 Mar 2026 03:29:27 +0800
Message-ID: <20260309192927.478439-1-git@chuang.cz>
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

