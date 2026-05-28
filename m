Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA42D9EC4
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976320; cv=none; b=u+gpyNJEVSQHPdzpo7q7BvEH1bCRk/Rr1j0+ks28Ik3ddYjLCZsis5XHuapIOsRYKvyf38qEzMtFfBdfJh0v7zebyWqnoUqWt/56pvMmS6UUJXR2GMwtRYpi/Q9SLGQVVGPhiW5oqzVgzyAmRQJTMHfYrBFsDTu6EuZnKTAB6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976320; c=relaxed/simple;
	bh=n4yCPkvyfwqM7MzsAswDO+ebUjuf2G8Zgx9N9HA2HFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9IYutL+RoxSOwblKm+X8QssA3+QpkOhGqo7RLa2hqFwnBzl72Q5QEemljCgXOwJ2iDmG31Mw2Bcn4xEnjO01gtWMe0wGkHC7orzmB/9oD78avDNQEHfOU2zIfGy2Ruoi+8tLHokhqI7d+LrYVW1DFj8mzZ72lYHL5Rof1YfX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4UmiESg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4UmiESg"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd8faef2e18so1626395066b.3
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976317; x=1780581117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDQ/tiPuyfzwfBV4n9YbMw4Pd30yVycLBAunY89akC8=;
        b=q4UmiESgp8svPMTZCw8HuaCUQIkERmwTnmGJfziX6gsQq1xa0xo36IS1q87MS/Qn6a
         z7vkYuuvp1ti+RgxqZaR7vYWQ3FYtzgOp2RXlHdPfSgH6cwxcAdL+RUhpMuszmBjJyRU
         mAHe/ShSSkDmkXUHyLVm2Uz7PIa6GxxepQFwDC/q+Z+AJt7Rp5kjmia1/sMh/gssrL/v
         QpBI2A/nIHSRbUanpWLlVtmt1cOXkvlIfF7GOr472KI2ZOVoWFuZ3DsPf2+/0hazT2PL
         MeX//YMqVOxtmwHyIvkr91Rtv2wrK9tPQm8U9FIGXPo7gVZOZ2LrpehMMoWfkcH0Gz0Z
         izwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976317; x=1780581117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDQ/tiPuyfzwfBV4n9YbMw4Pd30yVycLBAunY89akC8=;
        b=LunvMxi+6LsVdkuCntwYxrrSnN7WKZ1xs8uaUriFjSFjGFyOs0sy1wnzNXa94UBepS
         WveiCiMxMg2C5H1EnPuBkfZ3vHXSKu6GWQg3jsAaPPWTP3Xlg8yBfgtI/xuJxewEMrgh
         ZEaxpdSRqFjjYDZp/sv3C62cjyokDvO1RxNR9mkELXg8dStNYsxWc2e8rdZPo8Z+o6zG
         P/qh51mv/BiklgYSdGihn4tgJnxV78GT5xm43aDCsejEzmbLqi1bW7S8LqlbzE4UvbRA
         sD536tXmbRfiZD0wNQ2GnQOLLOc5e0P2OvWrA12XW3KXEGkWG+lvNiYy1gt7rC5QSOn/
         P6yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xe9i85GuZUCQho46nXBbVfbHZ9xxvLBnD/kMTwAtJYheuo/U8+mR6uDXh4rdp/fzG9DShYmbX/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZiW06HKCG9uTGb9BxpHmjdloT0bI0bT1Z6I/68Y86F+Jf9lE
	fPMPb3z1WP1vbnhRgT4fnwv2kJtw3gkVfcM5UFfb6xMV03sZDXS0iW69
X-Gm-Gg: Acq92OEAHGXyK6IiMosnIcVh6HHwTZqfWWRpC3Qx2GepOBumiARglqe0hSnw+p0vxZK
	+dyTOmECN4pw5oS5mq5DBZsZ984UhXyySCn9EdQ2s5VGXWTo+Mr656X+2F5l+pijTmpkI4w9fmg
	B3iX91wgcAeu5xpjD9S4x8rUsa3Jn0Vf77zb1bs6rAo10fW6CjnyOgpbJz6/KaXQt8jeDzFCeSz
	1CNDCAHmoD40Mw/9trJ+26bUbKtBX/JPoJFypsEZKb8dEEWaYC/up8d47kr8ZP5t9hvtmzhRieO
	V3UW6cIH1KZ/BYkgp+mYXakGdFM+cnnzf81byMFsOes5IaF1UAs95iS+nz8MvK8XMr4Wend0RiO
	p+tPt26en9PSxCwmR+dLfpVmIxhbDzySTgO15gBp51VD3gKYcJzvlwJxBq8NXXMtC7yOFKVae7H
	2uwWjGJiuaEl5lXpP5OdirgguURkOT/EO6Qw==
X-Received: by 2002:a17:906:f049:b0:bdc:8c6b:4842 with SMTP id a640c23a62f3a-bdd25cecf04mr1579914166b.30.1779976316385;
        Thu, 28 May 2026 06:51:56 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:51:55 -0700 (PDT)
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
Subject: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Thu, 28 May 2026 16:51:22 +0300
Message-ID: <20260528135123.103745-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured. Additionally, update the linear sysfs code, which uses a
similar coding pattern.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 50 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 42da652df58d..c03d0d1667e4 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -32,6 +33,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -135,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u8 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -144,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -159,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
 	if (ret)
 		return ret;
 
@@ -253,8 +247,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -317,14 +318,6 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
-	backlight_update_status(bd);
-
 	device_property_read_u32(&pdev->dev, "led-max-microamp",
 				 &bl->max_current);
 	bl->max_current = clamp(bl->max_current, LM3533_LED_MAX_CURRENT_MIN,
@@ -333,9 +326,20 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
+
+	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
+		return ret;
+	}
+
+	backlight_update_status(bd);
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-- 
2.51.0

