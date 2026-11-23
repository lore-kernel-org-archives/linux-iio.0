Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417319;
	b=fdAerwcIjlCianuJirwOmOk5OntGbnSMtvdrF+f0CbnKaw4p+6ds11HejJzbKQ+CTIdH
	 eIvtcN9EUGAY3+7XO5uvvemUP3ZgLHRD4+DoEqfH4whfBYuZt1mKJdm8+c9RH3wAjO62W
	 wXxihlv2dA+Xaefops1I81WNLHJ5LRoGEh9E9tcj0rl4GbCJIY7c8Nmx2eFO71xBJ6L0U
	 PFUrI015JD8cfTzEs5aLXgDjNPAjMpDesEw+Z/425AXz8TWUk11Mdk9NRX78te6r+HOYA
	 qkAJUptg4bSSppVP8OZ+wMvu/lTXOf0nJQpPCF+dLzgL92cWW9y/wDmmUvaNF0lZOnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g2CjduqTplR6Y/0NMaC1HGY20Z0WtrWxgraSoRihXcI=;
	b=A/GFxCNziZKXGEQRjhS2BUARkjMvM30e/b329m+SU2xnU2uOoAUD084GSzYamS8tpmC1
	 eZ9P6rfMx3QWyS9obDpeWz0lPe5azv8cEKFuiR2Qv+wtYPENkNA6Chj8Qb4jdiJR11WY9
	 lucVM7VBPSy4ftBb/THcvfGtldNIyDvNJrf2R4uvjNnTluDWBudCEfFFcs0qv+JdK/L6+
	 KXctubPolri8j90DLqs0Y+0AOXCNMq1uNVdELGD8ytb10U2JQ3kL/VKzpPxbCfocaqh3d
	 U6CQJ1/wP8kxoPOvvBjwqf094keD3uLsu7PkBqzopIhmhhLu/8pUqiV89xEt39S1hHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXWHNzgj;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56536606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56536606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXWHNzgj
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so3362978a12.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417316; x=1796022116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2CjduqTplR6Y/0NMaC1HGY20Z0WtrWxgraSoRihXcI=;
        b=CXWHNzgjA0yUA2i/GW2ZXwg+sMyS3y7h5sGKuvPwI5gWhUxGwOmhqX8mt046G81QOz
         Zc5oqQ/HCN3zeVzGcjtF6MlbZsPYIwbCaUCa8c5EWO8VsZZR2V5+IbDCcTWLIu5zletL
         CNdyCaEKlsVu08+X/T2tqyspVHqrTGEmX2rJc9FiVP2GCnlso7FaD51sJPcxRASrImJQ
         hk6Sit7QC5kk6URFZwICYJk9rwvesjW+vv1xU4H9jyoAwpuTW8Gw9kroSE7jnT7L24Kd
         7GmacQQr1IypIp5gjvIUASqZXqM+QpvkAFh9mY4T9Gvdq3RQFhXPoC/h4UBQlcspamhU
         aCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417316; x=1796022116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g2CjduqTplR6Y/0NMaC1HGY20Z0WtrWxgraSoRihXcI=;
        b=MUPC/IrbAoOvffkjZaCIhZ0iau9+09Ci2E4algUgEMXRsaE3LpN3k598ojKlOSR2MJ
         LveOqHazcjjYzlK5SoRbc6HdgCO1jAAJjfWmErNdRnwmLbXjb6hqeaMPETjjgsCBxYpw
         Ue+1wD1oY9k++vTmgLgJSD0yTgBBLA9AX5HMQkb5vpFiHEg8lWRRjdc+svlo0zlKqoLB
         R1tQPMJ3hooEEb5VRimPC472PWHw9icSQJrow90wjKz9ITk7Klik+3VJGizWGmsIIGeZ
         Um1DtzjNDrSGo4dOgnuvwpjeAmTGT9sLOOEDxfqZ4XJVvBc+K+fRG8bleREl/7ucIZDF
         jROQ==
X-Forwarded-Encrypted: i=1; AL+hErE3fX151HDEaECP9skybwiPqxfZmlfVd0GiBWONR8fj5MVo2cEDaqAedab5fP+8u2bhD5C4Gxe+fg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rA+XtnLYwonDIdrM9LF+uoVVoYjjPYv34AogyJhzObM0TBsZp
	cneO+qlqlzR3vUWlyLRQYpgiotDk0i4lcpL09yDdfH+wtbgGXKYddUkv
X-Gm-Gg: AZFdTZfZKRlWQ1t8Fqh7dbvDhL79Pov6j095tQBe0iUkWWFKrOuAseR55K6CU0AdyCs
	rtDj3vBJBi5V6S77m4uzNL3ra7j1CImmlP0FObMzLlkTxAz3PZH78l67PSnrs8PyHeQLOgxJNDK
	jpmov7iBpK2+hXh1HFsNcEsjcLoSdS/lz8XZptIh6GtE51oeQalSm+AGOd2nM+CeCZ2PqkzHW3o
	mS7nGJnSeeVZl77+5px8A/djukM3a2cS4QOzC8sJda+oODGI0RdQwfIBhh3RvFjID4I2shExhIv
	xAVqxD8JkOMjtci2235RgwOxdtbQjcl5YKpx6VueY7C43MfCijp2r9Puk23/UIuulMCfkAe6nOt
	vfm5oRADxxE1uj9ltQCe2x8Fivu/zqGMl8KNSMI1flmUCx4SxKz74XhGMPkyi3jXrlnsEzAQZ/a
	4agwb4o4+jH5ZEOGcmDGsBLy7s76JPfmBv+u7dUveSiXeLi13XL8nFZUFnGe+j4KHBw9M9JJckN
	o00bNMqyDQj9YyE5+1fH6nTL/94PCTlL5xrUydVVlt7M2aVrlj+J4avPc0B1bdSk1CNE9Dlhrwm
	aGooZWUnWMfEnDdvAvCsDcVeoJHEGqaGPTUQ
X-Received: by 2002:a05:6402:2807:b0:6ba:b1fd:6e7c with SMTP id 4fb4d7f45d1cf-6bab1fd717dmr1440319a12.1.1795417316290;
        Sun, 22 Nov 2026 23:01:56 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:55 -0800 (PST)
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
Subject: [PATCH v5 5/8] iio: adc: at91_adc: use local struct device pointer in probe
Date: Mon, 23 Nov 2026 09:00:58 +0200
Message-ID: <20261123070101.53868-6-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
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
in place of &pdev->dev and &idev->dev throughout the function.

Also switch devm_iio_device_alloc() to use sizeof(*st) instead of
spelling out the full private structure type.

This is a preparatory cleanup to reduce the diff noise of the upcoming
conversion to device-managed resources.

As a result, messages previously logged against the IIO device are now
printed using the platform device being probed.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index b6e6fa77c782..3d9ae99a2ce6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -989,68 +989,67 @@ static void at91_ts_unregister(struct at91_adc_state *st)
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
+	struct device *dev = &pdev->dev;
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
 
-	st->caps = device_get_match_data(&pdev->dev);
+	st->caps = device_get_match_data(dev);
 	if (!st->caps)
 		return -ENODEV;
 
-	st->use_external = device_property_read_bool(&pdev->dev,
-						     "atmel,adc-use-external-triggers");
+	st->use_external = device_property_read_bool(dev, "atmel,adc-use-external-triggers");
 
-	if (device_property_read_u32(&pdev->dev, "atmel,adc-channels-used", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+	if (device_property_read_u32(dev, "atmel,adc-channels-used", &prop))
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-channels-used property.\n");
 	st->channels_mask = prop;
 
-	st->sleep_mode = device_property_read_bool(&pdev->dev,
-						   "atmel,adc-sleep-mode");
+	st->sleep_mode = device_property_read_bool(dev, "atmel,adc-sleep-mode");
 
-	if (device_property_read_u32(&pdev->dev, "atmel,adc-startup-time", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+	if (device_property_read_u32(dev, "atmel,adc-startup-time", &prop))
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-startup-time property.\n");
 	st->startup_time = prop;
 
 	prop = 0;
-	device_property_read_u32(&pdev->dev, "atmel,adc-sample-hold-time", &prop);
+	device_property_read_u32(dev, "atmel,adc-sample-hold-time", &prop);
 	st->sample_hold_time = prop;
 
-	if (device_property_read_u32(&pdev->dev, "atmel,adc-vref", &prop))
-		return dev_err_probe(&idev->dev, -EINVAL,
+	if (device_property_read_u32(dev, "atmel,adc-vref", &prop))
+		return dev_err_probe(dev, -EINVAL,
 				     "Missing adc-vref property.\n");
 	st->vref_mv = prop;
 
 	st->res = st->caps->high_res_bits;
 	if (st->caps->low_res_bits &&
-	    !device_property_read_string(&pdev->dev, "atmel,adc-use-res", &s)
+	    !device_property_read_string(dev, "atmel,adc-use-res", &s)
 	    && !strcmp(s, "lowres"))
 		st->res = st->caps->low_res_bits;
 
-	dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
+	dev_info(dev, "Resolution used: %u bits\n", st->res);
 
 	st->registers = &st->caps->registers;
 	st->num_channels = st->caps->num_channels;
 
 	/* Check if touchscreen is supported. */
 	if (st->caps->has_ts) {
-		ret = at91_adc_probe_ts(&pdev->dev, st);
+		ret = at91_adc_probe_ts(dev, st);
 		if (ret)
 			return ret;
 	}
 
 	platform_set_drvdata(pdev, idev);
 
-	idev->name = dev_name(&pdev->dev);
+	idev->name = dev_name(dev);
 	idev->modes = INDIO_DIRECT_MODE;
 	idev->info = &at91_adc_info;
 
@@ -1069,24 +1068,24 @@ static int at91_adc_probe(struct platform_device *pdev)
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
 		return ret;
 
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
@@ -1098,13 +1097,13 @@ static int at91_adc_probe(struct platform_device *pdev)
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
 
@@ -1131,7 +1130,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	/* Setup the ADC channels available on the board */
 	ret = at91_adc_channel_init(idev);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Couldn't initialize the channels.\n");
 
 	init_waitqueue_head(&st->wq_data_avail);
@@ -1145,12 +1144,12 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!st->touchscreen_type) {
 		ret = at91_adc_buffer_init(idev);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Couldn't initialize the buffer.\n");
 
 		ret = at91_adc_trigger_init(idev);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
+			dev_err(dev, "Couldn't setup the triggers.\n");
 			at91_adc_buffer_remove(idev);
 			return ret;
 		}
@@ -1164,7 +1163,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(idev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't register the device.\n");
+		dev_err(dev, "Couldn't register the device.\n");
 		goto error_iio_device_register;
 	}
 
-- 
2.56.0

