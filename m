Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93F39E164
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321453; cv=none; b=q5M/+W85cgkS8IiDRxMLs9EEaxcUuvUojqnAH/heCGGzCuFolcvRy7x15ZDZAHR8o4AISDRV1rrhroSy70uP+Vgp9FT2qdX9ZaRiaEdeR4EjApNUVzInHCsDATmYC2s1lXEoEgJKhbnuUz50WaXvP1RWtTOQAZ/XuNvut/EH8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321453; c=relaxed/simple;
	bh=qxh9mNsgMQ/xB4BxyREkiTMPAocgmkD2LnOzKtz8rgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiHkG8AkerdLVSFV69kmyYukRLlUN0PO/FD+epVO0iTLBhB6T74CXIfcIwFyg7TsMApq1XdJrO8bpl+lzUgRjg6LU008pOT1q/agoACuR0gAwzMTftrT4yfClBTXZF+4Oi1lnfc9BRlccxbpoxVbx/Nbq7krTYQpnj2JH690HQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDxVQZEp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDxVQZEp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bc85eda6b6so751005ad.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321451; x=1778926251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+/TwTgUKwpqbt6bnwp+kW260JQF+yfn7VRp15dRTeM=;
        b=LDxVQZEp7e57qhOgSLcHc/Fl3qjwOGKIZ9DLU2roC6xAjZlTcBQcJuKYwHziUrosBt
         Jk95LT1DSL0YeKGL43goVAP3b1KxQ4T5RZyoYK3x3UYznDs3erd+tuFO7+bSETK2HmCN
         1XMl/geYNRpQBr/mnUR/3YtNx3gsDtREkHpQzxOZDcLVvBjPabKWmbXlkn/HCZF7xZw1
         6ZcHrmzlGh/OnPDpQxhvjsI+3MeWiGwJNBGEbprMHPiKr4bJmjoYssfOWpQWF+FrTpC8
         Ly81iQBLpJMM3alVP2pAkMePUGp3UQQNKVuEqJ4PVY2WNAk0Weg9ulAjaWPspnvKQrVD
         eI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321451; x=1778926251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+/TwTgUKwpqbt6bnwp+kW260JQF+yfn7VRp15dRTeM=;
        b=RjBBzrHWHdqBnMC8f4KeyU7e9N2x83ZhvPN5YDwCcHuVNFjqf/tySSvYOSwkzEzFz0
         fbCs2jYV7UPFWm3In6BCzEQPlpbv1dyKQK/lKybcjn8/XCfmHlJjvKKwlnz+y8QJ0eyv
         lZ2CDy8QMCiGvaieFOoKAzQC1QGeA8DBXCUZum6Ib6Uamz76h4Ngsg2MMvpAI+ehjrtm
         3b+98EN3kwK4tV5nMtoG9N6R9/cKyF+3N954v8Uvb2qMrmDjZ+TRSbNc3NzKsmpJXsXl
         9ukqLUp0k31ZKxbBQPdBlAmJpI5Px3Ac473uu1psvrx/9NSQujtPHVIh7DJOyDJE2qf/
         zWQw==
X-Forwarded-Encrypted: i=1; AFNElJ84dEkoMcFVH+piG0ZgNNfweNDERP0Hf6JZPKDa3q1x0+KDuL4emy1iYjmdru3bxfDvOQHLj6hXN3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PmsxLC1wiLVRgZtikCXW6j/h5tXnFJaC1om78SWIjbUe++n4
	W2/ZPRh/sJ8ddgoIB6+KQGbo8Gry+XvU54rigEj79Q/4kVy71vle0kE7
X-Gm-Gg: Acq92OE4XjCIKwAgBNrh+9jl8TJ5EODVl3+/GX0tfGh/ehKnPV/FPlx8Lcb9oYM+REz
	D2WSdbl637K+Q+l2mOJUz6RZeIa/jbq5oI4pN6q1Y0qG0Q1K7MvOu8DWpCTAdFYE4qlfKIM7FR7
	p3MTTaocQ+ENMQGJqUcOW4yoOqE+cE5+EaMChaGq+vLephqoKhPMY5jSCz5iTLL3jhf4OTng3on
	MUyJXnhtPIsgByw9u+PrSY5rE02HXR0f2xG2nY8vCl637upb1xsJtu8NQ89Z/Sv3P6JujvEphxW
	/M/s8IooTWlG1HuK2eDgsqCMX5jRdYWdOSGDy8CzbV9nIWDcpuQf0CIODkDyJ76RoWwm2hJgaIc
	RtDKTh87ZsJPqVKqp65LqgI5/QDCXY+KdToBf8+XQ/wCXha6CE88HugmsPYkSaKAYLbqUGRpi/L
	APs6Sy9/dDos+lr06Fy+my6SnSAyMpx55YBnnLevYFengIBv9c
X-Received: by 2002:a17:903:2d2:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2baf0cf399emr67752045ad.2.1778321451176;
        Sat, 09 May 2026 03:10:51 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:10:50 -0700 (PDT)
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
Subject: [PATCH v3 1/9] iio: hid-sensors: drop redundant iio_dev argument
Date: Sat,  9 May 2026 15:40:32 +0530
Message-Id: <20260509101040.791404-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_remove_trigger() uses struct hid_sensor_common to release
resources acquired during trigger setup.

Earlier implementations required struct iio_dev to clean up buffers,
but with the current code this argument is no longer used and is
redundant.

Adapt to hid_sensor_remove_trigger() API change across all HID IIO
drivers to match updated prototype.

Removing it simplifies the API and is a preparatory step toward
converting the trigger handling to a devm-based API.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 4 ++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  | 3 +--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h  | 3 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 4 ++--
 drivers/iio/humidity/hid-sensor-humidity.c           | 4 ++--
 drivers/iio/light/hid-sensor-als.c                   | 4 ++--
 drivers/iio/light/hid-sensor-prox.c                  | 4 ++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 4 ++--
 drivers/iio/orientation/hid-sensor-rotation.c        | 4 ++--
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 4 ++--
 drivers/iio/pressure/hid-sensor-press.c              | 4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c     | 4 ++--
 13 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..a63dae90dadc 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -416,7 +416,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 	return ret;
 }
 
@@ -429,7 +429,7 @@ static void hid_accel_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 }
 
 static const struct platform_device_id hid_accel_3d_ids[] = {
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..28d050b45c74 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -218,8 +218,7 @@ static const struct iio_buffer_setup_ops hid_sensor_buffer_ops = {
 	.predisable = buffer_predisable,
 };
 
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb)
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 {
 	if (atomic_read(&attrb->runtime_pm_enable))
 		pm_runtime_disable(&attrb->pdev->dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index f94fca4f1edf..afec46ecbe71 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -16,8 +16,7 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb);
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
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
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..e580a2af9562 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -255,7 +255,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -268,7 +268,7 @@ static void hid_humidity_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..9b57cdced18a 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -432,7 +432,7 @@ static int hid_als_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -445,7 +445,7 @@ static void hid_als_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..473c45626487 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -340,7 +340,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	return ret;
 }
 
@@ -353,7 +353,7 @@ static void hid_prox_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
+	hid_sensor_remove_trigger(&prox_state->common_attributes);
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index b01dd53eb100..8be3dfe4dd58 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -542,7 +542,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -555,7 +555,7 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..56fd9c53dfc2 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -378,7 +378,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 	return ret;
 }
 
@@ -391,7 +391,7 @@ static void hid_incl_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 }
 
 static const struct platform_device_id hid_incl_3d_ids[] = {
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..56fdb3412fe3 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -353,7 +353,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 	return ret;
 }
 
@@ -366,7 +366,7 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..5288b63f4e21 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -337,7 +337,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 	return ret;
 }
 
@@ -350,7 +350,7 @@ static void hid_hinge_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 }
 
 static const struct platform_device_id hid_hinge_ids[] = {
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..2bf5d055e175 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -319,7 +319,7 @@ static int hid_press_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 	return ret;
 }
 
@@ -332,7 +332,7 @@ static void hid_press_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 }
 
 static const struct platform_device_id hid_press_ids[] = {
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..60d4fcc8043b 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -253,7 +253,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
 	return ret;
 }
 
@@ -265,7 +265,7 @@ static void hid_temperature_remove(struct platform_device *pdev)
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
-	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
 }
 
 static const struct platform_device_id hid_temperature_ids[] = {
-- 
2.34.1

