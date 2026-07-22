Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7713B3899
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749180; cv=none; b=s/Q5sZG8LeUVyzQIKwmv/mGRTmVlJo4tW3N2PGFoX+qjs8ECdzEDA7cOWneJKug698PyRvDWZe5wbTZ+QHQiFHPi8a8e7ozdbZ3auh+vU8v9jEnEhFSep3i/dH2CCVFptuuP2v4UpjPwGaap3VrUPtJ3szLE7JD+yHrNerKaNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749180; c=relaxed/simple;
	bh=XPNZh5Xwi4uWv1AMYrkob8yNIlR+8Um03AjzUYZVkS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g2gdm5oBP4lNd9WbQJqebsznBRNDYw3FWhiXJVe+nuVl8wSToRRC82uK1h/Jb2kzzSeBueg4WnzulObENqDBHfvdkLfeHCfRTHeP8mii35xNm2QaAhp6KoXIozBEQS//ECRBw6Xz916JlYuSWLDAvXFolQrFjIqDaoQ46G0HJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTEpLz+E; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTEpLz+E"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so8932026f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784749177; x=1785353977; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3/pATTsYUQb3NxIiOQb/wmyPkTDqGg6SXe95ZoxSscA=;
        b=ZTEpLz+EmUaaAPzFwiVT2dY3o/9RfiDyvJDztZQ4e0i923hozwWHLRNh1hGMMfxQDc
         A7Hadu8xCvJJ24hds49i57feul2MI/duSabT5x9LMHAGucphdEVGV1iNKjkeSbA1sDCv
         readiSSPWXQ/cZnBb+RcBfS6G1h5+ZMEl3d1XKzZIn9Nj6GD/HWF38CRg2MVWqfqvad6
         jMYx58ZY8HvUSoVo2hi8oypVcmEAQakJ1ae0Bmic771JdjfxyGQUfVsfU5+CNVcuuAYp
         54VTahVCcLNKTgTaoK1e1Q0TwVAR5wxh9YhapOZhp6mQPQc/TiCPtTodUI39d20qxwDI
         GB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749177; x=1785353977;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3/pATTsYUQb3NxIiOQb/wmyPkTDqGg6SXe95ZoxSscA=;
        b=V9lDyYILP8OHGI0abGi09gI9t3Z8B6oi+9WWw4qhhQo8pcXOk8DBgqcLZdp3Bb61EF
         3OEHCgaSGPlObP6dBd9EM+2Zfu+HQ8bxKkeOelIfAiKvLBfYMS191Dyzq0z8E0qiYwlU
         asu3kMZ0qJUSXzF8V6K+SfVeIHk5ovCdRzMlHA2kYvWiBCq00ulXgt5SINQtCRBm2LBa
         Vk7YTxbkjz6dcTr6AfkkKMiz71xfyZGRM9oZgLk6z4te1bSOLcNLZFj0YnyTwLMfWuGW
         c5WPtjYxA2GqtwjtDk//szQHnV+aEkfCS7tJx9zdvDRPM0ZQXs82kCmCWL4cfbCyO5kc
         6KCQ==
X-Gm-Message-State: AOJu0Yz+iwk0pdBKC5mcivCBFS2BOseRCWLWgyEPmGqrmtxie7kjv1dP
	PWILJ68jOEEQf/uIe8fhlqIyiA6xVXH73H3tICQBvMp7aR3LONo9FOdh
X-Gm-Gg: AR+sD107hIwdgQ3f2tVrRxQBDsRK4/RTslctFjUon4AfrwaF7jZWXiO1K+kUBS4qUcn
	ZNkVEMgDjiJL0njfbsdVVsYlzPyTkFpX6vLFSerQsuBh7P/wHChsEXSSpGOfo1+dxvvGTZibIRt
	63Au/3oRICW46dEkEFUYDxKlsyAElShoW560JV20+BmNpJQJMrJ4ZPtavAyKT7r70zTGpicG0WT
	FonhWWd9bclXWcn6AKB9LyG+QUUToX0hmnYQb41N7tXednENUjZRaSSTemozizf/oD6PiY6VjV6
	AClreiEmoiJY73CcTcv7FYBhtLYF3XpbOrZPtfbidL3wQek1rzhjs+MSRrHRfStuTDbzELPIS11
	/aciWryMfYGrb8pbtWV30qY3nUrcOAdWv5my7bkwXlKjPmpSGVPfVKhY6o75kBxF1k7O+44mDxA
	dHBUQv1btz3jb54F//aorpsBGSYdzZTslpRFsuurqXzqNr5JVU1accQTED/8XXxy8kNdI=
X-Received: by 2002:a05:6000:1849:b0:47f:6d57:5a9d with SMTP id ffacd0b85a97d-47f8dc9d728mr202566f8f.47.1784749177126;
        Wed, 22 Jul 2026 12:39:37 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb0007c599000ca1676dde693a1e.ipv6.abo.wanadoo.fr. [2a01:cb00:7c5:9900:ca1:676d:de69:3a1e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd77a9sm8416243f8f.14.2026.07.22.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:39:36 -0700 (PDT)
From: Amin GATTOUT <amin.gattout@gmail.com>
Date: Wed, 22 Jul 2026 21:39:32 +0200
Subject: [PATCH] iio: adc: at91_adc: use const char * for DT string
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-master-v1-1-ab0591897e4b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHMcYWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3dzE4pLUIl0jY0NzyxTzZAODZBMloOKCotS0zAqwQdGxtbUA6rU
 4h1gAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Amin GATTOUT <amin.gattout@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784749176; l=1257;
 i=amin.gattout@gmail.com; h=from:subject:message-id;
 bh=XPNZh5Xwi4uWv1AMYrkob8yNIlR+8Um03AjzUYZVkS4=;
 b=duOiTGUULrhHnUItYRTOCMeN5TIN+RIYU4M66Ic3AEffJWCMmbKYv8Toonmt22z6r7aR05FiC
 1YqzrJz8s/gA6vAVaoVVpntIsLwsgvOXakeeuMsQAqnZ8iPX6Fb99c9
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=C9HM6Jf5d9dPl9fnP9pM/nhMwm+c280ldqYZ0ESu3a8=

Declare the local variable as const char * and remove the unnecessary cast
when passing it to of_property_read_string().

Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index f610ad729bf3..0ac74ad92fca 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -988,7 +988,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	u32 reg, prop;
-	char *s;
+	const char *s;
 
 	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
 	if (!idev)
@@ -1023,7 +1023,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st->res = st->caps->high_res_bits;
 	if (st->caps->low_res_bits &&
-	    !of_property_read_string(node, "atmel,adc-use-res", (const char **)&s)
+	    !of_property_read_string(node, "atmel,adc-use-res", &s)
 	    && !strcmp(s, "lowres"))
 		st->res = st->caps->low_res_bits;
 

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260722-master-23179d7c00c4

Best regards,
-- 
Amin GATTOUT <amin.gattout@gmail.com>

