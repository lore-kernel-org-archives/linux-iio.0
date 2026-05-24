Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67E3148C5
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650922; cv=none; b=KPImGuQuJ0AxRhglJeyEucDcFsAVOB/b4IAXnIy5ytWLEZG5GCFb9aNwoXXePh/lMxDvrr/miz4bO6bMQcBJgyMqXuELjQ3i+x9wG2MknqhZTHyN6+0qWyyBGScpGTgqygyLpRVtFKreSHgHPSz7HbWzBFODciLs+8xs+iRK0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650922; c=relaxed/simple;
	bh=TfQM2n9PaW2LYOAzQm27yBOHRGkaZz7kMrQobQwrgFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQWIn3UZpKY+eY5KHbLfP+TG7YdcpELeoJdT9MPsIi9FCZtrgeX8iTBvp8wlsz8KfXkDnehi/MVsdlaDkD+rj3y+vzv03WRmgSgDz4RfnfVJNX6xyqgVYP/zLwisybnu3eHCpU3Cfz0oKaoKVRkSgjSxHH5o1sTp1C+IvHE+MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/v6N/I9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/v6N/I9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd80b3aa13so58856235ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650920; x=1780255720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBvjFC3BgJUK6/GWOaxjq0Cqy4r1fMLR1uyffKxup8=;
        b=s/v6N/I9v6z/OkcZEx+2gcqonIPwPWvBMz/rcD5dxSYXLMxkgBiDwwNfDwbITy2FQQ
         B1i1MA1SFAOQ7udFl1rxvUA6Ovb9VKLr9e1yAwyArnZpgsaSV1V+twVzPx9OyBwUinzL
         2ccFSOtE+ETRuH0TTCzzzX/M9PXRYTPEgRZ/VrBFaXqBN8DDWVgUnHfwcmNRxMXXc2sI
         22yS10S3GTEEuCnAvknu4UEfzpKBf0oEV9lNQGHzb0ziPXwkFpXO479chcAFkzLgXVia
         VUIR4kRGMHNX6oGD2HZ3oNe3kG+7E8vP81f+4KcA8tdx9+oJQA6qKdt6X5avJUNxx9GR
         azhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650920; x=1780255720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYBvjFC3BgJUK6/GWOaxjq0Cqy4r1fMLR1uyffKxup8=;
        b=IKIO9JzP9E27pW8mKWx0ty34hMMaK1Zm0NdW7C90NuuchzTCTOzRytgZ3x6sTtFuLk
         k2vwS3i3BMS/OQd8aLe9hM/KGf/E2yT5bxyAgjqRzRuELT+/XVZ8FgdnJ5FNFqNIw+9e
         el0fJk51gWVMllETTsZum28YWgJyBDDqm17oLAltEZ7BQiPEEUpBO6+3IKiItfTOyvCM
         meQObHY72phIyGeVrHYBb9dA30KnvNQvVQDqCJlGtdHzt2a1VyZIaP38eUena4T15mAm
         LBT9YyvlzyHGeTgl+OMm7cC/gyISX03G912NPZB2HDGbXCcYBQ6tBeE3SbtTaVP4s1uN
         DANg==
X-Forwarded-Encrypted: i=1; AFNElJ98lbFboJgV6UbX+DjGxH8V9zBn4dMiSrybt8ukesjzshQ3qB7IW2puqSd241OcXdYmYKCVtAcVDRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyuVHgsd1Aq6Yugwf904RlM+0LlpHV0ORkq6HyU6/rUONG+GM
	slIWPk6DtTK46HyRnIvRs4Fy6GGA4/GdnFMELs5jnKjA9DZ4J+GLH4y2
X-Gm-Gg: Acq92OHO3pgHNP7qgu2qDmqizJy0agw0nHeuauj0HaArSnKQEZsj/ahS8v2NwJPk/1o
	eTf3Bz/ppzkShtjPLyazbtt5tYbL1jMTlUT8feIvxbmzMpF4sib20DJ1l1cJpFrq+8wxq9i4ezb
	lcdOeuxrUGIlqiTjtm0scNSM/VvCa+ifBn1xd+WcO8aMBqhD7slaEKOCBN+OfpajshiQm1FeRmV
	Ci94oaZ5UFyDJ+Mvo9MyX1m6DI4F6J2bFxgh3bgsBV4baW576CQWph8noH1ZSrA0XYX3afLDvTE
	WwsRebpigcAvf/NYnCGu/Ul9SECE0GIdUGd3IEGFequHESJWwJFoFQey3wBvy+eo6/kVRvKDNbZ
	1SHGrfo61stD+f3ONysCKugYsp13VCSEgHyBRMPzTe6PcNPof6mSfb9bvIv523HY0VjwykDdqvt
	TTjxxdYSpS+p8l1uniY6UuTLFCDMerjXmIJX7+Aoo21xSmmFvF
X-Received: by 2002:a17:903:17cc:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2beb0722d9amr133066225ad.10.1779650920215;
        Sun, 24 May 2026 12:28:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:39 -0700 (PDT)
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
Subject: [PATCH v4 25/36] iio: hid-sensors: remove unused iio_dev argument
Date: Mon, 25 May 2026 00:58:08 +0530
Message-Id: <20260524192812.1196549-6-sanjayembedded@gmail.com>
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

hid_sensor_remove_trigger() no longer uses the iio_dev argument.

Remove the unused argument from all HID IIO drivers to match
updated function prototype.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
Changes in v4:
- Rectify commit message with input from David
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
index 561d9784d936..5b0978955f09 100644
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
index c8ccf96f3d03..98fadc61a68a 100644
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
index c891b1bb09dd..f611a10b92c5 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -356,7 +356,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -369,7 +369,7 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index ea6f66ce0f8e..d310ec43a118 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -256,7 +256,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -269,7 +269,7 @@ static void hid_humidity_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(indio_dev, &humid_st->common_attributes);
+	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index c84fb4cc5105..0af235d30800 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -433,7 +433,7 @@ static int hid_als_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 	return ret;
 }
 
@@ -446,7 +446,7 @@ static void hid_als_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 }
 
 static const struct platform_device_id hid_als_ids[] = {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 033dace06681..eff206d7b812 100644
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
index cf08503ff1ef..22c7b24e2e3a 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -544,7 +544,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -557,7 +557,7 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 93fce8510468..21a32f506046 100644
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
index 332d56757679..cd9fe74b5b30 100644
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
index 34c7cf734018..e616988fe9f4 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -338,7 +338,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 	return ret;
 }
 
@@ -351,7 +351,7 @@ static void hid_hinge_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
-	hid_sensor_remove_trigger(indio_dev, &st->common_attributes);
+	hid_sensor_remove_trigger(&st->common_attributes);
 }
 
 static const struct platform_device_id hid_hinge_ids[] = {
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index d85f6247d8ab..fee7dcb86801 100644
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
index 31ebfd1a1fe2..1ff0233d7ab0 100644
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

