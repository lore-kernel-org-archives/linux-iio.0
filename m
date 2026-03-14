Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32137CD4A
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504407; cv=none; b=tHuMHdmuATpGBcIA6A8NAT0WP0doKrVgICLdkYeG0scLpZtJgxChbR2lCri36ABrknT702kToLEb3VNhP17d6K0FT5mujTJVm2UURo4AaNpihJVu7beRq+2JpyNrbeAmpD5Hxqba5gp6P69a0h5cey+6sbQCXUrxGoP4HhGgVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504407; c=relaxed/simple;
	bh=AAYQH8m5hJopiQqgeTngADuMlO+elqyJCsSOeSZcnBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UA/JY0z8RCQh8t6RifJ3Cvhe/1fz2AXRsGLu8SJw3k74YXQOZCwWmLFdC6YS/vpWjelRF5QgQ//UBWdPWj+nwm2ha2OdDBJ/16ZErUYAzMExuqWRW/kDcwWYF8ctRHZbENAWjfKqJy3FC1iLI1D0FUu5rfH9brm0WOIa7BgbOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGaiKDey; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGaiKDey"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9358bc9c50so392905566b.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504404; x=1774109204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztVKqP7Iue8aUh5WW0pabHa7SHe1KuIXZfJfBXrdn9M=;
        b=dGaiKDeyCS/zMpoONAWtHlh6/lm5+lp/RD1B9EeSGZ2u5oRIpW1Iirkmz6zYIloLUs
         /VEQqCH0R4Ju26RpDnC1TS3BAF8DBdY3Q1WBZn2Uc+aCHx1O3h2FCSuD7NOXd8cKJyew
         J7uWG3FghoA8CkNzjwbAEajbKB3PKa6EDxnl9TvygmQ7D3+SB4dAu+1gec9Pp9HuS2em
         3BBpwDEj7DyjxSYc6iuY1TW/JVmo7U/pE/tUCSnHUkzJ/wit9T/7rU8xc4H5q+DmUNWl
         NSDJUXU3GBO1RC28jclfsIoF2DHlcKiXVfRlT2OpoKW5x6xn9oR1sY5RKL7fIDYahpB+
         f2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504404; x=1774109204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ztVKqP7Iue8aUh5WW0pabHa7SHe1KuIXZfJfBXrdn9M=;
        b=nESQwkadcSlrp5JovqmUbx8fjXX9BHenyiGpy9dpaoyXwL4zwrsp2YntO755UtWg10
         AsAiRK843gx8uBXP2GMtUbAraq4puXlrufmahxUu4Kyvm8kHSsPuDySSY8mOEQjUmydU
         402x92aR5cOwf12pkWNeZc4JII1Piy03SPPjdfX5vIx2ZmiTM9MXjzmDTFAGTqUOucyn
         oWZCPSOxxvHAcJxZLjveoXMP35zaw9nwLxnW2S4sEAKRHREByCP1p2IEQrXulwPKEWl7
         u6x3E9zDsqgHvAZSnliql6pGWGa9u/zrTLuPfw3W4GjAadq73vQh3KFMbZSd92bgv80u
         +F8A==
X-Gm-Message-State: AOJu0YxNr3LI+nX7x7H6vCwjUbn8vBnjcsXa1cVjZZURLkuDFFonYfp1
	Of1488w77CoPu2/IbDBHx7JiJ2DWTDxZAad31VGtHaLmdMHLjL/zIxJ5
X-Gm-Gg: ATEYQzxhoC2QtYAOH+kuhwOa/F3O/rQHVNLbu8WUj8mG1JACAytVvoHOsyRgedynQRC
	MQ9EA9Oa06EuzNYFFPJb5gnb/3hIPtfCZZ59DL/R/zV4hOYAU3PW+HljQh5VP30MY+PFE2L2b4/
	djpdrK2lY9rWP+5YtLEEXVCBcnIf8oK52gA2i6Hao3B5OrCcRThF+i9k/0RCwZmBZYRhO38McIt
	QeRhfzarp9D7+l+8+C4qmmPZLhtJ9+7rUgiwt+l53Bx2HzxgZbuKBTRUy5W4hysoaWKQgnqdCJ2
	w6DJb7SnXp8KyjzdejwNcwpjxHmVZv6wTE1YjfcRIyTwwNow4ycv5/cdQhnMb91+6/iOemRQSoz
	f6VY9L5muooH5y0SCk0rTwnOzXqJjmfNtAX4Z7OvhAPII83Js/AJDhJAXEHrUa1SD/thy3fYhxl
	iffAk9P83p9kJK49mOdtSNVVFYiQ==
X-Received: by 2002:a17:907:746:b0:b97:6384:2317 with SMTP id a640c23a62f3a-b97650e5609mr440832566b.17.1773504404085;
        Sat, 14 Mar 2026 09:06:44 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:43 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:35 +0200
Subject: [PATCH v3 6/6] iio: light: vcnl4000: use variables for I2C client
 and device instances
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-6-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
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
vcnl4200_init and vcnl4000_probe by the said variables to reduce
clutter.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c8bb1826b916..9b7cd3f0c8fb 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -362,14 +362,14 @@ static int vcnl4200_init(struct vcnl4000_data *data)
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
 
@@ -379,7 +379,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 			return -ENODEV;
 	}
 
-	dev_dbg(&data->client->dev, "device id 0x%x", id);
+	dev_dbg(dev, "device id 0x%x", id);
 
 	data->rev = (ret >> 8) & 0xf;
 	data->ps_int = 0;
@@ -413,23 +413,23 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 		return ret;
 
 	/* Use 16 bits proximity sensor readings */
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	ret = i2c_smbus_read_word_data(client, VCNL4200_PS_CONF1);
 	if (ret < 0)
 		return ret;
 
 	regval = ret | VCNL4040_PS_CONF2_PS_HD;
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF1,
 					regval);
 	if (ret < 0)
 		return ret;
 
 	/* Align proximity sensor sample rate to 16 bits data width */
-	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	ret = i2c_smbus_read_word_data(client, VCNL4200_PS_CONF3);
 	if (ret < 0)
 		return ret;
 
 	regval = ret | VCNL4040_CONF3_PS_SAMPLE_16BITS;
-	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
+	ret = i2c_smbus_write_word_data(client, VCNL4200_PS_CONF3,
 					regval);
 	if (ret < 0)
 		return ret;
@@ -1998,7 +1998,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -2022,10 +2022,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
+	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
-	if (device_property_read_u32(&client->dev, "proximity-near-level",
+	if (device_property_read_u32(dev, "proximity-near-level",
 				     &data->near_level))
 		data->near_level = 0;
 
@@ -2037,7 +2037,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	if (data->chip_spec->trig_buffer_func &&
 	    data->chip_spec->buffer_setup_ops) {
-		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
@@ -2046,8 +2046,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, data->chip_spec->irq_thread,
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						data->chip_spec->irq_thread,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
@@ -2060,7 +2060,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto fail_poweroff;
 
@@ -2068,9 +2068,9 @@ static int vcnl4000_probe(struct i2c_client *client)
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

