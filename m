Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B350282F0A
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405471; cv=none; b=E5XECjHXqIG6imKw3t9viQRrD4Br46HQHGH9UKyBixgLgreZaMRI7KIBdEttuzyOqf4WP5sUU/oX0d7ZoKY5Tmve4Yp8ArdJJ5xqrq0wfy8WxOvt+M3Ol6MTiq3F0jx+tKgO6xP45TWWYKFeFYhPWW5VhLbCghH7sMmDq0MO5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405471; c=relaxed/simple;
	bh=ypN7V548x4EKOmq5vAbetbJ4K584gqDCxFws7qAK/iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsCc1F3XzTM36jPrdTS3/hrPMBl6ZYZ3mW/XqNdN4I2VCiwQA1kSINzc9CpezwEG7tTKNgvCwfG1Nu9SzTVHuzBOu43yfu6k7IBJfpGGX74OHFOX1+WkpyWK41xYPKvgypmcBPVE/JVOtObgtgzQ6fQSEqBEet3WMZgX6gjLOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8GEQSQk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8GEQSQk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c73c990a96dso1953801a12.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 19:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774405467; x=1775010267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMpmsaiWG89XF5HzNW61uXjH9rISZDARf2EnPrRV2mU=;
        b=Z8GEQSQkt6fR4TXL1Kj6EGPArX91TjMcw50a2L5SkHLJbNSsQM4Z63PqXXqfM0hMfG
         UQcGdoA7n665QgEYRO80/mo5KnTOl5QdGb18t7Sdd/mBrBv7v1V1xe6laxjzN4M5VQWw
         1/Kb/BBEoPZ6/fRQJDmUlfDD8TWgk5wCRxGgNWYxfVVxP6qCfU37dPDxRXzvQ7WvkfgU
         9UwIoRaSPAuC88lRfyTbdy4rXjNFo+9Qnv8g2/d7gDGYmJ4XX94qsS1kZw6daPkZpIo7
         +WxFepUiIfEbn9Dkr+qhWEnVueV/izqCg0Iy+5cccHkLqfTQg1Ot+dV84kimDk2M/gS0
         d/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774405467; x=1775010267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMpmsaiWG89XF5HzNW61uXjH9rISZDARf2EnPrRV2mU=;
        b=S/HYRjqGYuz7yXveELD1c4GkdLAtNUitqobdq2xsQWogw/ktKL3reRhnryrYSTq/Pl
         XtlO4YvrctIgIPhtDd/cXxEw9coMG5PVtfee7ZU5ZtrDwKxipvb3829lfKzCp50U6pEX
         GFypbEAmC57eQo/FuJ05z4+ZcjDs9LRfSO9cvJl6d+6VtvdP4/OL4XLeCHT+B4EKZvPr
         beVWQjbB1n+WtzKQXTdb/SBAbrwKv5zZerK7H+1VlkEbkTX2cPm7YzmjXYLmsj3ZhHnV
         6Q05/r3XgOu7pGIzg4O/rJzivVeiD9o7Md2KX3fiSQQjw2h7k/ehbnCYFrgl7u9MRHY3
         xsjA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjPcnOeyQk0mWxUndCTGR4a8rkE2Ji/Qa2Wv6RI61zW/UT9ms98JMCzQiii4cc9wxWwuM5p8zHCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/YFrh1jj2p8M1pGE5BJaEWMJmQpajjqoUBSgNV1i/u1rQvbj
	igbSSLqPjFqfuqdIFXdGwcTkF2i2te1RnCcCmKf3MdbKZsTB7w3n6mAU
X-Gm-Gg: ATEYQzwS60atKHsmj5wt+rB+vugvKsL2qkMIUmmyWswHgrxRB0zgnY35/Eyl42lZV6R
	9qsAfVfj9qnsnzgLI/uyyr8A5hIV6G1eOSBoyBc9lRdF+ZS9j1PN1RGpLLpbHC0m5X26DhNK/sR
	hEWDuo1KC+jClnQZmidguWN6c5dlEtTlPR05Rn7Ymdxo97Wv1KiG21YilsMUvSTx0UpXKN5qg1B
	SH04KW2BW2haRM4pnuZZizpMu634xc9emSg+2BpTTg9tssF9rpSTMXXdHe7UP7T2JIILd0R6ol+
	F7itxyrGUSzpClS7f1v86kKJyVmHd1fFOjo7jBSy2DWRkUfk522SLvsfUZ453sPE32Z8awDwZ4m
	XbQr1IwQmQcsn4MIV3FLK9MgKNpsOb7EZbgBapSpRh/WFxFg0dgmAvR4dT2UiFRV/Sp3GRnQDnT
	aFnlCVIldZ7PTTOWuj4i+2tpGf0CKn2m+CQaGgeACFwV5xauJCEkl5QAJvYaGM8vvawcxFkDndP
	Q==
X-Received: by 2002:a17:903:19cb:b0:2b0:68d1:2537 with SMTP id d9443c01a7336-2b0b0b106a1mr19748055ad.42.1774405467322;
        Tue, 24 Mar 2026 19:24:27 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352ae70sm170348635ad.23.2026.03.24.19.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 19:24:27 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 25 Mar 2026 10:24:22 +0800
Subject: [PATCH v5 3/3] iio: adc: ltc2309: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add_ltc2305_driver-v5-3-e0d29daa54f9@gmail.com>
References: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com>
In-Reply-To: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4420;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=ypN7V548x4EKOmq5vAbetbJ4K584gqDCxFws7qAK/iA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpw0df63jGHRr6Rb3yLa1VHFGG9IAXwD7kyho9E
 a8vf44CZI6JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCacNHXwAKCRClg0K3CVbE
 gXAVB/97I2caN1oSKbHVQHDhnvsk053+AmckELCjiueujhlHB+JuB4yfBv7iaq8nC9OvERCjABV
 T/8u9+yC7vdBQw/yhFFLd6xcHp+HXYtRCg1s2sQh19u2v9sRmSwy/MR6+wIdmQ0vjHhBLKGIdNL
 1YpWm/2ufYSzXdH1L4XK2LQuZTLN4XVg6DdJbKFRPGxLmjW5TFGLB/63Wk1Ru5KA9agi+vwnhx7
 JtSPeEU9BhScNVTp2WrEEvcjXZjMBf4U8FqpSLGKIDkpRZBj2+UZlA+X5r9qFMCpajRy/Y38GtJ
 v/tKexQF5WBZtlSb7Eqce9L7AUFE4V7sIYAhQYnL6TRCmVdO
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add support for the LTC2305 ADC to the LTC2309 driver. The LTC2305 is
a 2-channel, 12-bit SAR ADC that is register-compatible with the
LTC2309 but has a different channel selection mapping and count.

To support multiple chips in this family, introduce ltc2309_chip_info
struct to store chip-specific channel specifications and names.
The probe function now uses i2c_get_match_data() to retrieve the
correct configuration for the detected device.

Specific channel addresses for LTC2305 (CH0, CH1, and differential
pairs) are added based on the datasheet.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 3f27ffc66668..316256edf150 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
  * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
  *
  * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
  * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
@@ -41,6 +43,13 @@ struct ltc2309 {
 };
 
 /* Order matches expected channel address, See datasheet Table 1. */
+enum ltc2305_channels {
+	LTC2305_CH0_CH1 = 0x0,
+	LTC2305_CH1_CH0 = 0x4,
+	LTC2305_CH0     = 0x8,
+	LTC2305_CH1     = 0xc,
+};
+
 enum ltc2309_channels {
 	LTC2309_CH0_CH1 = 0x0,
 	LTC2309_CH2_CH3 = 0x1,
@@ -80,6 +89,13 @@ enum ltc2309_channels {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
+static const struct iio_chan_spec ltc2305_channels[] = {
+	LTC2309_CHAN(0, LTC2305_CH0),
+	LTC2309_CHAN(1, LTC2305_CH1),
+	LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
+	LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
+};
+
 static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_CHAN(0, LTC2309_CH0),
 	LTC2309_CHAN(1, LTC2309_CH1),
@@ -99,6 +115,24 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
 };
 
+struct ltc2309_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+static const struct ltc2309_chip_info ltc2305_chip_info = {
+	.name = "ltc2305",
+	.channels = ltc2305_channels,
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+};
+
+static const struct ltc2309_chip_info ltc2309_chip_info = {
+	.name = "ltc2309",
+	.channels = ltc2309_channels,
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+};
+
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
@@ -158,6 +192,7 @@ static const struct iio_info ltc2309_info = {
 
 static int ltc2309_probe(struct i2c_client *client)
 {
+	const struct ltc2309_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;
 	int ret;
@@ -167,13 +202,15 @@ static int ltc2309_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ltc2309 = iio_priv(indio_dev);
+	chip_info = i2c_get_match_data(client);
+
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
 
-	indio_dev->name = "ltc2309";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2309_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->info = &ltc2309_info;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
@@ -189,13 +226,15 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2309" },
+	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
+	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);

-- 
2.34.1

