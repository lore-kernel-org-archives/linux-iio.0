Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89023CD8C9
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683261; cv=none; b=AxIL8HfJ5yQcjjaSdvK1mUtCo7vrBqrSXzzzccEmzp8gYGaeYV4HPitKsVagvnbOYo64DxvzWm78GbyaoCzBgDk9fEkN74PQJoMl0Mi1oVmYNSZFxaJnKBUwME/M84elLxPBEABJvJHJofJpWObVxW53Iov7CHOaG5fLSylVom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683261; c=relaxed/simple;
	bh=BwWYKnYatgp0/f3D570qVWCNy9eZh1sTktWSktle2dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiOiyhi1iF8v4sB1TOXITsBVuqUg3pYg8D2qBz9tNwOP4Oskf6AK5FeL4a4frX7GIaZghsFe9YBV+HfFr/+j4uZv+vUTbhkHF2cEGbLcX3NGX0A1Ih1ki1WNdeElND5ZQE4iAS7gydgjhoBVXLC/iA5FJneqB95+Y5oQqaKs0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5FvIMP4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5FvIMP4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-becfa735b9aso683866166b.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683251; x=1782288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
        b=q5FvIMP48mll3yVpjAuWYJ3T/u8Cg5dIq6l67h4fvUg3PiilFeHS/nBCe7KHm8M2nM
         Uw6BTGaGfd8U7E+7yrdpvDibkoKmSW1uJaJbWTDZiicaqgBvJG6suX6gkT4ul/q1vY8a
         KwvRRXWHUAY3HgPapPfOu6PCw4Bo4quZLc1xxm8bLDfeabnMf+CYz3z/KqIMjp3lcU0m
         d0YAQhg5bS3P9346WFMu5yzpdSeMkQRrstkj+AlCbaAQBMgFuVRvanArFdAz0sFbAjkw
         Madl+Dx5oaB5m2CXiBeH64ew2UakvEOt9V0yJ43GlGY2wNHo1TlyN2Y+YE5emmm9bk6u
         wO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683251; x=1782288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
        b=HYlhxdRfKKW3mXymiRAqHJvlpuer5NLHUAfpJE9LDGAEdxD9amXfHBb9tsohwzng58
         P/cYHVgxKoXpaYWDKxl7CSVlPzH8WfnUSdm/tfDXfIW36HULsigtZSLNR2/m1rmE6EaI
         0soqbyhpGNiYI2GZe9GpwaRZRaMoKqMFO3pdrNIv8A3v4G6B5QX8msxU73oiXlDVBEjG
         4vQumeiTXPdlW/2YE1W8iccIxIOQQYhREmH9/hNbeRquNBk8EtO73VFNu4VTqaGe5kh3
         jp8It7sQWSAFLQHm7jS7Eyknkj7DyGqnajSKwMyU8uT9UQdDEsBkBPNQ1YyeYaQae7Jw
         zNVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CxabN/5xgEn41v+QOTZSEHLuTSE1TY7jqnWYOG9Nl7nSkkXj/BQlm2XSa8ibUy3Lepn3GSg3QJrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmuydctLrRL1JTl0gPIRxptybykmC2km+wwdR/41uRkoDtJHV
	elPmqWkm/mqY15IfZF4wJOcOfLcOMkXa8LQjhnP2LrNFGAYRt7jj4xyZ
X-Gm-Gg: AfdE7cnOg7Ms27I2zs5oibP3y+HdN0dTigHnACwfdpSNn6xHx3fkVXwvEa2eUtJHqZt
	CkXkZoMHtU/TmP9qEExzqoVX3pG9efuzJuW6F3SYSukZALnVoyxQaiJwkltGlIqmDXlF2poFEeb
	MZsqAy8UGmchaXvSOU2QjPs379IBJOEU06bfVkyg84Cmn7zZlITiHqDillljX2B3BpfeeVbkJcf
	pqnxYvH8V2GJ1LSwHmlk7U4eej9BWmNxRIvAbnawD5alPAoO7yzXMHEd7bwbWy8iJ1Q9IKjfkfn
	0o/hIvj+SwGP/SMDzf12knj0KpVS9hWFnk7vYMmu6ff3Sk4tFN1TPAAb8f/39CzTi+NzNm1M/Oo
	EGcvq/aVzxryt3cg5WR73J8+Vp+ZnQy78DS43O4s7EUYbNNko/Wg0Qd71mGm0bGSjjd7RpXDj9e
	h+z2PR7XJOqMO6
X-Received: by 2002:a17:907:d02:b0:be2:d66:eb4d with SMTP id a640c23a62f3a-c05a7abd063mr208115166b.44.1781683250733;
        Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
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
Subject: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Wed, 17 Jun 2026 11:00:23 +0300
Message-ID: <20260617080031.99156-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

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
2.53.0

