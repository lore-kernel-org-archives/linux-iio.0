Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D93CFF61
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180107; cv=none; b=scT3NgYSmVuHlYgwcCjH9zJE61b7oJoA3p8Nofbc137/YpDYfb9e5lahO9TUtOleMmpSvpnAruBXMmdbgIOBnxkXt4SOl6JGGJ5YzWO21nUT6+B8deiw6MBxIdvR3CwjUyxoQNu/vvL9GbsLFbz+167HDZVfS59+yl4ooyMgErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180107; c=relaxed/simple;
	bh=P2H0Uy+qCE5Jy/e5u7fiYkX8xZiEgEpXSqTGtGKc58E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sEsuunbbbOFLA0f5gK4J3rmSBoUD4vNP1JbhyyyWFSG4PakgEWIpKIy43oSJVgl9srmlxMNFYVp4IkrSoCRI/HE5/14DG+OAmdzMeVrBPknFcUB/FjY5bnH8fdICzAN+kTeLn7fhsGVf+zM44l3da9eBrezTfgiWVNWnwIXhr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjvlio1S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjvlio1S"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad8076b01so37997445ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180105; x=1785784905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AA2oaqkGbFTjS87Z4DpjB7Sc3FAQRMCUmxPyX/3i3Zg=;
        b=pjvlio1SwS+FhF5ajoeSS4Q6KwNeAQWk4qoVqYAR8tuUn0wRvJYIqBHMllWFhISKSs
         YHHn89I3hn70I5Z1WTiGHCzKsrIy6+fqY0w5QZDnMF/hc4LkZA3JHEHgvkme7zVeegSC
         W0LrlXKK4SWMHlwAyz8R31tOQwp4teMP1RziLubEorAPL7ImU3v8phMExALzVHNkZ0p/
         KYYPPjYBoDu1bKkXVezNp2j8sK95zOcwpZQSNDxgT0of74mLYggwGgdBaSHZA5GZl3fq
         OB+H7BC6lxUuEU/9N2zQ7onGAjAaA0cRVhQn5BhbKL7AJosyI6G5U3WMhGeNa3Cl6c1v
         RmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180105; x=1785784905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AA2oaqkGbFTjS87Z4DpjB7Sc3FAQRMCUmxPyX/3i3Zg=;
        b=Jxgym1ft9aoZ/MU04ZQC1DzRFvONcqiInoyMLYqjAwPPzO08uN2kPgP2jpXNMP+T/l
         L1UovJDEyxM08uTmVSfirGq/uzKtmPiZTtOfYP3aLpnMm0IlNULUyVx/U+gQaaTHP61F
         JlihB5DK+FA6upeSSv8G2SImuSkGGB5aayaA851S+djiWyyJ+rFQ8BT+yO5Y+fjubKim
         xmJmn/UjwbbzYFCJ7zAWQVvWCwpo8ZjRo7tXWRPUeIKEe0YDKS6s/U1Ss3dtMwZ0ME/y
         zcgkp6MRgpxwPGqWeZfaQLUTF21Fs3bC9bLrJzM1WNR16ac1BdUsi2Rx8KpU7kiWFkuP
         qboQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqZwQcuXG6TvLIVtUAgHEpPz+tKZwjPGEPetPcejtwg/8lL0JNakkVaZdjUPy6TopWrYKBrU7yScg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRFqbIyEvsbPzf7nGwMukpWMiRq6N1dzzzNYG+QqnHHmV/xtH
	wvDBaHdZ+otZuRChvOpxwxsFlDeGTGr7zLZ58PW2qqr8x/1gEIq81I6eTWv3pYFdp+OX5Q==
X-Gm-Gg: AR+sD120Fkf14SUBoFd6JG0Q56QwlGmEYuC4TkHY78GNM/8w4VyNUjkzkqgbHgd6Z5l
	Edt+6UIQ4E44STxwX1gTHpNiM6ZyfYmPAwgFK/iIxONa6Yyqm5ZXA4zmvK8RSgoSunoFERFrKZE
	zz+g2A6oY+hqVYUlI5SNCq21hh63sndo48xjxWScvpoKeprbHa5k0XGzXKpYwd0Z400wRT3B8Uv
	swxJWE/FbNBc6gNtR8xV9hIWDVr81R0STkrmX5fpkpsrkcvkq7XKZE24c1VO78MOjcRYxM5LvGV
	XShx8MMNrdwLvwU5fsuLidjkieBGkJw9cXgtRxWZemng99vop+ivrAeRZxNRg3cdCVLKwAg8teO
	g9PsmahJwO01efn41cpNkOKLGnsW65U+Hdtn/gAiOUSiid3JuuGAfva3KEcyiM2PeEE9F7brAE9
	bvPc2aQLhx95yZNPRFo2XKZUfF9IJPj+KRlVzdhnZAePYAteQ8LCxg
X-Received: by 2002:a05:6a21:58d:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3c6c7b7196cmr962714637.12.1785180105419;
        Mon, 27 Jul 2026 12:21:45 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:45 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 6/6] iio: adc: ti-ads1015: convert to fully managed resources
Date: Tue, 28 Jul 2026 00:51:02 +0530
Message-Id: <20260727192102.37968-7-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727192102.37968-1-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the driver to use devm_ allocations and power
management, allowing for the complete removal of the
ads1015_remove()

Key changes:
- Use devm_add_action_or_reset() to ensure the ADC is safely powered
down upon driver removal.
- Move to devm_pm_runtime_set_active_enabled() to manage the runtime
PM lifecycle.
- Convert iio_device_register() and mutex_init() to their devm_
variants.
- Remove the thus obsolete ads1015_remove() function.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 45 ++++++++++++++----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a8dba4e5aed3..f92ec5941c47 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -928,6 +928,11 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 				  mode << ADS1015_CFG_MOD_SHIFT);
 }
 
+static void ads1015_power_off(void *st)
+{
+	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
+}
+
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
@@ -948,7 +953,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1029,40 +1036,23 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
+	ret = devm_add_action_or_reset(dev, ads1015_power_off, data);
 	if (ret)
 		return ret;
+
 	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register IIO device\n");
-		pm_runtime_disable(dev);
-		pm_runtime_set_suspended(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static void ads1015_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
 
-	iio_device_unregister(indio_dev);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
-	/* power down single shot mode */
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
+
+	return 0;
 }
 
 static int ads1015_runtime_suspend(struct device *dev)
@@ -1147,7 +1137,6 @@ static struct i2c_driver ads1015_driver = {
 		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
-	.remove		= ads1015_remove,
 	.id_table	= ads1015_id,
 };
 
-- 
2.39.5

