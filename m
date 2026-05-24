Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C3339705
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650785; cv=none; b=RAFCh5hgIlgNqzmfjNZ9OGePgPXizcZ1ZahyJdYoMWBR2iR/x5Ti0nv7zHlhbiLspCzfj4ZmjGfwELu2FdF94zJyywlUU2ekm1JP9zeBkzVJ6T3djQSAF6NfxQdwDn10hHiYVhkotPjn2V709sXLq9GhjWZmWT6pFuUZBx4yldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650785; c=relaxed/simple;
	bh=7PRMoD9vJAzFPnPVnt/PERV904czcBPZxnZNYRHlRD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc5foN/UZmMZ3QF/clI6UXsw5SwKyR+aYdq4uGAaJ+GCszhktMYINCbnN/lSvdetPi9jR6CqQsfX+naVBccjJiTJQKQRK40haCwIKUejJOuPOD4RrbiOPY3AqhzX3MLjBA1q5pcmpZUrNeTkdtGSjWCZ2LFLs1fxJ1XVouCDU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REgxADMl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REgxADMl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2baca4df358so55304425ad.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650783; x=1780255583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZpNiHPFeF8hK/y/e/W3MqlZSN9qWkMyFvMyP/Ycuns=;
        b=REgxADMlRIXFy9jk+STjbztQz701KXl9nkDkeQSgMU0iAx3t/fTH8gyq1tjA9hHOMq
         uz2Uv29hhAHRIpVTohM5fwqeoVur+u8j/X3b+4qtPsxWUtIcwaUXQesK6EZrUNAx82Uz
         1Cnz5wLgFhxpfDXAtoJ0I9Czhe+/fCDemvTzniOqNJZ1OL1j8a9kX/A7oCSxNpxGFBSG
         w5vJ6ItIB9gDH2VhUmjnqlylpjySJONMzYNTRLfuKmgMP9lRN2siCvBwRiHQ0o8HDtcx
         6cLLTxQ5U0L5b6fc5gBcmk/NN9btz6tehREq2EGjmeuCQS9/5t41fvo8MdZXlDfAAECW
         AyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650783; x=1780255583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZpNiHPFeF8hK/y/e/W3MqlZSN9qWkMyFvMyP/Ycuns=;
        b=J/JUM0Al0VyZq+rU75wsi1k8i6GAOEuXcKvnaAoRxX57Msh9EHToKJa0gE9zXchdnR
         nUNwWXD4bO0RMQ7bhJblikllZhlhpvEU0H1P/o3Oi7RA/tPH86ACDL5XRGY4sY+KeMhS
         GRH46NzQ/KQmKQRrljXNbhfyxaPid+15IL3b+7QBhWohAsywwBuTgz1854v2gMrLfZwI
         jpPN1ZNaVBZrIcPOaV2XSCqsa1Lu0oYtp2qnc72e7dLegwYWtUbZxWroCaUQN5X4u7mq
         56LeF5P/jmhjLJNN7C2HntJMdsuam5m3jaoe7gVfuL3z1IHFiRhUHNqU+jZRzJb7U6Gl
         5Srg==
X-Forwarded-Encrypted: i=1; AFNElJ9EUAxxkxKmm2tFHHxFqM0mSqz8nRL+wWwxyRZqXIYuvX9rDWDlXCaMuq3VxdlTpnXp9XTaPeK5uqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKq4p9KIzcToB+0MGNcu5eUsNV0RJ8GRtd8sO+6GMzGANTSyeD
	uzlJNVGplNjRYd8/Wqu2uQC513Ma6TvVelIAi+bqzEztvNpjkRSflMyR
X-Gm-Gg: Acq92OHgtz3NwqiDkdgHH+iiyTJZG3TimlhtvAbSRGg4KttsuCuh7O+LSZ6AoUD/0j/
	JtdT+wLKSUmLZ8YPkanGHPW6STAFgzPTqz5RbeuUqBL/EWdJY8F5XDwZv3ognIJrIyPcoahLuFt
	CNKkoWTQDOJ9Tu0mYOxbTTslYuu6Vai+oppKEvTxhgNi6c3ENqOFpSNZZfEuzM89IHwaVRo423B
	mycLzvhSNmbx48YodGy/vuS+nC/SvXxCf7dFIfJSKGUcHE7vof0Y6IuuMho7CTdOO9wSQPK8iri
	uGpJ3mfggHfoKQJq+GuVyVyzPw4muHieflye87WsiVZnUS2ED6RiYDiffc1JcX747AsQ7G55sAR
	birPIKJVN3b8STXf8hx0BlvprjrD862siZP8W661+v1O/IA7/vUgf74E3cQM0cyhN00HgTekKvh
	8QYLlTCRjTToh9SSk1AWt3OlkpvCOa7sq/oCrhsU+GSuDHTN0X
X-Received: by 2002:a17:902:d482:b0:2bd:2de3:519f with SMTP id d9443c01a7336-2beb074f92cmr130040995ad.19.1779650783475;
        Sun, 24 May 2026 12:26:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:23 -0700 (PDT)
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
Subject: [PATCH v4 15/36] iio: humidity: hid-sensor-humidity: use local struct device
Date: Mon, 25 May 2026 00:55:52 +0530
Message-Id: <20260524192556.1195042-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 73120b87d641..ea6f66ce0f8e 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -196,10 +196,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct hid_humidity_state *humid_st;
 	struct iio_chan_spec *humid_chans;
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*humid_st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -215,7 +216,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
-- 
2.34.1

