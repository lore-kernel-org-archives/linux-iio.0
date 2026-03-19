Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569B3CD8C4
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921563; cv=none; b=OfWwwemaM5OSq369SGJLTplJS5tmBEtxgu3gTrd8/KL7iCd8eOV7+/55k8k+oooeXhX/X3GkWl3+hUQLr/+vHe+xSUhANUEo9izFEYMHq7iOrgDg+OEIPXwmwhAIoWimRpksVJxpTHmofQYYh13xmT7ZbBigfkKlsiJO4kuws0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921563; c=relaxed/simple;
	bh=egKHr0hohoUF1Y46/QK4pbAPf8UkacKpEmSV/fnmdIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sn4UQVcLFKBb0B15/NqdlA62Nl7Il9bjpSyu2Pg2mCWvyzKtVNUkzMi4MAkKGGzgVNZcyokVibuT9ILu76WWTuCZoUWwVvUAt07YjZ448bJ9ozfWOxh4TUJ3gXpnsogRHauIJKJ/Z2ZdDYt2LooaHztLpGggqmiUVrbhWqNUSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjrdSSgm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjrdSSgm"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9813eed77eso100743866b.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921555; x=1774526355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dtlos7JIiB738v4Wa8FtbGBxNvY35k21oQSX4LVS2wk=;
        b=GjrdSSgmlb2KrbbOT6j+43Ru+iTKWJP24YhsLvvuE6FQf81yA4j2BvWIkRyDGknu/+
         7PH8nx7WcNBKDp1LDt4HGa+OY9yMp7mjwbae7tRzyoTAtT+0valqkhMwgDJOe+JHvEbS
         BYy+K0AyFJTBvXdVws352ZlStgUqX4OXH//QpqVl+te38byYNCzpRkz0lYtGdblkMy5I
         PQ1YPvGl1IgZkSdW2/oYGMjhhiF4bLGySEuYhGfpXyLdIbfEQM/l5qSjG6NhkCh0quAk
         78m5OxBWwdHeUJCBt4TCzxkULbYXYPGkrYiwRSvxnm8Bg53vEggYy0iqBbmiaTmkY/To
         5VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921555; x=1774526355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dtlos7JIiB738v4Wa8FtbGBxNvY35k21oQSX4LVS2wk=;
        b=lDYhZg877zM0XsvTNRBid1MgnW33GIbs3Q8A2uJ/d/befQ9z29jKAOXuiCFdSwAwcB
         RzxEC+ao4KmfdAZwKwXSh1XRO9ttkjL+EUK2U617Mrr4PytHF2tOZOsJ8I73xUHwwItj
         jsztijuL0aj/gbKVGJuZ6954dT9F366ym6STnL9e3Tkb0wG7cu02/av8sgw1vVn7NcZP
         RFQApWsLJv4KhQc7+WDuLnr1VhcJx8qF+d9huvaQlR4rzpUAg7r6V62R1LdeoZrfNkTm
         UHbpeIwMDH2qyITURtT4yD4J8W3cLxLnErr6uuNJBUrfe44eNaht3wsa+sfN9n8z2q9E
         yIgg==
X-Gm-Message-State: AOJu0YznJ4g+doNh/oKNPN4WJp+04T75BK2CSi+eRGoum9aod/5GKRb6
	IwWVhoER4BHyD1UkTzvBU5yuEqqIwtjH2qCXl8HQj1lrHjhfzq2lGrZ1
X-Gm-Gg: ATEYQzzef1tv6U8Spt5ETwlmk0DvXxUQv7v5Kf8mhDy62V8kx70Z2jL+7st2ClXIkdn
	Inf1mXN8Pqusn3YYnIKASdyU5jbFUcOm4oKg0p1dZBQ6uDApH5b5gVen96PcW9otGb21hMxT0qN
	wa1fkvVyZ/xFu2s4KapktC5xpi5OXootr7sw3RMW/Ca4QgPgAXgTIri1l59P53fcmyuq/CmAnie
	8agrIxdn60Qi8WxGOI9arocMqG/k9eeFlAZyHtnDnSVJQAsdXlKjjFzzDanEvqkuPWn61yTrGm1
	/lKTTwo2KC99IdWgxzaGSXvfGf4PbAYPJhl7n/8ggrziCBZe7eRBQhwPCvSDWWONGBr07DDaQjL
	FgQLx9cbSa6QuM7xfys3Ow20Ls3YWICfZYTdoPj5rhiSJw9bfQLjio8ehV+8deR4Ll+kYe5uw15
	djhWxZ9LFIsRjM8OZDInSgb7EJhAIzGq6KwNen
X-Received: by 2002:a17:907:60d5:b0:b97:cc05:61a7 with SMTP id a640c23a62f3a-b97f4aad93cmr479421466b.51.1773921554991;
        Thu, 19 Mar 2026 04:59:14 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:14 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:44 +0200
Subject: [PATCH v5 6/8] iio: light: vcnl4000: use variables for I2C client
 and device instances
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-6-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
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

