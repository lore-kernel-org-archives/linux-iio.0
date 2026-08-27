Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B204A2E1E
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851310; cv=none; b=DNqY2lgWL5VAJrX+mNi7QScopa0AW2ErOwT7Fw9aS7kc46ajzwyj4CJIIRCWZATtXh1jrb00UxgxHBJ0DSRjxpaNLLSl42Ub1J3gg61lpShhoqB5hzAbXE2vvmtrYQq5Ti3lzBDymecWUKpTg1jUVrwuXkCZ3hnm6FwqHV8St0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851310; c=relaxed/simple;
	bh=tIj3Rwco4Ww1OkSETUoiv/BrdF5nP3f+DgIRRQpRcO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7Uwj8khZ6LeGdkJorbXmVQiD/zz9NKVSKrTE1TXNZM1Ab7Y1/vq746yW0xLG81Sab2Ttbplt/36kDgvKlloabQO0FvmeapdgWq4NQl+ogYVW7koi7t1HB4RpShqc6CA4EnK/oC76TZrq/H+ttmAEhq8jLC6bb8KfPgFH/xTUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYznhukP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYznhukP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso323019a91.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851308; x=1788456108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gD1m0WaEvx2GvhSS9FSHrS8bwWBRtzwM1faMwnB9Q4=;
        b=nYznhukPhS+PLB/vwgeSYyieYfOyR7YSM4HD5f3BNTIz1dyb5w3LOvZje4rzumKJ0+
         U3r/nY+IaxuZLNHeEnhBiKnkOdzTHu6/MFeECiXa7T2oXBJHHijfbkGLR7Qk717YWBtk
         JcdZvUeC+J/sVuGahnMOZqK9fqVbuMWBfyVnnXUFakykyjwK7qWiH2U5QCJq44xtkcuf
         0TSW5a7EjQRGIKOfcjgolOP3OFvEawcxSiOtxXy/N1hz9geiK+ejLDDAcnYLkAr7gZab
         D/ysgYzzitidaL0zmmOUzIMwquHOCo9HhVKCnx4ccj9B28cd36oCOwyIT3e+cR46Yw0V
         CtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851308; x=1788456108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gD1m0WaEvx2GvhSS9FSHrS8bwWBRtzwM1faMwnB9Q4=;
        b=eHt2NICbPmokMOsYUaeq+4HEibiHhkokLlNlcKPBHRFqwPa/IGuRhYNTSzIlO8JPh0
         W0LRT5jNZG6mRcatct3wViXNflSefXCbw2VvJ9eKukaglzVSCAqrCMA6rmTnXNcLMdM7
         hB4w6nCDg31oGuMfIh5NU/l4/uvyfkPaOiZAFo/ierEyhRlWxjsDKrCZ/I0kzTt55zMW
         GboWjynCdoAraIk55t2mn9pHk7wpKwDoxB+yV9kj4p4lQ8s71MMsckk+CozcPN/WnmKw
         R6fc6R+QCgb79Ku/lhdQANSRvHUN5UQgWrF7dPMFPK4ot4z2lWVRD/7F03h1d2h+60o6
         xXjg==
X-Forwarded-Encrypted: i=1; AHgh+RqjE9vvLnSzjc30l1ACuI3t13C1FSJZwhg8SlapfyDPkiwaB52LilXppeMLL86WnAq9myNyPk+8hc4=@vger.kernel.org
X-Gm-Message-State: AFuF++kiXV8bh/yP0XnM+7AJKUVElfHF2JdDgy1i1s/7lTzXcfTel5HR
	mXKFO4F7tr+6lWiH95c84rct8GEjNG8aaBXbWlUqgnSUFSWU/oTbIdMF
X-Gm-Gg: AR+sD13b+7vp6tFg1adT28GAON7NculfqSrAob8CEPW5ncuaowLNQO0Bvm2HK1XSyql
	C88EUBd/j+s4PgZRiQ9xbESzh2GdABx+HpwJPr02m7ZY6QbafPyyP3TkZPohxXAQzjTzQ66Sd2m
	2X9+ylclAGueekKWm15Bx275Yt0exgnnEAoo1964hieHbYo5CaPSJJGftZZZZ7sY71KHv2zKgwj
	M4U+95YQbLPSlaas09+uk3SIE1/w8SXw66i8zZwzD8jku6PdB5duQMO0HhRuhnNERYg1izjP886
	5atATKhyjs8PngNzcjh6xlnTp6/1CrIqohh03rkIyiMP8x+VRxmboQ5NPaTuSYgOCMBWb/Z0oen
	J0IdmvkiEa8zqYKjQ6UIFyDa6HDJllTR51Qu9IbgnBj6kqUH7i6kEZ4KzQsikW+WIa7/FwwIboK
	h+G0AimhFisEzERkb0KNHNVJM13ce5qUnZ0oEOmmzXqxO5AotMdcH9RoBZhpgiSyl6tXds+wX/y
	y3deOZbUz8vDG4Dc2obW730b3hPAwj6OXW6
X-Received: by 2002:a17:90b:2552:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-396d0f02a58mr1272578a91.7.1787851308430;
        Thu, 27 Aug 2026 10:21:48 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:47 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 3/8] iio: adc: ti-ads1015: use local device pointer in probe
Date: Thu, 27 Aug 2026 22:50:55 +0530
Message-Id: <20260827172100.39176-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
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
index ef03b74bda3e..9c1d36db15e8 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -944,6 +944,7 @@ static void ads1015_power_down(void *p)
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
@@ -951,9 +952,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -993,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
@@ -1029,7 +1030,7 @@ static int ads1015_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ads1015_event_handler,
 						irq_trig | IRQF_ONESHOT,
 						client->name, indio_dev);
@@ -1041,22 +1042,22 @@ static int ads1015_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, ads1015_power_down, data);
+	ret = devm_add_action_or_reset(dev, ads1015_power_down, data);
 	if (ret)
 		return ret;
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-	ret = devm_pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ads1015_runtime_suspend(struct device *dev)
-- 
2.39.5

