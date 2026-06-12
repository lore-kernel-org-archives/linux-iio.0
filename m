Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608933D667E
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304430; cv=none; b=PO+qxU7czWcdJ9sc7VQdzBEU73/o6SlNb0XTNgvh9V1/v6rjqS5a1A1mc95I6uQyujJn7+sup3oXYb8mB/dfdnHpsoFuPkPBsQekUWJrvTYsmXFb+EMfa4kB3R+0qUqjSuu1geRjKh74dujDx3uKH7eRaVF8fLjvaw+B+ASYbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304430; c=relaxed/simple;
	bh=oHvglOPKruBb8v3/CxYpF7DzHgE+dGuZHbuEgkrWZec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Td6mSObj2+BmrOljXFKgI798eFAyNdVUlgYIoUZF+TxO0O1qFRqZqrIbq2rB+hgVZWNy3sr6UsPC08zCWBr+LRHWQsM5OtKxfoIzgYOJ8DRXktrZHokqvaOIsFr6yDfU9xCUGkn6OT9LC3YPjY3zjVOrGLNbYAacBgWNrBpAfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwPPTQNd; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwPPTQNd"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-59d541955f8so592752e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781304426; x=1781909226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YITfAxfZQwR/2oWmKY203s9He7EuuMhN0Pj6HZ/jvn0=;
        b=CwPPTQNdItyZ1cVtfBz2Y1i39K4u/pd22tEimHd79W8Wnd3uEYcUxYiSDmK9zmyJC3
         5siqBQDK59wIiYn4EMyH7OFqzCjIvj9nLdZLOdAuO8vRt+TxiWPaDnrxI9LQ9RJfZpij
         vTjYXHVcbgbfOpj+T6KAxb9Y811BUoyAUaMu3qOOXQIM2kZAfGMWCx4NFXj0UtuA5ftV
         qrEGf6V9jjIVjfgQZwEB1gro8KwV/EY1zJfetqjUxSBoMqk8JA2WfgZev/ZnIMQCWFDq
         aJImtz1q/q4hoaSq8PILgrZDbpsYi8UELa6y8IpJ10Y+TpRgz5Dpva5YoFTPi6cfSJDg
         BJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304426; x=1781909226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YITfAxfZQwR/2oWmKY203s9He7EuuMhN0Pj6HZ/jvn0=;
        b=EOjzClQCIoxfdLDYL0U3u0UyjbW4qvZZ8KkHvuD2wEdMfAYS45Xp31uclL+Dw6fs8I
         maRrNOCP1TiicCn78XP947eLig5+BUNLtu6+ml+n+Ah1JqADvXLZG1qsUvzAc8faNWLd
         HPYn4uTWnirlfjlb7Q5lDIVvVh63zi0K8vYVb68XuvH8iKdzt0FKJLkHQd0j3pHjd+F0
         gIFwXuqaAuv7l6G73VyeIGxOrkWBSIdNwx3AUsMvqhX5o0ggVzmNdXjoKCOhEBJilTLo
         DtfLF79O2GiaggEuqbhGUkHOy3Fg61Qb0iCEmvmB+UyvkRm0sTKlio+DWGsGwrz98bDj
         VSCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tRQHoWCvtP95GlOTGba/sJ5fYpUNEy3GK6XnvJugQgZZltenUaCWT41Ubk2LBsS3UDhKEWV2ZuTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxldp8tfLQtvUmkto+s6EydNy9/j4bRRrslmERlJ9QyuHHvgfT2
	5NLRZNv27PJxKUb2PecZpaxTeUxKZvbNNLCIM4IcYaMNNEnf2jJawzHh
X-Gm-Gg: Acq92OGZnDM65r5yylF0ZWvyJzLE5vp7DNomFHq3RoF5YbbDyB4pA2ccCJgUiCq3IuV
	/mspsQmYMcLT6bq8wJF6CjcMyeuV5NQ1tWBlkRM1xi3CLpaVze/GR39Wm5cHHuSrLM+siH3Gvdy
	tnGUxvVGEoqIU0FNZc9ibS68RfX40oeHLT57Y0xJiRRe0mokxWn224NIj//ie7n21PbaYyyhamO
	uM+anRUBahSLLxcNjGQya4xuB+To6mtXHWsXvEg4JpWPmDL9l+VGfyCRWeQO5BX9KGfmj2AAnUP
	uym+v4I8VHqaSxX0uCWxEEJBFT1+H93nWc+MpBKNV/9xEo1Ttpno3hIjYX12D1xjCA7P5THgvVQ
	8iKzrk5DjrWMv9f5B+9CYROhvFZp0IcXyHG8ORiXNTa5iSO6kIn5ODXB3RFIDox5ML4GDqlDdl3
	kb87Iy8dx2r6syj1hv/NiKmw==
X-Received: by 2002:a05:6122:169a:b0:5a4:5605:c681 with SMTP id 71dfb90a1353d-5bb6bdadafdmr3420952e0c.0.1781304426357;
        Fri, 12 Jun 2026 15:47:06 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691fd8adsm4244553e0c.13.2026.06.12.15.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:47:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 12 Jun 2026 17:46:21 -0500
Subject: [PATCH 3/5] iio: adc: ti-ads1262: Add GPIO controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ads126x-v1-3-894c788d03ed@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
In-Reply-To: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5460; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=oHvglOPKruBb8v3/CxYpF7DzHgE+dGuZHbuEgkrWZec=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFk6PUmZU5d+C1WMOdvLfHn7XZ+Hh62W9MvdNyuSW9TWH
 RC0Mamjo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACYiksLwT9+I6by7ofbspjNO
 x3O19lVvlo7cKKvg/Xtf+8bq73xSOowMU7xLOl98LvzKduDQe5EI6V1a1oGRe14t2iXZy8vyu7i
 XFQA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the GPIO controller capability found in both TI ADS1262
and ADS1263 ADCs.

Eight analog input pins can be programmed as GPIO. This configuration
does not prevent the pins from being used as analog inputs at the same
time, so no considerations were taken in that regard.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 149 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index fd1911cf65ac..6d5f22836ad8 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/math.h>
@@ -314,6 +315,10 @@ static const int ads1262_pga_gain_avail[] = {
 	1, 2, 4, 8, 16, 32
 };
 
+static const char * const ads1262_gpio_names[] = {
+	"AIN3", "AIN4", "AIN5", "AIN6", "AIN7", "AIN8", "AIN9", "AINCOM"
+};
+
 static int ads1262_dev_power_on(struct ads1262 *st)
 {
 	int ret;
@@ -1050,6 +1055,146 @@ static irqreturn_t ads1262_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ads1262_gpiochip_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADS1262_GPIOCON_REG,
+				  BIT(offset), BIT(offset));
+}
+
+static void ads1262_gpiochip_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	struct device *dev = &st->spi->dev;
+
+	regmap_update_bits(st->regmap, ADS1262_GPIOCON_REG, BIT(offset), 0);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int ads1262_gpiochip_get_direction(struct gpio_chip *gc,
+					  unsigned int offset)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADS1262_GPIODIR_REG, &val);
+	if (ret)
+		return ret;
+
+	return val & BIT(offset);
+}
+
+static int ads1262_gpiochip_direction_input(struct gpio_chip *gc,
+					    unsigned int offset)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+
+	return regmap_update_bits(st->regmap, ADS1262_GPIODIR_REG,
+				  BIT(offset), 1);
+}
+
+static int ads1262_gpiochip_direction_output(struct gpio_chip *gc,
+					     unsigned int offset, int value)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADS1262_GPIODIR_REG,
+				 BIT(offset), 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADS1262_GPIODAT_REG,
+				  BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int ads1262_gpiochip_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADS1262_GPIODAT_REG, &val);
+	if (ret)
+		return ret;
+
+	return val & BIT(offset);
+}
+
+static int ads1262_gpiochip_get_multiple(struct gpio_chip *gc,
+					 unsigned long *mask,
+					 unsigned long *bits)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADS1262_GPIODAT_REG, &val);
+	if (ret)
+		return ret;
+
+	return val & *mask;
+}
+
+static int ads1262_gpiochip_set(struct gpio_chip *gc, unsigned int offset,
+				int value)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+
+	return regmap_update_bits(st->regmap, ADS1262_GPIODAT_REG,
+				  BIT(offset), value ? BIT(offset) : 0);
+}
+
+static int ads1262_gpiochip_set_multiple(struct gpio_chip *gc,
+					 unsigned long *mask,
+					 unsigned long *bits)
+{
+	struct ads1262 *st = gpiochip_get_data(gc);
+
+	return regmap_update_bits(st->regmap, ADS1262_GPIODAT_REG, *mask,
+				  *bits);
+}
+
+static int ads1262_gpiochip_setup(struct ads1262 *st, const char *name)
+{
+	struct device *dev = &st->spi->dev;
+	struct gpio_chip *gc;
+
+	if (!device_property_present(dev, "gpio-controller"))
+		return 0;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->owner = THIS_MODULE;
+	gc->label = name;
+	gc->base = -1;
+	gc->ngpio = ARRAY_SIZE(ads1262_gpio_names);
+	gc->parent = dev;
+	gc->can_sleep = true;
+	gc->request = ads1262_gpiochip_request;
+	gc->free = ads1262_gpiochip_free;
+	gc->get_direction = ads1262_gpiochip_get_direction;
+	gc->direction_input = ads1262_gpiochip_direction_input;
+	gc->direction_output = ads1262_gpiochip_direction_output;
+	gc->get = ads1262_gpiochip_get;
+	gc->get_multiple = ads1262_gpiochip_get_multiple;
+	gc->set = ads1262_gpiochip_set;
+	gc->set_multiple = ads1262_gpiochip_set_multiple;
+	gc->names = ads1262_gpio_names;
+
+	return devm_gpiochip_add_data(dev, gc, st);
+}
+
 static int ads1262_parse_channel_data(struct ads1262 *st,
 				      struct ads1262_channel *chan_data,
 				      struct fwnode_handle *node)
@@ -1750,6 +1895,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_gpiochip_setup(st, name);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.54.0

