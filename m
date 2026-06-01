Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA903DE45D
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327168; cv=none; b=uVjZ+9tMdEWfoI8+xRw/SHLe6/1IFvDfD9/O4OBANhzDAsODekr25Zryx/Gf/4FWVnp1gU6LSsbrWXah77AGvG+Ea0+LPtbFAUaECuZ0Be1GG4sXmVQPYbXu1FAvMM4PcVqaDf6MhWvbiV7BADOaOJ5Y4CGQ5qjVVkui8bXSpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327168; c=relaxed/simple;
	bh=S8Y/SLmqiOO5N/roCezf9U+wAzAxng5Uw10f73gGxPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTvPBu8ul/E8yCGvA98HLCX1zQqtWCXJMCaEorvPzbD0i62gj6+cyZrKjYSiyyc+2Ly0wnFjS6eKusdXanwOvCa+i5tUlDcvphJGsNOB5gCLCpM/L20MowlRnMumlv3fMydXnNQ/btV8BLXbnPI3VlhFMmOYQ376bUcfXmzaqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez3BPqnQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez3BPqnQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd45e596cso887157f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327151; x=1780931951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMbWeeGe7TfgpPAVjQgWggP+Fym0ITJZjA/DygAtKOs=;
        b=ez3BPqnQg6HprkBZSv6xqhsXTAShRms5YEHj4EaMCgbYcbWvGXfZUTUmqmUQte3P4b
         nPA8+O1jPMuHQp/QQm9dUIyUORq45UXNKBxrkJ6My5DWTT8x7wg9GCZwml6Qdy4bpBE0
         YMgRlxbmfH38ctG9mgfNrYKTSeKOFwqjfON8ih0tbbrT6RsysRZkkEHGEfQ5rCPaAvKq
         eI0JJRWbFRv/dOAYZxVVQXwuF3SvUZ+yv4IgvjQjFo+AGstLGO5ZNfNnbNwMdJcnv8fY
         FCjQbKE9j1PAzBSKMlrrj/GXDW8onJB1MT7O2keqxEBh7r7RCI3tzHSxKrb+hD2eQKfS
         OWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327151; x=1780931951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMbWeeGe7TfgpPAVjQgWggP+Fym0ITJZjA/DygAtKOs=;
        b=lcPeqQrL40VyDkC2oVvYbX7XjkL7eyMSt6ki7Eo6ckpAa7/EZjchAcWAMyu+y9CxjZ
         8PHlw37z+jJYieA16YL+1x9L7nK2miga2kAcYf7hgHv+yTIWrPA/jGConR9ciZL7xkP4
         BWvm/QHM4hUQS1KR8EV9qJS+cJe1sHJiK2NnkodFOTB7VtTUFdjXCFKgjKP8Rod2Ej6f
         uvmkjBoIbNVin25tnaUwRWeGEG1hFn7ZwH3gb98tDBHNLWXCfqcjfRbJh06ci5G5eSkH
         1K7J5pzQrhZ8wPqGVuMP2kmn7GTt6cvYVnfS2a55q2iSpJBNDQlOodsdMqkO9JXMGjc7
         QT6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/qM8xDCNxfvuqwCN0d8uInv6oj2me+dq7fdIeGb1PAPPfhmV5XqffWZEH2m8L8+BiHjTajlJy90lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HJ38e1xmgKWU1FHs7NjgHGjgJy9BSmvSwxWwnHC4F4K8dUSt
	+R3/M81opx5Xg9EZjjSctPzEDT/FDCQ7QMg/ezeoR/U7fxFxdBw7mJdU
X-Gm-Gg: Acq92OFgq/4PX+xfaXMoJYs3F/Jp+9sF97Cl15X7QkGmjiWpP7DKKOnpFskdeFkTt5V
	TUUHZAZ9Wk+1VFJDfeKMdYmuW3fSY4J1Kj7jGTk/wlg18zy1oBOF9MGBkHHqNW6GQPzjjwO0E1P
	sxjR7Ya2BkZ0fd38aLkTskpnvFILgsdYaU+61GagavhmZcgeK1JGmbHg7Aqry/Ctcl7gS2423zB
	rfeZJyjr2QjeuB1OoCyaR6Yb98+ynbgxYzLzxsg0DDeTOnELxAGNvnBAHuRugHBdusaY9xgMsxl
	o0WxMhf9ecY1eAit+z3+/hn2aqnIaDIJUVytYXveZbYhtarhtqxOkG0ZWXrex7KZc2CMsq/MZrh
	T6XNmn/5PYSX6QQ0bbMcn2iA2fXG9l8g0qkPw3V1QvaEDpZ5dAe0PlU0P1Cj4buhwYksJB7QtKY
	+X6w9+S2RUzsiCyGy13m8fL/U=
X-Received: by 2002:adf:f190:0:b0:44f:9b70:2996 with SMTP id ffacd0b85a97d-45ef6b4f4f5mr15476481f8f.21.1780327151236;
        Mon, 01 Jun 2026 08:19:11 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:10 -0700 (PDT)
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
Subject: [PATCH v3 09/11] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Mon,  1 Jun 2026 18:18:29 +0300
Message-ID: <20260601151831.76350-10-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 36e6f027613a..f0d88b7bc229 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -34,6 +34,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -247,8 +248,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(id),
+				 bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -299,6 +307,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "default-brightness",
 				 &props.brightness);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.51.0

