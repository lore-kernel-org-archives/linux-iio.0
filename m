Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6B5187C1
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788345; cv=none; b=lmwKt6f4NGWqqZXBSl+QsdxBsO0la1MLCceozQqks9COoBYoNTNuPy8EG5pRKCnT9pGsMRGFM4nKvnFtYyRy/KklPPj+mWDZ/W1NPOhCKNaCjThXJbs0xMBrrgA3TJc14l5T2eoBILU1M9at1LVpknSY+YBCzBEpt2coVmR8gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788345; c=relaxed/simple;
	bh=i4ZF5tM1Z8ws8bEdVnkjHemZs7/wJkd9n0+slBx1btk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsdgXqS9L4vQfKw5vTNKB0fpcwQgMqgUQUW5Hxw+SoZ406Rjgn7GvCkd9N61O7TVJzRaXyHWFcgKe2/g83fc02JCAFjBoeaij+wG061IBrg6Yds63dOxmE4hStJ51/dyK6AFIXE/QB1qPPZeEcAAnlZFlLQGyjzmqK1a5suYb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POhocg0Z; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POhocg0Z"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88582e2153eso1649531b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788343; x=1791393143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hUyG3QvGU6Q+HKsY6Ncct0FACqa/9VKrloUu7M3UGwc=;
        b=POhocg0ZrGkgm6KY0qU7Sb1ekMiXgMWNQIrzyvtC7iXj3koqvoH5IJUlt0zv9xcctk
         zT9Nl9zrIobxizplLk9zqqVmY13WtAB4lwNh5oBeXIO8/k93f+f0Qb6+mpZh5Y0xws4k
         nP2Qc5lqe1XEy4/YXFWmZmJGd+7J2sPn+39eGlCpSQjRgA3ZmQUcvBuLYXpERrfVrhPQ
         s57B6Ar3B92aSuT74Q1EYS5y/q7Z/kuAq2GzjSY3xQnFYy0z5F0G8QOkvddUvAq+K69O
         5yNHa59+Du7kTKX98abuhKeMgfQtPzSCIi9AHEgPmiWZYWe9T3y3PD6NLnH5dNMoNSbk
         cJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788343; x=1791393143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hUyG3QvGU6Q+HKsY6Ncct0FACqa/9VKrloUu7M3UGwc=;
        b=zeA+2khM6JIbjQEDgIqzz5m6ohP455pE9+5Y0ssTDr+vqHSbdbHFpvsGytZJji83Zh
         iUavnC2v+dwgnXaJFB4argJhbItEJdlfV+0EFa5094cEk63jSByt5REmprFiqlJ/8DMT
         3gxKz67qGwA9wHYnRiDrb+JzPzovTrPSJIJgbamk822WF8LHaBvO7VTAU4jIj4sbPDVF
         06QDklyrJh0m4DW0r2qS1bMkO43oCBHefY2B2y1PM2ckrrqZoC34/UKBmqfiRlq/oM7F
         huIBaQQi3e1KoaYzwVCkV/C05qXATFi2lH8rggu8qEeBumsgo14ZAg0j2w5Eqzmcg8yz
         DvZg==
X-Forwarded-Encrypted: i=1; AKwUvBzqXBZXdG2jcaJOyaLsmU6ABLvUyUeSoLZLF6rdk69Dhkkk2GpkzpUfcLwrQNGVDKt+aGSY5jjVUuk=@vger.kernel.org
X-Gm-Message-State: AFuF++lqRmA3pLfVrBIq0qoaN/ztoNm0zloa1JuOhWgiOnjAh5WgM+k0
	QXvFYI0to9Y+Jbc1eOFIhGBHdaXRPbpQh1RwsaOrVLSOXPUBK1VGZqSm
X-Gm-Gg: AYBFou1JnPYjuK0RSCuFaMkEDIK4zh7NgT65VUkQ0SRNuxXr1phB5YO4RZpp3nU6ZLh
	5D9o7q6oUYJze7y74syN06bVRttlubqT4XjKo4zfMIIm7eEJEH1jq1BweV++JmX2sJUBrjS2Ua6
	OeROXcZ8zw02dpXRbOylN+eLlS7HDPb2tjl5B9H+6l9/MVsDH4Od8mG/F4GTsQxBjW2L8lDjbit
	B1Zmty4zCU9242f2y7ZB2LxBz0TYwC9AWTW/oGNWJCo5Mb15n+oqrTqTuXcCWYrE3spOCUkBBKu
	7wcUmUbgRhYToCTqcFImamPzkYuUArlVPk4YA+UeJLkSzisftINS7f5eU3ctKPPetO5AHTRuvgN
	l5SVnen93psOOeLoU0hCksNOCzsDNsCO0yK8boAJrnlZGE11yco/BI6PVkV9BA7gLWYxZXwrbga
	0WCAmTXxT9JoTh2XGq4PxKwF7isAp/2y12E4evdUFTYNNFlFv5X2meef8+vFWRxJnYB4CjfAcj6
	MbACG4ko7ORz2bNwSvCH9Vf17hGqOAV2K64hzcl4g+wz+nDbXFDq6g6Dic1mg==
X-Received: by 2002:a05:6a00:94f4:b0:880:cb95:aa7b with SMTP id d2e1a72fcca58-8874b5428e9mr1410325b3a.35.1790788343472;
        Wed, 30 Sep 2026 10:12:23 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:23 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 01/10] iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
Date: Wed, 30 Sep 2026 22:41:55 +0530
Message-Id: <20260930171204.12863-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
macro automatically handles dropping unused functions when PM is
disabled.

Update the driver struct to use pm_ptr() to avoid unused variable
warnings.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0fbfa4e499aa..93a165c5416a 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1059,7 +1059,6 @@ static int ads1015_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM
 static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1080,12 +1079,11 @@ static int ads1015_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops ads1015_pm_ops = {
-	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
-			   ads1015_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
+				 ads1015_runtime_suspend,
+				 ads1015_runtime_resume,
+				 NULL);
 
 static const struct ads1015_chip_data ads1015_data = {
 	.channels	= ads1015_channels,
@@ -1140,7 +1138,7 @@ static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
 		.of_match_table = ads1015_of_match,
-		.pm = &ads1015_pm_ops,
+		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
 	.id_table	= ads1015_id,
-- 
2.39.5

