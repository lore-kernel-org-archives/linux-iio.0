Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75E3BB113
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161548; cv=none; b=pCEsxulFF/DPthf10iIA1LLDtVIX0Pd6KW/QBPXEJu+uPOXzBoO2O5ZmOATBtqGqW9yakYZ2NFmux+u0rP9G4Ee1WTNN8g71MZmvpzgW1hE3sR4Fn1i/wIeCIk3enbL8bkb4qdxrExc3XvB0a0Sf3bUvhB02AboiIY6yH5puIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161548; c=relaxed/simple;
	bh=eW+qHE1g1yIqP4HICEETLIrGwlRb8wRg2/fNm4tOAkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwVf8JVWMSjdPf+/HgPLkiu8hODAoKybVYeCrvQOfFdoqWdDCOLawP32WUr8JSFGWX7pg9pZIKyemFAsrYr1MdwehQvq7m8y1lgvwmXjitXCHgG8GtTJ1vXnbLP7kl/+4kiP/kUQonKhq9zFQIMB2XGPLiNKi41PTn4P7fhGuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd3yAujz; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd3yAujz"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-745659c70ccso42068137.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161545; x=1786766345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwC1tObfEFZljzYy9BprIEzEE722iBsLt2gGX9PnCo0=;
        b=Nd3yAujzXbZvMBVtkypTiN8vAiNfw0S9pCojJVwZx/DFKQfCmFyLfdFyeZszUtFT6A
         pc2GAuEgeyG6Dxu9JUbYAaWQr2EUc2vxRWHuOKKA6ZvsSqtnxtG6qxZMqW1s0ZvW5K0Q
         2EeZBcAqq2AxCxcTk6EkVx168uB7TjdtFoeUsrbECL+9XJ9ubbcdGKhU8hdoUqSYRHGo
         cwIdVOZ6BV/JEJyFNX029HfU7DbOUqBB/RddxWkd3Nb6Cb+hZk6YH8Jg17izbP+wdlSJ
         DUG1iGpf2/kV0CkW0xmwNidnX18ZKvc0UDpMvR8BGfyNqKe1ctIHPifW0ej6lqE4AlNh
         DQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161545; x=1786766345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NwC1tObfEFZljzYy9BprIEzEE722iBsLt2gGX9PnCo0=;
        b=BUPluw9D6Ml4tffRpSCq22BBZmTysQuSL+7j63RamxYTFOx/jMTNHAlY3Qocvd9vb5
         188K82pl473cSrbhGhDHqRDVtFOBauFJFSM5ofJcqfvRLEUZjTcUxrauChtlRfAB5d+4
         WwAvp09tFl2zPdfgKoQAljttZVkKEDcTEYe8GTb5jGKniL980Y4PJOANMIyr3M6SJ/d2
         7oHYTjGIXr2NRAS+vFCCRll9EEVlxuek0mhi0Gy9edrP2P/NK1xoq2r3oXzBCrO6Erus
         Akv6Wy7CTom1aXqpOEXgu40jeuAiuv6hy9ay5Uj3w7/uKrDbpPBxMUP475B5qNWnxGii
         y/Lw==
X-Forwarded-Encrypted: i=1; AHgh+RpjI3JVNZ10acHefBF0pY/z9ujzl1Q3eIGv2yKd+pbidMHQZBJYuOEY0hbMe+2Dinrr7KnnhnJM8ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1gvBxCttUZ95pm2nr3RxtTbfuECzEZ+NPA22cJGvb/XXZ0U4
	m7qlht1YjcuJClEuYetlnybldqWzKhR37pO44lwZwap7loM0jcUI/xkV
X-Gm-Gg: AR+sD11Xg5hjbk+0nSjhXhPWYI1OMvu8EoWgTD4w4NyTvgsCrR0bHpy5+lYPlxOqSY9
	H3yoSBFrtAAAHW/9eDR7qHKYMKfK0bS2CL8rYjWKBjBth4b9nd6HDN0xulBlSzTT9gFWlmfYMPU
	Mo1GzF41Mpu/Z+PbEBH0dwsbw5f68oQHnsLKBsR4ZjQtUN41TINXx+H0jo2pGxlxmzBatH1sW+D
	a6/2mc23jZOmEcGrioQukAPF1539s3WY1kWljoONtWALxnn0wOy9PFezF4wGSeW+mwVntIy9OZ3
	pclWK0IhazPSTLmHlb4zMlVtlQmGelNf4eqJA7vIOuy+DQo7+0n1jirS2Zm4aj9u1WNyQyJeX86
	Ex5rtsWuL691Dvlsh4AK8FzH8SJa2OHhpH1TeJs4QKTNrxmhE2ZuIJ+CJojqLhBYp6MUcnKJr8v
	gkp9kOxqu0WpJgjmy/VmEmFAQGTC0ghPdfr5IRxDMQWMkd1qV1uv+ZABIRUiQ=
X-Received: by 2002:a05:6102:3c8c:b0:740:2d81:c2a2 with SMTP id ada2fe7eead31-760e95439bdmr6959985137.10.1786161545250;
        Fri, 07 Aug 2026 20:59:05 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:59:04 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:30 -0500
Subject: [PATCH v3 8/9] iio: adc: ti-ads1262: support REFOUT and VBIAS
 regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-8-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=eW+qHE1g1yIqP4HICEETLIrGwlRb8wRg2/fNm4tOAkU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllKyvO6WdGbrvTt2BR5cN5Mx19G2uXd2kfsDQ9uNtu6
 duN6zxPdZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEAsMYGWY8mVJwzVUn/DHT
 LqvkqRaWGd1Pq++k78w+YcXNGHs46ycjw8IDy84s/ThLcmFpcsvyOY6P7mgryF9Y03DaqO+q0Zn
 krRwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Register the "refout" and "vbias" regulators to be able to use them as
common mode supplies.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/Kconfig      |  1 +
 drivers/iio/adc/ti-ads1262.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b9b561be8347..e5206438ac90 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1845,6 +1845,7 @@ config TI_ADS1262
 	tristate "Texas Instruments ADS1262"
 	depends on SPI
 	select REGMAP
+	select REGULATOR
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 24a7ecb9fbd4..533574169b04 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -26,6 +26,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -961,6 +962,91 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int ads1262_regulator_enable(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_set_bits(st->regmap, ADS1262_POWER_REG,
+			       ADS1262_POWER_VBIAS_MASK);
+}
+
+static int ads1262_regulator_disable(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&st->xfer_lock);
+
+	return regmap_clear_bits(st->regmap, ADS1262_POWER_REG,
+				 ADS1262_POWER_VBIAS_MASK);
+}
+
+static int ads1262_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct ads1262 *st = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&st->xfer_lock);
+
+	ret = regmap_read(st->regmap, ADS1262_POWER_REG, &val);
+	if (ret)
+		return ret;
+
+	return field_get(ADS1262_POWER_VBIAS_MASK, val);
+}
+
+static const struct regulator_ops ads1262_vbias_regulator_ops = {
+	.enable = ads1262_regulator_enable,
+	.disable = ads1262_regulator_disable,
+	.is_enabled = ads1262_regulator_is_enabled,
+};
+
+static const struct regulator_ops ads1262_refout_regulator_ops = { };
+
+static const struct regulator_desc ads1262_vbias_regulator_desc = {
+	.name = "vbias",
+	.of_match = "vbias",
+	.regulators_node = "regulators",
+	.supply_name = "avdd",
+	.ops = &ads1262_vbias_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_desc ads1262_refout_regulator_desc = {
+	.name = "refout",
+	.of_match = "refout",
+	.regulators_node = "regulators",
+	.supply_name = "avdd",
+	.n_voltages = 1,
+	.fixed_uV = 2500000,
+	.ops = &ads1262_refout_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ads1262_register_regulators(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = st,
+	};
+	struct regulator_dev *rdev;
+
+	rdev = devm_regulator_register(dev, &ads1262_refout_regulator_desc,
+				       &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	rdev = devm_regulator_register(dev, &ads1262_vbias_regulator_desc,
+				       &config);
+
+	return PTR_ERR_OR_ZERO(rdev);
+}
+
 static int ads1262_dev_configure(struct ads1262 *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1707,6 +1793,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to configure device\n");
 
+	ret = ads1262_register_regulators(st);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      ads1262_trigger_handler,

-- 
2.55.0

