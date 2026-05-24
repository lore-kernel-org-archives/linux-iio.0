Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C43081A2
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650905; cv=none; b=Am0m+E0y2WceTYLWvGnd9XP3BRpK6ecbDJ9CuV2hJOsRH3+hh1SBF0J52bQWrFgEbAViq894s0QFnNMSd3PQPUm5mvikPJccXuk4yQ/QXLri2h26315p32N0FXmE5MCSu/XhWoJz6LNUTdsFSAtNs32dAPOK7wdHAVSKCRni10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650905; c=relaxed/simple;
	bh=9KBkBMShZ6Rk3MwkRfvkhK0E3NugzuNvlxRcXqS3jgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QC1E55HfKKCc+5X+baY31v1EigztyxC9+KzlPiHS8mHMmxOOPLEbNxgWdd0LC5o919Dx57QAMhERI0tKH4asJ4Mi6ZsWbyOeNWpSjwbq4d92FN+lAEplBujQnJWbF+3lk2GaiA+wCx3Gc8tZofPeBBdPFfPRXaVY8uMv2k/pdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCNRtleC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCNRtleC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba21d32776so65573515ad.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650903; x=1780255703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=medmHDQJvV2FcWBC8j+zjvPNWaeMYtRjYLXymq8T+6s=;
        b=pCNRtleCl42ZeX4YCaV8EjqlIz3pK2CFM+PGeUcoNxVsIrz+SjVcXnvNM7WX5o6FtF
         tSKMSnZVVxX0TRRkrdYe2NtcsoMysTt7YABYb7s2Q8aoTu1flGUcf6Ex019jC8scsfRV
         iFQvrpI5PegVu3BBw9gZpWp4lmAm4cpbHbX1rgf9+7B/mSnpqecAiXtrLpbm2yJ8PlVZ
         IJAP166bXwto08SUGi8//sf2jTmi0pgE5HnUjcXBrRhr5YucPlaL24fxcoT+bnmxmhca
         gLw89UznUD5sJKq/3ZUBSVoWUYMpyFYlokY5EmoQFY7iF9pKgxgIsMDh8rGXJWXTjlKw
         5t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650903; x=1780255703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=medmHDQJvV2FcWBC8j+zjvPNWaeMYtRjYLXymq8T+6s=;
        b=BZwU1tJZdsavCrg8j0zstwQYv2z9QTryidS/oY+/U+vRBOGCyeP425havTuHApBbFL
         N5vfnpNQUHnoqjNWZ9YwvcQdZMKaWHTz9OlWOiGlVg96GkWnx/ZYCWPZDRLui0mLXmgn
         9bcKEiXyUC/A2RNukvlVGJe4yxRwvzixj1mi3BqS+HeBf96wTL67GM5r5mIXaMVI6rdN
         m9jRyNBhsfLDe6TWV4Ou7rfIZ976Ybu5sxoaVr0f9BZYMGxFCGrJhxIPqMq45C+GQTdQ
         HyMMbt46/5UXZOqb9M1Ks1dlbYUVJ3cZPN9lO2JqRUjnIJYSGhy86zNRzYkR600BZzYJ
         7Epg==
X-Forwarded-Encrypted: i=1; AFNElJ/KqxkTBPjw7TBJtArFYHf2fnS57N1dVl48gdsJ0avFilZO4M62Qji27zJ8e+wBJxwtSSmo7pBHxRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCvfK3PtHk0gG7E32zKB7hA9HA1oXwhkQwX9V0XiiYyf6UknP
	vMBoUu8B8tIF7YbjhKzVybt14PDYJIdc1eAGTYKqsy+nHHUuLOBR7OFt
X-Gm-Gg: Acq92OEpOYB8sUMTRbDvMrae9Fvizcay/24dbYnGTLfyGnEBN60/3d724vJIEtLkDHR
	R6aeo4xwsjSl2OopPZV5LdNAqXimTN0yulIddCNLjC5yjMB20dPIaQDUw0Z9lBT02qLqH9+69YO
	+QT0RFPoHyAMZwRzS30gHDTurg5tn7/8u3lOfzzOqHKIzorpCYDr1+QWKE+3Z/xAAqHvrU3jZeW
	jAWR18arDJJO/uWrvP4qmeq9Vl4ocWzONxj2slQtb2VTyWJZ4nHK1juIIM3akml5qjzciac+fHO
	l+1Xi7S9yIkgqie1tSMxHePBdKaV5uekjEl0GQcB7BGPDIiSIwG3vAZnW/cQpULishr8mh7u9W/
	qj6ltwSqPmWnpAYzxXmCYTxnmJtV0WbNtZA8JwrupPde1Zq5V8Tgj6ctfiNRdk8c54o7Mj/HYzt
	vwPnIK9MzSIsklAuyKrkdMNxHHeOVex3HVfkV+/RgNwzrji0L7
X-Received: by 2002:a17:903:3b8c:b0:2be:1db0:f166 with SMTP id d9443c01a7336-2beb0346484mr129345405ad.10.1779650902872;
        Sun, 24 May 2026 12:28:22 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:22 -0700 (PDT)
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
Subject: [PATCH v4 21/36] iio: orientation: hid-sensor-incl-3d: use local struct device
Date: Mon, 25 May 2026 00:58:04 +0530
Message-Id: <20260524192812.1196549-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index c7fbff498be7..93fce8510468 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -299,14 +299,14 @@ static int incl_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_incl_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret;
 	static char *name = "incli_3d";
 	struct iio_dev *indio_dev;
 	struct incl_3d_state *incl_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					  sizeof(struct incl_3d_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct incl_3d_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -322,14 +322,14 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				incl_3d_sensitivity_addresses,
 				ARRAY_SIZE(incl_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
+	indio_dev->channels = devm_kmemdup(dev, incl_3d_channels,
 					   sizeof(incl_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		dev_err(dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
@@ -338,7 +338,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				   HID_USAGE_SENSOR_INCLINOMETER_3D,
 				   incl_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -352,13 +352,13 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 					&incl_state->common_attributes);
 	if (ret) {
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
 
@@ -369,7 +369,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 					HID_USAGE_SENSOR_INCLINOMETER_3D,
 					&incl_state->callbacks);
 	if (ret) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

