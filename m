Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374522;
	b=2ZenVdeOKQ3KrfsEKUgZee8q87xIY6wzPkO7Tefb9siboGzV2HnH6sFz8baT8ZwaG4gc
	 K6ZV+gpZNeTScgBwwnjy7W7fyRUxEbKLu4irskBacICNWRcSzusqDOhz6S8nrErXUjZdf
	 2hkNx8ZImVyw0L4FjPJhHWyLmeQre7UXq2kBtjOFtzSZowPI16r3cs5V6woqsPmKt2vRO
	 yJyU1ChsVhQDxwUF4I68J2gUGDfjK1aFVQzGgKEzH+/NdiQ8xoAQ+kGF3YDx/x+zdf1Bc
	 a68f665sEErRZu3ZprYx0Ta5kZKRvTJMnpk2Zrxc05lviZrkRLudFzFMYF7YaljKebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BP1qn3ZgXAJPwE9Z4LOxEEqcGESbeNlEBsddeXFHeNk=;
	b=2hCKo7fxnU+ey8ehR9/nvOmLZKk5v0htMOvoImCfkvwY0ubJ8dqYqfoiWif36nk7aTq4
	 PWOmGLoQma+4US+583OTpThlyNwd8VzAXfm4rFEGuXPXuM4Fyux+52SWyG6YZgrZIVDCn
	 52+kfJuTzPwpUpqg6JMynjHS2237hoAts51/u/F3pl2rAADqUwmIydTADQysotNDu1bVt
	 UgVVoayEaRRFNPsuV+yrC/XaO0cdbZIeekSF+4Bo9rT5FpnOvxJxhVwvmTHbop+Gmj+h2
	 kp6+xME022u3r4uV06qML5PlDXLgxGqtXE1VAtQ4GHCO4ACHUEWfLPy3lUPY1GAAdsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OynidK4K;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2100606A680
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 19:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2100606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OynidK4K
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so10087515e9.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795374520; x=1795979320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BP1qn3ZgXAJPwE9Z4LOxEEqcGESbeNlEBsddeXFHeNk=;
        b=OynidK4KUNaR4sXs4C9eY/rwSsK23cjX7gdlwtjh2qkjgkuJQLw8IAvcTG/MScWA4q
         iy1SZHhF9p5/nSYjuK0AvFJ70F1NuW/UcUOgbqALttsVRJ9n0ociNb7IDjbvLzxI81gQ
         z/PS/TKoWAkW4Fl5Zsw8MFcbK77l2R4AQ8olSNgoVTAWW9O/TwymYrJbyumfI7bRrBw2
         2TDSkXhea+56NLK0ZP8R01iiGyg9aEITaITErGUX7RnfSZIjQ3k6+/4nnbyTA/rlcBr9
         mExjMh7sUZAr++3hoB2yej5B7sjYKzm0eIyCY+F588P8fipxyE/LYPffRDmTJaIZtYdX
         DfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374520; x=1795979320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BP1qn3ZgXAJPwE9Z4LOxEEqcGESbeNlEBsddeXFHeNk=;
        b=OWLIiaaCYeGONl8LhM5NEffe09dx8iNQe+KOPLE+Ck0VCrg85GjxhjfS3QHR8leIeM
         93QkpHpGuxgft45PvKIvbkPkChGIMcV0kUiv0R/EqGPXx0PvN87XsxpyvKSNV74AmZqt
         MRuR5W7c/zMxAYq6qW2I2FFeNb4Adc196g8uCjizP0At9sxhhdRJlyiK83jvI6PohYNF
         ofo9y+NnB3+XPXJ7+EIUCgDFVeRAGjVEtyAZuEeHDgAGlWSpgZNrJtFfeILRNhzj0hKK
         whS/EFtfhmvIHlGYDXL+8RC5eZkZUpt1VN2AfnlUVuzAun1CeK8pIzyNKVPNplFcCvxL
         U9AA==
X-Forwarded-Encrypted: i=1; AL+hErFGlnqDeAXSEktT61/GfP/IrKyffED/H6nkTA1vAo7pGa/ROgd//PhfFeWjYKcfn0Xp3yo6lhVpXFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwYTqVPrNSRHMvy5YDuRXS6ws+HTe/W9UL0G1wbYi3S8EDnJK
	CfXmRM7m9H/5uM4+XubEmHKnUXDb9BjN23SBHcxir2DvKAZpqE1bTqPve2co4vv92iQ=
X-Gm-Gg: AZFdTZcKihbUrFBamUoKuP7pHOTRnTSX4wyyNcQXBA+gwsEVjk+a5QuJn4x7RM2o2NI
	1U6PrCF7rnlc81ZizC7aOiUVcn9GzsH9miex9mXEqvaSUL5VN8M4mTnQe/qx4kPAdHTyOE0MZcn
	g223DrBS7pMn/B87fZoA1cDhjjZuIIJAAsDO9zzdtQwTWuqktmgnDD0fwNNDHLDKRValUmnCyCs
	c9IbIux9EDrishpSIfRkVfGOLef1MADqFYCp3xGyl9NNvt229s15AKFYX24QZzHTsZHcBskO30O
	9hJHeRajHdtqTWwxk83R0XsEmlMF2PQU0dGYHGIfQjQ5p40B6SJZUdluboEVfbNA77kYkPQz1b6
	MbQQMmDTxi4CMAOT7Z+Y1d68J9eVE100sBVS+bXufBbKxcevv6TB6tvLUihYSejHNJ1SVNQGvBu
	w569r+tB8j9GgdwwA6c65vnQ5LhMwc3SaJirlxnUKIPV24IxXnEsyfGDuXREGLFVvECfmcKYgqk
	6tkDveiE0AlSciR6apapIW6jzhFaqdDO9i12dEzX5KQk55E8u+Oi5BMJ+R0bCfKFP8cUtAW0vkt
	XgJIoBnqT0hUp11Zfzqh7GdnhnJSY8e2GQFvilGKrQiCg0/5IR4StVHvQMOnwKkonEQIm41sdAy
	UDZBvOWGT+tk=
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id 5b1f17b1804b1-4bb887c2697mr216534635e9.3.1795374520111;
        Sun, 22 Nov 2026 11:08:40 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f7bc1sm103080395e9.3.2026.11.22.11.08.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 11:08:39 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: magnetometer: mmc5633: Enable the VDD supply
Date: Sun, 22 Nov 2026 20:08:35 +0100
Message-ID: <20261122190836.66111-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122190836.66111-1-gerard@teslabs.com>
References: <20261122190836.66111-1-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boards may switch the supply of the sensor, so get and enable it before
initialising the chip, and wait the 5 ms both parts need after VDD is
valid before they can be operated.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index b651f01e1b5d..79015c7984de 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -64,6 +65,7 @@
 #define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
 
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
 #define MMC5633_HDR_CTRL0_MEAS_T	0x03
@@ -472,6 +474,12 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VDD regulator\n");
+
+	fsleep(MMC5633_POWER_ON_US);
+
 	indio_dev->info = &mmc5633_info;
 	indio_dev->name = name;
 	indio_dev->channels = mmc5633_channels;
-- 
2.45.2

