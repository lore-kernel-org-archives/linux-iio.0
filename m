Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC33E0222
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025154; cv=none; b=dfTLVVI9Gjtm+bpKcDy3rDKwTWgZ8bL+Sr9WGA0wyRnfW79MK9qLVWXJu3UatMxeYwbPmCvf75VR9ce9S+wEJWEQOLm5rH0kJfid47bbPfP7Jdol/v4RWKtcqZVngd9v2I+h5udt8lfWJpXZ+7U4mK4gPB3fDFBBOhBYg15a3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025154; c=relaxed/simple;
	bh=egKHr0hohoUF1Y46/QK4pbAPf8UkacKpEmSV/fnmdIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5neexRn/Vx4ACcTiHzJ1caCTTcUVsB7N9FH1E54uucnj5Ucmh5nL9N31BqrGgYnEBe2o6aHh0WnaCuvYLY/wCbcHNIQzJXDdTs9w5//PRYWztM9HOuqPhdEs6Xcy42sdxzdja7a1CMSjdXpA4vSffQFXvTav/8WLH+ET1UrCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ2ErLKP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ2ErLKP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-668abc98923so1550802a12.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025151; x=1774629951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dtlos7JIiB738v4Wa8FtbGBxNvY35k21oQSX4LVS2wk=;
        b=cZ2ErLKPimUcmzLxAc+5R73d16ByjHxAAdvHVg/rsd929ySKBDz1QipHHSe8PpUI7U
         USRPLL5wVkobakmSG2nQ0tIZXePNDI5klD+XYrOjDDuq4Uy2xqCe/z01Z+12Orc4PR2T
         XvaAPffabmlP/vY8AD8VTRTz++4bCbpS9hyv89JtCXBB/lDImpvHuQSDqCAvdBRbb+T5
         6P6Nern3vI/fFkOQQOsmjJILtKSkh2pfrXU6oOrD4GKNOlM/Zm/seVlIRmIUUCx1t4jL
         G5LmUK9ye28Ee/x0yqpecqyZ683J0tvVut8uCIzYlOqTmzS1Yn7mDp5dcqUurO2T+lqS
         y4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025151; x=1774629951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dtlos7JIiB738v4Wa8FtbGBxNvY35k21oQSX4LVS2wk=;
        b=PyAaVxN19/IGgO/rLGeMb/6x0+Au/48s5MVPNsVTcMtt3GmzwlxBBNQzHksiKE3Ls6
         r7NxRXjI6U6+5hVH2MExIRfOPPz7iinkqNgzNMyekxcNdiwy9JumsNsDuBRiYTZaVaQg
         HLV14WqoaK0BdwlQdREnQN4P/eKSslJ6eULoyvsTxIDNEqTDz77W0THaaXEvXDOXQI5U
         nNZb+GOnW77+sBSGtqZI5HtOGjv6jU27zzDJB0C4s9EC59eJxCPXIWOv3Azib18HwdFZ
         tVK+/a/saYwgravElEnjmjHKsv/feWkxcfatCntb+F+m29Ef7n7TVXFp1k38R/9cu01j
         r8pA==
X-Gm-Message-State: AOJu0Yw8CO/qGZq8+pml/+dbxDYgR7C4Z6cGk9TUoIt5Z5vEc8U3m2RP
	y9EliOzbZi/YjmsrYhLQXuM6PmUnztp8+Sv/PfNRSp8vgRfEgfdApNHo
X-Gm-Gg: ATEYQzymZLYRymq8yvRDO9WTBO4UhfkoyKj3vaheMVAS5ukVumole8sKNeNxUyE0QVM
	KiQy2JzMNaeDD2gN4V4ZEbRDqCX/cnVw4k5PI3k4b7fXqxFL2s2CMbXDXe9PuVi6hc8MpOWuyOw
	KAxzt/oW1z6mUDpIaWMWpqq+ZrzEJ5lkMGiNU05VoL64/44QjdMh34a4gCr1VaDsxPrheqg0BvO
	shWLjVN5bJXZrnYOmXRVcZN+UTQ/Mbqwi2dZ/Y4qiLPhltZAI8gzY6/ZwtlQaHO1k5dEb0+QbHG
	8KREYS/qYADEPNI2vZ413fcnH9B7Aqz+D7qO7n06LTpSBOLPyVsFsm2RZqeFE4r2W91qPwMNmL/
	J36ESOcOEreKx82ivX+ctoX1q5wM5KSOYojF8pLN5yoWHr/OmSM/c4PXqgmbemTwroBFLqErh4o
	0HcMC27J7deI2vqu2HfI1Fakkf80RHcLGE+JrV
X-Received: by 2002:a17:906:f19a:b0:b94:22b1:4aa9 with SMTP id a640c23a62f3a-b982f4f9326mr222976666b.53.1774025150861;
        Fri, 20 Mar 2026 09:45:50 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:50 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:41 +0200
Subject: [PATCH v6 6/8] iio: light: vcnl4000: use variables for I2C client
 and device instances
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-6-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

After moving data->client and client->dev into variables of their own,
replace all instances of data->client and client->dev being used in
vcnl4200_init() and vcnl4000_probe() by the said variables to reduce
clutter.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 76aee16d479b..34b52725aff6 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -361,14 +361,14 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	int ret, id;
 	u16 regval;
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
+	ret = i2c_smbus_read_word_data(client, VCNL4200_DEV_ID);
 	if (ret < 0)
 		return ret;
 
 	id = ret & 0xff;
 
 	if (id != VCNL4200_PROD_ID) {
-		ret = i2c_smbus_read_word_data(data->client, VCNL4040_DEV_ID);
+		ret = i2c_smbus_read_word_data(client, VCNL4040_DEV_ID);
 		if (ret < 0)
 			return ret;
 
@@ -378,7 +378,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 			return -ENODEV;
 	}
 
-	dev_dbg(&data->client->dev, "device id 0x%x", id);
+	dev_dbg(dev, "device id 0x%x", id);
 
 	data->rev = (ret >> 8) & 0xf;
 	data->ps_int = 0;
@@ -412,24 +412,22 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		return ret;
 
 	/* Use 16 bits proximity sensor readings */
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	ret = i2c_smbus_read_word_data(client, VCNL4200_PS_CONF1);
 	if (ret < 0)
 		return ret;
 
 	regval = ret | VCNL4040_PS_CONF2_PS_HD;
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
-					regval);
+	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF1, regval);
 	if (ret < 0)
 		return ret;
 
 	/* Align proximity sensor sample rate to 16 bits data width */
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	ret = i2c_smbus_read_word_data(client, VCNL4200_PS_CONF3);
 	if (ret < 0)
 		return ret;
 
 	regval = ret | VCNL4040_CONF3_PS_SAMPLE_16BITS;
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
-					regval);
+	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF3, regval);
 	if (ret < 0)
 		return ret;
 
@@ -1992,7 +1990,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -2014,7 +2012,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
+	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
 	if (device_property_read_u32(&client->dev, "proximity-near-level",
@@ -2029,8 +2027,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	if (data->chip_spec->trig_buffer_func &&
 	    data->chip_spec->buffer_setup_ops) {
-		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
-						      NULL,
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
 		if (ret < 0)
@@ -2038,8 +2035,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, data->chip_spec->irq_thread,
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						data->chip_spec->irq_thread,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
@@ -2052,7 +2049,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto fail_poweroff;
 
@@ -2060,9 +2057,9 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto fail_poweroff;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 fail_poweroff:

-- 
2.53.0

