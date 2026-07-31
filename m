Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59020426430
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497848; cv=none; b=u5cAZO/AJY00vJFggH1Y84rU2xa3THnUlvVoAMhQFaORGY9TpbjBLcGK1oa4nUG1rlSU/lRcJ4ashtoPQWZIe0c+AOKCM0mhLcigSPRiWkvi97SmFOVQ4aDaajMU8Fnqvx4Rs5xM55U5qjN7I+Y1amX5/9ir1w/EdNwYYXD8kjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497848; c=relaxed/simple;
	bh=jzKL0N3YlVllgP+B/U9c8TNN1MATVwvNIY+TMDc6s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH83DJpDYZARUVMuw4SNmoMTTHhCs41rA2QAlaq2cGuE4Z6kgYhbQYl+0J/PTdyj3SimvR3C9Pd6K+TImvV3dKmsmMmIQ8nASi0o5fJzQYNShPH0vhl+AUtZtyE3Vs0WLYABctLaipu2hQc/njYkuNnJB526ms76HsAqRDvxyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5Ow2v32; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5Ow2v32"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47df43bfb07so340618f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497840; x=1786102640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
        b=q5Ow2v32jfbPPxDG0mXmP+CTBT2dGUH9jlwpUt7BufPhHC8Sx2h392TWzN//pybhJF
         R5ovHcdivFq7NfpfBbaqoYKpuTKwYVQqR464ghAymNN1Ppvd5BJ7Ksc8gp/60xchEs8W
         mMprOEEFx9iv8ppnB9uBfDc7OemiLBPDH6x4QRgDpmaA0yzsmUViff8XgxhWLMkF+3t3
         VLF6/0A6H6Z6CIHe/hrUKFraY02d2uGO5JWdK+cdYkVRNzzF23l7iaYegfSaYsKVf+Qs
         7tEhx1BFzB3CN0NfzazbbiaxtwrY10wVy7Jj4R2qDeHVg2aFOrAy3sPRQu5XUkXbTRKv
         irXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497840; x=1786102640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
        b=B8hjunlw3PCoppSFNMZLhQAykvcs4xpcCyRE++KGkEWUQn+gtsgadZM34SdarrK44V
         eg/nP41oeLI64I9miizVHh666TD5WXj/kRkt77ee3yKKeU+fTeBAfyxeh8SsvtEgejj+
         JQGpj9cNkEWlI9GpwOL0PadPB2Ey3dNgO0ouv0xTvobSZhLGnyTY0it6Nbo3wYGPOLpV
         B4dJrRHl033NxavTuszsyaBx2i15hX9diqq0PedIMjeRaN+wGVsVPAIgPdyWxMC636oh
         dlftBu6PN4ocn0CpfglzJR5GlMKU3K1E6Y/7lGi5UnANHcvouK6F3ToSeahxjQLdzglj
         3VNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxpqxySJCQgLPvSXvfw3FJB35+t5q1tKdI8o/l8U7aK4kMDJZVlBTHqJ3zS8AYfMnDWv/qcYxd+8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yPWzkzKXTuDI26UViq7K0f2nQy0NsEXm8ghuSqqaVVlsB0l3
	vGHTBK2jQoUf7CJNW1RKlAzaWKCSkqaUwO2dTszwNfkfl/k5XKIvTSjO
X-Gm-Gg: AR+sD129V0uMZl4/yHCK2iwdAqD21r7EpvSSLTElPrpnUffB5LP8FOhLZM4tUwTFCpa
	QP3RwscDV72AHG1FvUBfbo6UDRiaqzahFbh+5DlJvZkgZFvuh6Obfq79chpBICS9h6QIWRjvT06
	s8AaOCz7Bn20tpvvpgmVWmutoW18DJiINGbzuTcDz4vvdGf7h8d4ejGUQUABx8FW91cg4z5sSTf
	llImEiC+CbIYbuWTAywOYxDyDXC0aJ0mOBUQ2Y9+kuDW2PBlOCWinIKR7mZU1DBP53v23JkCdeJ
	KMWBwRrIbd0uE4s2MzJQNUKtkX2qP2mXpWSGNV8PfLTbcBA6rXBECaTanuUzTwkZHIx/OxTmMGM
	RmEVpK99uT0e4QkvfE/BBpeMzhb6LjmsAmqIiFoLQTJ7g8kJnhYbg9eDRouyh7pSecVT01WoNoV
	qaiFGFrMT0YVoCwXXNF/UJg61GSWGQ+Ukln2VpgXtwuo0s6PRCp+pauOBhI4ZjMBBqXld8lGCup
	Dk+SvjnRA==
X-Received: by 2002:a05:6000:184f:b0:47f:9760:4d25 with SMTP id ffacd0b85a97d-47fd2ac97a4mr4103846f8f.14.1785497839657;
        Fri, 31 Jul 2026 04:37:19 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:18 -0700 (PDT)
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
Subject: [PATCH v6 12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Fri, 31 Jul 2026 14:36:30 +0300
Message-ID: <20260731113632.158440-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2e31a79628d6b..666213cab667a 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -36,6 +36,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -230,8 +231,14 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -285,6 +292,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = default_brightness;
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.53.0

