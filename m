Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B081326928
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348606; cv=none; b=MZDSV3WIl14zXZtqylp6aYpMC8b0KmH8GcqYLYokXhEEuGrGCMZirhFg1Q/gOwqEglWqdi5yjPcWNAOLzMWHW0dFuBEADIIZzdAGHfISAc4eJkvjilYImS9ghN63Q4Cc/BbFVNJigEhXOrfWvuPvHBHMuzaqLgwG4cDMmQE7m6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348606; c=relaxed/simple;
	bh=/aEpFKjR+JV4pOYzDkZqOZgmIyIl0ijhVCjsZyzmokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K++tK8odlf9mkhIl9NMxDO+Qll5ojIDhO2zWCl5jfpTZh2SbGvn7bO1MJu3JIDmaYeCflyiaqjpcmO/vt70Ee0y7Pn74m3Hq8XLJ3c+ooUaTck1p4IevREIK/ASRVqdRP3ceFdhC7K6cxOeOrapGQb43QukFsZmeGCviCM89Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJKZ6RPz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJKZ6RPz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso28433065e9.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348603; x=1769953403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRbIbMdeNel2KOGXl53uBpMxFpiNgiTsob/4xIgOxPM=;
        b=hJKZ6RPz2KF4dSi4muBoh04J8jp4n902LMDJU6Bm9LzmrfBn+Tgnpn4iXPextzPDaB
         VoVARJZQWu7lm1uc+82s+OiHJXG5H37tZlpj5zD8Zs3h3OJek/MnV4B7gCdU1fvrt++P
         YFI/h+3Jr1PmC3TzHfAqtGEeWVW1TSuyq2DGO8AleOvazzmc4h/4gQsrmaci9TUnUesZ
         UFMKx2mi8OPYF3oP1XyQVFWL0vkabqHVq91tgDURTCpuQ0C64eANCWJ2rzGGIzea8NHA
         E3V3TAeDS9r1OfHwab6dOQmDp2CrkgwmqlqlZZb83vaAVQo3Z+etUcPauKLP7+A52lmy
         rGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348603; x=1769953403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRbIbMdeNel2KOGXl53uBpMxFpiNgiTsob/4xIgOxPM=;
        b=E3dN2vjmoA2COatlS3bLlcibgQ6PFXKycW4VIRGz456ofYgpNwAmCASFMvq+7O9dV/
         Ai4+YVjLy1BBJWTiCUVG8pT7wSkzQr4HqqODXOLBT6BWq5n5sqI3rIAmYeY/cu5Zj80Y
         vkiT8L3VgulsZvtbggtsjUT1jrbP/KyHxVo33dplvosya2RVVVmTXXFgo3FjH1Dlv/b8
         3k2O1OcTZWpfLvGujYiEsBgpK/dujn5wZVH0F385zcDe6hppw6W1ms3fo7WpiCNOABgB
         OVLZtJ+/EGHQC13/15b7osa99EplSUkm9wYlGdi3pj+xMSqfL1262hs8V067lX3lxrQU
         sQVg==
X-Gm-Message-State: AOJu0Yx6WYHRQ+Ippi0ZLxvPJ1Dw9PkAHCcVid/0CLv/t3Eoo3NdKUYQ
	5WqtaQcFiAzodbqESKd5XOz+5xNrOOo2gf+e1yo/oTOwc/BjK3bdTdCQ
X-Gm-Gg: AZuq6aIsRYJ8aJTs3Z4wOGo9LDQIZkkCPnzuDqFiKwbqsoI2xcVkBvnGUVDmioqkzk5
	5bIZ4X/7apBmoz0vRnI27XirfwwwRKEBXkBqBwU7nkYFjjIbijnjM0s6xQB2irlRBfNNP8XXNYb
	Vyu6Y+SQ7HKu/vNStU4lckcwHA8DtnsevcPIg/EMPM7ntRlOZqWnhqFYD8Lr831kpz8hyesu1fW
	8fHTAE0FS0Kg96yHCzG7obxTpgTsGJ5paEj5xA+KeBju7oMizO5c6TlhjtQciD7IG0ol5tJFvCA
	oUlcXv/3+21IHAYGDby4HBObqzO+CjmS9sonW4VCnalFL3vulXQmANiOCssYHAV8r0FnyHCmb6L
	fIXQlnSTcUxie9XmRDJcKQaLb9D+mGKD9bGB7WhCKnUlZ+Ny8NYYa2f8Indd6wfQ8nz2q2tD5mA
	k2
X-Received: by 2002:a05:6000:2512:b0:432:aa61:a06e with SMTP id ffacd0b85a97d-435ca1adefcmr2888121f8f.32.1769348602622;
        Sun, 25 Jan 2026 05:43:22 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 09/10] mfd: motorola-cpcap: diverge configuration per-board
Date: Sun, 25 Jan 2026 15:43:01 +0200
Message-ID: <20260125134302.45958-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MFD have rigid subdevice structure which does not allow flexible dynamic
subdevice linking. Address this by diverging CPCAP subdevice composition
to take into account board specific configuration.

Create a common default subdevice composition, rename existing subdevice
composition into cpcap_mapphone_mfd_devices since it targets mainly
Mapphone board.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c | 89 +++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index d8243b956f87..ebe525153c33 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -24,10 +25,16 @@
 #define CPCAP_REGISTER_SIZE	4
 #define CPCAP_REGISTER_BITS	16
 
+struct cpcap_chip_data {
+	const struct mfd_cell *mfd_devices;
+	unsigned int num_devices;
+};
+
 struct cpcap_ddata {
 	struct spi_device *spi;
 	struct regmap_irq *irqs;
 	struct regmap_irq_chip_data *irqdata[CPCAP_NR_IRQ_CHIPS];
+	const struct cpcap_chip_data *cdata;
 	const struct regmap_config *regmap_conf;
 	struct regmap *regmap;
 };
@@ -195,16 +202,10 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
 	return 0;
 }
 
-static const struct of_device_id cpcap_of_match[] = {
-	{ .compatible = "motorola,cpcap", },
-	{ .compatible = "st,6556002", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, cpcap_of_match);
-
 static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", },
 	{ .name = "6556002", },
+	{ .name = "mapphone-cpcap", },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
@@ -241,7 +242,56 @@ static int cpcap_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
-static const struct mfd_cell cpcap_mfd_devices[] = {
+static const struct mfd_cell cpcap_default_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-usb-phy",
+		.of_compatible = "motorola,cpcap-usb-phy",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 4,
+		.of_compatible = "motorola,cpcap-led-cp",
+	}, {
+		.name          = "cpcap-codec",
+	},
+};
+
+static const struct cpcap_chip_data cpcap_default_data = {
+	.mfd_devices = cpcap_default_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_default_mfd_devices),
+};
+
+static const struct mfd_cell cpcap_mapphone_mfd_devices[] = {
 	{
 		.name          = "cpcap_adc",
 		.of_compatible = "motorola,mapphone-cpcap-adc",
@@ -285,7 +335,12 @@ static const struct mfd_cell cpcap_mfd_devices[] = {
 		.of_compatible = "motorola,cpcap-led-cp",
 	}, {
 		.name          = "cpcap-codec",
-	}
+	},
+};
+
+static const struct cpcap_chip_data cpcap_mapphone_data = {
+	.mfd_devices = cpcap_mapphone_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_mapphone_mfd_devices),
 };
 
 static int cpcap_probe(struct spi_device *spi)
@@ -297,6 +352,10 @@ static int cpcap_probe(struct spi_device *spi)
 	if (!cpcap)
 		return -ENOMEM;
 
+	cpcap->cdata = of_device_get_match_data(&spi->dev);
+	if (!cpcap->cdata)
+		return -ENODEV;
+
 	cpcap->spi = spi;
 	spi_set_drvdata(spi, cpcap);
 
@@ -331,10 +390,18 @@ static int cpcap_probe(struct spi_device *spi)
 	spi->dev.coherent_dma_mask = 0;
 	spi->dev.dma_mask = &spi->dev.coherent_dma_mask;
 
-	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
-				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap->cdata->mfd_devices,
+				    cpcap->cdata->num_devices, NULL, 0, NULL);
 }
 
+static const struct of_device_id cpcap_of_match[] = {
+	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
+	{ .compatible = "st,6556002", .data = &cpcap_default_data },
+	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cpcap_of_match);
+
 static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
-- 
2.51.0

