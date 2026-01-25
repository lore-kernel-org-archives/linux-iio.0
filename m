Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FE3242AC
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348607; cv=none; b=ixozBN8PiaBQiy6BPR6lciB9TuCx4K0WaXEqOxBgGZ7Y9XnsbCNaOPcVeuk36jBrLAVwVXt0gv5Yl9+VCsMucsyTpwHxxxEYMSvFHc1yKJ1ZBLQKdyYv5mBtv3FaK9fMq1gbqfkYpyASgYApUxyyfwrNCHjzY1Q4RKVivYRpZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348607; c=relaxed/simple;
	bh=UpT9w/j7zvETDPr3pit94FmYLQ42Xbc6IpVqIuRWkm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcTHexylCLLbS6I2SQgY5hTrLolbWUSwx0+2+TYRQ6WDO7oF3lFAYBzVpKTax0pMTbLxnPTqev9dOYzcvXsiTEivdtE9RmA1XlLcQ59yHuWsRbrFXOTDxmBwaOUBtGyxQKN/G2OH7vl3tSWDfOWcadcfMrYZ2FcTv0lOg3DDgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGliBi65; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGliBi65"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2c96215so3306498f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348604; x=1769953404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee1LhLt59IQBOhKFGdg8xp5N7suKg45Yt/yHFoSdDPo=;
        b=PGliBi65kNX3NrDkikj9jo1gtjw1tZ49ragVXBs7VKYRH/yU0fsvsavM7itKgul1Zd
         Y9NoK0GQI78Ny4rm/FKNRZrLQ0lSlWTjszm08rf3oJ3hKOxscedMuq0/2ED8afHpBuuV
         jPvpl1N62K0NvrH1sYcNccDAn4KGcqOebMvZqVHo4McPwF6l3coYVddMsxi114dq7Ozj
         nRKP28J9dlq39Qzmn7UIeRc5ieVAoS6SLmKheXO4/evnDuTHztSssZFK2vu2E8Jmo8xA
         mhtVuNQWEiBlMXvMCAPdFrbsqk+6zoOnLcES/akk/MRu2c1C9oRv/ae/UwyJoPPX3qJ1
         TBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348604; x=1769953404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ee1LhLt59IQBOhKFGdg8xp5N7suKg45Yt/yHFoSdDPo=;
        b=aRl/aEqsxRUWt4kTDmxYCry0WY5Sloq5cldTAAOh7upirucoDC/0jqIoDKscj4aUi5
         2WdiVjz0rvXzPmf21tWkUYFVg3xXbMCa7v274RAkgfAHbeIMoizMD4Oln9zU3B1ruPrk
         HGPjMy1cXwFwrzyT6v2kvSjbbYpwIOsPUw8Txn27Q7aJOeppJPBoTFydNgMRd0zyxZHP
         JtzBbieQipsBOtqKJXNN6dKwLRxrheEF44s7Wx7ticoRiahUMkShLzCy+EeHiYRZ9ebx
         7g4TIATkxRaXdaW/oFo+JitU12jcI4bfh8EoyO5WdU4lR1dgfxzaRR63UJp+M+LNm2qu
         Qd5g==
X-Gm-Message-State: AOJu0Yz+9/OiB8t3got8e4DNczXnZilKcdu8K9FhKNbZnHyHqeBdZDTY
	5vamY4577UQ7h3/YROYsjanMwKYiYWbocAcrCePfFceixfXjxOB5Sa4G
X-Gm-Gg: AZuq6aKP52lRBJcYNblHVyZb2zW9lUp3w1+5Ip9r0DD6KOpDPRhGhd+AzK2rJz17+U7
	MBT+DSevNU30AHrU70/G5hNE4MINlyJkDg6ok0mCCUoNITgRXFI1IwPeyUkw+eEtJSxNo4TWKeW
	oqls0Xfr9GLz8c8HK+8Q4ktRjR4GzS/0JPVU48ggKab2XlTm9nCOOKE0/D1ibT14xYRxYvGQNfQ
	FsSZ77ufQ/zo6jQAO68VPRM5sqdx6WMsRa2OA5sNUO49uqGGIpXb+187SQdX7Em0sAtO3oRj21r
	oc5PB7pT9JNfHCrH5/OZhAUIrfx6Sz9aGprv92oxszv6OTmygk9ZIhZUsBWs4psyPIJjDbKXbDg
	fv+J6Bx+AwxWOLpKoQsgh18A+FUw+pJVGKvTYl3vD/hXOW1h/tkQD7ck8OzMZBCgYxo00MBSEhn
	+6WdASBLep8sE=
X-Received: by 2002:a5d:5849:0:b0:435:b020:30ab with SMTP id ffacd0b85a97d-435ca0fbbfemr3062531f8f.15.1769348603864;
        Sun, 25 Jan 2026 05:43:23 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:23 -0800 (PST)
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
Subject: [PATCH v1 10/10] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Sun, 25 Jan 2026 15:43:02 +0200
Message-ID: <20260125134302.45958-11-clamor95@gmail.com>
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

Add a MFD subdevice composition used in Tegra20 based Mot board
(Motorola Atrix 4G and Droid X2).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index ebe525153c33..c475eef30f22 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -206,6 +206,7 @@ static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", },
 	{ .name = "6556002", },
 	{ .name = "mapphone-cpcap", },
+	{ .name = "mot-cpcap", },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
@@ -343,6 +344,49 @@ static const struct cpcap_chip_data cpcap_mapphone_data = {
 	.num_devices = ARRAY_SIZE(cpcap_mapphone_mfd_devices),
 };
 
+/*
+ * Mot has usb-phy and charger similar to one in mapphone, but
+ * since Mot is based on Tegra20 it is incompatible with existing
+ * implementation.
+ */
+static const struct mfd_cell cpcap_mot_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,mot-cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,mot-cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
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
+		.name          = "cpcap-codec",
+	},
+};
+
+static const struct cpcap_chip_data cpcap_mot_data = {
+	.mfd_devices = cpcap_mot_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_mot_mfd_devices),
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	struct cpcap_ddata *cpcap;
@@ -398,6 +442,7 @@ static const struct of_device_id cpcap_of_match[] = {
 	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
 	{ .compatible = "st,6556002", .data = &cpcap_default_data },
 	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ .compatible = "motorola,mot-cpcap", .data = &cpcap_mot_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
-- 
2.51.0

