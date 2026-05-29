Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB94478E45
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079840; cv=none; b=mKbVpzFs3niwq3ulQp8j6ptr7iOE8X8ihjtp3jpk+XHJBLQc6hEG7Bkej2hDhSeIeO2b/VtmAyEifyQlIFGGYXN9iyrOu9kYnvt7bIN169NmX2K+k3nRTpk2+g9RX6jNgSOwp0SmkRKw9mj3sc2Xk1HvdBDCu9EBO6Fa/DcsXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079840; c=relaxed/simple;
	bh=4kYvBVIyxbZc3wN4nTs2bf6YuCzG0XhcPUB/ns1CWpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFrDAik3OU/GnBfEQh0rh0GHNTJd3SI3GbVUMiuD5pQxPxFwMW1gnmQvTySzphNhp/PH3qrWVGZ72u8orlfWG9E3Th2jhDEAQgfOPmR+LUKfEVUCK/wJqAompq+R/cbbc1zLqYMHmSNFYARxmQTqC0CMD9qiEO4/DjLZ9skvJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d30sJnjB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d30sJnjB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48962cd0864so11803395e9.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079834; x=1780684634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/m4QFm7x6hshNVSS9JbTtp77lFuR+iDM6hBxOl/wts=;
        b=d30sJnjBjDm25cyvNEpoBxOBvYO6g6xlA7hX/IIgC/RDMBgbz0pQv/BXQgQDVdXJJE
         25hPQzNhCQBxNaX4Y6HDjSZoJof17r/tNqQSz6Dco4dOiJmySoSsXxwrcRYTwVtZVIzC
         rb6mJYwiPEP7g1ATguZgMr2KPdSUjpVQ2+1FIV7rnHY5W8MMU7dtZfRWdU9W8Xm0xvxq
         8cgfIvFrBFkses3N3CC92SeHS/QRlyC2MavpIUr/XgJpX/T92Qj+IfKEb4qz9t+PW9ja
         MGWdl+OIYxKmi7KlPJ5TxliClp5d/gFsc8uoAFlDFZBpR3Xk2lZ31MWCwYG56rBupxsF
         aaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079834; x=1780684634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/m4QFm7x6hshNVSS9JbTtp77lFuR+iDM6hBxOl/wts=;
        b=p32JxY6+MJsQDnM6qlJ3WrpwRsqL6HP3+iJ2M/NX8L3Hb+Z4MFiEGsuzNamNuLQmr/
         XYJrXIAjONaEPUGVQJmvFbBCBGdw1JVLxtZ906qAkcpkfUBor84K1lgXtYNUSLLPTyj2
         aTxHBygRu9X5PrU5tMuBMrn9DMm6OdrrPhl5kWZUzMdHc6/sscw9CQY2HHX/1ah6OlWy
         4K9BqH7IXCeUYLH8AiqdgVMz5ua6r1B07E67UAbkI6tEyZmK3XRaIk7Si2v9XoJoGya9
         BumMUkKAkcGk8K6IU7xO8uztBzOanHdYUvWD3aR8M1kaFuZ9dlUpEdl4D6BFt0X89goP
         7ndA==
X-Forwarded-Encrypted: i=1; AFNElJ/lhfbcvgQH3KYyRS73qX9GThC3zXR8XohcjUMP3YhWF3+A0WQwFmcQYlT5piac1jyh94nm6bTCQGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFB3JRk7gceg50KE7Exo9ejmxl5LBNehJhxfYw6SN8ftrub9f
	9EfKEa1Bt7DP6iJ4uFFWZ0cYGYXQ2MCcRLO5J+k3YaJ31Av9NpKymj+s
X-Gm-Gg: Acq92OEeVOJx5/VUe6bNLW/Gwe3nYHfR/YudSOvU9X06YYywXhqJ5Ldbp5MZJ/496gE
	7yNXH88s2LVNuFokWLvvLTJFmsFWjELxQA+boHwOZ43yNAuC+2oACpulGX9hBpdNFMvy4qiggzb
	4s97KTq3vJJA3s6fNvufmxiGpDebapbWRunRcNvtJ40CcNtZnRPP02kgn/uoefKkeZrz7UMyCJT
	zsb2oy4THNamh7DE23hA3JnpiRaE+v9y4/rXOc71t9lCcMxKiR8rk1YY/ZuUcOnS2LcI1mVQnxg
	5vuyMFTw2ww1RCoNKO1n7I68I8NFIQBR+/m4woAcO3+w2pOB8cfcxpSq3YZzY9H04wMs01jp5xe
	9zkpECW0BAw/JO7dLTgT7CkvYj+iVrD4oICR8NSvg+zBHkHAucqu/SBPEjiv3j1airO0M9bhUkr
	k1q7mmIovz0xZDEAbgA41svYAmLuxkwqazavB43kXTImzEmay6SIE8FsZBLqmQ9UUiVg==
X-Received: by 2002:a05:600c:4f8e:b0:490:6238:c5d0 with SMTP id 5b1f17b1804b1-490a290ce4dmr6140515e9.1.1780079834202;
        Fri, 29 May 2026 11:37:14 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm5740555f8f.15.2026.05.29.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:37:13 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: ti-ads1015: use devm helpers to fix probe error paths
Date: Fri, 29 May 2026 23:37:08 +0500
Message-Id: <20260529183708.17819-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once ads1015_probe() gets past ads1015_set_conv_mode(CONTINUOUS), two
resources leak on its error paths and on driver unbind:

  - pm_runtime_enable() is left enabled if iio_device_register() fails;
    on subsequent probe/rebind the runtime PM tracking complains about
    an unbalanced enable.
  - The CONTINUOUS conversion mode written to the chip is never restored
    on any error path after that point, so on probe failure the chip is
    left running.

Convert all three teardown operations of ads1015_remove() to devm so
that the error paths and the unbind path share the same unwind in
reverse-of-setup order:

  - ads1015_set_conv_mode(SINGLESHOT) becomes a devm action registered
    immediately after CONTINUOUS mode is enabled.
  - pm_runtime_enable() becomes devm_pm_runtime_enable().
  - iio_device_register() becomes devm_iio_device_register(), so the
    iio device is unregistered first on unbind.

ads1015_remove() is no longer needed and is dropped.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Full devm conversion: register a devm action for set_conv_mode(SINGLESHOT),
  switch to devm_iio_device_register, drop ads1015_remove() entirely.  This
  avoids mixing devm with manual unwind (Jonathan) and also fixes the
  pre-existing continuous-mode leak on probe failure.
- Drop the unrelated dev_err() -> dev_err_probe() conversion from v1 (Joshua).

v1: https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/

 drivers/iio/adc/ti-ads1015.c | 44 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index c7ffe47449e2..d7f4d0d5bcf9 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -930,6 +930,17 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 				  mode << ADS1015_CFG_MOD_SHIFT);
 }
 
+static void ads1015_power_down(void *p)
+{
+	struct ads1015_data *data = p;
+	int ret;
+
+	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	if (ret)
+		dev_warn(regmap_get_device(data->regmap),
+			 "Failed to power down (%pe)\n", ERR_PTR(ret));
+}
+
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
@@ -1030,6 +1041,10 @@ static int ads1015_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&client->dev, ads1015_power_down, data);
+	if (ret)
+		return ret;
+
 	data->conv_invalid = true;
 
 	ret = pm_runtime_set_active(&client->dev);
@@ -1037,33 +1052,11 @@ static int ads1015_probe(struct i2c_client *client)
 		return ret;
 	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_enable(&client->dev);
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register IIO device\n");
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
 
-static void ads1015_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
-
-	iio_device_unregister(indio_dev);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
-	/* power down single shot mode */
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
-	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM
@@ -1150,7 +1143,6 @@ static struct i2c_driver ads1015_driver = {
 		.pm = &ads1015_pm_ops,
 	},
 	.probe		= ads1015_probe,
-	.remove		= ads1015_remove,
 	.id_table	= ads1015_id,
 };
 
-- 
2.43.0

