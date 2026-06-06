Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D22F8EBB
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721908; cv=none; b=SXMUxbWXUJtHGetJWaHUaydNA1Ho7nGoKpDViD9bUxEBL+pu1neqAWlAdpPl7/vE1guaTNSIB3kdrgsLTpq//BZdTFz4vQcvhwCFX4D7DRIVqpreN7XNzPEd7xtAcOaUvn+qsLwXDCAXSKHr5XpDjzHrLVKM5xh/oOG7vCcb4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721908; c=relaxed/simple;
	bh=O+IQDDaskjpiY9H7vh3SwWeHCbOSEhzjDI8laqLbRkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qj1Ick9RwCP9pgxDNQsd6KWSOD2dZE8MhbweW91yJ/y5tYf0ZSbCFf6gCO2f93g5vOlFa+8x8t18YMd7BScJYWa2B3ADv2GW4xzkkOEyINmXahSoZT/I3vZaHHml5HJIE0YhMfrSBBi9G8rQxJRvP62glgq0h2y3alVMCD0SE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E49JGrj4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E49JGrj4"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso1485762a12.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721905; x=1781326705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
        b=E49JGrj4Nx+Ge9LGt1wMJ1FmPcIKiAT5nYDYu7F9BK3kHL0NhPX2bABzkD+KSEC8RB
         93lXRNaJatpao2sKzCk5RD79L4Yl258IZmVVwamxpPPt+dO3kkIjHxXMsDhraXFC48IU
         rNgDAP+LGeSrph0vwpHhNvlyvoc1d296v+wCYoZmhV9RiREZo5Vh4LiHsdSIK6BliRJ6
         WBjPVEojKkPX9vEejLxNAD8i5HDk8AhZfNpFWR1U70JBk0pImX1mjGOB1OOf5lMvIBoj
         veErV2Ym4lq8fJxmk3eCyJIJxIfREbGEF1nvE5p8j7PxYJw0u8utWfkudGYdkYdR1Q25
         B9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721905; x=1781326705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
        b=pdEAY+n9AFRrh4BiYSEFlOWHqDZIKWQnPrT7GptdaGY6DiiPti073QlJVm4VxzTy7M
         w+4Ln5gXr+Ara0uQInhYiaNEIizrHVyXnV2816/w+OPCG5E3T6OWF36qiVQ9m7s3ajaq
         Q/VTFmanrbQzvbgaEa4Gmt3fm/6j+JIoppwiZSD4kQ6Lhox5toHSkObvJR1QigS/XP9B
         ULj3mnxbfW3GKxps9MNUxa0nSVfiV9/NaGrLcfQiC5l2tgPPgarx9PWABSjYSE3jpumO
         t4jG+IMZr5vsXZ6G/OfY17JW7nUEY6Qd2wY70EkkkZ+Gg6wp7piC+GjxsCG2PbhJKX4p
         O6iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ws6CaY2fOdoHTYexaGrBkhUscxhxx++8UDy/lBWP4cnxY+dTKFO+ltKzaT0svX/gw4coK14reuGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPp02cjQhInkT1AkmjTQf9J8EbYpLw8yBPz+lgrL04A5LhLvkY
	DH5EuLiboflJQtA8cA2Nx3gGDWn8VNELhhUeuGoGqKjEMQQuiLtBNZDT
X-Gm-Gg: Acq92OFQ/LDfSNghSaprZMsCdro0Drq3k+8CIQKu0tB+X5m0S2tzpBiKhkoZCUK4/mI
	b5IhidM/Zyhv2O3F1dFlkoLMQsno1igVQGdIhtyuITVZ0adqmiiKb6xdrLycAOVUoOi1f3WNUq0
	GlYbj2MRFrBWFcBHYZ9YpmA8Pp5mar6SrU5SVQJkuDAQOO0mGm2xtA84UoPsF6YsvyUXE1CmmdN
	dzX0Pl3Q+Z+ZRUt6LJn+CGn7OZ8iVoCZo+07TYcjUJYaEK73gVJSDRxkeZBYKgiidpSG2J7Ac3V
	bmiNMkpD5EyI7XcowR2doJgqv91zZdRZzoOOHdOmNmL8CgxWVws6VK1IONFL5xmnzKPSjP9b0QL
	VhFoAe9x9jPa1L5EWVECt9n/3Grus0XtC+vJJy8AxS8497luKiwHmbJJgmgJ0+7o2HY6p7uYZse
	lzb150eWKNECvVmmWZe9iWx+k=
X-Received: by 2002:a17:906:f58d:b0:bed:5d12:db5d with SMTP id a640c23a62f3a-bf37135e498mr329022266b.4.1780721904690;
        Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
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
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to device_add_group()
Date: Sat,  6 Jun 2026 07:57:31 +0300
Message-ID: <20260606045738.21050-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from sysfs_create_group() to device_add_group() including device
managed where appropriate.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c           |  4 ++--
 drivers/video/backlight/lm3533_bl.c | 19 ++++++-------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 45e7f7481aa0..e3efc9f6f348 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -416,7 +416,7 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	ret = device_add_group(lm3533->dev, &lm3533_attribute_group);
 	if (ret < 0) {
 		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
 		goto err_unregister;
@@ -436,7 +436,7 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	device_remove_group(lm3533->dev, &lm3533_attribute_group);
 
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 39f438114c48..b4363a30b2c8 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -304,28 +304,22 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
+	ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to create sysfs attributes\n");
 
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
-- 
2.53.0

