Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490E3EA967
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588385; cv=none; b=PHXlGNlc/nwUI/4svzwLgX4HViX+25B+lKr/RqZLdU+oUwe86TecgUhj5vJh6t+kuOPXf51VefnM3TB4rgYWMLXeyDWVgx9fiGR1IWrtpWBNajuAUEMpxkagiiD9BldaW1xBp0JPL25oKNPulAzEjA8o4oxAKl6XrhSOHWolfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588385; c=relaxed/simple;
	bh=aSCk7vR7RCc/E1Vdt5vktFWYGrnms6k1gSa+I2W+kyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q51oVL/A19Q6AlTlPQ5S/TVfVh9aGXPnreEKZqmf4tzG7RsgYaY1k8JfCyTVvGJjkUWBGcwvHC5Ge35kP3/gQ4WwTBH7A8BTFGx6uAVRM/mgiOt95hGqA8a47hXwihb9Utag4lLCJJsvmgNlTSfNijmSRx6V7oBYxiveXs2mYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UVxRWwFb; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UVxRWwFb"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8245021651dso243434a34.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791588382; x=1792193182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqJrYP7Xtsbw30SMQRn1hKDSp3oWJh6uZpJoxaHfYgQ=;
        b=UVxRWwFbyFizweJCophojEEfb/ohMPV6NdGpVOlYz1h5AFy/tFl/xiujeLOFhqibwr
         YN+lBAztqMvJbekrhT0RsLaTb8pgX5p1lLILuqKn5x6SC0DvdcAhZc3z1gcO+1yIVH8E
         9VwEDje9xjyxYwdYRWyc4DQfFGG7aW8sC2w8X7l+fi6zpbp+iVyCBKH5M1SkZzhXNgrE
         wgyS8u8sYPZcnEKjmON1w2FZagUyGe2eZnx0iU3wtP5PP0EtEUeAicgaUOo67qYKfML+
         SlrLS2E23QZZvgGqKo3TOC9RQH0HrbWz9hRfG4WoV5HUzu9c65cHSTXDVAMpOFfs92+g
         XbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588382; x=1792193182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqJrYP7Xtsbw30SMQRn1hKDSp3oWJh6uZpJoxaHfYgQ=;
        b=F89pt+uJEHHpM15X82BlxF/nFBDm0goyTeFNjslwyJojj7qgTeXwwb4zK2ffFEwB0x
         uufdhhXJe67X2Md0uQlJyXJ7ETGLM5fytoNx3xxgUT3TtLtkCXr0JdpfaCh43zRkwZsi
         WyTjmCAyXMcTl1jBJ+S0bSLJujhgX1XcNbKZsfMzbmQfibCxMEpWEMO1n2d1+NCKPrDg
         uahUMrxqB4DdMvDcZzOCc9WwPLHeb/oQ1KmF55XbUoUj2Bdu+OCCIJeTbU9WQDdLkUb7
         m1B7jkpMrcgUwqc4t+/pooCpdgXuili38Bq6XID4qozWwETW9VsnIRQ5F+veLOncD3i4
         1kXA==
X-Gm-Message-State: AFuF++nWf/n9Eb/A0KiZ/oPuwBjSgY0dW2vkav18f8KPJIDEUsB0FtoR
	czaj0chdFRxX/5iyCQ9uOHH8gD8s3g2XOSG7lqxZyccErnW8ADbE1NRqUeTzPFMiU3g=
X-Gm-Gg: AYBFou0M/xq1K8xvK182+tAH3bI5H1sDtQsEUEwlyrIZgiCUEy5tWAb6CqL3mGYjTe2
	26xSIMLLVl+riTDXoStP/Xn54nLbJZr+anC/od+A6TY0MTtwOFKW+fnWsQaBQAsRxdhbo4Ie91B
	ncVb9UFh3H4XFnngp4IIV6GoSTowbKlVfIgZIQ1l1fv+cf+419c9SaCOu9dK/q1WrXMR1DkSsTG
	4+kV+ksz+ulsRDave+SeUNC8mBrHrMHkq+/OkCDaN0AlnPR9agEXGbh2hgTfZQC52sDg4xcH4AB
	ezPmColqquY+TBZC688K29tO6ZsFNURo9GmzD+Dd3meZ7CGxP57LUj6tYPiHTqfDQ/ntSZm+ime
	zx0x03t/CgSKMl/fHSrbZ0snOJdzheQ1o/S7zMK2Ej1RZK/zN84hYJHE9wMynjtdnD5PAgpW8nH
	ISgDnCeH/8RFdpAzvLxMNTkp2IRdmMzCf/oTAF7+lzvWYxamyUWXHDrum+7Xhcrk9t6qBsB9DVq
	dQ=
X-Received: by 2002:a05:6830:349e:b0:822:a76e:9595 with SMTP id 46e09a7af769-830966ee42emr3475463a34.18.1791588381787;
        Fri, 09 Oct 2026 16:26:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f82468sm3293817a34.11.2026.10.09.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:26:20 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 18:25:52 -0500
Subject: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
In-Reply-To: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9894; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aSCk7vR7RCc/E1Vdt5vktFWYGrnms6k1gSa+I2W+kyM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqyXgQIhI0AwTxQ0IKOmHaWuzhL2x0NEMM6iIQy
 FRyR6A9eJyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasl4EAAKCRDCzCAB/wGP
 wGFWB/0ZhDj6oIXwKpnq83W9oI3ZH/vM6c9sA30YyNTXqpTGjXMdCoFZU5JANPAXtcGAb/AWIMu
 drKdToBDwCkqpNMOgiB114ilPwy9RfCtqDOeJAcfiYk3mg1CTPYQgHHr1v2LgpjHX3h08J7JEXN
 dmfAQYdCLlQrw+Uo2B6yHUSaT7QwsA2WM8v/BiubP3iuru4+2CeiimUfjvp2607YCnYZQMoHK5Y
 gnv5F78t0qaQT1PE54V0KuaOmTwJTDfZVTR1yu5cT5K+tB9qnSAMeFuCBnhVxtxJS1KdLnFKpra
 g9VUK5N7RC/NV5oloNVQBLo/dtjiEqMvQvZRAo3y6ghyU4Fq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
the gpio-controller property is present.

Pins that are already used for something else according to the
devicetree are excluded from the valid GPIO mask. This includes analog
inputs and excitation current outputs used by channels, REFP/REFN when
an external reference is used, the /FAULT and /DRDY interrupts and the
external clock input.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/Kconfig        |   2 +-
 drivers/iio/adc/ti-ads112c14.c | 168 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..b0242b2fdb2d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1878,7 +1878,7 @@ config TI_ADS112C04
 
 config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select CRC8
 	select REGMAP
 	help
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index cbd82de03127..e0cadc445a44 100644
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
@@ -157,6 +158,8 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+#define ADS112C14_NUM_GPIO				4
+
 enum {
 	ADS112C14_VREF_SOURCE_INTERNAL_2_5V,
 	ADS112C14_VREF_SOURCE_INTERNAL_1_25V,
@@ -357,6 +360,9 @@ struct ads112c14_channel_state {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	struct gpio_chip gc;
+	const char *gpio_names[ADS112C14_NUM_GPIO];
+	DECLARE_BITMAP(gpio_reserved, ADS112C14_NUM_GPIO);
 	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
@@ -384,6 +390,135 @@ struct ads112c14_data {
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
 
+static u32 ads112c14_reserve_ain_pin(unsigned long *reserved, u32 ain)
+{
+	if (ain >= 4 && ain <= 7)
+		bitmap_set(reserved, ain - 4, 1);
+
+	return ain;
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
+	bitmap_andnot(valid_mask, valid_mask, data->gpio_reserved, ngpios);
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
@@ -1965,7 +2100,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 				return dev_err_probe(dev, -EINVAL,
 						     "single-channel value must be between 0 and 7\n");
 
-			spec->channel = pair[0];
+			spec->channel = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[0]);
 			/*
 			 * NB: channel2 is unused by iio core code in this case.
 			 * Let's us avoid special case for negative input mux
@@ -1984,8 +2119,8 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 						     "diff-channels values must be between 0 and 7\n");
 
 			spec->differential = 1;
-			spec->channel = pair[0];
-			spec->channel2 = pair[1];
+			spec->channel = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[0]);
+			spec->channel2 = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[1]);
 		} else {
 			return dev_err_probe(dev, -EINVAL,
 					     "channel node missing channel type property\n");
@@ -2014,8 +2149,11 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 				return dev_err_probe(dev, -EINVAL,
 						     "excitation-channels values must be between 0 and 7\n");
 
-			measurement->idac1_mux = pair[0];
-			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
+			measurement->idac1_mux =
+				ads112c14_reserve_ain_pin(data->gpio_reserved, pair[0]);
+			if (measurement->iadc_count > 1)
+				measurement->idac2_mux =
+					ads112c14_reserve_ain_pin(data->gpio_reserved, pair[1]);
 
 			ret = fwnode_property_read_u32_array(child, "excitation-current-nanoamp",
 							     pair, measurement->iadc_count);
@@ -2420,6 +2558,10 @@ static int ads112c14_probe(struct i2c_client *client)
 		return dev_err_probe(dev, -EINVAL,
 				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
+	/* REFP and REFN share pins with GPIO0 and GPIO1. */
+	if (data->ext_ref_uV || data->ext_ref_ohms)
+		bitmap_set(data->gpio_reserved, 0, 2);
+
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
@@ -2496,12 +2638,19 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	/* FAULT shares a pin with GPIO2. */
+	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "fault") >= 0)
+		bitmap_set(data->gpio_reserved, 2, 1);
+
 	if (fwnode_property_match_string(dev_fwnode(dev), "interrupt-names", "drdy") >= 0) {
 		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
 		if (data->drdy_irq < 0)
 			return dev_err_probe(dev, data->drdy_irq,
 					     "failed to get drdy interrupt\n");
 
+		/* DRDY shares a pin with GPIO3. */
+		bitmap_set(data->gpio_reserved, 3, 1);
+
 		if (clk)
 			return dev_err_probe(dev, -EINVAL,
 					     "cannot use both DRDY and CLK - they share the same pin\n");
@@ -2546,6 +2695,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	}
 
 	if (clk) {
+		/* CLK shares a pin with GPIO3. */
+		bitmap_set(data->gpio_reserved, 3, 1);
+
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
 					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
 					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
@@ -2574,6 +2726,12 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "gpio-controller")) {
+		ret = ads112c14_gpio_init(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.53.0

