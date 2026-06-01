Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF73DCD9A
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327154; cv=none; b=WVw0QJ0pjSU5OdXYdiiao+YW+nDUSwg1x32Guf90exj1JGGJVNUMVPTCW05KbE6x866/v5pccELlGDmTwO1M/B3+OJ7AwEfF/4jN0EeybvcQRzELGo17/2gvVOO6y3rVb1eAgkqNaUhfYl3P/ZY4XAR+r5zItWvZVURY99wWNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327154; c=relaxed/simple;
	bh=JALmBwQQvVIGcgHB3eyuOJRgqo+XiRn3ZwSnYM+2DMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsgItHn2mAlhwL3KBN5ofmS2f+9Agbe4Jh1qK27KTp69XgHQ+eh38thrLJYy6BO986M8NwO+2Mq1CEWsZIKpzGzG74RT1Vo7bRUZCvipCFYQt38w/fb10snLWH1Ne30GluNs/4LqSLaiiEQUkSEosMLaul9aVp5aCbGVSTnmXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvW4Y97o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvW4Y97o"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ac357c55so9185835e9.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327144; x=1780931944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHipHX0fj9UFI6kqkRtr6SnJM0WlhcDH4RQJ2Kh7RME=;
        b=IvW4Y97ophhmqt4XxMHLdh1gLDGtbOqT+OdFsZOzhu7GJHt4vFrtSG2IedcR77PLxE
         O761zpZ5pUZzK1CQqP6WL/kvw4KIckjUVXCAu1jXVO2LhkhDmEz6tqxKw4Cer+Hz8/Xm
         67puVzY5GHziIvAaJSb8KZ4Atba79E5rp4sq5NnTZlvEbmqZU4gf280Ic598i93jS/z7
         M30NpnPAhWSN1q+VDv5Cxs3gb28XlLz3zMcsqzHm8pmOKDLT4CaMJy/SKz1mp3X+4a6X
         uiDaEZXVwjcg+VKzesel8hwijPgkxWbm90hqpOci5HtG/85+Q48RyZBlV2rLR3GuLWc6
         j9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327144; x=1780931944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHipHX0fj9UFI6kqkRtr6SnJM0WlhcDH4RQJ2Kh7RME=;
        b=JOUs3ywycbWkpvyFMJep11rlNr/LzXngRkpKspmEBeBIQ8EZMoEyFV+ITMg8qEpHwh
         jIRu2PQqS3clsU0PYCu++b4p+x3XkAVOSEu93Oe/+ibS9GkVGXB4I2HDqNfvI0zczLga
         oexmsY057LWwqW/Vlr8tirRbLlcyDIi/wye5vsdPuIVCY18ImKA74BhsAXaXw+5GX4mx
         ZwGYaRFaEeTTW0GwBSaKNXo4iiBqaf3zWVRSTtR13iT0gEIKKaol3J+flmLSzPPMcJOf
         o00VH3oojhA3RrW2VtcodbXlVzTzdmskbaD1FDui6RaqLriV040h1r60WTuKqPLT2wzn
         9jVA==
X-Forwarded-Encrypted: i=1; AFNElJ86GuSoSMIQLGV0+GXhtjxlbC2QJta0c5oW97odD/Vb9LkIJxDPqzYeHxx4l81hDaQYBX+fyhAVfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACP6PLdHxAHv5xcg8Y3Ri9xWMb/PtBQwrXR48RCP6HQmlZYYT
	8ioZTiLK5ldbGI0JljdVLhybeI131aVTw3d6Tr39NiyjwECxyQQA/SIT
X-Gm-Gg: Acq92OEBPAQglZxMQMI+Xhh/ti3bf0clA5SNsZcuJuMcyX8a1rtK8uRWAIC5Mch8PcH
	Ej7AQB+7HmZBFsGos8FbDqLN8Pmz/CGaNM5uxyDIJ8u6iGoWPv3x0kfsezSLDKdG9ih7xKwRAQ7
	/zp66pffROV1mMiM3Hx2PB39A/n831He1l8qK/SZ/ZSxzivahBhBYG5jLF1rY5VfIZznWJc+gbV
	gBHnmM7JkjMUXBiOGMiCNiXpNPn7IT42t8ciMPbB6C+HKMD90k1yTGkdTxr0JDf6L0BKPlWcomg
	ghSQMWFHp3AbfsdUoJYxWKXUVNoZh2xQHHYzoeWAOzEKd61skwt2njTeOtnadLa9cZPM7Q2vEa8
	vavIxFb6Emjbp/cGo9xETtkx2u+xtiKz+LkgPCWHOijwJUaW3kDiY6w6tfQp6lWKT8rMRTtFR0H
	ku0ZW5Iy5VM9sh0swCiA+zBHc=
X-Received: by 2002:a05:600d:8444:20b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-490b078f2d5mr5481165e9.7.1780327143862;
        Mon, 01 Jun 2026 08:19:03 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:03 -0700 (PDT)
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
Subject: [PATCH v3 04/11] mfd: lm3533-core: Remove redundant pdata helpers
Date: Mon,  1 Jun 2026 18:18:24 +0300
Message-ID: <20260601151831.76350-5-clamor95@gmail.com>
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

The lm3533_set_boost_freq and lm3533_set_boost_ovp functions are used only
in lm3533_device_setup, which in turn is only called by
lm3533_device_init. Incorporate their code directly into
lm3533_device_init to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 57 ++++++++++-----------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9be..45e7f7481aa0 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -80,35 +80,6 @@ static struct mfd_cell lm3533_led_devs[] = {
 	},
 };
 
-static int lm3533_set_boost_freq(struct lm3533 *lm3533,
-						enum lm3533_boost_freq freq)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_FREQ_MASK,
-				 freq << LM3533_BOOST_FREQ_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost frequency\n");
-
-	return ret;
-}
-
-
-static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
-						enum lm3533_boost_ovp ovp)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_OVP_MASK,
-				 ovp << LM3533_BOOST_OVP_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost ovp\n");
-
-	return ret;
-}
-
 /*
  * HVLED output config -- output hvled controlled by backlight bl
  */
@@ -406,18 +377,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int lm3533_device_setup(struct lm3533 *lm3533,
-					struct lm3533_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_set_boost_freq(lm3533, pdata->boost_freq);
-	if (ret)
-		return ret;
-
-	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
-}
-
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.51.0

