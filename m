Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A93148D0
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650992; cv=none; b=FwgInIByJ7A4DtolYbtWZiNLNPIfhT/554rZ5Hbgd2Q+ZPfkYS1uyyMq7ZC2r0TbeaFxgufG/hGEoW/LADyIv7FQ/MS3VXM9RAJ6wGXW/kh0pfNdUzCBtZw1pElSIS9wafhDhZ+50Xb5cUKvmrWgImk5OX3CpBzTXgk/4HtYB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650992; c=relaxed/simple;
	bh=nkBMU3oUCIG+gkk+3uSa8iE8bBpxriUGIogtHgv6Kzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haspCH+ljHvE/HljjwnbzxbQP9a3LcOSSaDIC7QLt34WxkOgXQY3OoA1Duc4WehUrXSzf6B/T+jR8gmWKc0JyxfIWpaJowCvJDGu5WAnG0TmCLm8aJelI9QuKTqCvvegRWeilPJrnO7eNssnVF8jw2Ev8vtdtbi7wttj/hDebOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InEM13Fw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InEM13Fw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b941cd869cso57231405ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650990; x=1780255790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=colMMYIBzsVvLitSa7NIWevX9bHxswKzhO4ixCpeLK8=;
        b=InEM13FwZkAkKx/CnX/IIMQorJzRoG5WFjVZfmsZQEO3iwBY0oAxPrU7cAkiX5xLLs
         D3TsZbcaV9hZqmKLy48eSxXWL7Y7cxQPreyL7YCzWxSHhfte6SoGwIOF/Y6+EKIiPHvz
         OD3VpbdecBieSOEp++rJlbPpMewlHMWjZAll76v0uKMyrOKsmBHlLpJQGtIE1k8AYbPw
         s3zGo43vWN622RgZOsD5w6YqKhRKNnyj9uXgNoqrJQrVHLZSVcDsh2cKMOOMT8YL46km
         +Hn8+OhEx5aKqQh1cuTSaWfmP6NgUlZGtwz6sGumRMuzPCSFm+OztpICJuQtjbwx9t9S
         bEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650990; x=1780255790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=colMMYIBzsVvLitSa7NIWevX9bHxswKzhO4ixCpeLK8=;
        b=B8iR0O14EjYFyuyMkb38NDXU2c3hs2POewM46hK6Zq8ELNJQoftFhDjQrR/Av++W6G
         2ng+0lnoI+YR69YLOK6umieCw7GElPrhipYiobIMXe+6S4PJ35NXzLgckBHVoK/ATE7Y
         iN18W3hzhuIMk/rctr7cxNfRLRLurXHkm0pm1dh14vRJhUOtZaUtv5ZVPpjKDkNZg1pW
         VbWOXAGXZLYduULfKlux47+3sdNkUsMQmnrgpCpOo9PjhztjHXmac8onIP8f5bwYCq4S
         s9NrIXqbEYeKepPo7YLIG5cFHFbYenlboDmYhIOONGBPNOn04zHZaWnCtELo2PQ3RcxG
         5Q1A==
X-Forwarded-Encrypted: i=1; AFNElJ+ox9Y/qSX2wrzO/bztEPamEkHNmrc+tWNsdM4L4pL7s1sDOWySsJPIOhwEtgh25fT+iRgVnUL5FxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrf4e0b/SRJeN1NydntRqtyaGRM36PynrwgCwdo1e+Il/NHTX
	x0wLSiLdNLz31p+FmiplmNiXbTtac1bgfJPk+ysAeD4ydODts2z5vxhm
X-Gm-Gg: Acq92OHgQOfCnyB7DH5RTkkbOEL5n0CBRE1Hvqyi0NsytX+FQSVnPZPWlOB2KP9ilfO
	64YXlcNQj4E8oekmj1qyR+3p1jcDR7MM8RcUTyyBFl3iVdC3Pvhaig3W9M7qm2mVm0qthjEMkqR
	sANFFZgEGVKRH8n3AXZFucc8CLS9iO5/1ZAKXb7w/zM1jiGbNajw/1jIJ1AhWg1dB9viWd+3lEF
	sVGPW9VhTpMD9rv32OBerNFM/FO9iltQgaERVWN41rwjdTG9pLQL6LJcA7HC0WCoRyZ+xkdk9s1
	niBCJpl2hkCVWeLb73hGouCG/bF9n23RyN/i1EHdKU2Dn56DmL58gXuvEGpliIvaIm5w7TZ2CzU
	v1QQL9IYF2sb7vVhRjOYRnzqIoEVPrW/fTFzd4T1zKwk92ZQI8Uo6oGZ7cb3kjMJb/TmVuUpX0v
	LXi0qEE8/lW9EejARpLwz9Xva6g3E5dWdsPd34lscjgLc9aMGtQwg00PSXNgo=
X-Received: by 2002:a17:903:1ac5:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2beb070c102mr126832325ad.38.1779650990145;
        Sun, 24 May 2026 12:29:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:29:49 -0700 (PDT)
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
Subject: [PATCH v4 30/36] iio: light: hid-sensor-als: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:37 +0530
Message-Id: <20260524192943.1196773-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/iio/light/hid-sensor-als.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 0af235d30800..2e9ed860c556 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -406,8 +406,8 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	atomic_set(&als_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&als_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &als_state->common_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -416,7 +416,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	als_state->callbacks.send_event = als_proc_event;
@@ -432,8 +432,6 @@ static int hid_als_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -442,11 +440,9 @@ static void hid_als_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct als_state *als_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
-- 
2.34.1

