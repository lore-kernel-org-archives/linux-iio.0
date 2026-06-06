Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0B311954
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721921; cv=none; b=L2YDqdKqXkBlEC0tyXvC+pfukXI71NcJSO1BpTFIGRfPVPKTGfBzGcuYAPLpyZKtVg2EZtv79C+RuOIk762Xjezz/tuKHThX23WLObBdZnRMgmyB9t5kgRZL/QpVJH3BRcVl8dB2NnJDmCJwGAaZc572UiubLgE6L/w8JH32ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721921; c=relaxed/simple;
	bh=/uaa0Rfad4NLZbr7JCGcZ/k7YxCiey9V8icGrQZSDTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axCLX8ETWoI5034DKZ05OFA7II1TmfuATN3JgQUa2Yt2GU6RomV3ZH9KHgxSOyYPir22Loq388aTPyU7rviGqtV0ytpfC07hPVJCYgXJix4ATuTx1Z5jE0/K8L2BNG2pZIsmAe8Q09pI7g7+k8Ye178VJ2JF00+oJ58IFm5gl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcwU1SnI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcwU1SnI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c08bfe5afso4974899a12.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721918; x=1781326718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
        b=bcwU1SnIaojyRF02UDyw0xrz0CtVVG9O/vVworaEsVBb/tpTD11chsUybEjm0DPbTj
         YDPcgPk243grbapbfcxbVE/m/buNJy0+nxNF1ovpe8fFmchj6ePejXYLWbfcuXNDHxrb
         FaKOmxVbEo4YUNYaCGQGKKLQ7cC56tyWmjuiv8VacUN1A95nrmxWa9SIkQe6SgmOlaLE
         KKiwc9MTC2JCZUrvwZYPilSK5DmSDZLwli+zPjEGbXbgRV4Ab1w/Gjv94y5B4fwLwxrG
         0TDjohQl+IDaRuY6B9HJuOi9elT6q/uRuFR7WiE+75ZA3g6QjDbExbCrhkP4j/DUNTSR
         Gqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721918; x=1781326718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
        b=l/tejQ60mXSYF9uKzPs4KTsa31twu0U2RoQ+f2lqAI+D/mA46cXDckT4qy742ngfhC
         kA+VazC+AiApFjyStpJAYkeJEC4uMnHWUOlM8tAgtFowmoNrcWwLxN1DdZ/fI1frJLwR
         ofyvIc99xeA2WLzy51uAPoCPAsQwjU3mU1K+xTBXO/1SNF6JG+NVUq8n8i3aXxi/Ok8b
         2PAz3PjGmZo4A/7S5YW2X+cue1B41UMnT3HU60Td4I+X8hYjmgizxoAKLMJQ4L/YsKvb
         WNNBHfYkVwHnHoYIk5I28OCU3GDG0A5D6FGjdhkIN7xxJA9AFat3gwz0ZgxGC7XWCFys
         xgQw==
X-Forwarded-Encrypted: i=1; AFNElJ+NDeBRTkDDh9jtCG9B+imm/7PZ8XZeiYYW88c6zKh1mtfNL1niQrTnfTqpX8Mgye0tAs/PwfrcuCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLCF+se056p/lpToQBUAG+rtJCgVGRNx/xhWD+6x8ziL8xFLJ
	E4zIYLvKLX/ynUArrgeIBJkrXxBSs9WDlkckzxr2MABK5Hw9fzYFmhtl
X-Gm-Gg: Acq92OGkkc/e+7Cg87DJh8GwxcKKoK//4z/+l71Yrn8tmsJmkQQY7JQF9DKOpcSSO0u
	NDJgXAcA/tLuuqQ09uvNr6OUYeTU7MWiSfhH5VfpjhjvCDjF0D8VFvy0sI0hdqtLEfMcdzdeVo4
	hHlvFw0NJUkSFMSgCua9hIVdlANc22SeFyiWJlL8wdNeGMDtsjpj6shyI74zuoncSOH1bb9bEav
	XTWYOMNwpADLTEtwqe1F57j/xOQ/4kRYFREmIXqz5Hl9CHQ9ka9sSW6nAjnH9OX9a+eOE8uVNJq
	6IDHI5RWhcwTGIrSWGhUYvBrasK1CoJyi0Ya9isrh27LQ7sjtz+rr5j8flUWvZhs5FO2oGsM3yt
	vjxlqChPnnOrfjaik0QIqLWQoUsUD1WnUIaKxyxxttBU06sESXdfgvNDRTI0qyFjV4VHRc+VUfL
	q8ZPei++7QyXs3ZKZv9rFZHUI=
X-Received: by 2002:a17:907:72d1:b0:bde:170:a0ef with SMTP id a640c23a62f3a-bf37234c5d9mr367725366b.27.1780721918445;
        Fri, 05 Jun 2026 21:58:38 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
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
Subject: [PATCH v4 11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
Date: Sat,  6 Jun 2026 07:57:35 +0300
Message-ID: <20260606045738.21050-12-clamor95@gmail.com>
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

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 58 ++++++++++-------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index e91c598342ad..9ad7ea1bbbcc 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -85,88 +87,68 @@ static ssize_t show_als_channel(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
 }
 
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_als_en(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u32 val;
-	u8 mask;
-	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_als_en(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 mask;
 	int ret;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
 
-	mask = 1 << (2 * ctrlbank);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, enable);
+				 CTRLBANK_AB_BCONF_ALS(ctrlbank), enable);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_linear(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u32 val;
-	u8 mask;
-	int linear;
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
 }
 
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, linear);
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), linear);
 	if (ret)
 		return ret;
 
-- 
2.53.0

