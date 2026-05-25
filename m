Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B925B08F
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673193; cv=none; b=hcVz6c/MkUX3hvmdRoJ7ADRpENY1ZON8vunpEZepUAmhPyak1y9iLLbAq7HJPp6pvQBxqpnjzGzU5nPPMFm9eb3sX+Y2rS1w+dakHWdQckCPLBz0i0v+PlYpjHaI7GBPx5wmo0M5Ns2OX7aZ1HrqCKwhchODrn89MXEbSQsFYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673193; c=relaxed/simple;
	bh=au3KpLqYbepgVrQAt2RX8cSSLgzx8HL8SFAfmcOoutc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDrO2egcvJ8cPd7ENQNWJ2SAjCPv9leRsqEJYuYNropQTdGtx80j/BLELXgbEYzE9Oz/ij+kLXiDAhVYdHA9xRDeth0MCWVglPaLBPRBMg9TRP3Solz66s5v2TByim48Pozw8N3XSykp1GTAFOeed73a1MPy298RrmRE7ntP7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h0HmU0Nx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h0HmU0Nx"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e5fe62fc87so2427598a34.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673189; x=1780277989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMUE3/7kINiPQNa3IbX9MLqOrJoUgIbbeots1aiBMpQ=;
        b=h0HmU0NxhcD1Xkk4NDI9mNWzowlaI6n5oCJxUT56p0xl8Cg67gKVPdiGHxevwH39x+
         NQigcm/8Gf81MxMB0aIZF8o6AcWpMC4nKEdGHddPi3p63JRG84piGoeO/j/djmRQf7OY
         fhExU/hOShKh8TxmnBrTpAQLmml6aWM6gep766WxdTJ/p70KV1wiX+PN3YkX1AOwZMQM
         5zgO16iTqefzFOGUApPG88tQSOUfGy7JcAKVz5cWYB+Wu70GddqRnILt6OgeT8s5Kt1i
         n4OdxVvfb9ZfEr1JRC299nh8v3hCHPzrkc01Y7auK0wnsO0/yWxE+NHfjKmiayHJ+83C
         Zi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673189; x=1780277989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMUE3/7kINiPQNa3IbX9MLqOrJoUgIbbeots1aiBMpQ=;
        b=gLEJwtbgJcgWvCy7SKiB2x7fVwm6/6thVrOBVN63zYKCggGrck7vLG3uihW/olBqsI
         fn3pp7DwHPTbtE95y+Xlp4FG+DlJa3WDLB3H+k9h8VPX8siFhCft5UDJByAfWFlG18uv
         akKBVPpvR8HWHTzfTiNDQNj+VwxWV9nmgDVxtM6LE7lbBbpkUqVrAivGV07jb2i1tJe8
         nfJKx+XjhXroFWwtc4wrqrk29EK7kE+zAv3F86PV4xk2SquC2qwH5qdiOAjSkAB9zVtM
         b7ozyzSIfhR3WYOXWhTfsL15UdINjzGZYOTVgC4ftt/PXfmztdiUpGX5ikZqomUOGYDw
         Zblw==
X-Gm-Message-State: AOJu0YwOukWOJgIwYaW5BxRjGeNJzam0qHqXU01QL0hdQrYXUf90FUr4
	FR0ctvZRWdf1gfEhA9c+TwFI46zQs1aRqeySb/aG0JVCm5fGQH/WUgR14juR67d0VV0=
X-Gm-Gg: Acq92OGpdu7XVvOiE4wZRY9o9GbpBdZlDBJGXYHX3mHobIa2ce2qd19NM9bOcxhpV8f
	xa+eREdMKEw2pyIQojmzo0mqtkciN0rcONgwh57Q4U8ME8W4FBC6tTtZKlEd90x7XoBJMxSnM4t
	VFKFb9l/ehVGZCVOGNK4oFuezv56dAodztSueA4jqer4cqU1HiSROr/aQqGpk+vQ/9Z3fifkRhw
	2ZV1/RKKGitkg9kNIokTUbzDv4SJgrVH0B5F6Onz+wpwQU5beAjVsloWdqGbR2tfLUe9Fr1IdJG
	2g3T2bvMw4uw/ARZNUopqBiO4MnpgVr3mAwmtu5+mWXppe7tml66WbK9a2/k0WxkdhA2R8fDBPD
	nkyIjFYdTYeWbk9BMZlUyR0MObom3CmtmdWRJ6nohDTs4I4va3DHb9CRC4n096Cso0n32uPifA3
	nl37NAUQnJOnItp254RNc9CF3j8Nd8XgPfGtLmoeNk2vuUyVPmcA==
X-Received: by 2002:a05:6830:438e:b0:7dc:db3c:1d63 with SMTP id 46e09a7af769-7e5fef8778bmr7211293a34.24.1779673189590;
        Sun, 24 May 2026 18:39:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:35 -0500
Subject: [PATCH v2 3/9] iio: adc: dln2-adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-3-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=au3KpLqYbepgVrQAt2RX8cSSLgzx8HL8SFAfmcOoutc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6gxGpINpNsbfXFkHrF+BjDlueBxKNBZdolVS
 wzGu4LBeumJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoMQAKCRDCzCAB/wGP
 wLvKCACg/4GawBxVUGhqi1U/lCBImoTuAHgKA58qiBGlLscoWThFgoEqehSdU1vluTATvJPVJ/K
 NVMe+3HlBGTZh6GZAkNWuxDKm9UU3/i7rMdPqRprTryF7XmJRy7erIWRS18FKuuH28SSwe5PqTH
 pI1+U6/YZwgRhnxI0QItWzNlicfPd++Q4bY0+NYUpeiUw6X1UI5+4c5Nk1+nOen0W9Dp02eJN86
 1ZFb3HpwxHPCUDld5p/mxWNeOgNQ2WqmCRdbUW1LsUBwRtXoVdrvXl7Dp3gGzlrDoEZpQXG+06a
 Mj8/bPi9uEawWuM+whYNIKUpoNvmPLjYStWdmvzai+z5laQk
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/dln2-adc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index eb902a946efe..b01c6f5a73b1 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -444,16 +444,6 @@ static int dln2_update_scan_mode(struct iio_dev *indio_dev,
 	lval.scan_type.endianness = IIO_LE;				\
 }
 
-/* Assignment version of IIO_CHAN_SOFT_TIMESTAMP */
-#define IIO_CHAN_SOFT_TIMESTAMP_ASSIGN(lval, _si) {	\
-	lval.type = IIO_TIMESTAMP;			\
-	lval.channel = -1;				\
-	lval.scan_index = _si;				\
-	lval.scan_type.sign = 's';			\
-	lval.scan_type.realbits = 64;			\
-	lval.scan_type.storagebits = 64;		\
-}
-
 static const struct iio_info dln2_adc_info = {
 	.read_raw = dln2_adc_read_raw,
 	.write_raw = dln2_adc_write_raw,
@@ -614,7 +604,7 @@ static int dln2_adc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < chans; ++i)
 		DLN2_ADC_CHAN(dln2->iio_channels[i], i)
-	IIO_CHAN_SOFT_TIMESTAMP_ASSIGN(dln2->iio_channels[i], i);
+	dln2->iio_channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
 
 	indio_dev->name = DLN2_ADC_MOD_NAME;
 	indio_dev->info = &dln2_adc_info;

-- 
2.43.0

