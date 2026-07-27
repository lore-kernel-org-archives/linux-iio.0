Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF73D3D02
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180097; cv=none; b=WPuIR+v4yhc3p/vMOo0glYEj50IaXiTOSGLRmjg+ex75zlxr9rC0w3Evb913nD3v90OstwkvO+JwDJeNBZu0WdbdLWX2kfEITtfKqx0Y+SQc7SNoubJyiglaaeeHgWyokG7sHN10T4u3CttitlDM0q/Lk1pm6wcdyg00QjFjpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180097; c=relaxed/simple;
	bh=mGFQRJNkPvV16NBiYqV3OgDiOSf0+58Wg0hMGJfV+qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIC9lt/QjTqS49cMvMCvL2P5kIzhzA2u8I80ts5VQeSjS/dcKiY08yjfiSaR8Ehb3AJAir1uHeZ1L0h1aYY065CQ+VxMPh6v6QAe8X+zp6GMfZEdLvs5YIQCt0YZqB3Q2DAiAsFVXKJruIJjOZCOx7/XqscswMXrgl3gISE/qHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db3acGfZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db3acGfZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so34953845ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180096; x=1785784896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbGB5azYyiTEddP4WDQeN9HbbgdGItmbRSbjHbCy85g=;
        b=db3acGfZnmDoDqsDuQ3MUlPyiJMS8B42PAVdKJppxxRCI3zWj1cOw49ryD2WIJxwFR
         3hFPTfe08tdgajGfZI1gwo3L1UtCV1K9He9ffxEH+rAuHDFLWRK1r75/7GJuMldvMMnl
         T/hNbA1ql18So3DBn3jQibiH7jMto7C9qKi+mqbXE8mdwYZc6kz2BAq2Sx3M5ieVEKfq
         sox2QA4sxXsJu2p2i7E/CH+qOgzCw0/mTqFN8tcsUQdz/KpkGudyu2XcbhmcvFH1uUhi
         b3yU43KW+CUfbbncT1I7eCF6ZN1df9CCGWehi3FWpKNS1WBrzLJMM7isIhPv4IWBYC9c
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180096; x=1785784896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbGB5azYyiTEddP4WDQeN9HbbgdGItmbRSbjHbCy85g=;
        b=LgkXvlKnd/i5OrdKu/Ao3ccmjZblAKrG6mSSlu1GMHzDwKdhG+FBSE9T/2uShTwgut
         nTkPNpZINATweHEneZKwvQr2y5F6Xd89WBBcfwdThpmOCHZpHWEe7cuo3GTcHL5uXnnt
         VKeYkE9amWu/6Exv3fRaGnU4UTisLAmJN/tEGIlBZ4nAFeHUNkqcZHf9PlPQ/TxG94X0
         Be/MvdoCqMMXhngCa4jNXt+/ofJ+1RzeeEQdxc+qi8MdIFoshQSMGjf6uotIHovgCMaU
         DnfCy5BOE8rnCUScx6gP43LwDUR5emFpBTuh7PUG0PcY2eL+19m81ru0Mn72t3EX7dp1
         Xd1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqygwe1HeeRs1Z8zpEpu+iTypIYI92ChT8hUWe/o7BxSocWGA85R3g2B8CjCng5aLH4FJ5R9m0QgRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2zwj+QMrjbaf8QWTE8Ps7jvpffU8BvL058QZKbggCVWjUArj
	4djCl25PY/Ja1EcqgjIfG03LOBSj5/1ALNFKz7Ojk1qKuZbxrrWk8uuI
X-Gm-Gg: AR+sD10eAyBh38l4+u/4d+AREG1U3LMwpmCHfsLtz96VEaT9V7ozsylbW0tHCYbFHEM
	R+CWGPd6/PMKl+ucPCuhHbw4lEl3JDW/HTm2Cd7rOFgLS56T+ZYkJ4YuwHTnqV6TlNPVBFHfiUO
	M4e9a6GUW2R+OiciMMyEKqUuulfiiN6cXr6duzEXztpeHSW8nSCpj9XteKVt9FKdLTis24ktIAZ
	oDEaqUjBdVhD2t/5rcfE2qFmDnKbJguw239COIMFgja0Hgt6qLVr0BEreXNbWHp/NISrfvX30kb
	P5Q/ZFTv6evH0FyN+h6AwuRh58z88oXrdHxVQrIS91zg7uVVjlUUXjcyAo86L4llhfe/WsRPE9I
	rx0KWnHfkZ3FYzIW9VAWODzBm4TFncVIGbvXwGVMP4YaZsahoIkdXlbYF/D8LKExSHL3aMwPeBT
	93aE4RA0mgOmzn5ofRAPSzh0V7kHvZag6XAet4G5PIgYWSN2LRA4PBL9ronQbR/4c=
X-Received: by 2002:a17:903:90f:b0:2ce:ced3:490e with SMTP id d9443c01a7336-2d00f45f125mr5380825ad.39.1785180095855;
        Mon, 27 Jul 2026 12:21:35 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:35 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 4/6] iio: adc: ti-ads1015: use local device pointer in probe
Date: Tue, 28 Jul 2026 00:51:00 +0530
Message-Id: <20260727192102.37968-5-architanant5@gmail.com>
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

Introduce a local device pointer 'dev' in ads1015_probe to
avoid accessing &client->dev repeatedly.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 293fdd49381f..59ce2f89daeb 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -933,6 +933,7 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
@@ -940,9 +941,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -978,15 +979,15 @@ static int ads1015_probe(struct i2c_client *client)
 					    &ads1015_regmap_config :
 					    &tla2024_regmap_config);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "Failed to allocate register map\n");
+		dev_err(dev, "Failed to allocate register map\n");
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
@@ -1018,7 +1019,7 @@ static int ads1015_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ads1015_event_handler,
 						irq_trig | IRQF_ONESHOT,
 						client->name, indio_dev);
@@ -1032,18 +1033,18 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register IIO device\n");
-		pm_runtime_disable(&client->dev);
-		pm_runtime_set_suspended(&client->dev);
+		dev_err(dev, "Failed to register IIO device\n");
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
 		return ret;
 	}
 
-- 
2.39.5

