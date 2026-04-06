Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589A306B1B
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462952; cv=none; b=guB/GyjiolLrgQq/+ZLLGzBzZm/fmHJGU7YvKUaQUIeY+RRHPTFsVASZd2sd9PY0n7IopjDv1qkgA6Rd4YDFLBpEXUOfYVpn3GPratBP3U/6WT61XQ+DUK9ticADYpuX/S1+/1ICvqzTcOSH5O9FQb9hY0PxA3+k7Hk8rsRmcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462952; c=relaxed/simple;
	bh=u/NbEkZKqHcYkS63Ubm7NmgdI+5+BWjcSYEk24oIQwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fn+IZV66cCylgOwt4+LZ9P30Wp5USSdyRBwwxQqlLGD9AyAd00V0vPo9zHb1JosdBy3KbK5TAo61m6H2qmGFjRsqWu9r1+Bu8K9IWpXtopDj3EGeQU0D591FJASxLh1ClJ+lNO51/ZwXE2aKVN56wXGH0+5waTVZJV0c8rV/lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn2B0Ifa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn2B0Ifa"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742723c863so2428108a12.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462951; x=1776067751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/7ec0UO3+S/ayxldfyYQuoWnFpVoh3m8YAbLEUE80I=;
        b=Dn2B0IfaaMtiDMJUv2xqsVwdVNtE2p0ujRXItQIa5SbYl+l+Ta/WTbVakZaHh5vU4x
         nnszTMnCXJ15WE+5nnGC4NgHORdCuO3ZvmdCubB9h409lvLwiyTlVmEFFBZPl56V9olv
         3TOsnEhJJbZDq41Pat1TOqYjBcT9eCbGDZm15hVu3gCkhoDWhr/fUvrEpaGIdp4umAFn
         BO2/afJJYIMthcNOzAVHULvxZF65X1us0k09za1WMJ2bhNaAdk5V66uFRRYTQi/lO291
         ilY//M17J57CkpTF5HG/dDikDI1Z9K41X+eCbBVykRLbcHkeEHc+nGDBkA7/MqIztgHp
         L1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462951; x=1776067751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/7ec0UO3+S/ayxldfyYQuoWnFpVoh3m8YAbLEUE80I=;
        b=rPr5Qh8pNVrAcPSG60+2Dj4ZRezqOasF6yedz2FqG9GsYSpNUcXiCrndp3MUMVRR3G
         akoVsCjE2e5FI0CHp4V5aumlmNBNBfL366fupFNbS9kzmeT8LayND1oDwRxnFRJYMTsg
         ZBMMxdpMzvXfPqV/BctEd1qggdedMehPVAQv8qOvnIdaM2Yh9SDLTZ4TAtDb0ocTkC/3
         O9hb0jiosOwXV4XZRmdfNBQoEASUmq1dJZ05KWAEaDsY2U6k4Ku+uy9UKmhtu0owVJA1
         0hMCw7oyKYGNIFdn/MA5m5IeWLWcOv7vQvIYc26EgCLUKbLUXPzBaH2QxBTTm4Kej9s8
         M4gA==
X-Forwarded-Encrypted: i=1; AJvYcCUH/cKmhCDH4j9WR7wGbXFTFFK4I77QIlZFW76yL1XozmnQVy7TxmprXchzdq/i3zj92yKosfEQXPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKUC9BP3mMbr6N1Sb0MMTaudWaoiIc8JKktmH9/mjSmGqzWbU
	lxIPjTg+gf6NDWNWMTlrepftCxeztoQdFQvXJzyEXTL+ti3km2MOb/uO
X-Gm-Gg: AeBDieu7+ZeKNoZJ4BsGXg1D/jwTa6D66Ha5Y5Hm7/DFRsXA/lpBF7fhmximeUtX3F3
	rjrzGI7IxgtZ+0UYDikrhICkYWVxi6HkS8he+F3C0irNhp1lv2F3i5f5Lby3662L4N3ElGLw35C
	0ui7DvAMoeC2lG+wrSlMEG4T2E/0tWgt2V5D8RwY2V1hvhCu0mCUlCCMH6WWKAZc8c3IMhPhD4a
	NWIsdTZQlugmIfkgERbpWRUZRbzEWwZIhZpZWsfd9k6MpW88p0nWQ7NK+NbS+CFyTt6SRtHt0QQ
	cgwlDz/QrzYFOLSu/EV/iIj2KVfV9hVruFqRJPIHE+PA4IxMpCsT53NdxZKLovEchqnVdUZFo/9
	aKBpZj23oUSEo4OJ0KCGlj1uaIUqM7ZvaWAYosiaWW3L6ywlxO/wPd9yZ4O7/ZmS+gS+2pDh7xa
	EEZc5qt4uYUOTfcbvhIubbaEd+4Fxs37umINz1jCeBXfpzAzobIAnoWqGcKkY=
X-Received: by 2002:a17:903:9ce:b0:2b0:54dc:63e with SMTP id d9443c01a7336-2b28193257amr126569705ad.33.1775462950951;
        Mon, 06 Apr 2026 01:09:10 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:09:10 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v5 4/5] iio: ssp_sensors: use devm APIs for mutex and IRQ resources
Date: Mon,  6 Apr 2026 13:38:51 +0530
Message-Id: <20260406080852.2727453-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406080852.2727453-1-sanjayembedded@gmail.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Convert mutex initialization and IRQ registration to use devm-managed
helpers, tying their lifetime to the device.

This removes the need for explicit cleanup in the error and remove
paths, as the resources are automatically released on probe failure
or device unbind.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 36 +++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..f4fc869fc770 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -510,7 +510,11 @@ static int ssp_probe(struct spi_device *spi)
 	data->spi = spi;
 	spi_set_drvdata(spi, data);
 
-	mutex_init(&data->comm_lock);
+	ret = devm_mutex_init(&spi->dev, &data->comm_lock);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to init comm_lock mutex\n");
+		goto err_setup_spi;
+	}
 
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
@@ -523,7 +527,11 @@ static int ssp_probe(struct spi_device *spi)
 
 	data->time_syncing = true;
 
-	mutex_init(&data->pending_lock);
+	ret = devm_mutex_init(&spi->dev, &data->pending_lock);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to init pending_lock mutex\n");
+		goto err_setup_spi;
+	}
 	INIT_LIST_HEAD(&data->pending_list);
 
 	atomic_set(&data->enable_refcount, 0);
@@ -533,13 +541,13 @@ static int ssp_probe(struct spi_device *spi)
 
 	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
 
-	ret = request_threaded_irq(data->spi->irq, NULL,
-				   ssp_irq_thread_fn,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "SSP_Int", data);
+	ret = devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
+					ssp_irq_thread_fn,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"SSP_Int", data);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Irq request fail\n");
-		goto err_setup_irq;
+		goto err_setup_spi;
 	}
 
 	/* Let's start with enabled one so irq balance could be ok */
@@ -553,21 +561,16 @@ static int ssp_probe(struct spi_device *spi)
 		ret = ssp_initialize_mcu(data);
 		if (ret < 0) {
 			dev_err(&spi->dev, "Initialize_mcu failed\n");
-			goto err_read_reg;
+			goto err_setup_spi;
 		}
 	} else {
 		dev_err(&spi->dev, "Firmware version not supported\n");
 		ret = -EPERM;
-		goto err_read_reg;
+		goto err_setup_spi;
 	}
 
 	return 0;
 
-err_read_reg:
-	free_irq(data->spi->irq, data);
-err_setup_irq:
-	mutex_destroy(&data->pending_lock);
-	mutex_destroy(&data->comm_lock);
 err_setup_spi:
 	mfd_remove_devices(&spi->dev);
 
@@ -589,14 +592,9 @@ static void ssp_remove(struct spi_device *spi)
 
 	ssp_clean_pending_list(data);
 
-	free_irq(data->spi->irq, data);
-
 	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
 
-	mutex_destroy(&data->comm_lock);
-	mutex_destroy(&data->pending_lock);
-
 	mfd_remove_devices(&spi->dev);
 }
 
-- 
2.34.1

