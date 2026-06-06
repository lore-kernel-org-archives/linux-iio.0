Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688F3002BB
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721924; cv=none; b=MolCreXw4QGTzqvw7GgKIyMKGR4p8RQfjjjtSSXGHwH1mGMxfgbd1q0kG5+JTXEoe8ngjRErkrMOXNVyd/gI/UFYqofn1QSrA6mi/rPev7ZrwunREX8EpgBBUnhjpqZbddyZ2QvGTHO4J+70cEoxe5xOlt0oPgKMnKQq2Gjbpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721924; c=relaxed/simple;
	bh=1X3Fe5KMAyI8d0lBSX7gzgdG4WYUQVZ8AWRde1CmRRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK9TmNJOwitElQVgyVAQfoM0PLhqUYk/KueIzKtCQwY+W97nkTT0lD6CLI4Md0xlJ8LOrnYuogww1X0PQc0IowL7npVNLF4J10hyFYesN5a65YllqAdKOtx/etG/8bAEyo+mgLRlxZBVutzZdJtvn5e3L3HFk+JAfauwx3chLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtSr6VpN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtSr6VpN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec3f69d343so390074466b.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721922; x=1781326722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
        b=WtSr6VpNr5A1Ml2hGyJFaVqvyy6fxdgIFVLXIUFtW0YsU3e93OWG6eVDH8OYO/VAXH
         qnqlb2GvKyBGxF+ZNcPHtJeyGzapi/3lhMyI4yUHGvLA4eXjYkHd8e0xqptkOzsX+p8W
         lTXYexnL2obWiFIU7CJRXtRV8/QzFvPgR8ctCxYHSSwshvvUSOM06XPi6V+nd1FcmCMh
         P4s5eYoK/Js6UOp083Gw+pKhrJ6JBvWzgf/Q75tkU4sVMVkl420LeDTV2CBMiCNb5X2V
         KlJ+AW/m8Z4g7n99HixqijrLfpY9aaisaNNkmWbiziId9dTqjRv/aJzhQTAepwRJhyHf
         RCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721922; x=1781326722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
        b=UYaECjH4bRcA+oONK51JAWy75oNQREaa6jfqBimifUAeMeCzfHQ/MQNHF6R0fSu0+E
         zRifvyQOmw0PwXJtm5DQ7WrINvPcSSA6G30U5LXFFD1Kl62iDLiwOnNacZSMSckz20rk
         wdxJ9V/U0H1354pESR2R3EdjZpzA8gyqU67F1XgiZvd9do1Vzb7i4E9iGoZx92C/gqIh
         5YLFKUZjmHnLlxMWqWQf3Y8WmF9DhR5mq0ihWe++UucuIYqQ6gaalbxBUmfuoPkDFOC2
         /87qJ1qN/SEKMuQ2IiX1F2P95IBvbLvY1jIClOVvlRoo3ZYtNhtiL9hxDSq2UANyGoe7
         ZJxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SZ2j2iYkOA8SYzpw9M4HxpL/yu4oGg/4uYOegvcy3DHQz3SN7g+eZ+QCGCNErsXuUgSZelmd7w6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZS78fkdoPObHiQxOGYdxQEtutqTO1qy0k3ZaUdR5PNhEa5yX
	Jpt/kyb2Mn+jr0YbTFDlkt3GiFukzVrd/uQQqok+NDVQojOJoeKWxPx8
X-Gm-Gg: Acq92OFr+9Sj33mu3rUXmNhWIxSNCkFXsF5Xy0nBG/ZG7ctjguMSdqOy++K1C9lVVAR
	LogsDmuaG6Iq4hQFDMby40kIEyvfZSwzLw9iP7aZ5HpT4Dp0yHC3tPBtRJC8r196MjCbDSz1vJH
	R4z6dPn5GsBQfOx1dJPs5eWwKHSadJFg4+VaeJ4cmkUGzmLWvWAVb6HW7lVynTj2qeY0lV2v6RJ
	8h6G4utM/xx2DNN7sTTCKImcNVrMicC/oY3rMBS7VDib4cmcFpCZ545xNFFtGRl/vxixnpxRZyP
	zIhC+3h7kEe3zRgD3hoNSRbKDbME04jp+CH2AMdogK9ZcemHPj9s8jnM0exAFup3TmVmH5hUQR7
	EqRohlXmlLFBZ7puefCRJKqpU4UJz1FvqVY+X5kDoN0udTfdzteOYWXq1Oql+2yG6HmKRILN+EE
	EUAJQW5wUHUgfZbFmibvsQvBHhdbU0l/lV6w==
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id a640c23a62f3a-bf3737ed359mr332707666b.43.1780721921881;
        Fri, 05 Jun 2026 21:58:41 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:40 -0700 (PDT)
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
Subject: [PATCH v4 12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Sat,  6 Jun 2026 07:57:36 +0300
Message-ID: <20260606045738.21050-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 9ad7ea1bbbcc..4f8cde9f290d 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -37,6 +37,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -226,8 +227,14 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
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
@@ -281,6 +288,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
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

