Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B7477E4E
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553109; cv=none; b=nYWzMm+MnuKD/DmXEu4hsIzif4cREfmfdHELTVfX3qJQ58q2MAZHtzLnOP3Aej9l9sK96U2dhtiAqw6hohBAEPLnaTr9y3+XpYNyOKPsJewo8OyE/k3hGNA9n9k6FN242CIwGx8U8fwrgkQuyIl7YMG7dEOoar+4U/CGrwWTsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553109; c=relaxed/simple;
	bh=QUvio3n6vPHiBUgFY09fwlmR9f+9a3qZYiwY31q8giQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnQiAzJFF3C3hKHzmSiRNzvcvWXo4FfeH79th5DfaaYeevGTcGD9kJe4BPzVatiZsyHFjAQAvCdWgLKUf9rRJLmxughT8OkfeoPveEJ/P4NZlR5PTh0rDXd5dYVRr1Toh8HOBhPFEC7Pkp6V/Rgb0zZAg3gZaAVkDzY1JCHr0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyVTSxmI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyVTSxmI"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso940150a12.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553108; x=1787157908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tc+m+PQKLTrKTCoguHDmD+VKsM+Xs95ymj9GwCb18tw=;
        b=nyVTSxmI6w6Dm0D3LfDo2Vrst5QyhdGJhxtcws5/JC1e7/CQjveTsc8ve70oO5C8XY
         BTLRBKCs48jeEusc8yXuCahuWkla+j3AksOMepr+tEVJGRKrNWSqmzU9WvHuYoGuQCEi
         pW1g9wnFXnhiitqFW9kxkJPXvlnmeQdDPEVPqCmJmmA16AO3rZD8O1LBeqQoa9EUQBvo
         D4MhtZ35f9S2jbjKDisR8MyEOvQofoBUDqSQeMT18DsUQecnAChC9QMI2+kloORvMqA7
         MvrjKq3h/lXEUSBBQBIyPWhnqzkBAeqGEEQDHQ090zgrOUy+ARK1D2+XcG8TYgzQGYVO
         m1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553108; x=1787157908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tc+m+PQKLTrKTCoguHDmD+VKsM+Xs95ymj9GwCb18tw=;
        b=QyRMor6XTkrYvu3gBmIs8WKAYpNOKojpNDRURUidAS9adKGCBmFemYAh6oEFv73uG0
         l9MyVH1dEKFUc5dGqKs/Av/OuOYV6eASPxFUh1wqzD42MgIzXZlA4djLgc9czQ3izOt3
         t+tBpNFy4jWytz79GVFLjTETJ8/bM0lHniatLy5OgSz4v2V8LsGVz5aWJar/hFtd05RM
         Uni6IVDSW3DahrL8ZnILvY6wPp6/JwxaqmnXmRWA4oeca6qBx17ZJtwLb6KVbqFSEYqc
         ZNIgWllRQju7egn7hcEDr+pDPuq9Es84SNvpL6z1gKJELmiilF+VkSh9GypuLHEZ/PFn
         kORQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYfNfJMuIvbJD9eXQcbQ7Uw+cIFrPNxyWdZN7pSnG+PyZ5HVFZjlBnr+KRtaZ1r06EH6sdFw+P7dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzirx3Z+RabcHOpMem06gO688KEGUUnNmeE+mPpq4TuCKOxDEtF
	GRGpBknvbSicF7U/JRH5BFRnNQD5YBQ9WEuN0ZZ2XrGvIo87oSbDQ8b4
X-Gm-Gg: AR+sD12Hq1gkGgoWLv78TD7c2o1ASq4zsOHqrbwbEWt4O1bPzsE/ob4tDiuDpdRuOK1
	h9WdZ6RjhPHendakxPH0gVGBSWAmOj9Bq1eciK/1jm7Gg5cuxIs0sy/uHGNuMgBPWK7Eb0D7ZNn
	umr3P3q4z1f1Us1DT3ZNvmUJNhMGOwTVaE7+2fqSFPyf7AMC2kcEzEX9BHaRKEjhi+YjsOTGVIS
	fEyNQB33a4tKX0GUmFiiiIp5gteAp++hDl76C6yX2dEiqvZwVqUliW1S18gsJ2EC7X21fB52bDa
	oiRqnJomvGkgflYsCVW/IkRsS5oMKUgEdHE7Bc0M9NQfZ5qSb1ZVAex1u1OL+JfjzAee8kO4qmF
	DtKP5YZWrG+g6HRkjF5uuL3B42wHbGXj0u5SPFb2m8TB5iyKdM5bcZJZGc0c29T01aCmi3cLQ8S
	ba9A00b3v9yYxoWwn9ZjVVub1zZXbN5h9ijcv4pvpVq79+aDKElF3UP57vGw6Acp6LlImFn+NRR
	sGCP8vEPFVw77ZvWjKw7HwbQ31BCcXrbzo=
X-Received: by 2002:a05:6a21:3988:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3cc3f78f35fmr8729657637.32.1786553107445;
        Wed, 12 Aug 2026 09:45:07 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:07 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 4/8] iio: adc: ti-ads1015: use local device pointer in probe
Date: Wed, 12 Aug 2026 22:14:29 +0530
Message-Id: <20260812164433.23011-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
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
 drivers/iio/adc/ti-ads1015.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 293fdd49381f..c88904d7190d 100644
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
 
@@ -982,7 +983,7 @@ static int ads1015_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
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
 		dev_err(&client->dev, "Failed to register IIO device\n");
-		pm_runtime_disable(&client->dev);
-		pm_runtime_set_suspended(&client->dev);
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
 		return ret;
 	}
 
-- 
2.39.5

