Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625831F9B1
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195072; cv=none; b=poSUwfj/lw5+10ph7w7MZgn69IgUi/YkFTqAx/2DItxzUt4F9v4ECOkc5dQMkRDUwfiTMXy8B4BNVf1lwprIpZKKbdPsBIrimcSlnsnM3eY/zVk7eVVbZW5PgXGk8cGXioahC/4pUD71PBxq7ZzrlBVnBMXK23dRffXIphV2WEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195072; c=relaxed/simple;
	bh=UI4gpJgvq80CY6ds7K4Xd3PFz3dFyLWx3uHd0iQGEr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWrwuQfKnNLdYm0eGhbG9iOIdMNDrRsdeTOEC+g7emMThDfbFZvwBJeO2UKoVJNKfNnpZ0xEaysggBKpt8/Jquv5h72haf3ub2xpyJneAF/2GO8zb0tQpyj5orAdAqtClxmYTMqQqH5eszwY/qvmWHfB6gYi/nfhh7Leh1I5RfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McENy7+k; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McENy7+k"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so4278100b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195070; x=1777799870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc1KBOhHJY+Esy8/gdy45qCEuLaCO98hwqmEBOIURLc=;
        b=McENy7+kmRLm/dm7yB8Agx6h9v5NJHXQ52paLOGNGzjs/jErg7qLABe6HQifkZfr6M
         jteeyDIP+Uj9AAJSYXNodRvbW5Oa/eHk5c/dWAIIhbFMyP27BUbTfjO6NFTdJ9f+dW4g
         p89Xw4AEvtAW3dVqEvS5M7yjQ1S8AViI2GSDMKmBtQZp9UXZiYvCSe/hx+s0h+S8dQkQ
         myL8lJZSDXoVL0Bo/E4By8W8PEBduDjkgxQrcxyMGkPgpO01KBtIKPlTIGQZUiIN/dr4
         nG8sMlbPw8eBnPCE5r1Q5TnrZdhEY3dhEjC0lEzLE3jbbFK1Gz8qq2rWyKr42hQ0jloY
         b3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195070; x=1777799870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yc1KBOhHJY+Esy8/gdy45qCEuLaCO98hwqmEBOIURLc=;
        b=JcS2uouU5BoCPasNMn0GaVhT61J8k39Z5mSLrrjaJ/uzpu/jwrQ1jd5we+F/mDZl21
         E9pSiCB05nt50ZjZd1Xeo0EfvAKAyP5VsC+Yw6bwGu5Y+IBkSqZE192TgLIcqYAYYK91
         ndtOTtQDGxjV/0jPr/4djMVOMsU3HBel09s3R7nGyIX6ladZPcfD52Vndr5tposgkwXU
         26VSKqnjeyIIK1to6hvei7LknSxSo8mx+JSOB9nmMWiXjuQ7TPYG4LF84jeG24/OeMWy
         fv5Py5BiPSbN8rJhR6Y6TUS3zeEab4qHgfWjD80PK8KMAIevz/JDSn9CczBzgt8YiiWj
         Whcw==
X-Forwarded-Encrypted: i=1; AFNElJ9rltjtYUOBE5q7Hu7Jd1GBlzWebgGaj7Uqernb5og9zJakLXPoYEO4sOOF1NxTcwIrgJjtb2wFtww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5J6YUJsTXkMVwibXVrwXijEeUEJmfRptAqrGUASwrCaewAvhc
	ce160cICz6jiaYllMHjGr1jIWmxmBUHE2OTPVuRtIVPtvTlM5QUUy1Do
X-Gm-Gg: AeBDiescpSXFBdCyt+ZSdc3OIhV+Gpv1Gkymu0OVHIaFItRgQWyUK8ITmX7PPm2Ff5U
	rLIcr+Tb9ZLb8Unv3WmGsDzEKUusqgMtzbLc+/j1ZaPsaVx5EIKKLceY1RuT4JDk0RbJ9wpTBG9
	N0BsE7bQh2bACK9pjTi8mw2HfODsrvwX2Ok6mh34puN8CXVaVcV7WHyMn20IB855+kJyxHY3Dde
	vFTn05taI6rdmpXsRkPa5wSb+/xu8QgKRCq3GXsH+NwGRtEpdRgcjZAeg8u3GxjRQ/5lo42wGwf
	0ofv0dSpmb0nt/+rbDgYXlZYllrUNdGSU0Q9TYLIHK0iotUXEXLO9jEkKZygXnN9rTbKkhkh4K8
	tVFTyP1ewLQ6ZEI+8kdg1z19bFwJqUYn8800DVNb2EgYXdbyI+1J3T7oKHtcAuaQf41Zykie0lM
	YXV6/K30K4ngCxNYnXApajHeVDCP2OBbeG47AJf+2dm71enuzG/JXptnj1hxk=
X-Received: by 2002:a05:6a20:2584:b0:3a2:cbd1:11e with SMTP id adf61e73a8af0-3a2cbd11245mr26262249637.14.1777195070188;
        Sun, 26 Apr 2026 02:17:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:49 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] iio: ssp_sensors: convert probe and teardown to devm-managed resources
Date: Sun, 26 Apr 2026 14:47:08 +0530
Message-Id: <20260426091710.3722035-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
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
Changes in v7:
- Following input from Jonathan, added comment to describe the managed action
- Keep it single line for devm_add_..() API definition
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-6-sanjayembedded@gmail.com/
Changes in v6:
- Drop remove path completely using devm_action with review comment from David
- Convert MFD device to manage resource along with mutex and IRQ
- v5 change: https://lore.kernel.org/all/20260406080852.2727453-5-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 117 +++++++++++++----------
 1 file changed, 65 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 29b17118ba2a..5415efc7bf48 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -204,6 +204,26 @@ static void ssp_disable_wdt_timer(struct ssp_data *data)
 	cancel_work_sync(&data->work_wdt);
 }
 
+static void ssp_disable_work_timer(void *ptr)
+{
+	struct ssp_data *data = ptr;
+
+	cancel_delayed_work_sync(&data->work_refresh);
+	ssp_disable_wdt_timer(data);
+}
+
+static void ssp_shutdown_action(void *ptr)
+{
+	struct ssp_data *data = ptr;
+
+	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
+		dev_err(&data->spi->dev,
+			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
+
+	ssp_disable_mcu(data);
+	ssp_clean_pending_list(data);
+}
+
 /**
  * ssp_get_sensor_delay() - gets sensor data acquisition period
  * @data:	sensorhub structure
@@ -502,9 +522,9 @@ static int ssp_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-			      sensorhub_sensor_devs,
-			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   sensorhub_sensor_devs,
+				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(dev, "mfd add devices fail\n");
 		return ret;
@@ -514,14 +534,16 @@ static int ssp_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to setup spi\n");
-		goto err_setup_spi;
+		return ret;
 	}
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
 	data->spi = spi;
 	spi_set_drvdata(spi, data);
 
-	mutex_init(&data->comm_lock);
+	ret = devm_mutex_init(dev, &data->comm_lock);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
@@ -534,7 +556,9 @@ static int ssp_probe(struct spi_device *spi)
 
 	data->time_syncing = true;
 
-	mutex_init(&data->pending_lock);
+	ret = devm_mutex_init(dev, &data->pending_lock);
+	if (ret < 0)
+		return ret;
 	INIT_LIST_HEAD(&data->pending_list);
 
 	atomic_set(&data->enable_refcount, 0);
@@ -544,14 +568,23 @@ static int ssp_probe(struct spi_device *spi)
 
 	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
 
-	ret = request_threaded_irq(data->spi->irq, NULL,
-				   ssp_irq_thread_fn,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "SSP_Int", data);
-	if (ret < 0) {
-		dev_err(dev, "Irq request fail\n");
-		goto err_setup_irq;
-	}
+	/*
+	 * Register deferred callback which disable timer and work after
+	 * module unloaded.
+	 *
+	 * driver should cancel delayed refresh work, watchdog work and delete
+	 * watchdog timer once interrupt is disabled and IRQ is freed.
+	 */
+	ret = devm_add_action_or_reset(dev, ssp_disable_work_timer, data);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, data->spi->irq, NULL,
+					ssp_irq_thread_fn,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"SSP_Int", data);
+	if (ret < 0)
+		return ret;
 
 	/* Let's start with enabled one so irq balance could be ok */
 	data->shut_down = false;
@@ -564,49 +597,30 @@ static int ssp_probe(struct spi_device *spi)
 		ret = ssp_initialize_mcu(data);
 		if (ret < 0) {
 			dev_err(dev, "Initialize_mcu failed\n");
-			goto err_read_reg;
+			return ret;
 		}
 	} else {
 		dev_err(dev, "Firmware version not supported\n");
-		ret = -EPERM;
-		goto err_read_reg;
+		return -EPERM;
 	}
 
-	return 0;
-
-err_read_reg:
-	free_irq(data->spi->irq, data);
-err_setup_irq:
-	mutex_destroy(&data->pending_lock);
-	mutex_destroy(&data->comm_lock);
-err_setup_spi:
-	mfd_remove_devices(dev);
-
-	dev_err(dev, "Probe failed!\n");
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
-	ssp_disable_mcu(data);
-	ssp_clean_pending_list(data);
-
-	free_irq(data->spi->irq, data);
-	cancel_delayed_work_sync(&data->work_refresh);
-
-	ssp_disable_wdt_timer(data);
-
-	mutex_destroy(&data->comm_lock);
-	mutex_destroy(&data->pending_lock);
+	/*
+	 * Managed shutdown action for the SSP device lifecycle.
+	 *
+	 * This action unwinds state by:
+	 *  - notifying the SSP firmware of AP shutdown,
+	 *  - disabling the MCU to prevent further IRQ activity,
+	 *  - cleaning up any pending command state.
+	 *
+	 * The action is registered once the MCU has been initialized so that
+	 * both driver removal and probe failure after this point leave the
+	 * device in a quiescent state.
+	 */
+	ret = devm_add_action_or_reset(dev, ssp_shutdown_action, data);
+	if (ret < 0)
+		return ret;
 
-	mfd_remove_devices(&spi->dev);
+	return 0;
 }
 
 static int ssp_suspend(struct device *dev)
@@ -662,7 +676,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
 static struct spi_driver ssp_driver = {
 	.probe = ssp_probe,
-	.remove = ssp_remove,
 	.driver = {
 		.pm = pm_sleep_ptr(&ssp_pm_ops),
 		.of_match_table = ssp_of_match,
-- 
2.34.1

