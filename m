Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924352;
	b=BHLytDluYIobC8RTss4G61UxJadfqQY1SHkxMI76RYebMrQUHoB99pyEpNMBikcYGQnL
	 7SqbhdX9Pv470BL5liMaHBKbU8Hph5Xe5kHdL7diD3/cnFAuOl7jU6MOR6wCZ++bjA450
	 wddxoX9XhXdBxeQuyM0K+l9BlGSLjhBEZ2Ha/zdZ5pTeNR3XH8SuSfvHSJYj+cxUXUR1E
	 0gUbRZVm+nMczorR/ut1GP4L/UILtp+b8AFndtO2lm5PCtXa1Vwc7+KNRAf9ErAjnGyOs
	 fqi+/lxXuQmzSRSTJO54nsWo8vZ4PanAd2maQUKrj7rDYHG8ASF8GtA6V4caYXnBBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=quQMrB7OSgXybtrUuyxFHk5pzIGZogKcKvne8SHcCQM=;
	b=OG3rkw629fYncJuctjPsZ1+sBbyygTyOSxHJczjSnpkiXTGpE15XMq5BAhxCTCvSUVrb
	 i29kUs4qp4oOzGm/xqEyHvFUjWS9/Y2XKxuBHd6oQZD0gdo9jME1i86IRWfw7wV4ra8Vz
	 ONtr1/JIVpgiLDGxYO0xDGMVMqqK1g+sVJKmKRloZ2ADCkIIzwgtg6j2JHmoTTl7rXqXm
	 kIfrZir3CeJwDneLaf+5wPayI+VAB3WdYBo4Z9Uc88+EWVmg83Hu6oSEKp7xRkwOFNX0Z
	 ZIafcwXObTfZl0qej6xoVaC9IQUyL3jbPbMA7l3J+WgZItq4lWb6z9Ei8g2SmHszFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSXDZD5;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067F606A33A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 14:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3067F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXSXDZD5
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so794942f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794924350; x=1795529150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quQMrB7OSgXybtrUuyxFHk5pzIGZogKcKvne8SHcCQM=;
        b=bXSXDZD5q71h2p27nbUBSSMT0K3jgKFP+hx4VsqeOsoePNxeftxluSDaxndcUPfQ0g
         jHXwyp9DUJyY2oaExw3IXEzlcpK2g9gVNE//wHOxRPp54Hs24gm2HgGw0d8vBiKHpXtP
         9a1Ze3s4zs9WkDHjM8ofzUZPxOtnV+nD1Bj4bow5RWsm9yWKgp7EH2+30dHMsP3z6J0B
         FGmLsQNwQr/NTTKk8Jgl3kFg1YGIG1popPT1vNC8UY1Da7eUN/8X9IeYrcpB0RwJilqU
         sywMdx3AR/RHsQEdNTFsooyrnU9pjJ0hbW25UYcmjec/EL0hKJqKdAd7KcQYd8N/LjRJ
         GTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924350; x=1795529150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quQMrB7OSgXybtrUuyxFHk5pzIGZogKcKvne8SHcCQM=;
        b=VltqZwXVIRvbFjQpFlsk1gIb0AgNKfpGDgKaGIk21xMEcRB0TO+AExrvdAYxP4qVJ/
         ZWMMoDJHUH72eGjTygHUzdqHmw8Dx4zyl24Wb6PqG9xUhAnwz9b+bAagK8CuNDr6DlFF
         WmTUk3PIRBpilTkq5cPKbuXWxkKzTzeJ+mGawc/NeCQ8nrIvJm6GQU0Ssf2NRPFH35vr
         1NyUthyLKgDqyO+UCNRxOiUTPfNcM6fcH6QFtDVHYByOtlWHF8jUkfas90MqKe8lPUe7
         WTUcndMhSh5f2S+rhZxNwFqDxGjdvMr/34n01fZqP1RpynoUYmxLqMcVxGMT+gi7IByi
         Vovw==
X-Forwarded-Encrypted: i=1; AL+hErGS5bKIsXUHCYfcaQDSgneELf3CcFWhFeabuM0Q0C42haTyy0KgpwcflOHvRYUeswLX18/2O5yInks=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DGA0MmhLaNKMmSeVQAp14BhxvWuEYil+MNll0SbGF/K0TtpYG
	ywbya2iAarc8o8Vz8FfFfKFGLEpF281BN/k1AiIv6lLzL87CQVrJX3/j
X-Gm-Gg: AZFdTZcM/eiVZceTh+SKJpZgRe0O6rLt2qsgrzxk0KMbm3p557b9Z0QE28d8Ob83uHn
	dzuf76jHytj/hBrs2oRKQFN6hPnvaqT9aubuUtAtOpO2KXS8OBHWaK6Dad5u25jw9Q2rTUoM3h8
	uv64htyokgRHH0cAfZyNpniQmvgGYvUXcsaVDDGe+jyF76Ewtii0BfO+gMGK1s+QBQdUaakhvl2
	3NuKCxY3lAUdMXa5SprZKsRYeGxxTY3q9opR0XIH6DiSNe3LZh/ccIHfgd1fz8Si4xaOkMi9Hoi
	9DHoaGcxXzg/e0t60jbBgaYKQsnheTZ3U3Zjj807aOrspnd68bmocTTau3XatPy46mJ7k7p7o8c
	brvbrqKftyaqNrwDNm4PEfCa5zEn2/QsrUZC6AJk4ddeO0haS59FhCb4PxE1R61sBZKluma/E7A
	k1lL+c9CO5QN0iHj2SbV6ZNOmZmyQPykCiZbZPS8lAybvbkBEMMfquiP2/cQDzUPofxiDnuvaLz
	Ijt+/WZD1mdPRHiNliichdMmKFIyq5yifAuhuumhz7QUxo47aEXb8FHzwpUlL+iq0xCP7L14XvV
	WfrzlX6ykM+fiDtw7ecAHr+0ysBzlLIlmQNcHA==
X-Received: by 2002:a05:6000:24c4:b0:491:eb12:e151 with SMTP id ffacd0b85a97d-4a36c30c94dmr6426991f8f.4.1794924350441;
        Tue, 17 Nov 2026 06:05:50 -0800 (PST)
Received: from fedora ([154.183.162.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm2623032f8f.8.2026.11.17.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:05:49 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 2/3] iio: adc: at91_adc: use local struct device pointer in probe
Date: Tue, 17 Nov 2026 16:05:09 +0200
Message-ID: <20261117140510.391907-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
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

Introduce a local struct device pointer in at91_adc_probe() and use it
in place of &pdev->dev and &idev->dev throughout the function.As a
result, messages previously logged against the IIO device are now
printed using the platform device being probed.

switch devm_iio_device_alloc() to use sizeof(*st) instead of
spelling out the full private structure type.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 46 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index c7fc06214c05..0553a08b8d24 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -987,32 +987,33 @@ static void at91_ts_unregister(struct at91_adc_state *st)
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
-	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	int ret;
 	struct iio_dev *idev;
 	struct at91_adc_state *st;
 	u32 reg, prop;
 	const char *s;
 
-	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct at91_adc_state));
+	idev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!idev)
 		return -ENOMEM;
 
 	st = iio_priv(idev);
 
-	st->caps = of_device_get_match_data(&pdev->dev);
+	st->caps = of_device_get_match_data(dev);
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
 	if (of_property_read_u32(node, "atmel,adc-channels-used", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-channels-used property in the DT.\n");
 	st->channels_mask = prop;
 
 	st->sleep_mode = of_property_read_bool(node, "atmel,adc-sleep-mode");
 
 	if (of_property_read_u32(node, "atmel,adc-startup-time", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-startup-time property in the DT.\n");
 	st->startup_time = prop;
 
@@ -1021,7 +1022,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st->sample_hold_time = prop;
 
 	if (of_property_read_u32(node, "atmel,adc-vref", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-vref property in the DT.\n");
 	st->vref_mv = prop;
 
@@ -1031,21 +1032,21 @@ static int at91_adc_probe(struct platform_device *pdev)
 	    && !strcmp(s, "lowres"))
 		st->res = st->caps->low_res_bits;
 
-	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
+	dev_info(dev, "Resolution used: %u bits\n", st->res);
 
 	st->registers = &st->caps->registers;
 	st->num_channels = st->caps->num_channels;
 
 	/* Check if touchscreen is supported. */
 	if (st->caps->has_ts) {
-		ret = at91_adc_probe_dt_ts(node, st, &idev->dev);
+		ret = at91_adc_probe_dt_ts(node, st, dev);
 		if (ret)
 			return ret;
 	}
 
 	platform_set_drvdata(pdev, idev);
 
-	idev->name = dev_name(&pdev->dev);
+	idev->name = dev_name(dev);
 	idev->modes = INDIO_DIRECT_MODE;
 	idev->info = &at91_adc_info;
 
@@ -1064,25 +1065,25 @@ static int at91_adc_probe(struct platform_device *pdev)
 	at91_adc_writel(st, AT91_ADC_IDR, 0xFFFFFFFF);
 
 	if (st->caps->has_tsmr)
-		ret = devm_request_irq(&pdev->dev, st->irq,
+		ret = devm_request_irq(dev, st->irq,
 				       at91_adc_9x5_interrupt, 0,
-				       pdev->dev.driver->name, idev);
+				       dev->driver->name, idev);
 	else
-		ret = devm_request_irq(&pdev->dev, st->irq,
+		ret = devm_request_irq(dev, st->irq,
 				       at91_adc_rl_interrupt, 0,
-				       pdev->dev.driver->name, idev);
+				       dev->driver->name, idev);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Failed to allocate IRQ.\n");
 
-	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
+	st->clk = devm_clk_get_enabled(dev, "adc_clk");
 	if (IS_ERR(st->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(st->clk),
+		return dev_err_probe(dev, PTR_ERR(st->clk),
 				     "Could not prepare or enable the clock.\n");
 
-	st->adc_clk = devm_clk_get_enabled(&pdev->dev, "adc_op_clk");
+	st->adc_clk = devm_clk_get_enabled(dev, "adc_op_clk");
 	if (IS_ERR(st->adc_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(st->adc_clk),
+		return dev_err_probe(dev, PTR_ERR(st->adc_clk),
 				     "Could not prepare or enable the ADC clock.\n");
 
 	/*
@@ -1094,13 +1095,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 	adc_clk = clk_get_rate(st->adc_clk);
 	adc_clk_khz = adc_clk / 1000;
 
-	dev_dbg(&pdev->dev, "Master clock is set as: %d Hz, adc_clk should set as: %d Hz\n",
+	dev_dbg(dev, "Master clock is set as: %d Hz, adc_clk should set as: %d Hz\n",
 		mstrclk, adc_clk);
 
 	prsc = (mstrclk / (2 * adc_clk)) - 1;
 
 	if (!st->startup_time)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "No startup time available.\n");
 	ticks = (*st->caps->calc_startup_ticks)(st->startup_time, adc_clk_khz);
 
@@ -1127,7 +1128,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	/* Setup the ADC channels available on the board */
 	ret = at91_adc_channel_init(idev);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Couldn't initialize the channels.\n");
 
 	init_waitqueue_head(&st->wq_data_avail);
@@ -1141,8 +1142,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!st->touchscreen_type) {
 		ret = at91_adc_buffer_init(idev);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Couldn't initialize the buffer.\n");
+			return dev_err_probe(dev, ret, "Couldn't initialize the buffer.\n");
 
 		ret = at91_adc_trigger_init(idev);
 		if (ret < 0) {
-- 
2.56.0

