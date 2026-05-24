Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCC31F9B8
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650794; cv=none; b=Lm2H2uAKSLKbrZ6Ags88PuxKTwzLD5n4sk5Go0kPQ9TAJQ/9QMBemkEee/WX7q0NqDAnsRuhFpFc7tzYMwfMYkIPBER8twU3serF9g1pXww1byllt7RZ6Lt40JPNgR0oBGb/YiIEq+SWKdkpsxtLUy9UzGKyHot2/HHgjt4GxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650794; c=relaxed/simple;
	bh=xKniFRfuFyd6flukHXIMF4ODBD4Vpido/so9s/JxbxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRooBLXjo4SYySck1gZYm0KaiCOD5rHzzhPgTPzLwTx/OKhDZ1ViGARS0tMvf8v22cJwZviUQm0s7djEk4ItzPi+hGn4/wKa11Y7iOL/CSwjTLTASrz+2Y/ErzIdbJ/ezdugh+ow22NECuPVyffCC1I1G995582cV9+HZnJE1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+WPsdSa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+WPsdSa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd266f6fc0so44060015ad.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650792; x=1780255592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPooqvpKCacKd5AF5eiLYnmB2/XjqM0LvIdFu8HwJA0=;
        b=A+WPsdSa2ZE2JHevNvcM5AJyMktL5/66KxC0FWcD4aPx76N3q8amTzp1fJXTwIOlMY
         obC76fgj63gXu+DehUkxOWrzTOgyTjvIYllMTWrtvWOHQFgxLPyLM97j9Pju6SRyw3FH
         Z6MElDeg1qcJtMvZ2jjkCHf+uKONDzJUBwMIjuPidxK2RPU74iMTQpCxT+bUDbMxNxiu
         GRKpfnl8eBryaRnMWKTpY35zQ/rRWFVsINRLbpbWVWiZxb8z+H3h+pIcsEneQXXvJwun
         ptjOoOXr7pIM0Q6fkUuOPXWLJIFRkF2/44qDbq3q6hmgDau1j/1Uq6Yf1NRJtTeQf0OQ
         BcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650792; x=1780255592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPooqvpKCacKd5AF5eiLYnmB2/XjqM0LvIdFu8HwJA0=;
        b=Oy+oWX+ty702rGd/CIR74y2UYmTotEGSAC/9A9IPe4BJr4tHT/W1gWTqq/DLpn5+Rx
         /mUs1JMTJz+7SFwglWW/OiIuL83yIOECc23uP/4Xb/y40R4HBQkRjZSHrY/IG1vHOZeT
         zjXP4xsDA+kjD8hkasAzUlWxF6J/T0C3SBIZumdraF7JPBr8QF9z97MPlcFWN1owzdX0
         6RDuSHEqjdNNZPRBalgEpiLmu/ZXOszlyUfYBgDJqg+054LL7D1VPdzlh1+Puj6RAyKc
         xvDaYxiw0OZ1ojakvZ02JNgma8qTBSE74chy/90u2LU+hH2jPXjKOB+zHxwrgXum/aZU
         meYg==
X-Forwarded-Encrypted: i=1; AFNElJ+BMyfAX7rnyFlkHiPSxntQ9MJ8WG6jAoOrV1eEi7U+IW+gzfPL/H03wYsMmWeRCxe7PAlt1oJjF74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUProLvxy+AHsyV5M6TkI6I7iohrJsjwLnzIjqaEoxViFjHuMi
	z/CFbrNwsswhV+qdGpMF3EHaTUzpCTIwpmCa3p61FrTHKK1x0V9FHI/O
X-Gm-Gg: Acq92OHIFKAlYAOUpzoOi5WOcCl/RCkx3R2JwqFQK2LPf7B62BmkisV0ZfNB2+YLy6I
	QwnqHcxaYgf1g4FUkzO4lrMBoQS3nhNfMqs/8pB8s9l/s6XsEXf3Yo9UoMzxPoqEMVCTCgmdqvi
	J0Ua7YHxUZq4Ntcsyla7MHzx1ivlawWabaAVwWf/zjJ6HkHts+LUvkcakaDTu9w7CD82TV/V/9g
	4peEv/OHdL6vnd95vtlTZv0i5mQu9uCPDLJJ4sZ5GnNHGhC2GtLmAlDxCNbGmFtoJPtXMhpaTRs
	ufTZH6MesXVriE3Nc2ssyI7TzGKpbVs0dCQ2xnXxSAuLUO6NEEEOBPMYHd8hNZCSwOYDQYJrFwX
	bGpA7aY8478/YAGta78ZxQZ8+QqLfGrzfG9EDunHoaRc47ROkiB0ygqylb9DARX47Q2BwgV8Ouo
	NHwfoxp4JpVB2D0nB+3cUWJWyN/PgjW22G8rJe95Q1/LSCsrkE
X-Received: by 2002:a17:903:3903:b0:2b4:696b:7bb7 with SMTP id d9443c01a7336-2beb05fda97mr132687455ad.15.1779650791895;
        Sun, 24 May 2026 12:26:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:31 -0700 (PDT)
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
Subject: [PATCH v4 17/36] iio: accel: hid-sensor-accel-3d: use local struct device
Date: Mon, 25 May 2026 00:55:54 +0530
Message-Id: <20260524192556.1195042-8-sanjayembedded@gmail.com>
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 67fb8efd6b10..561d9784d936 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -328,7 +328,8 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_accel_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	const char *name;
 	struct iio_dev *indio_dev;
@@ -336,8 +337,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	const struct iio_chan_spec *channel_spec;
 	int channel_size;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct accel_3d_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct accel_3d_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -364,21 +364,21 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 						 accel_3d_sensitivity_addresses,
 						 ARRAY_SIZE(accel_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
-	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
+	indio_dev->channels = devm_kmemdup(dev, channel_spec,
 					   channel_size, GFP_KERNEL);
 
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 	ret = accel_3d_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
 				hsdev->usage, accel_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -391,13 +391,13 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 					&accel_state->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -407,7 +407,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					&accel_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

