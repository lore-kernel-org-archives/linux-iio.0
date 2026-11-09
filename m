Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243522;
	b=I9FhIuzrUyDmOFQRMVdftXAe9+gz51VH1zXMZp16x0HEQoItld+5ZPA8wCdeZ/xcJBu4
	 kWTZGnWcZmdp1orSdH5EG66yCa58B3iZWcDbe8JaTs5OqBg9Q9xcxAFOPnz77yHa5sq4p
	 SGyNARvT1XzpvxDXhBvU4uYf5iEhrfb6Deluvac2ixdoee9APsAzL3BQwc/oPbzYgTezp
	 wSYhBsTUA5N580fB1V7aAQRZYbX5GRQCm2xHGUeuqpPA5GKXQtCNW6WOJOYqsPjHTrBqi
	 T07PNnFMdrhVd7Z6RZhGRYpILn3oZ5y7UgVIc4vW8CXGVx5mOWGkp9BBOf3Bt9FXUBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8nH9XBvOrIjxAwP+5FR56uEJV1OKa47NfQAPenOGI40=;
	b=SDu+VYF23McS3I/WHsYpLGgEzToH6crOmUy2oShYOMo5o0YIotYGe9+jbFlUGPvQbbU7
	 7TOpaSHmh3iToFTZ+vsxkbYR/UgnGAZysVXFak4ML2IzoDj6aQcBe8Ap5eiUbFCLgC5pN
	 JH2M87CwaZbeDT7gUzcsVUlQ83Z/mMym73aCxMNW1G3OiTxnMwWyPTwZkvEFWaquRtn/4
	 29WtRIEHmiZiNnED0w21b7Bw+K5L0lGthLneUhoUNkvPvKsceYRPZqJKRBov6M+4k2amI
	 bEWK5ditFZLIy0VPtSz6Nsg7S5v4E9WuqA3FK7zYnsDIXPgPx5TP+EU6e2wLyAsMsvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYp+iQLk;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC860A2607
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9BC860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYp+iQLk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso543086a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243521; x=1794848321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nH9XBvOrIjxAwP+5FR56uEJV1OKa47NfQAPenOGI40=;
        b=nYp+iQLk+Z56YW/HSJa2WSNMGSYOMBRrORWbn8n57fQlP3tflrj/nQJd8gsR5+xDfu
         u4cfQblbzxUy2vVt3GHNpXrVzExQig+33nDLbPCmQfgmoHDux01DFer3FF1NAbwTYq7E
         BV/d6K0GjstvnJLeIZTsLGlG8WJkFHZTzgIHqlPHKQCA7wBBcUY5JFfInSYFInohq52j
         57FEeZlprF5fpyaFTQxvlWzJ8IwT+17yG2VV6TzFDhISfdZSOP9jsU4oc1zt8Y1L6OJq
         j3HMdo2UbpZUiBVzvpMC9oHxgWg683aq0KDWdZp85dktNn1DclT2xaPlh1mX1FDP85jZ
         90sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243521; x=1794848321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nH9XBvOrIjxAwP+5FR56uEJV1OKa47NfQAPenOGI40=;
        b=dZ2rz+43tO8btgLmBmw8sCZzJyDQ7riWqdfj56fLxLHy3uQp5sCYP4Lh6zryjTGdVf
         Y06QEY6BUvLodZ4zq9ISSftcgN+b17q1432WPI0YwzoWVh3olgWMcuW3wTZoHGnlZXez
         1nQ0Ot++GeGmAOgP+Vk6iIOoysEsyBihUWB85TJF/TkuaNzIYkVN8ige1K7urNcJ6Ytz
         O0WIlxYhjVLBjwWTGGRaVfSQdEhdrrdD1DUTkkN95H8veFYUxcIVKmHKKf7fpwik+N7a
         VBaKOEEa7zammm8mh03ELXLhDsYwHBepk3sj3wTQ5lqmDg4IGelX0aPhTACTwh8aLcGR
         pe+w==
X-Forwarded-Encrypted: i=1; AL+hErGJev+UrzguC25eUK1Njun/Xm4ZFQU4OnjwWySgaRyLcnMVLug7vmwxgeFX2DgsndUKFk1rVFp5rU8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aevMZOlQpxFHI0iPsHmFQSyLykfbBwZRhBW9CaycRj04qfLyj
	Rf9pMY0paphgYeDRwslMifShGVwSbcaMwj05edR+7NaEfZeczEEM3BqT
X-Gm-Gg: AYBFou05+QDgAUUB0AdQYX2K1bZVWuOAcsJdrncRdgAfOjFFFfi7OnJQ2U9vCY0O5Qa
	p8y6UgncTOcjAhtc7PopUkVnhxz5VFL30QdDpLIA0xD0rhFHgdMcp5W9tKPZBbmGRQUtSmN0RSG
	4O8U39V+jeIQRhJiIL+2OI9LWwtCfU0RazuWy9eSftKqgHfeJMNWHUgRJ6j65Nir72Kq5Jxrn01
	nU0ULjvW1AOnFoWkYnWWgo/paSMfRWtMWzGmNYV7MY0V0e9VIjhMVEBt00o1kLH5wnq/Gpm+aRg
	s7pHZnRSOdjKpvEbkSMZtKseAdbysk8DGpD+233KVIoh3zzeNmmi+d/L6AyZ/RfddyCXbeX0oOu
	dtIuQ6SznqvbeYfrmLQtW+INJCeFzkpmP08iitwlRn4zauQBPjLO1QnZai10Y3lBmGyIwbNWgu1
	+JSE0+lHVjKn2V+e434UmYUOgZ6mLuWWGxE1erpYxtPSUvT7hJ1ck11zhAhXNgekK4Z9fNxkeAD
	vFR7xCeU5Nl42PxRBCA7nkhrDz/ncoCA61shVMRGlwEpFFz3jgGfnD9z7JMr0wAjcl8KHNtY9BU
	v5FzYymIKfiV0zjKfavmDCcMlg/mcLybcSPeC84pqjgaTLJqIBJP03w914BqeTXqClRdgxLfX4c
	qNTIaPrjZHPv25OuFV2jmwGlnbQ==
X-Received: by 2002:a17:90b:2b86:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3b166cc0430mr231963a91.10.1794243521079;
        Mon, 09 Nov 2026 08:58:41 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:40 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: [PATCH v6 10/11] iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
Date: Mon,  9 Nov 2026 22:28:04 +0530
Message-Id: <20261109165805.31160-5-architanant5@gmail.com>
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

The ads1015_set_conv_mode() helper function is a single-line wrapper
around regmap_update_bits().

Since the function is simple and only called during initialization and
power management state transitions, the wrapper is unnecessary. Remove
it and inline the regmap_update_bits() logic directly at the call sites
to improve code readability and traceabilty.

Where applicable, introduce a local 'map' pointer to keep the
inlined function calls concise.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 93a8318e950e2..2c3ba1b91aac4 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -932,21 +932,16 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 	}
 }
 
-static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
-{
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  mode << ADS1015_CFG_MOD_SHIFT);
-}
-
 static void ads1015_power_down(void *p)
 {
 	struct ads1015_data *data = p;
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
+				 ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
 	if (ret)
-		dev_warn(regmap_get_device(data->regmap),
+		dev_warn(regmap_get_device(map),
 			 "Failed to power down (%pe)\n", ERR_PTR(ret));
 }
 
@@ -956,6 +951,7 @@ static int ads1015_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
+	struct regmap *map;
 	int ret;
 	int i;
 
@@ -1007,8 +1003,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
 					    &ads1015_regmap_config :
 					    &tla2024_regmap_config);
-	if (IS_ERR(data->regmap))
-		return dev_err_probe(dev, PTR_ERR(data->regmap),
+	map = data->regmap;
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
 				     "Failed to allocate register map\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
@@ -1041,7 +1038,7 @@ static int ads1015_probe(struct i2c_client *client)
 			return -EINVAL;
 		}
 
-		ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+		ret = regmap_update_bits(map, ADS1015_CFG_REG,
 					cfg_comp_mask, cfg_comp);
 		if (ret)
 			return ret;
@@ -1054,7 +1051,8 @@ static int ads1015_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
+				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
 	if (ret)
 		return ret;
 
@@ -1077,17 +1075,21 @@ static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 
-	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	return regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
+				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
 	int ret;
 
-	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	ret = regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK,
+				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.39.5

