Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01843DD51F
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327157; cv=none; b=sKqw8Er1uHYNOVi0pLyEEKFHdj2e0KBEiJdw18psmCs2lJbw/RoqvV5mf664twEGv/8xNApXZ3nDszsreodQxJieGNCqGsfbrp45h4EG5+vFexvQvLkvam8+w94ZGNs5hrMf2qGTxyxnumpGpYCRoSsg9pBJhmB1AhWeV/PhFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327157; c=relaxed/simple;
	bh=1i1ud9qKyYnaqS2Sm7wFXRXPLupGr8dxgdr5XwdPNHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpaKg5JWNS7+slF7fN0M+JJItDTQpppc5JvX76zB66RwzuNoxwGUwH7BZFqWX1lP9PCcKcb/1yg9/G6Mw7rIWJ94/xHFW3LvgIRgPu9Fff2h+9IcjtYHMAzdhRWikcBqeJpJxeX1NVAUKRZ/vf1Bclylykiz4KgnpEqRc/0JynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIfDSjI6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIfDSjI6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef29c5561so1690714f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327147; x=1780931947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1lcsLIobScldpWx6WSR7/N2rSVozhhuMPVVUCbPDt4=;
        b=rIfDSjI6/z7rwVmbqWC0I2U5pgX6TdSdLHrpyRURtet3XqpmAYtKwW8Vdlo3XdqCf4
         W+UbSlRgSjszlfiAz3KANIuFsuuvJLxyFqO9ZtdrpiuRWGKbwe+0Kj6pCy+YV3iaeXJK
         BkfIcd7hFMkjXtoueKHt2hEJuA4zHRSd+mwv9mGQQlNiLWMI5796uMOzPeUTZ9/AyHCg
         AES8+CKpaGFJGqbLQPNLlEMH1tmy5Eaj3hWZGwSuP6XHZps/KvA7VFcgJtD5MUlRIrqf
         uMlWInZ4BoWZRF5vqHxKKpVGWPIBreE8BYxFi8C5IHyvgTRAnQRwn01CreithjA9vlAY
         JZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327147; x=1780931947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1lcsLIobScldpWx6WSR7/N2rSVozhhuMPVVUCbPDt4=;
        b=nXY2SoTPl0PzAIc3raii9JA8T5z6D0md5cZGDkl3nKBZGTqloE3K/edWxEgHzmgCs1
         1cfb4hkTHjJo7GbzRJHukd8K7papvyzh/X6ngbPbNVm6rYOulJNJKQrK4vK/824T5ZzX
         JJxsF/K9sPFZKTByRcJKisg/O3kPKyTLwviBFaogOjH4qDCzpT10Mv0uiQ9ziGKk4NOs
         kv2bhT8KS9oKdoaIGldJ3zwVcov7gZfIyowhW9wWj1FG+bbvG0yuLn/MLm1ox+LnDPL0
         Ra2GxPZEQQwNB0Hay/QgYs3x8hr3DSTdx/maThZXHQHdwOfSYlu1TVLzzxeGB6zqRhUe
         Fsdg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ykkj+3zghezEJrWapIywryLCkiBTQshxL+ZlnaA7J0WMZksL6izJFGPbIV0Sx8ypx91wBVDYWp9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/uaVdaTr/6rDhswCEbvSInjgOIvOtuE/hsgxvhavUxMtYoHa
	88XzUhCmyzEfQgg6XbPBo40bO8Wu9FDH/UNPr7sqRUHgc9k+XtcgX4YH
X-Gm-Gg: Acq92OGt+7HlSFgVCFKBmF9ZVJaUgiRULMd9qm2EXDpzuitst45BaM3KYneFPL7L8Yd
	BkhMbEAN6fdf9oLFOdM1QKIBCq9yinTpM7UNpXOFOKl/UzYLDksjnqGDvencG5PGewhRLymCoVb
	wUrXw+MI7kGx/5Tglm64SVSsJ5jOhQqOGOFn03qw92NKYwDIgfmbGcfbkCy5atE7E928v43RTbB
	8SsK6NTNNEFqTevd3zlvFH0riSaa3uJjwhVaXlcJPIjlTQGj1J3XP3ZMuuHyeWnIeVDAAww9U7H
	M0erhEjLRufQnaq6VH22TWS33qzjnivgcMYDZOVqQPhew0FjVwxlv1Q8HP2ZdBEXwhnrdFyrZsn
	yyvBp8t85WSSWG7v6+hiTETBG0Zgl6g0qgY8sJQVF9VSn3y2qb+hf2hYI8Q3TORgca5gLEZK1wu
	+D92Og/thpKKA2oo2WS4nGgK4=
X-Received: by 2002:a05:6000:40c7:b0:460:cfc:eb24 with SMTP id ffacd0b85a97d-4600cfced10mr13759481f8f.22.1780327146823;
        Mon, 01 Jun 2026 08:19:06 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:06 -0700 (PDT)
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
Subject: [PATCH v3 06/11] mfd: lm3533: Add support for VIN power supply
Date: Mon,  1 Jun 2026 18:18:26 +0300
Message-ID: <20260601151831.76350-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index d57c2cdf11c5..4dca5641b774 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -113,14 +114,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	return ret;
 }
 
-static void lm3533_enable(struct lm3533 *lm3533)
+static int lm3533_enable(struct lm3533 *lm3533)
 {
+	int ret;
+
+	ret = regulator_enable(lm3533->vin_supply);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to enable vin power supply\n");
+		return ret;
+	}
+
 	gpiod_set_value(lm3533->hwen, 1);
+
+	return 0;
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
 	gpiod_set_value(lm3533->hwen, 0);
+	regulator_disable(lm3533->vin_supply);
 }
 
 enum lm3533_attribute_type {
@@ -334,7 +346,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -458,6 +472,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
 				     "failed to get HWEN GPIO\n");
 
+	lm3533->vin_supply = devm_regulator_get(lm3533->dev, "vin");
+	if (IS_ERR(lm3533->vin_supply))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->vin_supply),
+				     "failed to get vin-supply\n");
+
 	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
 				 &lm3533->boost_ovp);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3fd8d4737ea5..9ee99be93d9b 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -22,6 +22,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -29,6 +30,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0

