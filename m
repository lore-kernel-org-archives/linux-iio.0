Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50CB403123
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866862; cv=none; b=VswpGRGbgURMZr0qKfyesa/XTyO6dXdYULuOS7SGNrl97n0mFo9/yp9m0j99bhQf8xJsc+mN+erJsfK1bQRruH7QH0t3PX6+k/rAlbqw1bsdwTAIxsTGXCGhMQ29Sv6pIyjV1eiEHEPj1wl8niF1UZThau/uTf/pnZgWhXXEkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866862; c=relaxed/simple;
	bh=+gNU/PzW/qiy8WZGm3AmwTeKihAe2oIQqarPGjmyA4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8HPVu5bSAOb8TEGZrFDPrpQu/BP3TI9+5My4tU0maP5pzSg6can7TAKt9wmRp4H8DnyfMeKhgn6TKtXFWTw82AzBFyPQVtyxU9hggiU6b+TBx8kctCpDZ4553932xgzqWukGa66SKPsRQqjKtUnvDbaxS5Holk6rkHGoz9/WPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anE8hDbH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anE8hDbH"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-835399c11e0so70759b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866860; x=1779471660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSF5lHJsM33tChHrGrFP0wNPuH6dLxO3ISGQ3D5XuKA=;
        b=anE8hDbH3PnXcO72MAZItKosm+NXR8qNvhv9a7dysGdN33f+g5IDkDc/RRglf5iBR7
         8Ht7uDIBpmKKubQuI+7s8twzXAWKuCWtNIxLUDGC+mOJydx4xjyXX6des67vvOBEr7YI
         1dhqupZdS6Q5GevdBEbSWPbQCNozZGcI18yo7hPRn96IzgcZ15Ue/IrvEdoaSkK4P1oZ
         0OGCJru8BKDx2VePaGJTMR7K1WSnOn0C99eEET9zBiBkuKLXotN36Npdq5L7msyTJw0k
         MPXol+vOjRfGdq4ZmGxnHY81wfTNsmtTJY7EeROWcnN6h6FWkLFKGWo0U/E+batSdry+
         Pmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866860; x=1779471660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSF5lHJsM33tChHrGrFP0wNPuH6dLxO3ISGQ3D5XuKA=;
        b=opwLFBFCjj8fqfM6CrabU2rDmYzKq3gAKgi/84CMxGhoyaQMf6ygmamsApUgxRbjzH
         CvjG1/KTwGokfa+17cjpCxEMezS9DelzefoQl4RqZWFblZ4HzLG/GVBHlabl5ZKZ4QjA
         dEl8dC7NoQceafKuMtTkLSqBPhSNzSKbj2HpvaXlDVxXPzgVAW4Je2KEJj5aXEEvboaX
         jQfzgxfbQvxhZDiEYQUlmLsVdeOJW4yivCrzDwMWFRfmdJHLV92BrUUcFeLaO5uVtksg
         Ki8Tag703pt6NI/9MjcyBjCXbz0sFNHJ4eirbSjbho8HwAPfwYOQc+hhyMhdYNyKsD7a
         RwZA==
X-Forwarded-Encrypted: i=1; AFNElJ84nU1xMbYLcC/YhPuHfrSqQoPdhMCpc92knU+cIMWup45ueg77tcG9j183bqfrXwjXskpF/ytcfds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6c2/5qTTbZkG3AtmBbvJ7FgPz/nNmgUuW2v4gR6E/kotlUw1
	EQFRZRXB7nwfHmtP0H7BzX9z3nLsLgRAUE+ZIpPRu3rosLhf7Xuump/+
X-Gm-Gg: Acq92OFcWUo2K1u4rzZm0G1hZtKYHZZXxkKG0lqgirVoIDXOv6m/9j/XansHP676f2O
	7n20PGXvktVs1blADdgmfMzGEH0B+CHQ+vLgMTNcIDfmXpEZScynjVROjvVfGGiW+55YxY6HSIn
	QRaX5MkdYyHClWU+3dkeyOmmFJzuwMRABsJ+URoAJKUPX9pmJhInK3D9W//vEb4NaG0DWHjNIys
	WLRhGcVRdD/3stt5VWPAl5jqYn5HdVIaU+pJ17FMNiGy0KKzod6UeiWT2m7jkcbdCEOTkgtAmLA
	HuS+5c1vEJV0xfiXFAT3b+Ob3Y6EUxPnF/1JKrKkhBzq37625K0K278FxySNEGEJZl4v1Nu9jcV
	KgC0GGGexcXYOSog5bqKdgaew6qEg+D+yzY4FJUwGOWddhdn0CeJOnH3Vkhca5rlvswlelpUE1E
	pMuYPoxyRAH7SFKGan9jyBOsQ1Jjsag6VaaNPx0PCaMnoR//1E
X-Received: by 2002:a05:6a00:ac2:b0:83d:b11f:795f with SMTP id d2e1a72fcca58-83f33d235e0mr5454415b3a.22.1778866859967;
        Fri, 15 May 2026 10:40:59 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:59 -0700 (PDT)
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
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/12] iio: ssp_sensors: convert probe and teardown to devm-managed resources
Date: Fri, 15 May 2026 23:10:13 +0530
Message-Id: <20260515174017.3962168-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
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
 drivers/iio/common/ssp_sensors/ssp_dev.c | 114 +++++++++++++----------
 1 file changed, 64 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 88bb8ab0cd9b..441416c612a4 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -199,6 +199,26 @@ static void ssp_disable_wdt_timer(struct ssp_data *data)
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
@@ -498,9 +518,8 @@ static int ssp_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-			      sensorhub_sensor_devs,
-			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,
+				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(dev, "mfd add devices fail\n");
 		return ret;
@@ -510,14 +529,16 @@ static int ssp_probe(struct spi_device *spi)
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
@@ -530,7 +551,9 @@ static int ssp_probe(struct spi_device *spi)
 
 	data->time_syncing = true;
 
-	mutex_init(&data->pending_lock);
+	ret = devm_mutex_init(dev, &data->pending_lock);
+	if (ret < 0)
+		return ret;
 	INIT_LIST_HEAD(&data->pending_list);
 
 	atomic_set(&data->enable_refcount, 0);
@@ -540,14 +563,23 @@ static int ssp_probe(struct spi_device *spi)
 
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
@@ -560,47 +592,30 @@ static int ssp_probe(struct spi_device *spi)
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
@@ -656,7 +671,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
 static struct spi_driver ssp_driver = {
 	.probe = ssp_probe,
-	.remove = ssp_remove,
 	.driver = {
 		.pm = pm_sleep_ptr(&ssp_pm_ops),
 		.of_match_table = ssp_of_match,
-- 
2.34.1

