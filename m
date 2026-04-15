Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDF356A08
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229698; cv=none; b=DLYrpiRRfWNM1gstkK+Usj7OCGOf0oJSrF1nFC68dVAstG4bowvF3QUHOJpQ1SVYPh95aPQdyFTdnJo4Kt9t/k0fDuPubjWAPyPbtB93ObkA4mBSOZnfr1kaE+o7r2pOVIPUMWTwGktE7D5FKQZ0sfA3lsPcKjW6jHmczorLWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229698; c=relaxed/simple;
	bh=LOhrsG8Pz8jrQhalvA+AyiSQI74st8YiwXNOTXJehnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkQvlig4yqXAA3vryXtoAuP44lyfckH0fJXq19v5ZKqiZDyfmxJm1HOc+35BkpW8amLp2S8fdqwbsx6V/MBjEeKTelQwYmXZjjmP6xUMPYGYMUIr/wL725RFPjCwHCb50hTP+8IbbPYkckv3UltX12Axa31gHC0BDM5wNJffirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkebxE/u; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkebxE/u"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so1308048b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229697; x=1776834497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv0u5blj3D1Jrxi3hUt1Z6abAjaZCmKIFZM6/uPjCsQ=;
        b=XkebxE/uaGNv949R4rAzEQ6MOJpComPJxtPxRFLIq0iQt2dCnXetVcHH4mG22yWdrJ
         OzEkX63VEanMaN2uwHgNs/pPU+YzoDeEDPXcQ4c+BLyFX1Z7iPsUh6a9nrd3LHgPdG2d
         8nze1bZK1yR2HkyHcjG8FeA/UE9s05fD6gqM56wVRwj4M4UC9vScb6V5+326VV0K0k3V
         YsNz4VLYSm/pamxIU2ZsIiiOJtnY1htDCn2JwzqSH6pcLRxSCYau746Xdgvyw1IGqLP5
         FxjJpkWDyZ45L8vQt0KoKtpRPg/poO/Z1SiPpW5Up9lIrvbYo403rotE83k+VtNv/ZqC
         +f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229697; x=1776834497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yv0u5blj3D1Jrxi3hUt1Z6abAjaZCmKIFZM6/uPjCsQ=;
        b=VEu3SetohXb8rcEO3rdpv3fk1wOVI2SE1O+1odjQnU6wO2wRrcP3jF6YCUoTlXCqv9
         u1vr9Z8QlZiiNGkGwWh8+Z5e/d9VPJTekOGEbP/oSLewlsMYY/uaoAPIjnSryBr4c6Dv
         QXwxbTi9IULRulp81g76dHvIIiWOFezuz+hUXtYEPAIYjpZ/9IpkMfq/EHgP/zvyrlt0
         fCKT8IRDkM3yjJxVx78i50HfCjQyeia+pg9S9TAA+5fwtpP8tnH3ogPAxO9OpyGwl/Dh
         nhrgEDkXTzu9WL+KRW8a3QpWVhovlEci2cktFIyENS9A4xet2SVAWRgQC7BsIurOF0ED
         wTFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WcEQXateEvvcWjWCnKtr0eKwGfG4FsEN/mP/BOf2WdmOzuNb1I0qJyj/8IdMrVj2Ifq/Axmvc/v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaS1kPZbnaBOakWV0tnpm6lAxQ2vvt8fU/Gf5fF1yt9VaEjY3
	TWZSPshUw78HMUh5UiqFpyynV/AFqRVAC+ihJ/awJUot7in1rYD2vocy
X-Gm-Gg: AeBDiesfBWkR0pKfY94DzOO0BA+ZFDKSdOXDfYQiKPt80GFsUNxqZxBTmy7LT/REnfy
	zAQHCAbCQeKOBrXBsMCh7kSLKZELENdV9FVySmr+FnNt4mKm4rZASE+WQTgDakGKWVkiYTv8/mi
	iz9pIh0yrG72FzTBOzkpi0EZ8n1YfPhbAxfJzrCtbqfa86gxWDsuqAwI8S8lYqyZNbDMBt5ZopR
	mgCR3c80CEcWEstwvcqU9nX8zBGMPnml7ZG0cLLdUYpH0lNNPKDTPtpK7rSb9cjJVfhZbikexdm
	K6d1XN2aqmzTLArVZS902/YoKMGRnnlqCOmGjhFS2R0y5HBxoPbchY26+EZNhvgkmtnAMtfenNI
	IHHm9lVmpD/34RlajYSvfyXrGg1IzkYr1G45y71TdFTSzKW+uJsv2A0VOVkhockEsMscYFGvYIt
	/YL1ZR2BVieKKpePverjDyf+/uZUYlAcmRPEQRcZYInZ4pJB6BUObCPMR7D4zye70oQ2Xwrg==
X-Received: by 2002:a05:6a00:12d3:b0:829:7e6d:cf22 with SMTP id d2e1a72fcca58-82f0c317a4emr20911335b3a.43.1776229696674;
        Tue, 14 Apr 2026 22:08:16 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:16 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] iio: ssp_sensors: convert probe and teardown to devm-managed resources
Date: Wed, 15 Apr 2026 10:37:47 +0530
Message-Id: <20260415050749.3858046-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Convert SSP driver resource management to use devm-managed helpers
and devm actions, tying the lifetime of all resources to the device.

Mutex initialization, IRQ registration, work items, timers, and MFD
resource are now managed using devm APIs. Cleanup logic previously
handled explicitly in probe error paths and the remove callback is
replaced with devm_add_action_or_reset(), ensuring correct teardown
ordering and consistent behaviour on probe failure and device unbind.

This simplifies the probe path by removing goto-based error handling,
eliminates the remove callback entirely.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v6:
- Drop remove path completely using devm_action with review comment from David
- Convert MFD device to manage resource along with mutex and IRQ
- Link to v5: https://lore.kernel.org/all/20260406080852.2727453-1-sanjayembedded@gmail.com/
---

 drivers/iio/common/ssp_sensors/ssp_dev.c | 88 ++++++++++--------------
 1 file changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index cb4c26a6b76c..94ecc794f926 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -194,6 +194,16 @@ static void ssp_disable_wdt_timer(struct ssp_data *data)
 	cancel_work_sync(&data->work_wdt);
 }
 
+static void ssp_shutdown_action(struct ssp_data *data)
+{
+	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
+		dev_err(&data->spi->dev,
+			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
+
+	ssp_enable_mcu(data, false);
+	ssp_clean_pending_list(data);
+}
+
 /**
  * ssp_get_sensor_delay() - gets sensor data acquisition period
  * @data:	sensorhub structure
@@ -491,9 +501,9 @@ static int ssp_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
-			      sensorhub_sensor_devs,
-			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
+				   sensorhub_sensor_devs,
+				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "mfd add devices fail\n");
 		return ret;
@@ -503,14 +513,16 @@ static int ssp_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to setup spi\n");
-		goto err_setup_spi;
+		return ret;
 	}
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
 	data->spi = spi;
 	spi_set_drvdata(spi, data);
 
-	mutex_init(&data->comm_lock);
+	ret = devm_mutex_init(&spi->dev, &data->comm_lock);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
@@ -523,7 +535,9 @@ static int ssp_probe(struct spi_device *spi)
 
 	data->time_syncing = true;
 
-	mutex_init(&data->pending_lock);
+	ret = devm_mutex_init(&spi->dev, &data->pending_lock);
+	if (ret < 0)
+		return ret;
 	INIT_LIST_HEAD(&data->pending_list);
 
 	atomic_set(&data->enable_refcount, 0);
@@ -533,14 +547,17 @@ static int ssp_probe(struct spi_device *spi)
 
 	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
 
-	ret = request_threaded_irq(data->spi->irq, NULL,
-				   ssp_irq_thread_fn,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "SSP_Int", data);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Irq request fail\n");
-		goto err_setup_irq;
-	}
+	ret = devm_add_action_or_reset(&spi->dev,
+				       ssp_disable_wdt_timer, data);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
+					ssp_irq_thread_fn,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"SSP_Int", data);
+	if (ret < 0)
+		return ret;
 
 	/* Let's start with enabled one so irq balance could be ok */
 	data->shut_down = false;
@@ -548,53 +565,24 @@ static int ssp_probe(struct spi_device *spi)
 	/* just to avoid unbalanced irq set wake up */
 	enable_irq_wake(data->spi->irq);
 
+	ret = devm_add_action_or_reset(&spi->dev,
+				       ssp_shutdown_action, data);
+	if (ret)
+		return ret;
+
 	data->fw_dl_state = ssp_check_fwbl(data);
 	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
 		ret = ssp_initialize_mcu(data);
 		if (ret < 0) {
 			dev_err(&spi->dev, "Initialize_mcu failed\n");
-			goto err_read_reg;
+			return ret;
 		}
 	} else {
 		dev_err(&spi->dev, "Firmware version not supported\n");
-		ret = -EPERM;
-		goto err_read_reg;
+		return -EPERM;
 	}
 
 	return 0;
-
-err_read_reg:
-	free_irq(data->spi->irq, data);
-err_setup_irq:
-	mutex_destroy(&data->pending_lock);
-	mutex_destroy(&data->comm_lock);
-err_setup_spi:
-	mfd_remove_devices(&spi->dev);
-
-	dev_err(&spi->dev, "Probe failed!\n");
-
-	return ret;
-}
-
-static void ssp_remove(struct spi_device *spi)
-{
-	struct ssp_data *data = spi_get_drvdata(spi);
-
-	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
-		dev_err(&data->spi->dev,
-			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
-
-	ssp_enable_mcu(data, false);
-	ssp_clean_pending_list(data);
-
-	free_irq(data->spi->irq, data);
-
-	ssp_disable_wdt_timer(data);
-
-	mutex_destroy(&data->comm_lock);
-	mutex_destroy(&data->pending_lock);
-
-	mfd_remove_devices(&spi->dev);
 }
 
 static int ssp_suspend(struct device *dev)
-- 
2.34.1

