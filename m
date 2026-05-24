Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E886318ED7
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650934; cv=none; b=bxoQl8opTwUvYdacIybtJ+t6fj1GAfhiJ1usPvVkvqeGuokP5UUYb9a6FuKMzQmjttdeKZJmrmGf2ysCgATnMmPHiw/Jq3lRnkBEIzendZZSOSW3y+erjPbaQ4InwrgQOKz2M6PujAz85zeksBIuuXzlaixK6W3ZMI8qhAikzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650934; c=relaxed/simple;
	bh=0TeL++3UJYh8RLps4BqCoofL11n2CIBy+tN75ljEiy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcEmRA+A3I0CVTls+E7WH8TkOhptIzzKwT/AAgSHGRVmSaclVis1uv+TdCrra0W2CDyXjkN3Ahi0PunDy8Y15oYt7P0HEFL5oFxlHlPh9hJcVYu7y59a2T2xsrwdkUo9QSXBVsRibeflNKIm5t6ifjaBsTHNEPIT7/6G+BqNPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltbs07Z8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltbs07Z8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso101524455ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650932; x=1780255732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kv+Y14gg4HOhmAsiDDylBeeyljXLDKBzGY99uU7KRA=;
        b=ltbs07Z8RMGzUg5tKCGeyKMnzqnhnn65kYVRzVNlkhTlXE/f8jlKFZm84NKZgzqO87
         8TLQJjT7Uz+C2EfcSdW1Yzg8beLgmET7DmUf2VlBnYtp9XnPldD0+KdP56kUNlPOYOGm
         ahHVDVlqSQhKy+W38fM40yw5zwvh8L+bukrCrgHkY/e3tEEVOy8ogEOHIR9WUNBqDqyK
         asdexBQRNoxxiWWQ1KnyS4KK7WmYaJxEXCGmabE263RK9XA5aplwr4PXkdkC2L6i/g0Q
         ekkHw2Kp8KWU++zeaMmChbPuc/eu6DiYY7kVtzXhr2bs7q0G/z2svNm6bHAI0573TW0l
         IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650932; x=1780255732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kv+Y14gg4HOhmAsiDDylBeeyljXLDKBzGY99uU7KRA=;
        b=dLu3qwT4I9e7PHP2/GREigIw5EzeTNlULTSrlLzMmbkl2QbBdb+iU0rDjxv+1yrqnt
         LNyhxb4LSllwxYV3HkAe4SHV8gCej6UrPBweNFARNBq/+Q+3hCVKAlHPU94RR++g4TUU
         F6DnyoFaK7/rJ+atYh2lGrmRTTAMB3S7ozZOeqCnfC2H05AFao2ZE6VwxgE3cFH8l6rR
         /lblAA+UlGDYbFWLdu1VJQVmI591IIh9I23vPEkx9/yLZPTRfwX2PLsPuEv+acl2XiOx
         ke/qDQfCsLLIFGAz3c75dRyNJhspezU+HHoSxDkhVAXILnS/2L2p7T5UQ8mEsAoIS7yd
         SmGw==
X-Forwarded-Encrypted: i=1; AFNElJ+1d11GwP9BW3Irjdn8v2PUbUNizAot62p1Nr+BOo91R9atIvEaCa1uMd6meMBtXYfJgV0VJewU1xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZMkl1YWmuTPs2F14QR2NlHYla4db+ReX20VUE5fyVQ7WTFxC
	nGnu3fz06O3BQ7oiJpS+B+nFpdL+lzNrzQFWWgsJwJ6daCRvkC+cKZemqOEPgA==
X-Gm-Gg: Acq92OEoyBpf+VazAl/CdWzrjC2NkoCRS27KxrSzF1EeNprhCCY5badz2J9Yk5cEHSS
	mijeZTDh85vD+ADKQjkx9wt+/62TYHyzuabu1R6ePJsL1AcFW56mH/55LdyyOMCHjiAYdsaVO9e
	1s7lIppIrQrsStlJASuiq7c0Jr/Tiiz+wdpG+ayULilmL1ntpk2cN16fBLWj48F/BuZytv+qawz
	wATsNmsUMTR6phTq1ke7GJJmVzK/gI5VP4cmIU0wGpSEhdNTftDHw+zO1wh7CXcNFbtfx5kjMHf
	H3YqzBSVpE+3Gj0A0p4sxOfK4GL58w5A9wtsWObY1TAx1GVhoL80yMrBSyKkd97mheWz01DszpJ
	+ZGnp3GEGzvcmvXk2eKTq1Ezv+05bmhbK8PqTxyypQBk8B2ahy5Z6oY3eSdp1HMYi7YlpOHlJzN
	h1sQhijR5dwe2WaVmfxX/DASinL6TyjGMjutytQ6k9lVe+F0RJ
X-Received: by 2002:a17:902:ef11:b0:2bd:d7b5:83ed with SMTP id d9443c01a7336-2beb07001camr138411225ad.39.1779650932544;
        Sun, 24 May 2026 12:28:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:52 -0700 (PDT)
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
Subject: [PATCH v4 28/36] iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:58:11 +0530
Message-Id: <20260524192812.1196549-9-sanjayembedded@gmail.com>
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

Use devm_hid_sensor_setup_trigger() to automatically release resources
during failure, unbind or removal of driver using devres framework.

This is done in a way to simplify the setup, remove goto and avoid manual
resource cleanup in teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
changes in v4:
- No update in change, added Tested-by tag
changes in v3:
- Update commit message based on review comment from Andy
- Based on discussion using parent device of HID platform driver used
  with devres framework for this driver
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-5-sanjayembedded@gmail.com/
---
 drivers/iio/humidity/hid-sensor-humidity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index d310ec43a118..4d4282e4b6e4 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -234,8 +234,8 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -245,7 +245,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
 					   &humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -255,8 +255,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -265,11 +263,9 @@ static void hid_humidity_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1

