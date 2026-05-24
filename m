Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239E33C183
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650789; cv=none; b=lc0oc+Edl/e5VLVBeimVEeFj9cKPj1xzgqmehXol8aj349TEgXADdhCQ1MbEQKaIlgm2a4ZFh3em9XjoF5xwX3M9QQH1VV3giUKGyp2fIWWr2QnRV/V/fPuV6ncyBBJJ15VvXk58FoZmj/S9ZkOWPKzD2T/tOjzJ+3pZtpD6wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650789; c=relaxed/simple;
	bh=MYeIYUM2KlH1XXxgzfpzPXXNHs0yocmW+9ZTkwyCkNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/7/yH9G99HIymfCsWt/AluSM+KgRmtgQrT4smxckw42iT5EHkV/it1/l+zGcSaitm/Ni2xaFaIs77qwcCvIS02+VgSF3Bvs4TSTZ14w5k3pDyAN4Q18z/NW2ytaYrsFC450xky0WyAIS3Rt18NdUxEHcenjdKd8AQZjY21t3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5CJPfp2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5CJPfp2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2be75f658f3so40589665ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650787; x=1780255587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BueeduEXr1LDnMvJYaRF+YqR/DBnuvSzvmSwN2I4KLw=;
        b=R5CJPfp2p2Rl2a6gPW7C3nvGBoxa7MOtXIUsLngsutq8Vap/JYUJVRf/pO7dHIek5U
         8x5TqeC0SOPOHdbmV0smFbTyn5h2QWacHxT+tc/tQkJyPxaPbDVs6uWI8ltO0RrsCwMS
         P3DiSbU94yDtLxX2klklhMQobt5ZHT682Ue9uhHD1qIXM+5mg2bTe8twXydq0ak/F9qj
         vctK4EOnWITqlNVxX5kVMW/FJdz3GvISULtdwkL9fNjNTfvigbvFUevJ0oEA/mPf7K+9
         cCv70J7PGvQQXnWBiNmJqgdUJaFWO8EwiDdgTApQk1gepoE89l7ESl5gBrAe0EQc5frf
         iyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650787; x=1780255587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BueeduEXr1LDnMvJYaRF+YqR/DBnuvSzvmSwN2I4KLw=;
        b=GZHS0iJaPLIu1JCdsWx0aQdZQSUxpFnWaWKqiP6E2nj72sj9gS+Z9qea1Zz7z7mJ3v
         wAM3WAoDwtaMnQyHzCqYuJIhxymFRYdGD02Gj5/oBiqo3hIo27hM0mC+un8dYuLan/lt
         wpK/8qqauu9hPaHCrj0cug+V/AfmZp3Kiy2PmjdldMh4S/QLp/tRJzFhexo++aj2cybT
         ZyRwUplGjju/m5Y71wYqOgHsuzqTIolstuNS3Xr2On4VPQwwESvI+gemm+NKvQcW9Q/e
         ikdPwZ2xWCqujTfF7bJOAMS2qvdurKukv6mWpLpgYEFhYEEBe7hoHUkBGEYvtn6LhSr1
         XmAw==
X-Forwarded-Encrypted: i=1; AFNElJ/KYuABZcPadyVFMbvBNDxkxwwYYgEmNUGM2te9nfkYm/Mi3Dqj0GsphvXFyN1N4WIek+kBKvWWoco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEaU6NLJBcA+v/kzMyco6FeGaoZog2rckz7daEoy5F354rFNW
	NqcFN4cBiS85bx0wlpP3i+LLGeq+1vbeVdf4BMYrmUH4PKYt4I36CElj
X-Gm-Gg: Acq92OEjRGRtkrKtQAypso6mYZiZOhM+281mm5GzNHqYW5wAwCJsTMRJtV6AKFNrKln
	o6jNT3hWVL08E9dXKj+wnHhMUPR4fD9Tg7Ax/vRhXoPJqg2srTAywNgaGl9iXGlwo9DFNxsvZCa
	YRrVi3fcUs5YK1yRHNFF5cOmIzD0fSldo6pX2Sj4Q7x4awmXfqgqHLxRCuliUVfqaXHLpp4VBDC
	p+ByMOEn/lQr3YJYd9zumb4LrxzFNNkb1Wj7W/fIGgDaiOBT34+Nze1iSmCJqMf1DQFaZQVz+Gz
	xCO9G1cg2ns+fDvlJp7soT0kP4Ib1YRhU84UpXzN5avMiZa/uAyedQhIjF70nd1VEewJqQxpdTl
	d0ZGei2iyRGLNODzF6etpmALtS0gAbReB1nWNWt201Ckcp0BhzOox/57EEbmwBTZv8Dp5/CZXgT
	XuMiNa/L2Re0J6NtbiRb3B3dJQMbWxKqq+GATShgndEtjTNULw
X-Received: by 2002:a17:903:3808:b0:2ba:5f24:cae2 with SMTP id d9443c01a7336-2beb07bb69dmr128631365ad.35.1779650787577;
        Sun, 24 May 2026 12:26:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:27 -0700 (PDT)
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
Subject: [PATCH v4 16/36] iio: gyro: hid-sensor-gyro-3d: use local struct device
Date: Mon, 25 May 2026 00:55:53 +0530
Message-Id: <20260524192556.1195042-7-sanjayembedded@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 4d56bd5b9f21..c891b1bb09dd 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -280,13 +280,14 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_gyro_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "gyro_3d";
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -301,14 +302,14 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 						 gyro_3d_sensitivity_addresses,
 						 ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
+	indio_dev->channels = devm_kmemdup(dev, gyro_3d_channels,
 					   sizeof(gyro_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
@@ -316,7 +317,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 				   (struct iio_chan_spec *)indio_dev->channels,
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -330,13 +331,13 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &gyro_state->common_attributes);
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
 
@@ -346,7 +347,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
 					   &gyro_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

