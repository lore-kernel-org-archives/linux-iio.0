Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E218333727
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651017; cv=none; b=p0GjAF1SwcHT4mbHCSU9ejlNOfUkg1qA6lel8K3VSem3jELm1OeP3TeTDxAUI337xMjyqsU1MTj4gUYvbN7QEOiQUBcs2ao2ngJKwaixvMzG0eMcoFQinBEDqFTr8uiBXlXIeE+irAe0fXPog5qi4iP+iRWE5qqOqzEwv8G/4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651017; c=relaxed/simple;
	bh=w+34NBfWc20MMNm05EC+EPyPPxYdO+GOfzkmj3lEcns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jn403fWA6iIADrWgpkAAaUSRiMKIkcSzcKJTCuBWokGIGeV0QROMH57vx0whot7YHgtMwvc1qjjI7sFUWfhjL1cI0yprMGu/CW507MZ1yl/ye2JDbrZgWS0Sn01zZYwz4llR3qxDNdkilUEzBV7H+EcXUcqpUZa9lc8Io24Pru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMc1mFJO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMc1mFJO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba6485d219so68280765ad.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651016; x=1780255816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT6llKwBcIyZDxdZqev8by8Y97Y21ILH6soiE00w2G0=;
        b=lMc1mFJOki33K5YRH6vSVRc0eJ1gNxvsUpmcQKrRwkH3GidmsWVH0EaaqKeX/RVlHY
         ln4TL09+N7zCpHL6c6OCNfNylgY+nBMcHp4xwpEQZGAsYdrCSfok81y7sumA8X4VcG45
         fld7yycGWeAWpyEx5HsgzmJUUQta9VV4vsG3pDm8xBANnXPodoZXLQGrIe67Xwqfgmyh
         gLemnaMk5TpVje5dla1aGZuNPucdzIzHjCvO34Hyw2HsrYFY2QBOIABBMExRZZvCyAU2
         zrZF0gxs2ku5IxmiCikODc25RqqpVf5IUd5yLNANGGYmJyPKv5kz4oh93mKBElCrseI5
         tHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651016; x=1780255816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zT6llKwBcIyZDxdZqev8by8Y97Y21ILH6soiE00w2G0=;
        b=iPC8WIZhK61D4l588K4CNqR7b0Odx7+sN1ur4bVc2ZQWMEeyuJmW0pMlMhyBy6xbNK
         W6kHe6woD1ATHKBKeBVG6l5FciajjLez4j3mW+U0unQMnqTQenNkpVz2nQpg1C6OWUA6
         LVbuJyjq1hm6DWalS6UeJ1fJIvFiospIy1YKUaCiuWeYqRKOpbJa8h9RHRpa26lQdTDs
         XLNddiD6sEGqHGRZGzEjW3CLU9etOMmJ8L9Eks5bhpkJmmoDsqr60iXUBt+F8addV3lN
         J4tG8m4PXVjH03uNx/f0C7wjbu32m9kiSh5XJV7xjQInDpPHQmEUxF/Wgen/I0O6PiSN
         EyNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EwcBBqAzildzAJnzaVlhGvzq4Ny8jgKkXrRltQF1dLkVUNpOVYCF0k4LHf72tAuSTaRQvZTQGc5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAyFznn5hkPeCHrvIium9OnjDxNLmy5jNmEcq/UNSwr/rOjc1
	Re05MTRuCYqwpipM4G8W3MtJnmTJlo7CzpRaWzMFzdtmddaeqAcnHcQu
X-Gm-Gg: Acq92OHgbyKaQgcLrKZvJU+/n+BIA4gYm0nWb7ltnilDqvQvm6FK8OfR9VBbk5zVlLH
	Mu3yWBNiBS195eUUD+0Aa8YXq9C9tOHX3jcjRcyXmh2NzcXwApGpNX1KS5zRHtbh8JqWJK/KcTK
	c7Sm83oM+tGoMSuviK+OWV/iBnjRAvAn4V5BanRZrZyAN4gH4ied/3QoOD42f9VWELnwTwyHHuf
	01whIyOOcggDwgslrqqoIO7G1KMqYO3jUFppT5v3dLrfWow2VJaEnPf66HYjRSS2OKWUxI46L8S
	hG0qsbv+RU/vOuOY9+qoshErBZfIZQ2ROcjv8GYgQYVfgpQ+b/83078xeFwyvHA6w/5VFx5kchT
	HLJCrJcQ9tOgC0I/vngAlgznZZmHrNzdqubWqhQKPXXLAJsa8VSmoQkpJYHXTMJ4QiymqbDHd7q
	JdbgmZrJDFRdl11gcykQXFBOslVU/tLGKFaLSjg/Sq+rSKu/7Y
X-Received: by 2002:a17:902:cf0b:b0:2bd:93b0:2c18 with SMTP id d9443c01a7336-2beb0385282mr132881685ad.9.1779651015642;
        Sun, 24 May 2026 12:30:15 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:30:15 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 36/36] iio: temperature: hid-sensor-temperature: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:43 +0530
Message-Id: <20260524192943.1196773-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 1ff0233d7ab0..ba68fb8bbbaa 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -231,8 +231,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	atomic_set(&temp_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&temp_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(&pdev->dev, indio_dev, name,
+					    &temp_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -242,7 +242,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
 					&temperature_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret)
@@ -252,8 +252,6 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&temp_st->common_attributes);
 	return ret;
 }
 
@@ -261,11 +259,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 static void hid_temperature_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
-	hid_sensor_remove_trigger(&temp_st->common_attributes);
 }
 
 static const struct platform_device_id hid_temperature_ids[] = {
-- 
2.34.1

