Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CD43B3F9
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699224; cv=none; b=d5vOIbEJItDH1AipzqwiFhsknitbhrXAaQmiKwuXT/Dji5GFy+eHwipMiG34WHcJVkO5Z/A0erI+32pAva2znvG7X2XRs8bIlP0AGjEi5tcsAvp+zbnhRoLibWwBeDwdl7I4puSvshUA4acj+bocTelnEw95ewsOhTICLqX1oaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699224; c=relaxed/simple;
	bh=kAyPTH/4tiqZKHmk1hPFWby2kNutxnNPbeUwxEyjAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj+It9G9ANVTbDmXn/Z9G5uHzuvB8GRk3LYqflKFLvEkgjvliMzPL/em2fpRBPTE+rAtRvoCoGuONiaQrwgSP5A8ptupcDnJs0lx8kn8dsRpN6hcPnpU1nllUEJp6hWa1uoZ2om2mIgaI1X/0z7Kw0eK23LoW2n+tJwbORw+4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yht/750v; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yht/750v"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c93a972b9so704921fa.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783699218; x=1784304018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=htbp4eZVoCOY0ETRBZFkljATlldpw89nkTYb09YWpTM=;
        b=Yht/750vR938JQYUbyO4Q7MCItPWHRQxC9EbNE6MlylRkD5pb1Fd+AQAyulyAejZY1
         mPFngfyLxryD1Y2GKOpC3OzJFAhFkqD7K3d6w2JLzp/jHeB2yXr7uAB+6GEq31uYOfpS
         pM7Xm/6iEjdq/swvuXykTpKiCTujkoFe1y3b/maURoEp7F+xscIXEEnmijOm7CC+4atE
         mPhWkbMAKywDkMXiGd6elmUXlCmBh4VQ7hh8CnAtv5e+pHRJvSi3MZV27aLNphAXdTOP
         V/Xbm5KMH3jZiM107o2pxyb82WBcoI6GM9HVbm9cXPXUWgGuzx/Q2zftlIwGFf9lBjUV
         VC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699218; x=1784304018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=htbp4eZVoCOY0ETRBZFkljATlldpw89nkTYb09YWpTM=;
        b=JV1A9n0LjvM3UAubiU2Pge5MJet8KgQnKUUpU0bbY5R0zrGdwr/eD9+eVYKCTaSij7
         BvTnITUKLQZbjiRI4s4roJZ5NyThZqqvun+lsXu1p9mSaNYt7BRmEngZtSBqYvVW2s3q
         cq+1wZzb8MXw0fm6RpWvmfpNc/lUXQCxkH11OJCPpSR9JuOjb7SgUo/lW61iZxQE0drR
         MXtBYlq5ZQyb9NtSPGES5VPumgDF5kXR73eiehazvA+eowd59os6l7a3Yzgxx2PqnndK
         1jKzrX+FBo4haNOkTe/8VKDCrEHTNdgwvlFt+9rpk7CjrvWY2xl49vdmEeUs8oe64g4d
         dpww==
X-Forwarded-Encrypted: i=1; AHgh+RqD9fRahQY4JSJo97svLXIKDRabP/v+57FX191MSgsM2mwjxTGFs95yw0dH1HmxaW/DQca/9InHwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4u+y+RJCntKAHmoNs1B9scSa5EkEqCAZX0i11HiMzWAuRfZYB
	p14f+cOpN4mtkxpLhOc1N8UmUVN9jbGjBfvSDmlswSygMOEodNL2zE5V
X-Gm-Gg: AfdE7cm/K+Hj5+ReEmRl2FyCpoNj/cN7W6zRxk/vZwyRA0TndB+Fll/vE1VIiLHT1Ku
	BWnVErjbQznvGYoJYciQnKhT0AdOLCmrDYKjWDRl2rFC7iuQCpWm/mVjj7mLAFATOs3/sLwSLFl
	WazB1lREYv+cyr2XGnroP0+LIVe5jsrH8bymUnsXHMRr121+XVHrPEIIbzTVZiNhI2FGfRFLTJh
	1dY0ZDLF8nR0KAUK/gvGFPnS3NPhILWKf9LxJTlVbP4ldrbYm2hSsR2h1QZQmYGGfPnAgmHu3e1
	mIbnOVfjhQd/fJFzSCuirMPAdZpix5loTyTZRBcYYoR0hTJuwChHn2TriwBlEtWUHV/EGMHub7E
	AavCcrogkyjv65+Bu6B1aLMw6/Z26Sgz6vHMGYaPkglfIn/MlbIbVug+UQ57JgNfC1bk/v3GS3V
	Gk19HnCyGfqeUqkpi/ik5CzITbmoEnHFIcZmE=
X-Received: by 2002:a05:651c:2115:b0:39a:fe2e:52b0 with SMTP id 38308e7fff4ca-39c82b3c679mr10420811fa.7.1783699217593;
        Fri, 10 Jul 2026 09:00:17 -0700 (PDT)
Received: from localhost ([5.250.49.195])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b83a93sm11421281fa.24.2026.07.10.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:00:17 -0700 (PDT)
From: Taha Narimani <tahanarimani3443@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Taha Narimani <tahanarimani3443@gmail.com>
Subject: [PATCH v3] staging: iio: adc: ad7816: Use devm_gpiod_get_optional() for busy GPIO
Date: Fri, 10 Jul 2026 16:00:01 +0000
Message-ID: <20260710160001.29856-2-tahanarimani3443@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710160001.29856-1-tahanarimani3443@gmail.com>
References: <20260710160001.29856-1-tahanarimani3443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently utilizes devm_gpiod_get() for the 'busy' line,
which makes the GPIO mandatory. However, the busy pin is hardware-optional
depending on the specific board configuration.

Switch to devm_gpiod_get_optional() to allow boards that do not have
this pin wired up to still probe the driver successfully. Clean up
the redundant busy_pin conditional checks as gpiod_get_value() safely
handles NULL descriptors. Additionally, use dev_err_probe() to prevent
bootlog spamming during deferred probing.

Fixes: 3e5971b2ddb6 ("base: original ad7816.c")
Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
---
Changes in v3:
  - Removed redundant conditional check around gpiod_get_value() as suggested by Andy Shevchenko and Dan Carpenter.
  - Switched to dev_err_probe() to avoid deferred probe spamming.
  - Introduced local struct device *dev pointer in probe and kept the GPIO request on a single line for better readability.
  - Added the missing Fixes tag requested by Jonathan Cameron.

 drivers/staging/iio/adc/ad7816.c | 67 +++++++++++++-------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 988eee3..807cf57 100644
--- a/drivers/staging/iio/adc/ad7816.c
Changes in v3:
  - Removed redundant conditional check around gpiod_get_value() as suggested by Andy Shevchenko and Dan Carpenter.
  - Switched to dev_err_probe() to avoid deferred probe spamming.
  - Introduced local struct device *dev pointer in probe and kept the GPIO request on a single line for better readability.
  - Added the missing Fixes tag requested by Jonathan Cameron.

+++ b/drivers/staging/iio/adc/ad7816.c
@@ -22,20 +22,20 @@
 /*
  * AD7816 config masks
  */
-#define AD7816_FULL			0x1
-#define AD7816_PD			0x2
-#define AD7816_CS_MASK			0x7
-#define AD7816_CS_MAX			0x4
+#define AD7816_FULL                     0x1
+#define AD7816_PD                       0x2
+#define AD7816_CS_MASK                  0x7
+#define AD7816_CS_MAX                   0x4
 
 /*
  * AD7816 temperature masks
  */
-#define AD7816_VALUE_OFFSET		6
-#define AD7816_BOUND_VALUE_BASE		0x8
-#define AD7816_BOUND_VALUE_MIN		-95
-#define AD7816_BOUND_VALUE_MAX		152
-#define AD7816_TEMP_FLOAT_OFFSET	2
-#define AD7816_TEMP_FLOAT_MASK		0x3
+#define AD7816_VALUE_OFFSET             6
+#define AD7816_BOUND_VALUE_BASE         0x8
+#define AD7816_BOUND_VALUE_MIN          -95
+#define AD7816_BOUND_VALUE_MAX          152
+#define AD7816_TEMP_FLOAT_OFFSET        2
+#define AD7816_TEMP_FLOAT_MASK          0x3
 
 /*
  * struct ad7816_chip_info - chip specific information
@@ -48,7 +48,7 @@ struct ad7816_chip_info {
 	struct gpio_desc *convert_pin;
 	struct gpio_desc *busy_pin;
 	u8  oti_data[AD7816_CS_MAX + 1];
-	u8  channel_id;	/* 0 always be temperature */
+	u8  channel_id; /* 0 always be temperature */
 	u8  mode;
 };
 
@@ -84,10 +84,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		while (gpiod_get_value(chip->busy_pin))
-			cpu_relax();
-	}
+	while (gpiod_get_value(chip->busy_pin))
+		cpu_relax();
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
@@ -254,8 +252,8 @@ static const struct attribute_group ad7816_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
-						       0,		\
+#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,        \
+						       0,               \
 						       IIO_EV_TYPE_THRESH, \
 						       IIO_EV_DIR_FALLING)
 
@@ -351,11 +349,12 @@ static const struct iio_info ad7816_info = {
 
 static int ad7816_probe(struct spi_device *spi_dev)
 {
+	struct device *dev = &spi_dev->dev;
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
 	int i, ret;
 
-	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
@@ -365,31 +364,22 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		chip->oti_data[i] = 203;
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
-	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
+	chip->rdwr_pin = devm_gpiod_get(dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
+		dev_err(dev, "Failed to request rdwr GPIO: %d\n", ret);
 		return ret;
 	}
-	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
-					   GPIOD_OUT_HIGH);
+	chip->convert_pin = devm_gpiod_get(dev, "convert", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->convert_pin)) {
 		ret = PTR_ERR(chip->convert_pin);
-		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-			ret);
+		dev_err(dev, "Failed to request convert GPIO: %d\n", ret);
 		return ret;
 	}
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
-						GPIOD_IN);
-		if (IS_ERR(chip->busy_pin)) {
-			ret = PTR_ERR(chip->busy_pin);
-			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
-				ret);
-			return ret;
-		}
-	}
+
+	chip->busy_pin = devm_gpiod_get_optional(dev, "busy", GPIOD_IN);
+	if (IS_ERR(chip->busy_pin))
+		return dev_err_probe(dev, PTR_ERR(chip->busy_pin), "Failed to request busy GPIO\n");
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->info = &ad7816_info;
@@ -397,7 +387,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
-		ret = devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
+		ret = devm_request_threaded_irq(dev, spi_dev->irq,
 						NULL,
 						&ad7816_event_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -407,11 +397,11 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			return ret;
 	}
 
-	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
 
-	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
+	dev_info(dev, "%s temperature sensor and ADC registered.\n",
 		 indio_dev->name);
 
 	return 0;
@@ -431,7 +421,6 @@ static const struct spi_device_id ad7816_id[] = {
 	{ "ad7818", ID_AD7818 },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(spi, ad7816_id);
 
 static struct spi_driver ad7816_driver = {
-- 
2.53.0

