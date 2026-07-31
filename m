Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E6400966
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497830; cv=none; b=rM5CaqSS5+8GrsIF69J45RkUWtoSrJo8fPDExU520XyclQX2mOBf7QxO40/FsQZdgU34e9aFuMuyGyRcKpbQaHI9bwaYYHM5MaPbAxpprXPE2dXIpzEN2G+Nk17UayV19ElzUXQ3F2jB3dYj9gSKkmICvJXiHDTgJ8MEjMkmIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497830; c=relaxed/simple;
	bh=vOJZIL8hR0cnu0DgFb5kL+GSXYmqw7zQYPQUbRUs9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRPvu02GWBFxJ5zETu0nBFlSYyvpouqzIbzxKuWrogF2NTKirsKC8nWX+ZlkFIylQ/g1sUcmoEz1xyZIZUNzMEzszUekS+V6QgPSyUmxpso05DcisAdicCKNuFnEasFJTKpcdzNL9qgeZiaOIXB1ZgNI74Pb+dp1HngnYRAagno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQM70YjR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQM70YjR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so669099f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497825; x=1786102625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ircJJN/vjkOsrZPEPqNXfhhtl9Kl7VXZaKYIBCeg3Vg=;
        b=NQM70YjRUso0HBskcENn5rDD9M/+tp7M29W+Ogvltken9MkqJj7A0yifdU57jIQl3D
         jahrrAyoZjAtVKxHOs5bxK29uC97NNxmY47tK4AL6Tn+ZSn2SRVuszfXpgRMsMxSnKqm
         r0DBRLvY380qoAyLo/iak0kRRj68zefMh2HzCm5ghbECptch5kfpmPJ+k4JjRm1veco2
         vSvyx9bk4fEsLuCubIE7PGkQ6f2BJ1xEASENWq0qCaYyzkavoTI0pu1jKkok7eQm3V6h
         DRGvw52l9nAUwcAL1vmahJWozRnjDB5ktDqFRpUowiSWR70mv31wyXixvG4NdyMvY3oj
         cMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497825; x=1786102625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ircJJN/vjkOsrZPEPqNXfhhtl9Kl7VXZaKYIBCeg3Vg=;
        b=CJJAlNevdEBvgF0Ba1MQnYfHCFfQm4+thaJdZv/MoWV1oPDmD7kkKDqTkN2eyLEpch
         ulvyAo3qDCeJfCcFNmNRdnFprKxk3s+dOqKZwKR4EcnlgTWjC93tEXDrMzNFtJCSWneQ
         JBVzzdJrX/mwnCZdOGprVUFSqe3LS1mU2evrfRxUULGfw/ugzpi+eYN0JCgA+Z5iHWVm
         ieD+vkHD/C9oQP1TbXgWCJH09UvVeVLtBky18QpNASR8B0GU8NxZC5gJ7ngC054TjNvL
         1fH+x8nDBfD9tb4lZ0fyD8UAauHPOjLYv4/1Yi7iktFNqXluEJrmFX1WUyEw6fSUrDG8
         /wUQ==
X-Forwarded-Encrypted: i=1; AHgh+Row5pnF6SKV0Fc7k46tYs047+v1EETDEGECiWisTCfNLwYmZ5T4e2pyZzW8HTKpSL4Guusk9b8MtCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAlGeK24gfU5FeZsEewILN73/BdeT7XpF41Nf0xq/bepL0EoN
	45MT7Ud17eHUh/4SY6yod6tXYiH1uEfAz4b+2U5aEpBnZ1eYkXhxYIz2
X-Gm-Gg: AR+sD13uZ+tLhosZK4n06ZVBobspR96C+uBHlaWObwbgKLQdBCU31kIC5njU7NIz2dZ
	BMDINHZ9/Q6aWKxroVians6s5orBj93G6eg9RyqkbhitbiKxGjL9Zr7UspEDi9gPLhibK3KCPlT
	4llOogdhBsDDL2tseIfi9aRusJFN8NEA43gbtxx8NoFu322bjJ1apJ5F0kcspjKEfpK6Uzb+4Rj
	grtOA2uz8wAu68sRTivRK9qcR7O78vx/Oikq3L6dGmHDcD0oKe0yyhGd26dCNMyADyxvqJSCULn
	AtnRL2G5tvdFtgMJ4w++TtWSrL5BIIhBxQZ7cpAcqLAlnu8Q4Jmnoc7jhcdubSSXNIPJn+r29sT
	9eFw7OMCjgajIftRMAyhFSCOe4cuKUawX4PdRBntIt7klzC9PA268XjNIpVQvbryHbadov5CldF
	RtOHr26BbG/1WLyIpgQNuRaKz9fQX0DjxJ0GwRjiDJtOZOvIncJVyK8hQs0jZB3q4jRbsvEhh8y
	PYwc0QP0g==
X-Received: by 2002:a05:6000:420f:b0:46d:d6e0:9cc8 with SMTP id ffacd0b85a97d-47fd2b56316mr3933735f8f.46.1785497824680;
        Fri, 31 Jul 2026 04:37:04 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:03 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 07/14] mfd: lm3533: Use dev_groups in struct device_driver
Date: Fri, 31 Jul 2026 14:36:25 +0300
Message-ID: <20260731113632.158440-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/lm3533-core.c           | 16 ++++++----------
 drivers/video/backlight/lm3533_bl.c | 22 ++++++++--------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 5baf934fac825..53b87958c2c68 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -294,6 +294,11 @@ static struct attribute_group lm3533_attribute_group = {
 	.attrs		= lm3533_attributes
 };
 
+static const struct attribute_group *lm3533_attribute_groups[] = {
+	&lm3533_attribute_group,
+	NULL,
+};
+
 static int lm3533_device_als_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -414,16 +419,8 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
-		goto err_unregister;
-	}
-
 	return 0;
 
-err_unregister:
-	mfd_remove_devices(lm3533->dev);
 err_disable:
 	lm3533_disable(lm3533);
 
@@ -434,8 +431,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
 }
@@ -530,6 +525,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .dev_groups = lm3533_attribute_groups,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4d6f680334802..9ef171d3aaeab 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -237,6 +237,11 @@ static struct attribute_group lm3533_bl_attribute_group = {
 	.attrs		= lm3533_bl_attributes
 };
 
+static const struct attribute_group *lm3533_bl_attribute_groups[] = {
+	&lm3533_bl_attribute_group,
+	NULL,
+};
+
 static int lm3533_bl_setup(struct lm3533_bl *bl,
 					struct lm3533_bl_platform_data *pdata)
 {
@@ -304,28 +309,17 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
 	backlight_update_status(bd);
 
 	ret = lm3533_bl_setup(bl, pdata);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	return 0;
-
-err_sysfs_remove:
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return ret;
 }
 
 static void lm3533_bl_remove(struct platform_device *pdev)
@@ -339,7 +333,6 @@ static void lm3533_bl_remove(struct platform_device *pdev)
 	bd->props.brightness = 0;
 
 	lm3533_ctrlbank_disable(&bl->cb);
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -377,6 +370,7 @@ static struct platform_driver lm3533_bl_driver = {
 	.driver = {
 		.name	= "lm3533-backlight",
 		.pm	= &lm3533_bl_pm_ops,
+		.dev_groups = lm3533_bl_attribute_groups,
 	},
 	.probe		= lm3533_bl_probe,
 	.remove		= lm3533_bl_remove,
-- 
2.53.0

