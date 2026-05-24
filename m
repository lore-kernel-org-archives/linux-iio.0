Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C77315785
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650997; cv=none; b=swlwqn8wCavjILmWmSHlTrIevno+BsAwHsb6kCtEXFoyeyFXpFhxW1SFxIpW8581oZZ1wcFLMfbSvwDzisBzZK9JhqDyjsN7a3K7Z0LWU6gzyZktjZPSxsbAQy4MYdTwQsqD1GQXxm/1mmDr30eXzzhaCTi+D4iLzUCnqD9O8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650997; c=relaxed/simple;
	bh=8aonlBzK6La32zoQta17/FxpJmctPYAGec2/N5xnkqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1VahGhy/xlgBOcTMXxaxX1vsdMqUne3It5b2Y+Byqd57lJZy0l4wN39WieJ6xyC2u63fo6sx/FOClz+Iim92v+GdFCecRczt0O91vunGAKNM8GEJmv6pDEQmKD+3OqwLiNpxG5BljlS2jpHQfe3Gu58/syTWOJVCo+rDCxlgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCpnWarh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCpnWarh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b4650d5f5cso36714645ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650994; x=1780255794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FkDvC/ErgcT2CVjGwqZhVxkScGNhYlOoSdsG0KrLjc=;
        b=lCpnWarhF6oXxixfUCy52LRXLqNlU8biw12HMHjCBHfB+0MlrItYAi4htcfxSRKyS+
         Ozb7AxL8i1LAJem/4SclzZx0TQIxcduyRMp8liZ9saLxQf9I6xWl+u15iK42TC0JEieG
         AoHm85swwvbMCtVjfaqrp1IQTd7vpUGQCT3c0g5RX8GbYpTo5wpkRIKGyGdYjDPFIFyk
         fLaUZ6qeIIWLXOG+x8LAH7VMX0YICzOFNnwd87WRkUfpX5nR1IfefLSgixc3smfaD+rz
         eD+xHclnUgIooadjIhjri8xk+OmRhNPOVK8yBJlrhdwKWCil0QzU5ni4RmfzSmykivix
         lEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650994; x=1780255794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FkDvC/ErgcT2CVjGwqZhVxkScGNhYlOoSdsG0KrLjc=;
        b=U+iR1s8uGdhnlsR/zbEyZKRKWNP1N530tVJePj8Dr/tt2oUIyojElWIMYpuW6EmAd+
         uKgNKdrx1RakwTEP1oiEExA8TUcGHEaKiwiE5VINvKMw8IF6z39AIGF1eSFnF6UYoK2q
         CHqOkNJFZZ9xGBuP4Ec1i2LPNaQUbFF5jwju1533Fwwjm8jPClqLs4wpbcca7iHris+6
         9cSWgfgTub7d8y6milshcz0Ti5YUxLVljM0TQfwSywFWf4iA8AQwwZZC3MkEXFMEOzdE
         DT/aWbnQsoQACiG7e7gPzGdGOAO/Y5deYQ9HmsS1ckGjz5SLk4PGKoRs7RkYXZX6kc/5
         HM3w==
X-Forwarded-Encrypted: i=1; AFNElJ9OsZOhPQw0kjATVkQpdWmaN+s4azVtOUn84k/1ZtU6qng0zipbvMPiVwnZmQZRuFG+wvjI/B3rqrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyGS1eK0ac/DGjAAtAGVxqW3PzsSkUaTU6dvFKSRt9bCwzXYt
	M+23wGw7z89cJqqvohcufYaUQ0tSelFTvv+vrfWB64tsJZEcDXRuO5sW
X-Gm-Gg: Acq92OGbnJHXcrBliK3Mg/SAJXr7sFPLr/HI9apNQorQmu6qLEzmpkp6lUUq5IO6O8+
	oktudzhlccspXaVkFUEgSI/RKESbdhuc821XbEqNvCcjJ6zdFxBtTqI459lCMNXmX4hmq71zNfv
	Z+h31bPdGX1TE3NAFRcK2dC9/0/1BNQN+tUKkNGX0+7IEIsTY5BvqSbv8/JVCknN3v0oIK9vfpf
	kyWhYPmx9UBO3EWJZJYz7rPU1IzpKORpMTtquoCyXGsFIZlD2hd0H9K8iaJVToq0Bjklxug370Y
	flKz19JazIfwGV3EsoWBwUVPzuG6plNoUdBWLUVKhSduc+DJliG5Nid+NA5l2tm0SxrPG5vzoUn
	s9f9muOin03pKe7xMY6/N6cYy8YJPXk3TV4dmeHNrI64yxYbtuDJLyQzmvPFdo3BP+Uje7NyFz6
	S1VmXU4+XEDLfOAoFAIQvxknr6rQlCkXYgFF6UdQTnA6472F/r
X-Received: by 2002:a17:902:db07:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2beb0634c8amr135686415ad.30.1779650994470;
        Sun, 24 May 2026 12:29:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:29:53 -0700 (PDT)
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
Subject: [PATCH v4 31/36] iio: magnetometer: hid-sensor-magn-3d: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:38 +0530
Message-Id: <20260524192943.1196773-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
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
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 22c7b24e2e3a..3019de46731a 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -516,8 +516,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &magn_state->magn_flux_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -526,7 +526,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	magn_state->callbacks.send_event = magn_3d_proc_event;
@@ -543,8 +543,6 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -553,11 +551,9 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
-- 
2.34.1

