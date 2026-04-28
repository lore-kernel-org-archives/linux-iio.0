Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29E3CCFD1
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360593; cv=none; b=oMDkErslFrkXdwzqK4MjODnz3oEtPRA7T8t5Tujyd0wVNet78aCDmCsuZmk2hUYbN7TnOo6OFjWi4AnFwSb4HjfnRxc0Nv6Byzv1Q7zcKxtC+KvrXmv3GLcPeHbkbgyFl1VFTWbNDMG+KLLBAy6JlVC+8nc31Q3NS6fq+7R3+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360593; c=relaxed/simple;
	bh=uryhhlRphKgd1n4wD45cUaOiYlG/HjkTzVQBMWUng0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhu6Ut2ezPZOSpY4IVZ7HY7wz2EZdGVvqlAN4PUjr8/2lCWGiXiWXTwm5caqLUfBlbaCzYrFC36qzB+n/xQWB+5E0CzVgv0lmJj3paB0/kDFKJrGpMqsIRQHieRjHB2ydVYeEm+GVVYK03Kz0wBXlCyo3/j7elYasx5np0UCYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIrMXMFr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIrMXMFr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4609645b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360592; x=1777965392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwITqMbwp6QzGlwaxUEDOdybuRa9W9fOQK2n0k2YBU0=;
        b=bIrMXMFrq7yLU+t3CEg9YjfAYKjsSiBxGAq5QNe/xLsDYDBAE6pYnkr5aViC14uWa3
         BZ3z+W0EXnPNmouBYXVpvqktLNV4jDoFoClMrD4ScHRSW4U/+RqC3Gt9o5QaRTtZXDaj
         0G/oKue9R62TMUaQxQe0qAlkYrnDxdH4N14YAupA2pXzd1pq1cVa9v8geM8k3nTLJx3z
         yfyZTOusFpmjjzYE0P1AlRIwjoZ5fFokjHi63uFStb++ZBQkBpijwWyNYITMcoxSXJJA
         FqGKJDaIot5h8fWVLWIxplP+ly+AbcANAL734IWaWPSwbmF07pPIuBpcUEV6tyqTV8f3
         Oz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360592; x=1777965392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwITqMbwp6QzGlwaxUEDOdybuRa9W9fOQK2n0k2YBU0=;
        b=Gj+F/F8RXauLg2svzeTNubXBUYFxmHu7LEk6cYLAwpHbbz7tURjJj4c+Nx+C/7/hdG
         iQQ8BfI/UkMPbzSzRll9mFt7TAyK75cFAj71rzpCn4wd6n4zov6cAa/zlBmflgvloxUs
         CpCWdvZq7TUhSm9Mn55XZnZ7+hAUsFNXqvlL39566lWZ6eyppMgp9K1k7rUgExQ3dIgu
         o7peOy9/mxJ79GdNqT+fUW7LTBuzLsI8N+VIPJI3caVNAld2mwqaQisDS+PMhp2jehT6
         rMmHlH28GPYUAwRi2FxigrNbTdorHVQszkWaPTREssgJIkC8mKw8lPNX1Kjwhb65/Yl2
         OQQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9i7tq3T1pHQVEJJzBbhmNgGRZNMjp4H3VX4FEUzXHKAWicNnycXFRksFIl3OgxHsE5a2gLkJpijhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylr2RfsRRW63ToLnMrg8YZPkSXosYKlGdJHD4/mCnxCYO58gSX
	dGVCVHae22uJ7v9bJhpcUShItIjjXvgHZ5jIV10nLmL30shHVJaIKqGN
X-Gm-Gg: AeBDievR0rNB74MT/SeHZoQQQs/ceYjaP8Tady068n6t9hgfzQgiu68udj/VHTO7xjj
	6xkco8VUUsGzLbQfw+hvxo0QP2+w8dWB8elPasaOz4pEBjUtR2Vqxo7Ccm5jL0gLzVZ5Cn/1IoZ
	UGYe6MBdilQWX/w0+MdwbMQ35nYcU+EReBg/gigQlmVpl7PNigW45qPKsu8Rf8ZRndVSSl+4/tu
	gEKdSS82/GoSqK+xWhhCUBpmFBVp2pkI6cFdWMSfeZv+WM9ru3O353PSbLztXmMb01QhiGQXwkJ
	dWVfZWopZSWvdQNrSBEGFklcEOLaD4ySM7UlduTOGNscwxFz/qSiedL5fItrqTvdO7iFapCK0ph
	6o/XxHukpE3mosavwkZNk4g6mRT1xeo/F8+zsTd/75JMqqqdqjo9/7CgqGkOJUSZjRV9U5B76Im
	u+mcs3JMm6OTqG6JJb1nABFZqES3/M+lcowxgAgLSahJ3vafavHwM0X3LZ8ZE=
X-Received: by 2002:a05:6a00:1705:b0:82c:e1a0:3447 with SMTP id d2e1a72fcca58-834ddbecc18mr2199417b3a.23.1777360591936;
        Tue, 28 Apr 2026 00:16:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:31 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] iio: gyro: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:06 +0530
Message-Id: <20260428071613.1134053-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..fe663b19e902 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -354,7 +354,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -367,7 +367,7 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
-- 
2.34.1

