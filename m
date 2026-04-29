Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3841B34E
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485583; cv=none; b=tuP+T7UZal9P7lIaeaT+ZTuEktThkf1UjzkVwq2llKVgWtqnVXo4MJnduCstuO93y9Dg1NUekbK61DQ50l45EU+AO4q76OskX9pRSO0KTivgfVdjAVnYEWp9TPjJgm5ws66FNAfXdPPeiVBLpACnAAVl1aF9TZ8ILGra0RlCNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485583; c=relaxed/simple;
	bh=8/qcCYzSJnLBTmLbTEfDHsZdZW0SMDQHR6QOpsBp21A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch6K2l9TpubI9wK96VUaYPabBrofp7w7M2ZZFIJSYxmuEWyhrK/+aWr7akrSzvo3OtkZgK0+1qOgQFuRKIjnQZ5uT8yojR64fq0I8SfELyM/p44rtTPHiYrHnwU1DUrJGZ+rKYP4NHRnG/EHuKa8qi8mWgxbxozCSzI2Mbs0O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD85aaFp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD85aaFp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so447545ad.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485581; x=1778090381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeZsajTGzir0DsezoA/yBicvjNkqNZfG5BhpGutw1+U=;
        b=YD85aaFp3w0TzcutfWGwDFRDOVpi9vVqd33gPHfntHYCaGt7/k89mDKusYx+8z4JPq
         4RISz20+2Y0oSDmjeXNAji8pJEHbLEOAbdsuqgOhKyNthcyUTZbfLtMoeD/BnHdz1jZa
         2CfX40p8SJvfK6FUb1XozkAbmzNmIBZdvNdZtCCpFqRP4Q2m/nwEEk1uLGt+Rh88l7bl
         FlBk46kr2vS5JkenC5osiPD/wrW1K8DnhQMu+mQItVkFTHsgdIWL6AbNIOlqUHBRX+RR
         OQI8XmOux+QuchBrliOChlsaZ1WDqaK6sKi5Sd/BJUvBrrCZFo9zcnPYC1UuK6aSLLXa
         eoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485581; x=1778090381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeZsajTGzir0DsezoA/yBicvjNkqNZfG5BhpGutw1+U=;
        b=X1cn4JfWA0P6XUyzb6mZ5bvtQtI/blKJODCl5UYkmeUfpznHkPqsc6ZwMziBTvlxfG
         Yy6nkfUnDkO/fplYwGkvo+vIzWSSI1gGkaFW5H+wHI7YwwqZYC8/CArBFH5rHtEYjCjM
         2HF22oP6p12Tz2maYAjpWPkx8ibgrKmsEVy3awnfsK106tROpe3+pG43NzYbZLZrUIZL
         BOKY2i/1m0n3qx8IQzip/JpIfft99ItI3xy3M7SHnuWlZ17f4Tn0vksKY11a1KpAk5vK
         Jpro6b2ceJCra4wleBqNazmGtCz6seYYSXgGQST0PrkS34AmEhHlsSim+DSrXreDI80q
         BUIg==
X-Forwarded-Encrypted: i=1; AFNElJ+WTTyKWxzruq82/bhOLZTegSoupUHTy3cCFbxx3F0r04quVQQvdHi74mBmTKr+Vq5HbiFeXqXCrSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuTCc/7r4rUdbGxpK1xbKpXgDW2Mlv7rbNwKd9/70YDTklHVC
	2sJ+pAnp6kT9YZFAEcINuzpyJbGVg+fe0ZLzY+LcsPmPWk6S3kdvxQb/
X-Gm-Gg: AeBDies5tYPsx/QffxVGRbMRH7LtoZvYSPxEkc2hBEXGNt1Xx9JitQKvKT3CTmHXioZ
	xJHYemjdiRWyi9pcbRqPZMK1DzF2EJNP5V07LVv+S0swaf/PtlLwdJkneSMi5lYZZfgXUDP0H6a
	BoLL2QCUosiizEkFYHJKwh7XCvt2pLd8GpDLHG8jU0Xg+Y0oSLkdYFm6XS1q+X5IlnaSqlpkF8b
	Fq8F7zqP1SbPaXT2qmy8fsrjd51IjzpbTGWjJyykFtuzpfVJp2pCoOmP4uFQQECuNo6QxCDX95K
	+nmM5mrQYW7hZqSkOtdkeIB2ETZuUQzM0XvlX2IXbHBbmLEIJooxerRHLzmZRDptVbZEb1J0OXM
	NHevJxJkZ9fEKEX0/PHRUDnr4s6HPQKRcekh9g9PzwhMPxwX+G/7CIatVAgTaYcM5Og1hzkfQS7
	Jv8mWucQa4HD7MhBwjIWhcCDetg434+xr/f1qeYXpvZ61MoFpElB08LtJ0i8dpiaB13P5XjA==
X-Received: by 2002:a17:903:3583:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b987407cfamr41849745ad.22.1777485580899;
        Wed, 29 Apr 2026 10:59:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:40 -0700 (PDT)
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
Subject: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger() using devm API
Date: Wed, 29 Apr 2026 23:29:18 +0530
Message-Id: <20260429175918.2541914-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
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
 drivers/iio/humidity/hid-sensor-humidity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index e580a2af9562..7ec8a8ba2b38 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -233,8 +233,8 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -244,7 +244,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
 					&humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -254,8 +254,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -264,11 +262,9 @@ static void hid_humidity_remove(struct platform_device *pdev)
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

