Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883669;
	b=uGj0SJQk980VdrSajqAkiJQpPzsnTYt8f0CRhJnjAlFae9JI/vMGAbFfAfzf9xSu1Bdz
	 lQuN9DEBFBhlXBfHddlfzq+SdumuqLhcr6mSh2CCxOZIO8okcmweODpi9cZd6UPjAbw0H
	 h2dl9tKp1JtL6fLEh/qF59j9Ab6Cv+MPk7z180SCdbg+VZ6iOyMog9vFjSYjfKEGkspJG
	 Vp5YxlZATgzsokotPWeA2lyhu9VgkRuB+I5l5kFL4EdgDVXpH2WYyZg/uoBgaFv1JKKhm
	 GG6s3m4BkqLwVe3td518EEsaXMJU249Hv+ph5rv6CQYkJ+htOB/DR7AEO5MYtqB0w/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O0Hxp+Z6Z20A4q/acm/GtdnoKxJONqcI68/yotG+5rc=;
	b=4UqroTFdUJaVFoKJBcFcQN+OKqReginWW7fjEnw4i11XVHpKggbBBHpjpaXG8fawVWpm
	 /R/edz3HMcsHqm7CeX8oyED9TRGesikU/FreIvuvz34TMHOsdIvSB0froelaHzM+xEnSv
	 +xwU/x6umlhuNibSZfcPwAgHtM2jS9kcVDnCjxbEJxg9SaAnU2g6XrM0wAm5cnvvzIHx9
	 1Pqv5JTYTjR3FEvVMSdOoyOq7K6KTzGZeshXhpUQJ1lMNRU5V93KQksYdXm5qLyzqESlj
	 Q/WEoLhcMdKTmCbOd7xE48Rdie+HrV2pbxNdk1f6Trasqzyz7K1eaLXwmDe9sx2gjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HxNgrnWQ;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3DB606A320
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 23:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C3DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HxNgrnWQ
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eafa528803so678218e0c.1
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883667; x=1793488467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0Hxp+Z6Z20A4q/acm/GtdnoKxJONqcI68/yotG+5rc=;
        b=HxNgrnWQN3H09j3KbAZChzmuxKMvKy3Xr3HAI6vlFlq97Ri+/LzETvDYHl2hn7XvwJ
         V/Zqk+33Q9H++LUACOKoyWXXV5druPCq0fc840ejGZ/k9akt+w+Qsi1Gu2WekXSoI8/B
         rIyxqkumcMd2ndEcpt+tbwZM6OTf4ssaNAz22i3dwcMCFLpc3+NwzLMMblsHaWFrfccD
         UNqKhCfW/HprFKf//uXWZVxJNc3CV/wyl8eY2RTXw7YEavsesNGRRGPLNh1ctFRNqcP6
         lhAYjwdDbwhpoznkJRSM9WtXYC1lUewNXQnhpghTByxu6aryuQ+Rk5p2OKNn21ux/rtm
         foWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883667; x=1793488467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0Hxp+Z6Z20A4q/acm/GtdnoKxJONqcI68/yotG+5rc=;
        b=C5Hm1U8EmWACqqsuPqPIUghiCCZeI70pn9F8GJTEkCV605/NgZHfox52/0Au4egkSG
         QT7DCVAxP0JD7coJcBNPzzpRLnERjy+5OQUVXuP9L+yp3wpE9YWReowK7jvWoewmQCan
         IRFa75WV1pBbKj0Yuj54dwC8Qfihx0dzDLOSo3cUJtnjt9qdw6Z+svmyZWwtgCJ7YrBA
         eqaI3212SvsCUc4mcjQ0Eug/nN3eV0O/u09WBrsNt+LLw+6/UN0B05SINDJJr2mIdjb5
         AJckU3aJpD37Q3/s4+03Ha7WtwnO8Rzb8Xa+UUZfifcAzGlxlUtzN2xMu6R6XAMiYOnq
         /tEw==
X-Forwarded-Encrypted: i=1; AKwUvBwlyCvBxf9lgtVxymr18xyQINjI+glrI6PUXoDBDlKr1ryBopHNdF6GOEE3g7igWeSAEEW6HGwMaJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdlNsBC8i7UbyGMNzhqLZ1D/dBHT8jNQ4Qnnaxyojkw3RvXHbN
	rdogQ7QzXcf0eyysbucdYG7dZZ8IL5lxIgZKWum8I0kHfFT4MStIbHlN
X-Gm-Gg: AYBFou3+dwBrObL4c+mAFQunc2wEsg8rFYTKDXFQuYJtudMPz+3Ch23yUQtXlbtmzvJ
	DkCp2iWgBOfKvKu4ucGQYIGkqCF1G+Isnqkq6Vckwkf9N6pvLfry4PDcCUTtJ+xCc6niU+s0cBb
	jQCw3qTrwLZKqTcfYisBXgC8CP8GMRjbkjxsFaw3kVsJw2vWS5Hj9i/GDM46X7424I3nFb8M/Bn
	A2sdrvzKAMqNCme1jEAwlmoYNWXQzjk40oVElIZQcOiAih/gujfjNh7GJVJzJOmlhx2r//yl+/r
	lPszmvI8lpFBQPdUexFtsuLJkYUyaoOmQ2zPwUcau33Mt7WNpFmzcXIDyGMqbhID5OV2khJff/b
	prFQ3RR20SVdbDag1uR3yKJlG8JySGoKCz5rAwqJMwBHsGn31K8NcT8uVAT9KyNjbAIUWg79IAN
	B4ug7DMfSDQnJiPANFwrdS08Oz5fUt8FoAkiKg/goYZsEtmMqWXPnKeYYux31gVsUspNqDiIg8d
	s91baLqI/KWlchfGn/M3FTuzJc5qd9XDcgXPf0ndwl8NiXLfbGM0kDBBL6TKOofAo2zqOBZ4dxU
	71NO
X-Received: by 2002:a05:6102:5049:b0:7c8:fb4e:a3b0 with SMTP id ada2fe7eead31-7ce5ccddc2fmr687752137.12.1792883666907;
        Sat, 24 Oct 2026 16:14:26 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:efc9:520c:e99d:e5ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b8f0csm3775406241.5.2026.10.24.16.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:14:26 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Date: Sat, 24 Oct 2026 20:13:35 -0300
Message-ID: <20261024231335.280955-7-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024231335.280955-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299, ADS1299-6 and ADS1299-4 are 8, 6 and 4-channel, 24-bit
biopotential ADCs for EEG. They share the register map, the commands
and the data format of the ADS129x, and differ in:

- the PGA gains, 1, 2, 4, 6, 8, 12 and 24;
- the data rates, f_CLK / 2^(7 + DR) with no HR bit, from 16 kSPS to
  250 SPS, and the oversampling ratio, 64 * 2^DR;
- the internal reference, a fixed 4.5 V, and the reserved bits 6:5 of
  CONFIG3;
- the ID register, which holds the channel count in bits 1:0;
- the register map, which ends at CONFIG4;
- the inputs, which are shorted out of reset.

Add the chip info for the ADS1299, and connect the inputs of every
channel at init, which changes nothing on the ADS129x, whose inputs are
already connected out of reset. The channel count is read from the ID
register, so ti,ads1299 also serves the ADS1299-4 and ADS1299-6 through
their fallback.

For both families, enable the DVDD supply when the device tree gives
one, and hold PWDN asserted, like RESET, until the supplies and the
clock are up. Nothing changes for a device tree that has neither.

Tested on an ADS1299 with a Raspberry Pi 4.

Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 drivers/iio/adc/Kconfig      |   6 +--
 drivers/iio/adc/ti-ads1298.c | 100 +++++++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a29ed8f45..724ae6123 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1920,14 +1920,14 @@ config TI_ADS1262
 	  called ti-ads1262.
 
 config TI_ADS1298
-	tristate "Texas Instruments ADS1298"
+	tristate "Texas Instruments ADS1298 and ADS1299"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select REGMAP
 	help
-	  If you say yes here you get support for Texas Instruments ADS1298
-	  medical ADC chips
+	  If you say yes here you get support for Texas Instruments ADS1294,
+	  ADS1296, ADS1298 and ADS1299 medical ADC chips, and their variants
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1298.
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 5ad543bdf..e0cea23b1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-/* TI ADS1298 chip family driver
+/* TI ADS1298 and ADS1299 chip family driver
  * Copyright (C) 2023 - 2024 Topic Embedded Products
+ * Copyright (C) 2026 Stephan Costa Barros <stephanbrrs8@gmail.com>
  */
 
 #include <linux/bitfield.h>
@@ -45,6 +46,10 @@
 #define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
 #define ADS1298_ID_FAMILY_ADS129X		0x90
 #define ADS1298_ID_FAMILY_ADS129XR		0xd0
+/* ADS1299: bit 4 reads 1 and DEV_ID[3:2] is 11; bits 7:5 are the revision */
+#define ADS1299_MASK_ID_DEVICE			GENMASK(4, 2)
+#define ADS1299_MASK_ID_CHANNELS		GENMASK(1, 0)
+#define ADS1299_ID_DEVICE			0x7
 
 #define ADS1298_REG_CONFIG1	0x01
 #define ADS1298_MASK_CONFIG1_HR			BIT(7)
@@ -65,12 +70,14 @@
 #define ADS1298_MASK_CONFIG3_RESERVED		BIT(6)
 #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
 #define ADS1298_VREF_4V_MV			4000
+#define ADS1299_MASK_CONFIG3_RESERVED		GENMASK(6, 5)
 
 #define ADS1298_REG_LOFF	0x04
 #define ADS1298_REG_CHnSET(n)	(0x05 + (n))
 #define ADS1298_MASK_CH_PD		BIT(7)
 #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
 #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
+#define ADS1298_MUX_NORMAL		0
 
 #define ADS1298_REG_LOFF_STATP	0x12
 #define ADS1298_REG_LOFF_STATN	0x13
@@ -354,6 +361,15 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
 		return -EINVAL;
 
 	factor = (rate >> info->dr_shift) / val;
+
+	if (!info->has_hr) {
+		/* The slowest rate at or above val, or the lowest of all */
+		cfg = factor ? min(ilog2(factor), ADS1298_LOWEST_DR) : 0;
+
+		return regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG1,
+					  ADS1298_MASK_CONFIG1_DR, cfg);
+	}
+
 	if (factor >= BIT(ADS1298_LOWEST_DR + 1))
 		cfg = ADS1298_LOWEST_DR; /* Lowest rate, in LP mode */
 	else if (factor)
@@ -772,6 +788,43 @@ static int ads1298_parse_id(struct iio_dev *indio_dev, unsigned int id)
 	return 0;
 }
 
+/* The ADS1299 has no WCT registers */
+static const struct regmap_config ads1299_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_read = ads1298_reg_read,
+	.reg_write = ads1298_reg_write,
+	.max_register = ADS1298_REG_CONFIG4,
+	.wr_table = &ads1298_regmap_writeable,
+	.volatile_table = &ads1298_regmap_volatile,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ads1299_parse_id(struct iio_dev *indio_dev, unsigned int id)
+{
+	struct ads1298_private *priv = iio_priv(indio_dev);
+	struct device *dev = &priv->spi->dev;
+	unsigned int nu_ch;
+
+	nu_ch = FIELD_GET(ADS1299_MASK_ID_CHANNELS, id);
+	/* 0, 1 and 2 are 4, 6 and 8 channels; 3 is reserved */
+	if (FIELD_GET(ADS1299_MASK_ID_DEVICE, id) != ADS1299_ID_DEVICE ||
+	    nu_ch > 2)
+		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);
+	indio_dev->num_channels = 4 + 2 * nu_ch;
+
+	/* TI sells the 8-channel part as plain ADS1299 */
+	if (indio_dev->num_channels == ADS1298_MAX_CHANNELS)
+		indio_dev->name = "ads1299";
+	else
+		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299-%u",
+						 indio_dev->num_channels);
+	if (!indio_dev->name)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static const u8 ads1298_gains[] = { 6, 1, 2, 3, 4, 8, 12 };
 
 static const struct ads1298_chip_info ads1298_chip_info = {
@@ -787,10 +840,24 @@ static const struct ads1298_chip_info ads1298_chip_info = {
 	.config3_reserved = ADS1298_MASK_CONFIG3_RESERVED,
 };
 
+static const u8 ads1299_gains[] = { 1, 2, 4, 6, 8, 12, 24 };
+
+static const struct ads1298_chip_info ads1299_chip_info = {
+	.parse_id = ads1299_parse_id,
+	.regmap_config = &ads1299_regmap_config,
+	.gains = ads1299_gains,
+	.num_gains = ARRAY_SIZE(ads1299_gains),
+	.dr_shift = 7,
+	.osr_base = 64,
+	.vref_mv = 4500,
+	.config3_reserved = ADS1299_MASK_CONFIG3_RESERVED,
+};
+
 static int ads1298_init(struct iio_dev *indio_dev)
 {
 	struct ads1298_private *priv = iio_priv(indio_dev);
 	unsigned int val;
+	unsigned int i;
 	int ret;
 
 	/* Device initializes into RDATAC mode, which we don't want */
@@ -822,6 +889,16 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	if (!priv->reg_vref)
 		msleep(ADS1298_REF_START_UP_MS);
 
+	/* The ADS1299 comes out of reset with its inputs shorted */
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
+					 ADS1298_MASK_CH_MUX,
+					 FIELD_PREP(ADS1298_MASK_CH_MUX,
+						    ADS1298_MUX_NORMAL));
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -830,6 +907,7 @@ static int ads1298_probe(struct spi_device *spi)
 	struct ads1298_private *priv;
 	struct iio_dev *indio_dev;
 	struct device *dev = &spi->dev;
+	struct gpio_desc *powerdown_gpio;
 	struct gpio_desc *reset_gpio;
 	unsigned long clk_rate;
 	int ret;
@@ -844,12 +922,18 @@ static int ads1298_probe(struct spi_device *spi)
 	if (!priv->chip_info)
 		return -ENODEV;
 
-	/* Reset to be asserted before enabling clock and power */
+	/* Reset and power-down to be asserted before enabling clock and power */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Cannot get reset GPIO\n");
 
+	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(powerdown_gpio))
+		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
+				     "Cannot get powerdown GPIO\n");
+
 	priv->reg_avdd = devm_regulator_get(dev, "avdd");
 	if (IS_ERR(priv->reg_avdd))
 		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
@@ -863,6 +947,10 @@ static int ads1298_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable_optional(dev, "dvdd");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to enable dvdd regulator\n");
+
 	/* VREF can be supplied externally, otherwise use internal reference */
 	priv->reg_vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(priv->reg_vref)) {
@@ -904,6 +992,9 @@ static int ads1298_probe(struct spi_device *spi)
 	indio_dev->channels = ads1298_channels;
 	indio_dev->info = &ads1298_info;
 
+	/* Out of power-down, now that the supplies and the clock are up */
+	gpiod_set_value_cansleep(powerdown_gpio, 0);
+
 	/* Power-on reset time, counted from when the clock is valid */
 	msleep(DIV_ROUND_UP(ADS1298_TPOR_CLOCKS * MILLI, clk_rate));
 
@@ -957,12 +1048,14 @@ static int ads1298_probe(struct spi_device *spi)
 
 static const struct spi_device_id ads1298_id[] = {
 	{ .name = "ads1298", .driver_data = (kernel_ulong_t)&ads1298_chip_info },
+	{ .name = "ads1299", .driver_data = (kernel_ulong_t)&ads1299_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ads1298_id);
 
 static const struct of_device_id ads1298_of_table[] = {
 	{ .compatible = "ti,ads1298", .data = &ads1298_chip_info },
+	{ .compatible = "ti,ads1299", .data = &ads1299_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ads1298_of_table);
@@ -978,5 +1071,6 @@ static struct spi_driver ads1298_driver = {
 module_spi_driver(ads1298_driver);
 
 MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
-MODULE_DESCRIPTION("TI ADS1298 ADC");
+MODULE_AUTHOR("Stephan Costa Barros <stephanbrrs8@gmail.com>");
+MODULE_DESCRIPTION("TI ADS1298 and ADS1299 ADC");
 MODULE_LICENSE("GPL");
-- 
2.43.0

