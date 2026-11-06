Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002440;
	b=2/+yMlccUiysnim/sgsjMDV6VM41mNSCMsQycwW3zpJuFvpMBoBgUjDKKpWzWbW11BJ6
	 idEwGIEbNidyq3qxLOMZIch/0b+3b2Sxu0JylivfQ1sj/e/iM0o+mQIqiouQxUx10p5TX
	 /w+XQE2esYwyPPWsV7FyQ+cReO3a22MdgxmH789P8CR2pDQVTawoNlWxcywrwNlUOi1Eu
	 IaACI4qCv6juwTMQVousY+rkfBU2pTRFUbExOZmvgcLNx8y6JurbxVXXoBJrUZMaRf0P2
	 e5NZbeNYHihKPHkBeLc3pKPje0/Amsu6XObcGoEtjiiuk1dygZ/Jvtk7rHyqfba8+Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=v7P+8v2cdqNKaWjVdCBZDLHtnb+wRwcMRss2SP5oJfI=;
	b=ZhFatjAhrx1olzmWOKHkMmF662ir7w7DpMqPnCLer7XPPyShWiQi+d82gz/F8BGiZsPg
	 hbd+4xJtZn3pThnzeyjDynrr5sFnZx3lr4FVYXoFYqfmOwG8tVnpYl1gpgGGoTlh10Sp0
	 gCBPLe4ZwFBmY4mkRCj2Xuf1I9pLjn80UoR6u3TqDtPPYBHk6e/MKV68i0jG/nGIf1DiE
	 1MJKuqsUubQaFSB+VY80P76Oc8HXPzWyDmgYrAQFh+LSQReBYvcMyGTrm0u4Q720e6cEM
	 EtANbDSfFqkL42IAsBFfG185to+dZLkZmxPt4T2VLER9iy5dADyY5CSfAnhdo9p2B6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="cCHv/ipF";
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0427606A333
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 22:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0427606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cCHv/ipF
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-5058b105df7so394575b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794002439; x=1794607239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7P+8v2cdqNKaWjVdCBZDLHtnb+wRwcMRss2SP5oJfI=;
        b=cCHv/ipFamhKe8jj2inzcAFWqZ87qOx1e8l4iuLAVCAEFLfdGr94AT37dtxk66Ty3L
         64k+YWwl62Rg6AuI7ZRsIRMDGKdq5jL0T+wx+fVKHAKM06SqePyObcUvFhUKijYPAiBi
         ScBCX4pK3qilMyMRuLxm27+UEgy1h31NpcDvMTpVcPh4rhQ8R9hfoOfQpqDNT3ib8zgx
         Vp9pw8kPigT8gN19I1hu1UohTnROd4xK9YRwCiPP3mFfltIUtqriSZq/Sl6i3+QoDP7S
         BsrVPaQsheYakc8xOTm/TpZsJVCCooN+aOJgT6f3R0dnMlQfGxmwn7SjbgrvrbqQ0KRy
         YCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002439; x=1794607239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7P+8v2cdqNKaWjVdCBZDLHtnb+wRwcMRss2SP5oJfI=;
        b=mleXg66DSwH6RgkMHGcyJbb8eYZU2UO3+gaSID75JVWdey6ks4w5ZAIq/yLSe1TmIv
         or6hEl+HQDDBO5AHi94xbeYgkZ28vtdoMzSztToMfaor635mU3QuXDd/4ZV1wmjK9S0g
         ZvTznYzU2MitbA9Jd8MH8Y0NkTlPuayD8Qpc3xFFP6uM4CCp+Mt/qMdM5557CpNlOAJ2
         GzQExIIwxTH4eyl2DZ92gqYHentUHiAq+/D5lQyRwREUo84IEI+5sb3SZMdHT1v2g/5p
         V9rlzjrZL+Yre4kUN/P+4il8D0I1pdcQ/acRfTKUWCv4tHptwrIHXxqcFH67kIKQ+8v8
         ggUw==
X-Gm-Message-State: APuU4Z84/SfuoDbhlF9qdpMmskd5sXAYOh5hZSZZF/RI9o4ToQUWemF5
	+f8rSgR+yigsDS+Tb3swwq0LJ3IEZDQiwnf8yJxYkL+iXDd9Zu6JGQ7AsJK8IS69ZcuzaSqNpEE
	Dp3c2pKc=
X-Gm-Gg: AYBFou1eNxlj+ixef3RebRZjWgZoJd8wZ2hvJApZtawumlx6uy3kEWbPrZgi2w0Q3Qi
	lHAYjyf835GAONrKQIcS0gLmpzV2m7bdj6jezLtXKWYvMEtQ6VjYu9d39+/obgBOhtkBqGq3N+K
	A/R17pldYvYheStJDdW9Lj1/U3tiotj4LY0eB8AJtI7SBbiDcKZ2KciBr8yPLscJuhjxBEjhJjp
	DpSPRkZOvKwMqk6hiGl0beCRIkhw4dt9CxxoOaEex6+Fak1Tw0XSzajRumWxst2gUWjJUmho7ht
	899EJsmQ3KWaylvsl5r6PyujH2NITJ68tfrTHKcFpaVIVSyYfFjxpdwL9RecuWnSZAU/wTCkHWC
	9EpAa2JKkslv3vv6sJcgi2yigb71olHq6XxKNhGzekgKx+P+zrST2Ex0mWR7swqZd+tE+YDsI5t
	aoInDxQfmEFMPi8LDT1DY6Mel1PifkJ7bZkacY9f7IPGk6Dm+/YLZTjEzWHfouad6VSd1qLzq5e
	PjK3O04Y4Ywl6L+6IxZXsL3PRVqCBQpBPPiSugVtDaySu/ztSS8q6UDnPWqY8aJAWoS1nkZPaGC
	lILL7bbMtEbhsiIpuSTQoWnyktJ0FTcXwA==
X-Received: by 2002:a05:6808:168c:b0:4d6:90d4:6bb with SMTP id 5614622812f47-567e11683c2mr2696388b6e.45.1794002438394;
        Fri, 06 Nov 2026 14:00:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7f010e4sm2432116b6e.14.2026.11.06.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:00:37 -0800 (PST)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 16:00:07 -0600
Subject: [PATCH v3 2/2] iio: adc: ti-ads112c14: add gpio support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-iio-adc-ti-ads112c14-gpio-v3-2-7578ae66ee19@baylibre.com>
References: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
In-Reply-To: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9880; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SDecQcNtOmqgY2GeVzEp6ze6U7MknFudJGVUC7uNAaE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBq7k34QoxuV/WpJ8JG1W8AzFS3h3YAWvSLxLTRh
 Hhh4hY75nKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5N+AAKCRDCzCAB/wGP
 wPa1CACa4d1LPiUT0gZYQIxRdXhLQ7Be9oejUhE/WoxcNLJDWSGLS86Uz+jltfXHLJOVWOIjqqB
 +kjUW60OPOylmUaWKoPous/jw/8MNRk9tL0TYduuQcUpHBNRtBOJ1w3liW6BaJRDki7he+Vglep
 9HONcu5caxVgwscrxoxUqJVFOtR+BqKNqh+eYfaotzvk8KKkePOBzgWhtWUwyGoHoS42Fwf6fkv
 f12rLVoYMMykmLawymupDjLbi6RMF2THJjYco9f9ZcZfr9mrHax0EB6iD6zTqNXoW/Mb9JD2uiY
 svFqxYS6w2pgtv7Bkzk9nhOqg6QHUPXu54gkNZ5P1grvVJ2T
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
index f8456c803988..9fd6693b109d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1903,7 +1903,7 @@ config TI_ADS112C04
 
 config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select CRC8
 	select REGMAP
 	help
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 498893bd01bc..1270299823be 100644
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
@@ -1959,7 +2094,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 				return dev_err_probe(dev, -EINVAL,
 						     "single-channel value must be between 0 and 7\n");
 
-			spec->channel = pair[0];
+			spec->channel = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[0]);
 			/*
 			 * NB: channel2 is unused by iio core code in this case.
 			 * Let's us avoid special case for negative input mux
@@ -1978,8 +2113,8 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 						     "diff-channels values must be between 0 and 7\n");
 
 			spec->differential = 1;
-			spec->channel = pair[0];
-			spec->channel2 = pair[1];
+			spec->channel = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[0]);
+			spec->channel2 = ads112c14_reserve_ain_pin(data->gpio_reserved, pair[1]);
 		} else {
 			return dev_err_probe(dev, -EINVAL,
 					     "channel node missing channel type property\n");
@@ -2008,8 +2143,11 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
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
@@ -2414,6 +2552,10 @@ static int ads112c14_probe(struct i2c_client *client)
 		return dev_err_probe(dev, -EINVAL,
 				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
+	/* REFP and REFN share pins with GPIO0 and GPIO1. */
+	if (data->ext_ref_uV || data->ext_ref_ohms)
+		bitmap_set(data->gpio_reserved, 0, 2);
+
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clk\n");
@@ -2490,12 +2632,19 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	/* FAULT shares a pin with GPIO2. */
+	if (device_property_match_string(dev, "interrupt-names", "fault") >= 0)
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
@@ -2540,6 +2689,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	}
 
 	if (clk) {
+		/* CLK shares a pin with GPIO3. */
+		bitmap_set(data->gpio_reserved, 3, 1);
+
 		ret = regmap_update_bits(data->regmap, ADS112C14_REG_GPIO_CFG,
 					 ADS112C14_GPIO_CFG_GPIO_CFG(3),
 					 FIELD_PREP(ADS112C14_GPIO_CFG_GPIO_CFG(3),
@@ -2568,6 +2720,12 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_present(dev, "gpio-controller")) {
+		ret = ads112c14_gpio_init(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.53.0

