Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243527;
	b=KadZGkV6rEnc14gVgOWKlGtPlrpfFfFOZ7v+S1jVpUWGKJSH7jSK3o+wj/pAd6t1W2RS
	 pM4cVjFFEO2YyhLUzw42oXdLDJfhC9Ps7wChcS+yaQrX5zH3Y1ToTyfshJ8cc1zJxotgD
	 IrKsTJc571SUHdLPfnCaykbg26C44DKl2aAS6PBEQL+6dtwGOq8CLH4HClBSSgmQuXFW2
	 QWwR3rd0rTWFOIWs3UqkrTj1tnSB/rUybAiLyk/u6maFDwL2xq2YilGuOYlVZ5OjA7Q9I
	 fMwwcvaT1HvhMB8yOaqORWlMkSwIzVwV03Yn4XLzPqIVOU4pPjQ/apvZphRDQWISqgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8/HNQ5vYcgTpt1NwnhKJpNsJpmPigqkI4i1xzO0yhCg=;
	b=wEWn9BQptLytWjukIQJn1Kc+Rvz3yQTXObp0ZIC0UBz7Q+eHyo3JTJMLk1yp77+r7LM6
	 /Q2nqvFOYwpQ+DJtfwaYbLAOr9FcI2yBmOPRyv49wgRd45W2gp+pSe2UIrcrBdnFCDc97
	 IFG0IEoMRmeC4L/HjFl6WqQj7h2M00kliESb16kBNnXqBuyL6gx6yqUhjSJTAKuby/rOR
	 5FQf6XtFjkg9hdxMZRm4nzV/VC55EpxZaOk3Wfie4L77IiuLotngV9Nq9WgRAkfW1FWFU
	 gWE0ZWtKWEO85CFH7Ti3rdjmoQ3Dvooz1MDYb1JsAPVldk4okAaDUVwMc4w9iWlU2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9PxNa02;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AC606A895
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB8AC606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9PxNa02
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso556328a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243526; x=1794848326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/HNQ5vYcgTpt1NwnhKJpNsJpmPigqkI4i1xzO0yhCg=;
        b=F9PxNa02IQYsdEPu/mDyLSJnDwZoSJn32tH+i4ySBoh4U8pdLcagmNFeTs2/k0cMGH
         AAXAVz/w0+8v890SDCsXJ/PBryG1I2icI1SuVfDAEjCchS+Ry1HwOp6czszb9kGKMVRP
         B6+yAuOtmBREQKgEVfMKRgu+KiM8oHoYqGsmA6PChF9agf2SrdRJd6tkpTnTU94BtTJe
         2teq1U6YGkK+v9bR6ePcfAo0Ld3qk1hmmSyWxqIoNoTBsKekazEJxrFvDqPuOnLcGQgT
         NtYm1K43scX15XAUD2pFLmHsSom+dz8R8FyaP+SoG3PVL3yHDHThM8jgyHzqxrMHle67
         Liig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243526; x=1794848326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8/HNQ5vYcgTpt1NwnhKJpNsJpmPigqkI4i1xzO0yhCg=;
        b=Or8P2EMOB4X5inatPmANbwR9SU6dFfj8RQMRV5kuq6Ubtnnlbd1Mf1laTQgY0gLE/T
         LjBYQ+OVAMOx4lQgZkGnfQfL1trXieIW0xM0omeGmK6MpYqYU55ruOgl8eAmeNhKyynP
         7PpQdnFWpFWyXXjkmg75l22jLEC1CfteEcQ0HbF71lugpR13zKtSvO01H83CqSiy//w4
         rVmGxs24BqZLkXrNYk+G9YQ9hqmz+F0KJlwB1n3CH7WyQxtmjdVuLjRlOruWkaO3w2I/
         zJ4iuxOfu/y0VuT2GKxW3mrWWFF0mQXSX6b9Su389SJNolsyPup0Z9HQXt2JHSAvpupp
         65ow==
X-Forwarded-Encrypted: i=1; AL+hErH/6cJKXaI6SyutCIKfudTphT0b8/g8O3JgK6zymBIvBCB0II/vOtcrll8KBYU+afll9WzmRGgUPS0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fn43VHffoMpdX2I2jAA7WFFL765C5ch04Fg7UA+vIgIwHnaIT
	5maxT/eZIqHAHO4kuLT554YbWALwBsKAXoBW0KKdg9A7hKSEBzXzAXoc
X-Gm-Gg: AYBFou1tT4UUxDasvR7zdvh1BkUCb5eFP9lRZ9CPyfrUXwN7xVjPsRfNtmtoTwkvc8t
	ro9bWZidKJSQPlG0LBUtIu5IhxOrN2A11CFnFCwIYHmEk7cArz5+/Ec7Tq7Ssxr6ZTo8aBqqZ5L
	IYB8Z76SK58VeSG4joAAP3ukB3RSbHsbrfmHIkdoyysYG80tHI9QYFdM2jLHttEJaKtVgJlmqDG
	FpUdyCW6nxR1wBAkLtldqgzxPkx5DoyBWRRIV6vVgR957iTXMw2P1W2G992HewbTW6j0210o6ka
	0NB4jZsDBTrmp984CCdRcXkA+sXkXR+2NghoFYro3MWVj3Tu+XRDFcSHZHt/mG2QC7qnAcI9Mih
	Q5WwnyOPQB1uXGe8lqP8HB6Bb5wrhfmNgMWOVmM9mw4hufaG1d2GXpDnB86naS3bfjQwaDv9hZ2
	cz6uNbm1Z02TBJmYlnYk6KSag7H0o8OayT5XlXkLtRcWeH/liTOQX5JV+YbvvjK3j2+mwUdhs0N
	tTZDNEqdXlPLm4FGRa/6dS2ua1yt4MuMSL7acJMUZ6EXFLeTk5u7Zhz+a7MYMHcnF6AdEleEMLQ
	FeODLDCkjkQMgGXBAkVcIWOIn0z/YNK/YMGBmclQ2W5BCgzRfTCqA5QoaG1Bbe4QmyeV8u0GPEW
	Q+sSNSHheNi3nOIw3BdThVBhOpQ==
X-Received: by 2002:a17:90b:1b0d:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3b166fd89a3mr183071a91.59.1794243525989;
        Mon, 09 Nov 2026 08:58:45 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:45 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 11/11] iio: adc: ti-ads1015: Replace custom shift macros with FIELD_PREP/GET
Date: Mon,  9 Nov 2026 22:28:05 +0530
Message-Id: <20261109165805.31160-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165805.31160-1-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
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

The driver currently uses custom _SHIFT macros and manual bitwise
operations to read and write to the configuration register.

Modernize the bitwise logic by replacing all manual shifts with the
standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
This improves readability and prevents potential bitwise errors.

Remove the now-unused _SHIFT macros from the top of the file.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 79 ++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 2c3ba1b91aac4..8f7ec61314363 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,6 +11,7 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -38,15 +39,6 @@
 #define ADS1015_LO_THRESH_REG	0x02
 #define ADS1015_HI_THRESH_REG	0x03
 
-#define ADS1015_CFG_COMP_QUE_SHIFT	0
-#define ADS1015_CFG_COMP_LAT_SHIFT	2
-#define ADS1015_CFG_COMP_POL_SHIFT	3
-#define ADS1015_CFG_COMP_MODE_SHIFT	4
-#define ADS1015_CFG_DR_SHIFT	5
-#define ADS1015_CFG_MOD_SHIFT	8
-#define ADS1015_CFG_PGA_SHIFT	9
-#define ADS1015_CFG_MUX_SHIFT	12
-
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
 #define ADS1015_CFG_COMP_POL_MASK	BIT(3)
@@ -382,17 +374,24 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 
 	pga = data->channel_data[chan].pga;
 	dr = data->channel_data[chan].data_rate;
-	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
-		ADS1015_CFG_DR_MASK;
-	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
-		dr << ADS1015_CFG_DR_SHIFT;
 
 	if (ads1015_event_channel_enabled(data)) {
-		mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
-		cfg |= data->thresh_data[chan].comp_queue <<
-				ADS1015_CFG_COMP_QUE_SHIFT |
-			data->comp_mode <<
-				ADS1015_CFG_COMP_MODE_SHIFT;
+		mask = ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK |
+		       ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
+		       ADS1015_CFG_DR_MASK;
+		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
+		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
+		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr) |
+		      FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+				 data->thresh_data[chan].comp_queue) |
+		      FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
+				 data->comp_mode);
+	} else {
+		mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
+			ADS1015_CFG_DR_MASK;
+		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
+		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
+		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
 	}
 
 	cfg = (old & ~mask) | (cfg & mask);
@@ -403,7 +402,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 		data->conv_invalid = true;
 	}
 	if (data->conv_invalid) {
-		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
+		dr_old = FIELD_GET(ADS1015_CFG_DR_MASK, old);
 		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr_old]);
 		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr]);
 		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
@@ -731,7 +730,9 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 static int ads1015_disable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
-	struct device *dev = regmap_get_device(data->regmap);
+	struct regmap *map = data->regmap;
+	struct device *dev = regmap_get_device(map);
+	unsigned int val;
 	int ret;
 
 	if (!ads1015_event_channel_enabled(data))
@@ -744,10 +745,9 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 			comp_mode == ADS1015_CFG_COMP_MODE_WINDOW)
 		return 0;
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				ADS1015_CFG_COMP_QUE_MASK,
-				ADS1015_CFG_COMP_DISABLE <<
-					ADS1015_CFG_COMP_QUE_SHIFT);
+	val = FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK, ADS1015_CFG_COMP_DISABLE);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG,
+				 ADS1015_CFG_COMP_QUE_MASK, val);
 	if (ret)
 		return ret;
 
@@ -936,10 +936,12 @@ static void ads1015_power_down(void *p)
 {
 	struct ads1015_data *data = p;
 	struct regmap *map = data->regmap;
+	unsigned int val;
 	int ret;
 
-	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
-				 ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+	val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_SINGLESHOT);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG,
+				 ADS1015_CFG_MOD_MASK, val);
 	if (ret)
 		dev_warn(regmap_get_device(map),
 			 "Failed to power down (%pe)\n", ERR_PTR(ret));
@@ -951,6 +953,7 @@ static int ads1015_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
+	unsigned int cfg_mode;
 	struct regmap *map;
 	int ret;
 	int i;
@@ -1020,19 +1023,20 @@ static int ads1015_probe(struct i2c_client *client)
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
 			ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
 		unsigned int cfg_comp =
-			ADS1015_CFG_COMP_DISABLE << ADS1015_CFG_COMP_QUE_SHIFT |
-			1 << ADS1015_CFG_COMP_LAT_SHIFT;
+			FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
+				   ADS1015_CFG_COMP_DISABLE) |
+			FIELD_PREP(ADS1015_CFG_COMP_LAT_MASK, 1);
 
 		switch (irq_trig) {
 		case IRQF_TRIGGER_FALLING:
 		case IRQF_TRIGGER_LOW:
-			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_LOW);
 			break;
 		case IRQF_TRIGGER_HIGH:
 		case IRQF_TRIGGER_RISING:
-			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
-					ADS1015_CFG_COMP_POL_SHIFT;
+			cfg_comp |= FIELD_PREP(ADS1015_CFG_COMP_POL_MASK,
+					       ADS1015_CFG_COMP_POL_HIGH);
 			break;
 		default:
 			return -EINVAL;
@@ -1051,8 +1055,9 @@ static int ads1015_probe(struct i2c_client *client)
 			return ret;
 	}
 
+	cfg_mode = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_CONTINUOUS);
 	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
-				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+				 cfg_mode);
 	if (ret)
 		return ret;
 
@@ -1076,9 +1081,11 @@ static int ads1015_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct regmap *map = data->regmap;
+	unsigned int val;
 
+	val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_SINGLESHOT);
 	return regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
-				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+				  val);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
@@ -1086,10 +1093,12 @@ static int ads1015_runtime_resume(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct regmap *map = data->regmap;
+	unsigned int val;
 	int ret;
 
+	val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_CONTINUOUS);
 	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
-				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+				 val);
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.39.5

