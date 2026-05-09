Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667973A0B3B
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321469; cv=none; b=k3L7PltvL8ERLHjDv4lMEY8MmNLzBdZSat0W8uFtR2pS+2D6Mo2nBmXhx63ModT7Y+PxNmxOHtI2LboMuAEwamMMGzk3HMvMBJPGnHLUf748Rmlqour8zP3W4FFHf1rnnsF3pktVrsdLBpA+aNfpxw4VKsgqjVF85+7EVxH588I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321469; c=relaxed/simple;
	bh=OXbE0hHG264Jq5RuBE0XlsR247e4tE58gxyxm5gN62M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bcF3b5GiRzdMlnsZm9ebTr2aGa54SAUprCJkz+ASAhAKn8MD7q0CT8EKh2RCCenBCUedZJlKKJn2usjgR28UwLcuGHiODwyMR5I2XibFJHCuwG4AGGjv/20g4eFTZqSzlQeFjhEcmv5N0dWOQ91nKq1IHCgMzdpno04IY6UrHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUygEjOI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUygEjOI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bc763e2ba8so2094945ad.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321468; x=1778926268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EOX8xMuI5acwbxKOg+QC2TTMrkRYYm6GWsY8rfp+3c=;
        b=RUygEjOI5CWh4K5d7GTulc+D/7vP0cIsNNe/HMo248buNJIM3UBm6oPG/bamQxvibS
         maAIxwaqQOPWy1ztrLC6fnIEfLHZ9ZbQKNTyEev+ZnSkEcW0wrhdk4G1VMwoAigiYseE
         iY6PwXhDvlNF17vGy6bl0QGNhkoHf/ImUGHQwIRL/wflV78fPdlodxK0NrCB2BIIHa1f
         mw98U6Tlb9f05OdE5fAjnyAILwFn9ZUFoPJotDxu/Zvx5cyNDJY/hdO+PYgoHaCYbvV3
         17AGRJazsdzfylyDcCdtEMiAhygJ/xbSmJGnuZiKtLrEFP7fz5OXw523M75JVgpq/mgm
         WSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321468; x=1778926268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9EOX8xMuI5acwbxKOg+QC2TTMrkRYYm6GWsY8rfp+3c=;
        b=F0mnR3XowmX/uHSwbhTw43fdpP/fLM+N2YZL+4nsPZJRMYrt0bv/KiNgx+nhe/BoyZ
         spF9FLWYl1nWV3zPl0ZX+UZfihZEkh0hnY1GQKzns/TM0uSHQd1Y0XunNRiNymyOAihg
         xehsohqKbRAML27gQSOE5oFtE7eELSRNICgrw06ddXgZ2QZiWtscLXQwv7GIEPySrEZN
         vFFgkmOtafa7vWd8W5BtpJk3z+dKMDzh7mm2NwC7C4ZHY1lfEmkDnV5DzeFKmK0Qt6s5
         kY1upLIVo7eiVuQaOcyp3b4x7h9BB2dkPuKsonCJdf/h6Pc3ehzuH9RgOa31YVVHc2GC
         rYGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K77sAl7XOBQ4uX/Z8MlLFVd+yH9vDA/qqsPZ/LY67HTHJKiV5SD2nGk0rBXk9Ak0ESFdC1bdt7xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbz2XnTs1Vr+c4h9AblfkKYaNsTwCAckOOfKhwLh5TTXYJHdH
	k1ByF6EcyMGOnbSbtpCNmbq2kX5sUO8bsQsSaoEX2/Ts4hZV3qzWJthS
X-Gm-Gg: Acq92OE14STpbIcQaYuX8yJa8CnGBUPdzkqwvebMMCWALyI3CDPak4hb916hzHv3TkR
	JK8QchRCk1eEewWYeu+CYQqkJ+xXKonBiIYhd6Sx6OIV5+4ADMrjgsKuYJQK+lKOHcV+K27O2hX
	mbgERPrW+HFdcJvLrENTLSE/z6QOCsPcW0+KVGUQP9ChejpwGV66AA2EI7E1CQdXgLdQOJo0Kr6
	O9TAkqRt8/cXwSICXI5fTVh2BI93HQCfVv3nUdyBYHc6mrJSkvhnKU5YiOLGW1C5x2iLTfHNFGH
	jUO5C0wOq8E6KkM+GABm6KngLTkK1qNI/9rudmFNL0IKEGIa307nNo0hLNsHz8xRxpuV3VM07zc
	WRiEWwmoIVU4xpo5OhFvh6YgSfCu38Bjbpou60aoqMsvFq2NakbNEIUzZIY/Mm44skPPsw38BsK
	sBehDqAWA/wjkmCmJzzjeNVimzksI1l4CwGSysPdqWHLbsl6MK
X-Received: by 2002:a17:902:8b84:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2ba7a343404mr117379655ad.37.1778321467655;
        Sat, 09 May 2026 03:11:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:07 -0700 (PDT)
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
Subject: [PATCH v3 5/9] iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using devm API
Date: Sat,  9 May 2026 15:40:36 +0530
Message-Id: <20260509101040.791404-6-sanjayembedded@gmail.com>
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

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 87537f9c58fb..72e7db8ce3b2 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -326,8 +326,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&gyro_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(&pdev->dev, indio_dev, name,
+					    &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -336,7 +336,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
@@ -353,8 +353,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -363,11 +361,9 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
-- 
2.34.1

