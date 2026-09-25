Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87247B423
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373062; cv=none; b=AAUi45PnphfOEfFQpfjRJC/uqmLKh36atYZrCcIT0fNgQUYw779MSU2jmUy4IbgMxCcbllovNu+4FSVsvdBUMtnxv5Uzr/GbJuLtxMOCQaLm+ClhndgGljEiFTeXt3O/U8uUbg989LXjm4/xUreLzR0EG5Qy7sDuUK9kVHcC/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373062; c=relaxed/simple;
	bh=AuPpavUxIfLC0oJdMOsE/vhiB3CqJSq/0j9oWa4KPAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oAVAA0Z9IjHI19ffT+nkd9eET9nWHUkwNSt6fTrt5N0VAj/jR9bkoKh1bIu0e6l/00JUxzBfGHTUyTZQhHvupYotGE7suJpqb/XlyagWwRKwSyRde9Agz9OjxX58NPCsvPhtPczN62YLUqlcRX0lo0OafU2bYjXyIw2hbe3lNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bsXcrTqY; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bsXcrTqY"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae7166edso1017824eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790373058; x=1790977858; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2xavothqOwHeZB4bh98N0n0uYgOhBW9jj9OLVcedt+M=;
        b=bsXcrTqYUWEEuwpjn60DE7YJax4xMowJm7pq3D3yeO931SSTqUgdp3I+ehu1ev4ftW
         Byo28IHfe9j+05i/sqtRIci4y+46dZvU+Jya7KT9nYjStBv3yU1a31Wr4f8Lk4me728R
         IU2nXywQRdjRjMtx/t/ureUUEpJ1gVbb9om15RERjznmWzPBlp8naRMjin0fLhyQ8Ljy
         XwBK/ivXRXzxVxFJ0D3/oUpab0Y8oHktKG2IMFH+G9xy3HzJpEsGjtUZ5WpDdhNhIK8N
         uwcqsgDxLwvnsxptlQcJRxbHoIQ2z4Zzc8W0lo9rLCefS8v+XtanoJK2LULPN5JooNUj
         kmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373058; x=1790977858;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2xavothqOwHeZB4bh98N0n0uYgOhBW9jj9OLVcedt+M=;
        b=dNc5Zvg2+fbLgJHSUAJFt0hYxR29nDdNsN9JtsygsaRIE2FlYdmHOCFjCfzuDkudos
         ZbMH7sandwRvGRcyGKZfNHa/aP+FSo3dFnBYZ1ir3qy7UxO7gu050LDnE/4thsvDgr48
         qJau2nVvpnmgwTIZByCaTqvz2NtZ2/FYCsx2J9d9zh2bB6DnaRKDq8ISfXAuaLDD2Suz
         gR5utVzv9Hmk4NJa3XiXXzQINrEcF3/iLOZK9Gq5mcplNbwgFLjjYzWubi/caWfCaRT2
         dqTFtR6j1HazJ6PQlbM8rnYE1MHmDbmICGnYahEs53BaNHrCmMZp+ShZDKmuyLDIeTh4
         I5Gw==
X-Gm-Message-State: AFuF++lzY7EPlRCIVt0sP0b/X/gZURv8Q/MaMAGhiQwmroJWG/o8oebm
	OJD7Ggu8Fpqy53D2DrlCmhjHpY8Xl5QRRep8013upIx3ZQRcWP0SNXJN1wHFu1Cam0w=
X-Gm-Gg: AYBFou0sGhm2HnYx6MqAhAVSOkT6vanqZWtkRcoRa6qvgBfsaAFurb03r2PrnzReGED
	w49PCIRghUueXlcVf3Kxm/01cU/myUS+8xYZQW48lMTuuXuY4HNIUnrjzxz3W/UABwtnSb9ZNmQ
	q4EvrdX1kIKUtFpumlShfgpsOIvCXNmYaL32tB9/i3W0y4XJHCO3x/qCLO4YJk6iaO2UklZ3Eel
	Kecs4mt6hCHt3JM1jT8GNi4B/mCLrUbULNf00AxzFnd2MI958Ynhlo7+ijpidCWIAe8JHqvDI1n
	7RS3XyKp6eoGQobxMrOO7fLQr77r3EpPuSeONsN0QLdC2HVGHYxi0+3aKyehlW9lfDnR5Tje85U
	TaiLBE4nswO6PkKxhUVMzhDvv7lV43W5DxxQBK346lVWYB04JTE8ySCPwbuMAZPmVx9hD2YkeGC
	cZas6T8MKJl3CK+9lC95VEQGWk0r0veMT0vvmUTWqaJkvdaPAbLRzJtxinZCGtkzg1wpmJMIddQ
	RpVQDZ944DHQQ==
X-Received: by 2002:a05:6820:4df2:b0:6b7:46fc:1c7 with SMTP id 006d021491bc7-6d43fe723e1mr7445449eaf.38.1790373058085;
        Fri, 25 Sep 2026 14:50:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a0e:55f3:1b40:7bc6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e97ab6a7sm3877556a34.22.2026.09.25.14.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:50:57 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 25 Sep 2026 16:50:47 -0500
Subject: [PATCH] iio: adc: ti-ads112c14: add gpio support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAxFryJZNzAZpopepXThxFTjQmViS0G8e
 9N29Xkf3jvApKgYdNUBRV5qui4OdKmAp34ZBXVwhhhiHdp4RdUV+4FxVx8jikwJx81fapucEzc
 hEYH7W5GHvn/t2/3P9syz8P4Nwnl+AEZ1zYh9AAAA
X-Change-ID: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13375;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=AuPpavUxIfLC0oJdMOsE/vhiB3CqJSq/0j9oWa4KPAo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqtuy5dlDf7qBQGwrEIRh6Vfp8T4koO/RYSyrM2
 UocPWHwJRWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarbsuQAKCRDCzCAB/wGP
 wH5HB/4udUFwlmxc40xMlILg0coaXwFGTwCEBPFtoetjeFO/iBUTHdFArYuS3XoZ/+zwx5Gr0NU
 o5NRKlWAWQSTQOpZORHgONvYHnu6yEng3CrC3yGzyWzb04tY2ZaKixU5r0xSRyfVmd7pkcY+2eM
 8dcoaiKFZOWUF7g3eqveqVyveT7nF6Q5U+KmTm4RXt3N450gJxdrbBic/eJN5eWTNCa6iwQwlH8
 QawXaeNAEdVuV+4smg3cYmvW86+pI2JXPCDThPaYJ+HfSfFLxCpDRakvKriZHHsG+/ZoSS/ZIFa
 IDVvCGBOWfnEAlK3huLo9wZoOn04YSrj9LyKkiMXIF5uXuZb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
the gpio-controller property is present.

Pins that are already used for something else according to the
devicetree are excluded from the valid GPIO mask. This includes analog
inputs and excitation current outputs used by channels, REFP/REFN when
an external reference is used, the /FAULT and /DRDY interrupts and the
external clock input.

The per-pin register field macros are replaced with parameterized ones
so that they can be used with the GPIO offset.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 198 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 3c877126b0be..1c0519716faa 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -63,10 +64,7 @@
 
 #define ADS112C14_REG_STATUS_LSB			0x03
 #define   ADS112C14_STATUS_LSB_CONV_COUNT		GENMASK(7, 4)
-#define   ADS112C14_STATUS_LSB_GPIO3_DAT_IN		BIT(3)
-#define   ADS112C14_STATUS_LSB_GPIO2_DAT_IN		BIT(2)
-#define   ADS112C14_STATUS_LSB_GPIO1_DAT_IN		BIT(1)
-#define   ADS112C14_STATUS_LSB_GPIO0_DAT_IN		BIT(0)
+#define   ADS112C14_STATUS_LSB_GPIO_DAT_IN(n)		BIT(n)
 
 #define ADS112C14_REG_CONVERSION_CTRL			0x04
 #define   ADS112C14_CONVERSION_CTRL_RESET		GENMASK(7, 2)
@@ -133,10 +131,7 @@
 #define   ADS112C14_DIGITAL_CFG_CODING			BIT(1)
 
 #define ADS112C14_REG_GPIO_CFG				0x0B
-#define   ADS112C14_GPIO_CFG_GPIO3_CFG			GENMASK(7, 6)
-#define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
-#define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
-#define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
+#define   ADS112C14_GPIO_CFG_GPIO_CFG(n)		(GENMASK(1, 0) << (2 * (n)))
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
 #define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
@@ -147,10 +142,7 @@
 #define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DAT_OUT  0
 #define     ADS112C14_GPIO_DATA_OUTPUT_GPIO3_SRC_DRDY	  1
 #define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_SRC		BIT(6)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO3_DAT_OUT	BIT(3)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO2_DAT_OUT	BIT(2)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO1_DAT_OUT	BIT(1)
-#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO0_DAT_OUT	BIT(0)
+#define   ADS112C14_GPIO_DATA_OUTPUT_GPIO_DAT_OUT(n)	BIT(n)
 
 #define ADS112C14_REG_IDAC_MAG_CFG			0x0D
 #define   ADS112C14_IDAC_MAG_CFG_I2MAG			GENMASK(7, 4)
@@ -166,6 +158,8 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+#define ADS112C14_NUM_GPIO				4
+
 enum {
 	ADS112C14_VREF_SOURCE_INTERNAL_2_5V,
 	ADS112C14_VREF_SOURCE_INTERNAL_1_25V,
@@ -366,6 +360,9 @@ struct ads112c14_channel_state {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	struct gpio_chip gc;
+	const char *gpio_names[ADS112C14_NUM_GPIO];
+	DECLARE_BITMAP(gpio_reserved_mask, ADS112C14_NUM_GPIO);
 	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
@@ -393,6 +390,135 @@ struct ads112c14_data {
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
 
+static void ads112c14_reserve_gpio_for_ain(unsigned long *gpio_reserved_mask,
+					   u32 ain)
+{
+	if (ain >= 4 && ain <= 7)
+		set_bit(ain - 4, gpio_reserved_mask);
+}
+
+static int ads112c14_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADS112C14_REG_GPIO_CFG, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (field_get(ADS112C14_GPIO_CFG_GPIO_CFG(offset), reg_val)) {
+	case ADS112C14_GPIO_CFG_GPIO_CFG_INPUT:
+		return GPIO_LINE_DIRECTION_IN;
+	case ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL:
+	case ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_OPEN_DRAIN:
+		return GPIO_LINE_DIRECTION_OUT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_gpio_direction_input(struct gpio_chip *gc,
+					  unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	return regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
+				  ADS112C14_GPIO_CFG_GPIO_CFG(offset),
+				  field_prep(ADS112C14_GPIO_CFG_GPIO_CFG(offset),
+					     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
+}
+
+static int ads112c14_gpio_direction_output(struct gpio_chip *gc,
+					   unsigned int offset, int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_assign_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
+				 ADS112C14_GPIO_DATA_OUTPUT_GPIO_DAT_OUT(offset),
+				 value);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
+				  ADS112C14_GPIO_CFG_GPIO_CFG(offset),
+				  field_prep(ADS112C14_GPIO_CFG_GPIO_CFG(offset),
+					     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
+}
+
+static int ads112c14_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADS112C14_REG_STATUS_LSB, &reg_val);
+	if (ret)
+		return ret;
+
+	return field_get(ADS112C14_STATUS_LSB_GPIO_DAT_IN(offset), reg_val);
+}
+
+static int ads112c14_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			      int value)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	return regmap_assign_bits(data->regmap, ADS112C14_REG_GPIO_DATA_OUTPUT,
+				  ADS112C14_GPIO_DATA_OUTPUT_GPIO_DAT_OUT(offset),
+				  value);
+}
+
+static int ads112c14_gpio_init_valid_mask(struct gpio_chip *gc,
+					  unsigned long *valid_mask,
+					  unsigned int ngpios)
+{
+	struct iio_dev *indio_dev = gpiochip_get_data(gc);
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	bitmap_fill(valid_mask, ngpios);
+	bitmap_andnot(valid_mask, valid_mask, data->gpio_reserved_mask, ngpios);
+
+	return 0;
+}
+
+static int ads112c14_gpio_init(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+
+	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
+		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
+						     dev_name(&indio_dev->dev), i);
+		if (!data->gpio_names[i])
+			return -ENOMEM;
+	}
+
+	data->gc = (struct gpio_chip) {
+		.owner = THIS_MODULE,
+		.label = dev_name(dev),
+		.parent = dev,
+		.base = -1,
+		.ngpio = ADS112C14_NUM_GPIO,
+		.names = data->gpio_names,
+		.can_sleep = true,
+		.init_valid_mask = ads112c14_gpio_init_valid_mask,
+		.get_direction = ads112c14_gpio_get_direction,
+		.direction_input = ads112c14_gpio_direction_input,
+		.direction_output = ads112c14_gpio_direction_output,
+		.get = ads112c14_gpio_get,
+		.set = ads112c14_gpio_set,
+	};
+
+	return devm_gpiochip_add_data(dev, &data->gc, indio_dev);
+}
+
 static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -1913,7 +2039,8 @@ static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
 }
 
 static int ads112c14_parse_channels(struct iio_dev *indio_dev,
-				    bool *need_avdd_ref, bool *need_ext_ref)
+				    bool *need_avdd_ref, bool *need_ext_ref,
+				    unsigned long *gpio_reserved_mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
@@ -1981,6 +2108,8 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 			 * for single-ended channels when taking measurements.
 			 */
 			spec->channel2 = ADS112C14_MUX_CFG_AIN_GND;
+
+			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
 		} else if (fwnode_property_present(child, "diff-channels")) {
 			ret = fwnode_property_read_u32_array(child, "diff-channels",
 							     pair, ARRAY_SIZE(pair));
@@ -1995,6 +2124,9 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 			spec->differential = 1;
 			spec->channel = pair[0];
 			spec->channel2 = pair[1];
+
+			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
+			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
 		} else {
 			return dev_err_probe(dev, -EINVAL,
 					     "channel node missing channel type property\n");
@@ -2026,6 +2158,10 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 			measurement->idac1_mux = pair[0];
 			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
 
+			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
+			if (measurement->iadc_count > 1)
+				ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
+
 			ret = fwnode_property_read_u32_array(child, "excitation-current-nanoamp",
 							     pair, measurement->iadc_count);
 			if (ret)
@@ -2332,6 +2468,7 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 
 static int ads112c14_probe(struct i2c_client *client)
 {
+	DECLARE_BITMAP(gpio_reserved_mask, ADS112C14_NUM_GPIO);
 	struct device *dev = &client->dev;
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
@@ -2353,6 +2490,7 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->chip_info = info;
+	bitmap_zero(gpio_reserved_mask, ADS112C14_NUM_GPIO);
 
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
@@ -2366,7 +2504,8 @@ static int ads112c14_probe(struct i2c_client *client)
 					     "failed to read ti,refp-refn-resistor-ohms property\n");
 	}
 
-	ret = ads112c14_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref);
+	ret = ads112c14_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref,
+				       gpio_reserved_mask);
 	if (ret)
 		return ret;
 
@@ -2429,6 +2568,10 @@ static int ads112c14_probe(struct i2c_client *client)
 		return dev_err_probe(dev, -EINVAL,
 				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
+	/* REFP and REFN share pins with GPIO0 and GPIO1. */
+	if (data->ext_ref_uV || data->ext_ref_ohms)
+		bitmap_set(gpio_reserved_mask, 0, 2);
+
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
@@ -2505,12 +2648,19 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	/* FAULT shares a pin with GPIO2. */
+	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "fault") >= 0)
+		set_bit(2, gpio_reserved_mask);
+
 	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "drdy") >= 0) {
 		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
 		if (data->drdy_irq < 0)
 			return dev_err_probe(dev, data->drdy_irq,
 					     "failed to get drdy interrupt\n");
 
+		/* DRDY shares a pin with GPIO3. */
+		set_bit(3, gpio_reserved_mask);
+
 		if (clk)
 			return dev_err_probe(dev, -EINVAL,
 					     "cannot use both DRDY and CLK - they share the same pin\n");
@@ -2520,8 +2670,8 @@ static int ads112c14_probe(struct i2c_client *client)
 		 * order to support open drain option here.
 		 */
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
-					 ADS112C14_GPIO_CFG_GPIO3_CFG,
-					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
 						    ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL));
 		if (ret)
 			return ret;
@@ -2555,9 +2705,12 @@ static int ads112c14_probe(struct i2c_client *client)
 	}
 
 	if (clk) {
+		/* CLK shares a pin with GPIO3. */
+		set_bit(3, gpio_reserved_mask);
+
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
-					 ADS112C14_GPIO_CFG_GPIO3_CFG,
-					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO3_CFG,
+					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
+					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
 						    ADS112C14_GPIO_CFG_GPIO_CFG_INPUT));
 		if (ret)
 			return ret;
@@ -2583,6 +2736,15 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "gpio-controller")) {
+		bitmap_copy(data->gpio_reserved_mask, gpio_reserved_mask,
+			    ADS112C14_NUM_GPIO);
+
+		ret = ads112c14_gpio_init(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

---
base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
change-id: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

