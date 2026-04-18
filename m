Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD70396D0F
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523677; cv=none; b=ppPG5Z5feJahhb7qCqNwipbHrEUtF7wPftQ2kJN+FBYUkf0i2lOgRSo9OgOESfZdFK70okb8McC1WXK4jHATKR1e+Td9ZdHY3N3a5LYRyA3WWHGo5DVw7+R5ePfA4hevFOXvEPl45sppFtCISy9mkcHTmzBgDbHHzmqZ/viOGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523677; c=relaxed/simple;
	bh=rCQzvUH792A34KGa82QobcsaKhrIVTRQsg+4lXUOtso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeCZ/dtkI002oiWNOn9RJP6q3lMCARb0aEnfxtjXo3xsZVrEQZ3jK6TGOVne4jianrVE0GT4k6wDmWJFVblFi+iCqJUblCPdkLu+KElqfyKjTN3ETBv1NP3auYJWWAHqdFkmQG6JZr11jF3Txb7WrGMQR4oNQobJcNYUfygsszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSjQpjp5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSjQpjp5"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so15735191fa.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523673; x=1777128473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T70S8dN9ner/tiva8iQd9tojxAAdiyEdJbrj8X3EImo=;
        b=ZSjQpjp5Er5v6XDasK6sabopBfrHSd9733dNHoKA+kY7LGZFOY+oZxIF9Vts2q7ERf
         uu9nynfT286Q+5yKeg/yd6e7/SBCxvJ0SQQX3vZngNWe3MO6xVTYVen57B0YhxEPlZRr
         /d4ezaMjdihzZUI8KiikJtvxNIe2XySCUtUgTYh0UQ9PiSn8MGKiuWZpwX75PVaiVHYx
         3gg3pGgzFk2Vc2awMoExCD52ovnQwNRrZTx9GAYbH3VO2qOJQBo4/P5HxTNnFRbXKM7V
         GhotQVw7VF3sTnogfg/jBep3zke/yEeLhN+f+ZylDlMS50AYxMGNG79MF1oWp8Bja6Wu
         o3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523673; x=1777128473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T70S8dN9ner/tiva8iQd9tojxAAdiyEdJbrj8X3EImo=;
        b=fvVwEotJB7vwBw1aeJMSw+b1vuKDt1g8iUmzDeQbn1xxAonxWhMcaYCzhQcvLf14n1
         dVv7OPjAvrnWhc0zDSBVHd7u7sddrvghsWrzwkHn4SmPphJLJ9GQUOSENhE1TqznA+3r
         emPCIb3y6U/TuwzMyL6sRmWOx90uJ6x7NW2WrD6JgKjQlNOtSdQDROHxoKHBMZWlZkSE
         gWfdVCBmArONE2yjWNoMvqqc40N7DmLhfGQcNB/SKDyVVfD8w2JYrhJhcLj/dNZREzRB
         RuOjqoqLvdSj5YHETTmzm0rEohXgC8YOjFUH+YQ2vCtq/rT+Mn3t4zMGS4jY7z1wAyuC
         s4eA==
X-Gm-Message-State: AOJu0YwCrYgXRILBYKivMwQovhTiQAPt5gJ9WeMZTP7nNzOLmXsY3lId
	Rzxd1v30mzPw14RCaJcBFoa3Mnh+ciTMeRgolKyQ8d3sPe6rqkgBFU05
X-Gm-Gg: AeBDieuWjBYhn7ksYAfxDdGCELQ3ZkbORX/xoNt8J+Gom+s0nhbkUyAgDuWKrefJi20
	hDa4e3hWLfz2BXIBHzWQaetwkgn+0L9y/4CYaeBd4ubd4iaAFHdCsnsbRzGsTMDPsCn9UZyQGuP
	Gfe9Tr5k1cRYeXDC0iYLcHFbjTV1/uGvHnGcaQRRJaGlq7xZ9WXeva4KK/UejTBiruYnY9TcegX
	MxsmDtat5WG/Wfbs1kDoQRqgRAINeUULb+z0XZKFsqn09u+yb6wBY8uiDSwc67PRIMpzeOSdRDW
	P1W5PquuGL5edhxtI5GQpy/906+VA/Y+Ti1AoHMIjd/OKCr3d7WBFmtdqqM93alJn+42CJpciYz
	y8tg8WbA13pdzDXxkbHkRlnVx7O1R1Ev23KjpYjLnMn/nvLu8Hlqg2yoXyWt76mlrD80McPLm78
	oEdFWU0V5u0S7xvkp31/XgJKU=
X-Received: by 2002:a05:651c:1056:b0:38a:f5a6:9173 with SMTP id 38308e7fff4ca-38ec7b4aaf8mr14252721fa.27.1776523672748;
        Sat, 18 Apr 2026 07:47:52 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] misc: apds990x: Convert to use OF bindings
Date: Sat, 18 Apr 2026 17:47:15 +0300
Message-ID: <20260418144716.132936-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are no users of this driver via platform data, remove platform
data and switch to using device tree bindings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c                | 112 +++++++++++++++++--------
 include/linux/platform_data/apds990x.h |  65 --------------
 2 files changed, 76 insertions(+), 101 deletions(-)
 delete mode 100644 include/linux/platform_data/apds990x.h

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 264335b581c1..557c8476ea80 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -12,13 +12,14 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
-#include <linux/platform_data/apds990x.h>
 
 /* Register map */
 #define APDS990X_ENABLE	 0x00 /* Enable of states and interrupts */
@@ -100,6 +101,36 @@
 
 #define APDS990X_LUX_OUTPUT_SCALE 10
 
+#define APDS_IRLED_CURR_12mA	0x3
+#define APDS_IRLED_CURR_25mA	0x2
+#define APDS_IRLED_CURR_50mA	0x1
+#define APDS_IRLED_CURR_100mA	0x0
+
+#define APDS_PARAM_SCALE	4096
+
+/**
+ * struct apds990x_chip_factors - defines effect of the cover window
+ * @ga: Total glass attenuation
+ * @cf1: clear channel factor 1 for raw to lux conversion
+ * @irf1: IR channel factor 1 for raw to lux conversion
+ * @cf2: clear channel factor 2 for raw to lux conversion
+ * @irf2: IR channel factor 2 for raw to lux conversion
+ * @df: device factor for conversion formulas
+ *
+ * Structure for tuning ALS calculation to match with environment.
+ * Values depend on the material above the sensor and the sensor
+ * itself. If the GA is zero, driver will use uncovered sensor default values
+ * format: decimal value * APDS_PARAM_SCALE except df which is plain integer.
+ */
+struct apds990x_chip_factors {
+	int ga;
+	int cf1;
+	int irf1;
+	int cf2;
+	int irf2;
+	int df;
+};
+
 /* Reverse chip factors for threshold calculation */
 struct reverse_factors {
 	u32 afactor;
@@ -110,7 +141,6 @@ struct reverse_factors {
 };
 
 struct apds990x_chip {
-	struct apds990x_platform_data	*pdata;
 	struct i2c_client		*client;
 	struct mutex			mutex; /* avoid parallel access */
 	struct regulator		*vdd_supply;
@@ -131,6 +161,7 @@ struct apds990x_chip {
 	u8	pgain;
 	u8	pdiode;
 	u8	pdrive;
+	u8	ppcount;
 	u8	lux_persistence;
 	u8	prox_persistence;
 
@@ -546,7 +577,7 @@ static int apds990x_configure(struct apds990x_chip *chip)
 			(chip->lux_persistence << APDS990X_APERS_SHIFT) |
 			(chip->prox_persistence << APDS990X_PPERS_SHIFT));
 
-	apds990x_write_byte(chip, APDS990X_PPCOUNT, chip->pdata->ppcount);
+	apds990x_write_byte(chip, APDS990X_PPCOUNT, chip->ppcount);
 
 	/* Start with relatively small gain */
 	chip->again_meas = 1;
@@ -1051,6 +1082,7 @@ static int apds990x_probe(struct i2c_client *client)
 {
 	struct apds990x_chip *chip;
 	struct device *dev = &client->dev;
+	u32 pdrive_ua = 100000, ppcount = 1;
 	int err;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -1062,22 +1094,14 @@ static int apds990x_probe(struct i2c_client *client)
 
 	init_waitqueue_head(&chip->wait);
 	mutex_init(&chip->mutex);
-	chip->pdata	= client->dev.platform_data;
-
-	if (chip->pdata == NULL)
-		return dev_err_probe(dev, -EINVAL, "platform data is mandatory\n");
-
-	if (chip->pdata->cf.ga == 0) {
-		/* set uncovered sensor default parameters */
-		chip->cf.ga = 1966; /* 0.48 * APDS_PARAM_SCALE */
-		chip->cf.cf1 = 4096; /* 1.00 * APDS_PARAM_SCALE */
-		chip->cf.irf1 = 9134; /* 2.23 * APDS_PARAM_SCALE */
-		chip->cf.cf2 = 2867; /* 0.70 * APDS_PARAM_SCALE */
-		chip->cf.irf2 = 5816; /* 1.42 * APDS_PARAM_SCALE */
-		chip->cf.df = 52;
-	} else {
-		chip->cf = chip->pdata->cf;
-	}
+
+	/* set uncovered sensor default parameters */
+	chip->cf.ga = 1966; /* 0.48 * APDS_PARAM_SCALE */
+	chip->cf.cf1 = 4096; /* 1.00 * APDS_PARAM_SCALE */
+	chip->cf.irf1 = 9134; /* 2.23 * APDS_PARAM_SCALE */
+	chip->cf.cf2 = 2867; /* 0.70 * APDS_PARAM_SCALE */
+	chip->cf.irf2 = 5816; /* 1.42 * APDS_PARAM_SCALE */
+	chip->cf.df = 52;
 
 	/* precalculate inverse chip factors for threshold control */
 	chip->rcf.afactor =
@@ -1098,13 +1122,35 @@ static int apds990x_probe(struct i2c_client *client)
 	chip->lux_calib = APDS_LUX_NEUTRAL_CALIB_VALUE;
 
 	chip->prox_thres = APDS_PROX_DEF_THRES;
-	chip->pdrive = chip->pdata->pdrive;
 	chip->pdiode = APDS_PDIODE_IR;
 	chip->pgain = APDS_PGAIN_1X;
 	chip->prox_calib = APDS_PROX_NEUTRAL_CALIB_VALUE;
 	chip->prox_persistence = APDS_DEFAULT_PROX_PERS;
 	chip->prox_continuous_mode = false;
 
+	err = device_property_read_u32(dev, "avago,pdrive-microamp", &pdrive_ua);
+	if (!err) {
+		switch (pdrive_ua) {
+		case 12500:
+			chip->pdrive = APDS_IRLED_CURR_12mA;
+			break;
+		case 25000:
+			chip->pdrive = APDS_IRLED_CURR_25mA;
+			break;
+		case 50000:
+			chip->pdrive = APDS_IRLED_CURR_50mA;
+			break;
+		case 100000:
+			chip->pdrive = APDS_IRLED_CURR_100mA;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	device_property_read_u32(dev, "avago,ppcount", &ppcount);
+	chip->ppcount = ppcount;
+
 	chip->vdd_supply = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(chip->vdd_supply))
 		return dev_err_probe(dev, PTR_ERR(chip->vdd_supply),
@@ -1130,18 +1176,10 @@ static int apds990x_probe(struct i2c_client *client)
 
 	pm_runtime_enable(dev);
 
-	if (chip->pdata->setup_resources) {
-		err = chip->pdata->setup_resources();
-		if (err) {
-			err = -EINVAL;
-			goto error_pm;
-		}
-	}
-
 	err = devm_device_add_group(dev, apds990x_attribute_group);
 	if (err < 0) {
 		dev_err(dev, "Sysfs registration failed\n");
-		goto error_resourses;
+		goto error_pm;
 	}
 
 	err = devm_request_threaded_irq(dev, client->irq, NULL, apds990x_irq,
@@ -1149,13 +1187,10 @@ static int apds990x_probe(struct i2c_client *client)
 					IRQF_ONESHOT, "apds990x", chip);
 	if (err) {
 		dev_err(dev, "could not get IRQ %d\n", client->irq);
-		goto error_resourses;
+		goto error_pm;
 	}
 
 	return err;
-error_resourses:
-	if (chip->pdata && chip->pdata->release_resources)
-		chip->pdata->release_resources();
 error_pm:
 	pm_runtime_disable(dev);
 error_regulator:
@@ -1168,9 +1203,6 @@ static void apds990x_remove(struct i2c_client *client)
 {
 	struct apds990x_chip *chip = i2c_get_clientdata(client);
 
-	if (chip->pdata && chip->pdata->release_resources)
-		chip->pdata->release_resources();
-
 	if (!pm_runtime_suspended(&client->dev))
 		apds990x_chip_off(chip);
 
@@ -1224,6 +1256,13 @@ static int apds990x_runtime_resume(struct device *dev)
 
 #endif
 
+static const struct of_device_id apds990x_of_match[] = {
+	{ .compatible = "avago,apds9900" },
+	{ .compatible = "avago,apds9901" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apds990x_of_match);
+
 static const struct i2c_device_id apds990x_id[] = {
 	{ "apds990x" },
 	{}
@@ -1242,6 +1281,7 @@ static struct i2c_driver apds990x_driver = {
 	.driver	  = {
 		.name	= "apds990x",
 		.pm	= &apds990x_pm_ops,
+		.of_match_table = apds990x_of_match,
 	},
 	.probe    = apds990x_probe,
 	.remove	  = apds990x_remove,
diff --git a/include/linux/platform_data/apds990x.h b/include/linux/platform_data/apds990x.h
deleted file mode 100644
index 37684f68c04f..000000000000
--- a/include/linux/platform_data/apds990x.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This file is part of the APDS990x sensor driver.
- * Chip is combined proximity and ambient light sensor.
- *
- * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
- *
- * Contact: Samu Onkalo <samu.p.onkalo@nokia.com>
- */
-
-#ifndef __APDS990X_H__
-#define __APDS990X_H__
-
-
-#define APDS_IRLED_CURR_12mA	0x3
-#define APDS_IRLED_CURR_25mA	0x2
-#define APDS_IRLED_CURR_50mA	0x1
-#define APDS_IRLED_CURR_100mA	0x0
-
-/**
- * struct apds990x_chip_factors - defines effect of the cover window
- * @ga: Total glass attenuation
- * @cf1: clear channel factor 1 for raw to lux conversion
- * @irf1: IR channel factor 1 for raw to lux conversion
- * @cf2: clear channel factor 2 for raw to lux conversion
- * @irf2: IR channel factor 2 for raw to lux conversion
- * @df: device factor for conversion formulas
- *
- * Structure for tuning ALS calculation to match with environment.
- * Values depend on the material above the sensor and the sensor
- * itself. If the GA is zero, driver will use uncovered sensor default values
- * format: decimal value * APDS_PARAM_SCALE except df which is plain integer.
- */
-struct apds990x_chip_factors {
-	int ga;
-	int cf1;
-	int irf1;
-	int cf2;
-	int irf2;
-	int df;
-};
-#define APDS_PARAM_SCALE 4096
-
-/**
- * struct apds990x_platform_data - platform data for apsd990x.c driver
- * @cf: chip factor data
- * @pdrive: IR-led driving current
- * @ppcount: number of IR pulses used for proximity estimation
- * @setup_resources: interrupt line setup call back function
- * @release_resources: interrupt line release call back function
- *
- * Proximity detection result depends heavily on correct ppcount, pdrive
- * and cover window.
- *
- */
-
-struct apds990x_platform_data {
-	struct apds990x_chip_factors cf;
-	u8     pdrive;
-	u8     ppcount;
-	int    (*setup_resources)(void);
-	int    (*release_resources)(void);
-};
-
-#endif
-- 
2.51.0

