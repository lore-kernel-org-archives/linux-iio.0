Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D54FC8C5
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015503; cv=none; b=gb6SM5/uGMsovuWTe248gah04d50KU1MyY0BWAbnGu+e/dj00SwMPvOFuG1jt5/fyVLWGgeOk9B43UIYX8XJ1X+0J1g6Gws1iwwkwdCvxiM+EyIW+3YHjqhvdgKJHA8vTBQiCXGnLeoLlm1aUIZ7XNj9J+TexR24Uv/w8b7sSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015503; c=relaxed/simple;
	bh=Yj4RwbCvi7B7lQgZjaL6AuMOkRGQNU1rLzNzZVSRhLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqPZ4Iq47o4VPC93aaQEn4DmI8KJOmky0AoQeQrMfa7THFxvPdH+8eJ8HI/jyIv5mC5i7v+f9KeSWVEaN8q03U5ynLWBomRW3IWvEVOaO0XN8pK7UKnHbQ4fQR7YYnqBUyi8KRpiqMH1AVGgYh5EQHloq7tikbXsfleRIBSjdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1v9rFGO; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1v9rFGO"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60ed65bc8so15643801fa.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015500; x=1790620300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIjQv3Ni12nKKfUqhl2wfffLShu1iZGR3QKWNIW24Vw=;
        b=k1v9rFGOq29JfAvVic9zrYkqG7bvrAzTjwUe+LiiVzJJc0cCBEKDU0GahcOmFPq3xZ
         IajVmL3GibHoWavmbvxkX5bV2ExYunqq9p2tIi8hN5/o4WAAgQ9DmCzia3f/hf45sTfe
         W1x0JU3VEkbS/qUH1lhzThQbXF1Bt7L91K6K52WbBhKnIVut4SPCpZBJ3wFr63RShpju
         yO92jY49YqvV8ScMAvvfYJCuX8oyX/DtbDDrOZJtICTB+OitvUOnBCzwFvMEothRq8XZ
         SBnBu/NbTJDK9pccFoh2jt31OOtEWbPgWbj0y5gAYwfZpREuAItsYoGJOr2sypuu7RcO
         8C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015500; x=1790620300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIjQv3Ni12nKKfUqhl2wfffLShu1iZGR3QKWNIW24Vw=;
        b=BZBxi0wEeKiLTbWMlrNmdLwthFLCMGp4m11hEMkA/evmcI8/BNn8c1tjLFwlvY/aH2
         VMKOGHlPRf3N3hR/N3rd474x7QnYADOULr0+ODLlV4MDIhg0fK5GpSvOWJlFQLVg8NXn
         9UC9hoOlMOMwYgQoy0y7A3unx3XnV9emkEwxSfvAVVbWi8iVtQpSXOXE191p0R33EF/2
         7AoV0/kqW4PyQdFceqYfeXnLPz8ZgmR2qnFYPVbUKtMWPizJtVjRkQnCeOomefGbAjl1
         rKUCSIcioRqXA78JYY1QJwplX653vcUVWFcc93mLjQys4Kg/dcbAcnuOXUh0Ol5IrkJY
         eo1g==
X-Gm-Message-State: AFuF++n/eRSlRoYztTTlRy9MABLwtJxtmdnyt5kBSHctu0d7wgJ6Dok5
	7fMQIq7NJ73I30thXVhqRMCF8wxwkxWe1pZwfSZx43TkEhW/RZgp+1Vh
X-Gm-Gg: AYBFou1wO62LwIRsgDssmJXn7SzyBxRqQ5/hMeveQMdWCvwEOOSZqOG+O25y+wVsRV5
	FOrENeKan3/UcHnBTPIaYcbT3WSvc/1o/VGyJk6clhKyWySlljlmbnyqDCdTKw+JwzYXG1qiSVh
	AcpvvKtZeW5Ng0qyDzq+qcRDBG30WvVa0CyXBE6C+p9SE9084lW84srLam8DpsNKwhiFfyZ/kJp
	z90iNidwSWStVaatE37AQnS50xNdzXmvLZj36KkJUt3Wq5nPrFcNFEvxp5emOzzQvcLjS0rf+3J
	YVkMGM9oV49KP4H4c7nKCfMyJjKidGBOfBObantWGUlwzJsAM4gJWaf1tiChClbPgjFgt81fyJ0
	Jz9CYioPQBzdv8khE7Trf++mFq6RCUaMvqgP32ZGyISxeECNoEEcBd/hwFd2gp7eNLYUpfBa8ya
	32Lxi7WeM5GQmuyQnYZ5jijVBpm8xfr+ISham4aVj132OEq7CcFcebGffyuYoZCxVoKXexzftbC
	GRGpCGBMXJfZGuxwVWtmgKiIvbcCcJuwKqHJ8yom1MbcBriO+XYrVU7Uq5xmnkSW8uAnpGaJjYB
	qQdD
X-Received: by 2002:a2e:a812:0:b0:3a3:74b9:8a7f with SMTP id 38308e7fff4ca-3a5fc089db5mr26899541fa.24.1790015499454;
        Mon, 21 Sep 2026 11:31:39 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:38 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v8 02/10] iio: pressure: dps310: use a local device pointer in probe
Date: Mon, 21 Sep 2026 21:31:24 +0300
Message-ID: <20260921183132.233136-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

probe() spells out &client->dev for every devm call. Take it into a local
instead. Keeps lines short as more calls are added later in this series.

No functional change.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 35260b399390..bd7da4f12749 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -845,11 +845,12 @@ static const struct iio_info dps310_info = {
 
 static int dps310_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct dps310_data *data;
 	struct iio_dev *iio;
 	int rc;
 
-	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!iio)
 		return -ENOMEM;
 
@@ -868,7 +869,7 @@ static int dps310_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 
 	/* Register to run the device reset when the device is removed */
-	rc = devm_add_action_or_reset(&client->dev, dps310_reset, data);
+	rc = devm_add_action_or_reset(dev, dps310_reset, data);
 	if (rc)
 		return rc;
 
@@ -876,7 +877,7 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
-	rc = devm_iio_device_register(&client->dev, iio);
+	rc = devm_iio_device_register(dev, iio);
 	if (rc)
 		return rc;
 
-- 
2.43.0

