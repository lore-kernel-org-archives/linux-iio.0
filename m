Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811883D7D65
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683278; cv=none; b=KTpoD5jqzjm4HKvp/Fjbid5oLozEe09YMQHPzes+fh1nUMAutXnLWQ9K9LRi8G7hczVE5PLAuCYGU6wB2fFM90SxgCbZ/9VHKE53MpIZ5/eRQEYKHzgzI0d8fROZ2Dl4y5L93Lol4TbQQrNXCTK7ALpr5uOtC6uVK4aYQ2ydZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683278; c=relaxed/simple;
	bh=/uzMDa/Qq+h3z+mWxCj74u9KaQuuNkmAuhmbHq8QMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqLhQ2z80u4TdhqwFPR2sPlKA2+y3R37j3Z8jixgTOib6TtYGE0Rfkda1WanW+8OILhaCUztnCk0PFqePGfMDg+u7o4tdqsw+zPU3wl+YZeroijBvTCrO9Bzt7sBCKpVwrsZrEepyC8iHSgMrp4NF9seSEQmragXP5LyaT53TL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIhj4OO9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIhj4OO9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6957b74472dso455205a12.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683264; x=1782288064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSD+o5Il4q3N15GHNpu+Bn3w6lF4AaqNR4K4QWPriYo=;
        b=MIhj4OO9jXtutz0acSiwlbCRMKJXNqVi6GY9VagYQBArS2qx6eRRcBdhf9Y1ZpOUBr
         AzJYakjD6QnJmr4xBoXAKQGUbwcsNrYM4TTyvC5fxf3jMNbOobKv3Zsbr10iUYxf5zP+
         TDtw6EW6ARF2sISKC5ksSPqakWRB8DH94Qc9Y8xjSZigmr1ewcoagdkxjrFSn8D9t3e1
         qvKfCRGKo803MImW9Pom9hgrsvr+5wHuXtC8K1GlRuOD3CStmjmD8xd1EzOxR3j4bM0V
         jXNXlVg7xl/wqQEpV9Lj4yEgJKwpQOI4JryuEBsrv9YmjQw5QZZ+uEvaqyEFNBnVzRxD
         /vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683264; x=1782288064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SSD+o5Il4q3N15GHNpu+Bn3w6lF4AaqNR4K4QWPriYo=;
        b=AKBIDgBod1NDHXlm2s06tEhsJ+N25VFyYSUeWMXXW2JRDe162cEXynZfdMHoEVpPJs
         mTZrX3o5QyKzTR1otrvKNoPM2wEXV767zAj5c/Nenxjv236PCHjMl8ViXIlKVXnTZ3DP
         c5EYLAUw6134MnmeyKxM3UGx7VX3ZTGn8wp453VE9pzf9O9Im3BOAsk/HrpN36FvHaIw
         29zDpphJAJdYLzB+AVWLF2n2i8RwJ1TqSDSVKXdGoKlvGbSfykEvPRrvqnnR+VeYCbRb
         TyRGLb+Hk85OtuFOGNbrZ1BItkhXS8jxGr0xjFGIDoXwrBRw/ULdCB+ClviVf64tUJBc
         Lnkw==
X-Forwarded-Encrypted: i=1; AFNElJ9M4czGhsM8lN+TarQ7PKbUqC4RXNvekkAq1IiaX0vwSYH/ezbvHlB80fw6ALdkd1iZyUrXsTrbEbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLaJDQIkEVYzgn5dC7fuLkx7ilI/QfPPyPLFgc/vaFA1MZHif
	AYeqYIsRj40SSuWstL8WVAYMcM2EqyrcJQ/h8i/Z34kPj+s3/SKPNiaV
X-Gm-Gg: AfdE7cmxmbpd6RCnMLxpMYASp5ZhOBqqyFnSmvp69pMp6Ky5n+Pb0NHJYs/TCoGEeC2
	rQcc/BU2EgCqthDf2U8KoNtjKaN0Y4F5BrfxZP12hy6fHs4hsquxtU2sOks26J0ySn1oBw0tKNM
	RDLgFeRyOf7WHr6cRblYYa0PKwKTDVBOubp1iSC3AwERWQ5qJsTYYTLwTI218h4WZSSU/e0T4sS
	c3YESRQm0uG24xCgx+zsMTXzio/haZ6OKMuLylPrLTjkwX9f1ZZ2F7wRtaLe+UK2orrGvB/1g1h
	v84OKI/hsVVU/6pw7IHssnMzCFfvzjsDbQcZcnywX6RZnaAybLKdW/9/F8S7mVQTLTjbPDRVrUs
	e8S8U58vGHS9hVGUNzZdQdfeHbbvqMYZvu4BIj82OACEHxHOWzq0nNvHrY4hE9WSRDMfkoQOHM2
	B2ew==
X-Received: by 2002:a17:907:9452:b0:bee:bcf6:6a22 with SMTP id a640c23a62f3a-c05a511eb50mr157102166b.44.1781683262372;
        Wed, 17 Jun 2026 01:01:02 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:01:01 -0700 (PDT)
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
Subject: [PATCH v5 14/14] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Wed, 17 Jun 2026 11:00:31 +0300
Message-ID: <20260617080031.99156-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
 drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index ed810c23f30f..9e07953814fd 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -27,6 +27,11 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_SHIFT			2
+#define   OUTPUT_LVLED_MASK			0x3
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_SHIFT			6
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -55,6 +60,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -623,8 +631,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
+	if (led->num_leds) {
+		for (int i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
+				continue;
+
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
+					 output_cfg_val << OUTPUT_CONF1_SHIFT);
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
+					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
+					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
 		return ret;
@@ -699,6 +735,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
+		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
+			LM3533_LVCTRLBANK_MAX, led->num_leds);
+		ret = -EINVAL;
+		goto err_deregister;
+	}
+
+	if (led->num_leds < 0)
+		led->num_leds = 0;
+
+	if (led->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index c99fc68cb669..b3e5b3042d34 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
@@ -36,6 +38,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
+
 	bool have_als;
 	bool linear;
 };
@@ -237,6 +242,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
@@ -244,6 +251,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (int i = 0; i < bl->num_leds; i++) {
+			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+				continue;
+
+			output_cfg_val |= ctrlbank << bl->led_strings[i];
+			output_cfg_mask |= BIT(bl->led_strings[i]);
+		}
+
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -321,6 +343,29 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
+		dev_err(&pdev->dev, "num of LED sources %d exceeds max %d\n",
+			bl->num_leds, LM3533_HVCTRLBANK_COUNT);
+		return -EINVAL;
+	}
+
+	if (bl->num_leds < 0)
+		bl->num_leds = 0;
+
+	if (bl->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led-sources\n");
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.53.0

