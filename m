Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC53DFC61
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337180; cv=none; b=MiExtbL9SL0XZjUmy6KXUs8ewt/IBjJzB4UsxSVxFMg785LD27WbxF0llcHiOroAkK1Q+LdOLIDHglsRj8cl8mdtDxPEcutEAMebIGvkSf2LtJxsEOpilCRU1wrWjasP6rrCKUich6iegMEUptIngXQrQtmzpdP67zZHP1RUHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337180; c=relaxed/simple;
	bh=w3uKlEZDcTlP7XzOYKLmMSGLxzdQZUzts8upMb4ovRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdjYugZAC7FTQ+gKrj59WZ7yIdI/1wqzb97ZHbTOLPJkzH1J9g2VQYkiJWE+JKjBdjrgbiHCmwRHBujdfbW4jqIOL05q5M3qlbUAaTIcrHcZ2upZWIbPNkIGJ3NYkex+HQHzpGvQIw9+CBys2654MKbzP2GORdXkRLd8tpZ3OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR3ch3Up; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR3ch3Up"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39669bcaadfso33071791fa.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337177; x=1783941977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJNdrRIFxAQBh0lwpJuS7VrFtUEpkWefe6iS3IJz/7M=;
        b=FR3ch3UpkyD/lUJKtJOs/CN4sJC22Jo74ux6awP5G0/gSbKBwLSDqfPfcu1C7cjnzi
         1+IpOF8Vpzg2O00U9Y8vtdPKNlVZ6Kl0kofGTweB2VuSSDCctT2+W9H0K2WLwhX/ab3A
         2SoiLf9NawKRarzQvaIld16qtAyKBu4+YsDHT7DHqb8fnc/la8bbvUejb+XKpCy7J6eA
         fYrrASPiE8l8Ki9ohguTDrdFgAe3rI/al1HcSQJfiApdlX5KO9RZc339G1EyFoEE9Rev
         tBT+6mU9PbUoAKn2rERkx/83v73tp8T+dzggvDVorXb8TCL0YC+GXLsALhmgGvkWH28Q
         ASqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337177; x=1783941977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJNdrRIFxAQBh0lwpJuS7VrFtUEpkWefe6iS3IJz/7M=;
        b=OrU379f6roro6Unhk/TZ9tgatPOYMFnqbNFIqCCVWkKn12amnewQdk+1mAk6okuPan
         PlwJ+Baia9mhpteNI7TNnccwy+GB9gRo0wkI8WR58YuWQUb0F6k8ArXjfrBhQB/kGey2
         2ggEK+T7FsstQBOwZzKsxXRp5VjQAb6BpvSNg/gxFNNIfZOYvdkXQkJh+bOc9HFRw/Xv
         5PUXxGz4l2Mwz95wgwP/Sc0ABLKaNBs/orTzpw4H47ycpkvjPlwmdSCxzbslqFLm9ukF
         x2L17BJew4kBks38YIZmDDwypjI/UsJZlibGPitptDzKh91fVq65TkLxYLFYAGEYP5e3
         qUGw==
X-Gm-Message-State: AOJu0YwolOt6dh6peSz3fdKhT/eIt41cKULtRARnjk8u8y9XB74b4KOl
	hdeS9MAH/9I93CczCjjwqx4wGukd1/oH8DbvSatHuWoR7CUrfGpMslrOkT8mylXNviB8ig==
X-Gm-Gg: AfdE7cm9UuAEzId1OB6Kkt6gS26UxjsuxPhFx1Mu92fu2gRG4l3brbWQUClYekGuFo5
	GiSQzmbxiaTgjLkMSqWbpkZCu/AEtfwXq2OpyjZwoseWbtTtHqcazO8Jt2lveibVvjEGhjkLhj2
	hEV/9qlXasJ+FQhKjlShgKHQtM20aRARJx1rhkaQVWnmaReMhUhFhNH/O0JKAU8hlb3ZfRmXfXH
	jtuRZF3LNbjVf8PtCNn/Yo80LmB52NXk0k2dWGoejayGWht1RdGKC2DN6Ul5fbIOV3MP8ICZFwY
	IJstlxcAFZdrQiPR1ii04mYrJ0o+V6TSv2WAIOFXGlLHT8boQLYDIxLvfSYC/RDU+SZMj5WPhqd
	nWyLapaHTTTtnLN9ve9xIWNA3FRMNrzQ92hqEObjhAViyBTeOFZnzbroQsiouNTwniy7dtqKXK9
	DmTxHHMnOOqK5BXFjQ31ang/OMxFrkPwEfC38yp+AkgODMwA==
X-Received: by 2002:a05:6512:3b82:b0:5ae:bbaa:5156 with SMTP id 2adb3069b0e04-5aed50880a0mr1679580e87.24.1783337176523;
        Mon, 06 Jul 2026 04:26:16 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1377075sm2730755e87.28.2026.07.06.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:26:16 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: ti-ads1298: add ADS1299 EEG ADC family support
Date: Mon,  6 Jul 2026 14:26:14 +0300
Message-ID: <20260706112614.1262241-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706112614.1262241-1-shofiqtest@gmail.com>
References: <20260706112614.1262241-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299, ADS1299-4 and ADS1299-6 are 8/4/6-channel, 24-bit
biopotential (EEG) ADCs from Texas Instruments.  They share the same
SPI interface, command set and register map as the ADS1298 ECG family,
making it straightforward to support them in this driver.

Key differences from the ADS1298:
- PGA gain range is 1/2/4/6/8/12/24 (vs 6/1/2/3/4/8/12 for ADS1298)
- Internal voltage reference is always 2.4V (no 4V option)
- Channel count is encoded differently in the ID register: bits [4:3]
  identify the ADS1299 family (both bits set), bits [1:0] encode the
  channel count as (bits + 2) * 2

Detect the chip family in ads1298_init() by checking bits [4:3] of
the ID register.  Store the result in the is_ads1299 flag and use it
to select the correct PGA table in ads1298_get_scale() and to skip
the 4V reference option in the CONFIG3 initialisation.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 84 ++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 579200e06cbd6..7cff51d23d12f 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-/* TI ADS1298 chip family driver
+/* TI ADS1298/ADS1299 biopotential ADC driver
  * Copyright (C) 2023 - 2024 Topic Embedded Products
+ * Copyright (C) 2026 Md Shofiqul Islam <shofiqtest@gmail.com>
  */
 
 #include <linux/bitfield.h>
@@ -43,6 +44,20 @@
 #define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
 #define ADS1298_ID_FAMILY_ADS129X		0x90
 #define ADS1298_ID_FAMILY_ADS129XR		0xd0
+/*
+ * ADS1299 family is identified by bits [4:3] = 0b11.  Bits [7:5] encode
+ * the silicon revision and vary between production lots, so only bits [4:3]
+ * are checked for family identification.
+ */
+#define ADS1299_MASK_ID_FAMILY			GENMASK(4, 3)
+#define ADS1299_ID_FAMILY_EEG			GENMASK(4, 3)
+/*
+ * ADS1299 channel count is encoded in bits [1:0] of the ID register:
+ * 00 -> 4 channels (ADS1299-4)
+ * 01 -> 6 channels (ADS1299-6)
+ * 10 -> 8 channels (ADS1299)
+ */
+#define ADS1299_MASK_ID_CHANNELS		GENMASK(1, 0)
 
 #define ADS1298_REG_CONFIG1	0x01
 #define ADS1298_MASK_CONFIG1_HR			BIT(7)
@@ -101,6 +116,7 @@
 struct ads1298_private {
 	const struct ads1298_chip_info *chip_info;
 	struct spi_device *spi;
+	bool is_ads1299;
 	struct regulator *reg_avdd;
 	struct regulator *reg_vref;
 	struct clk *clk;
@@ -276,7 +292,10 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
 				  cfg);
 }
 
+/* ADS1298 PGA: register bits [6:4] -> gain (000=6, 001=1, 010=2, ...) */
 static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
+/* ADS1299 PGA: register bits [6:4] -> gain (000=1, 001=2, 010=4, ...) */
+static const u8 ads1299_pga_settings[] = { 1, 2, 4, 6, 8, 12, 24 };
 
 static int ads1298_get_scale(struct ads1298_private *priv,
 			     int channel, int *val, int *val2)
@@ -291,12 +310,15 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 			return ret;
 
 		*val = ret / MILLI; /* Convert to millivolts */
+	} else if (priv->is_ads1299) {
+		/* ADS1299 internal reference is always 2.4V */
+		*val = 2400;
 	} else {
 		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
 		if (ret)
 			return ret;
 
-		/* Reference in millivolts */
+		/* ADS1298 reference in millivolts: 2.4V or 4V */
 		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
 	}
 
@@ -304,7 +326,8 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 	if (ret)
 		return ret;
 
-	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
+	gain = (priv->is_ads1299 ? ads1299_pga_settings : ads1298_pga_settings)
+		[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
 	*val /= gain; /* Full scale is VREF / gain */
 
 	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
@@ -600,20 +623,39 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	/* Fill in name and channel count based on what the chip told us */
-	indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
-	switch (val & ADS1298_MASK_ID_FAMILY) {
-	case ADS1298_ID_FAMILY_ADS129X:
-		suffix = "";
-		break;
-	case ADS1298_ID_FAMILY_ADS129XR:
-		suffix = "r";
-		break;
-	default:
-		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
+	/*
+	 * Detect chip family from the ID register.  The ADS1299 EEG family
+	 * is identified by bits [4:3] = 0b11; the ADS1298 ECG family uses
+	 * bits [7:3] for family identification.
+	 */
+	if (FIELD_GET(ADS1299_MASK_ID_FAMILY, val) == ADS1299_ID_FAMILY_EEG) {
+		/*
+		 * ADS1299 family: channel count from bits [1:0].
+		 * 00 -> 4ch, 01 -> 6ch, 10 -> 8ch.
+		 */
+		priv->is_ads1299 = true;
+		indio_dev->num_channels =
+			(FIELD_GET(ADS1299_MASK_ID_CHANNELS, val) + 2) * 2;
+		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299%s",
+			indio_dev->num_channels == 4 ? "-4" :
+			indio_dev->num_channels == 6 ? "-6" : "");
+	} else {
+		/* ADS1298 family: channel count from bits [2:0], name from family */
+		indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
+		switch (val & ADS1298_MASK_ID_FAMILY) {
+		case ADS1298_ID_FAMILY_ADS129X:
+			suffix = "";
+			break;
+		case ADS1298_ID_FAMILY_ADS129XR:
+			suffix = "r";
+			break;
+		default:
+			return dev_err_probe(dev, -ENODEV,
+					     "Unknown ID: 0x%x\n", val);
+		}
+		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
+						 indio_dev->num_channels, suffix);
 	}
-	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
-					 indio_dev->num_channels, suffix);
 	if (!indio_dev->name)
 		return -ENOMEM;
 
@@ -621,8 +663,9 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!priv->reg_vref) {
 		/* Enable internal reference */
 		val |= ADS1298_MASK_CONFIG3_PWR_REFBUF;
-		/* Use 4V VREF when power supply is at least 4.4V */
-		if (regulator_get_voltage(priv->reg_avdd) >= 4400000)
+		/* ADS1298 only: use 4V VREF when supply is at least 4.4V */
+		if (!priv->is_ads1299 &&
+		    regulator_get_voltage(priv->reg_avdd) >= 4400000)
 			val |= ADS1298_MASK_CONFIG3_VREF_4V;
 	}
 	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
@@ -739,12 +782,14 @@ static int ads1298_probe(struct spi_device *spi)
 
 static const struct spi_device_id ads1298_id[] = {
 	{ "ads1298" },
+	{ "ads1299" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ads1298_id);
 
 static const struct of_device_id ads1298_of_table[] = {
 	{ .compatible = "ti,ads1298" },
+	{ .compatible = "ti,ads1299" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads1298_of_table);
@@ -760,5 +805,6 @@ static struct spi_driver ads1298_driver = {
 module_spi_driver(ads1298_driver);
 
 MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
-MODULE_DESCRIPTION("TI ADS1298 ADC");
+MODULE_AUTHOR("Md Shofiqul Islam <shofiqtest@gmail.com>");
+MODULE_DESCRIPTION("TI ADS1298/ADS1299 biopotential ADC");
 MODULE_LICENSE("GPL");
-- 
2.51.1

