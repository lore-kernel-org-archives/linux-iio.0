Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB122E9757
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195077; cv=none; b=odOrY8RZg0Na0BKRcynj9yF92+hH+E55Fjchtw5lG/XQ6BaEFBHu/o+HNPiITcEc0RFQPIB1MxHgqq+rHqIMobE4uzwEgz9uFIw4oby2VpRlUHlyqabkm1pKPbAKdscpfo1pdFa/m/qalDlU/9ZLrkVA4B78o1aTg8ycvndpvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195077; c=relaxed/simple;
	bh=Tl9tD+ph9kNEON0ieUFN/yRGnWD83boxn4tOUTxDMCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbcG624r4fOIFedMom5Tb9FoHRRclvREP9hiQVxha4O8eI64nNQpMN/ujJjDGhGV82wyo3xbxQGaRKUXXkZ/UEpVxdFj+qcHAXZmhhSIseP2bm6pvkI/UyW68HTJSP3l7qyVKOk7TjfrQ9bprnbBHttG9mcmXEkJOif70upDw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+iw4C/G; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+iw4C/G"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3416554b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195075; x=1777799875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NOjVOegFQrtS3izH9LBynQBmkc3ptaz6NtorLHbOAA=;
        b=j+iw4C/GuWXXjyelWyqEYkpmcybvu7u6ItRQ2NtwUInyuVFpfqdU/ClCmZM/s9VV6I
         2lqJcx9lQ3lmYhHTWqS4sBYE9rC5Fr2O8etfISHZ0JTlXgt9R13wb4n+K3kZ5RumYccu
         aa5iQGVnwVJWr5SuVa90FCo0tDpGYmYlpMPCHJWDH9k3LIQgbwoNGBWJiOhSdMDvBl5D
         gn91Qn2UGCly33V83LHhuWqqTLNiRiDbUvu8HWRQtOcPcHxei/vq0Poftgc47UjHGlmw
         SXa0YfEajRm53GWFii2DiFdxPjn3A43c6xPqUoB2QIMxc4vkHQIEhynHzGF0cEd4uEF4
         a0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195075; x=1777799875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NOjVOegFQrtS3izH9LBynQBmkc3ptaz6NtorLHbOAA=;
        b=Tk7G8nDTj+yemD//LM8i2QSVMjGKRohdmdMabl5GBDIRt4KVwhZ/S7+C1oO7zgRgSf
         7TnuYMkwsMwfreFM30zAj7/sqpYTDFN14HFeE1Cy4+R/pDJYJwYl5QJFwg71Ejr6JrAA
         adobsspDqU2ohN/97Uv1lesk0KsldTVHXGDXgzJwI7NPOavTY8f1pUKhYjMZw7vq3XLS
         /lYBnSCYDbFX3nRnBMfN+bZzRWeOpr5qc6AmDAs3ruhealOniaincCAwcCadNRCeHXKD
         JsV/wSLfTNDL5XTH6yAdZ3gcn6qvwBH3FCD+1DCxVIIVTvOCktYNhHtQqTqVFcEJ/rQf
         fHeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/96WPixW/n6p3jRwiH3ckAkT4Q9YtrEImPpoLorxj9viQl5RlR2yfPEDTYVO6peKYcFZMTuJo7BFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWaT6b67H2SjHyFVPGCCrjdfsWPxCS8aWrDLKcHicvuGDXl7K
	tywOgzFKhS3eJfMTeoZBIetnB34TKeDTHrIaYT3BF0fPZ5h1r4yhp0jU
X-Gm-Gg: AeBDievY1Ou1Bhnl3+qPtSfUdvbp9cqOxrOHHx/w32UVJ+3v72AdV9AMkQpLifA+lC2
	ZNBKHE8yOVczDYQngEifsCZFLtQLY14GWBezjBO+IC2nPIsJzvB/jXkTzMZfsEgopMwZBWMzYPQ
	MQDReJ348/yFaIsvvH7xOn9MrkrXUbWzp29d13kP2CIXeA/r/5MWhHw6WUV2ZjcxCOLNUiDtzRs
	zwNToIEd/Edhmz4gHJkohJ3BT8RlMAi/1slRe3pxUbGLLx9A7o2Ud24SgCnCC6U4IcaPM2FLHiZ
	/fK9WTKblXimyRm2aie0jy9zqSQSD5ZswCEj+ebtqomHE9uBgr8a7trw9kyDtIZtg9qJZQm4RqT
	peWl2v4Uwd+aMCJDB62hDa7+S+nuuvh4UiTOIcqt10+Et2COOxIO1rrdTzSR6jRWI5fNCdnta1R
	lH1vVe2kACZh/0lyoyeYJNO+dymhbUDJZmVZs2OFVGw3vYzhhXX94UVWlVJxg=
X-Received: by 2002:aa7:88ca:0:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-82f8c976ff1mr40075723b3a.46.1777195074840;
        Sun, 26 Apr 2026 02:17:54 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:54 -0700 (PDT)
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
Subject: [PATCH v7 8/9] iio: ssp_sensors: Use dev_err_probe
Date: Sun, 26 Apr 2026 14:47:09 +0530
Message-Id: <20260426091710.3722035-9-sanjayembedded@gmail.com>
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

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v7:
- Drop redundant else with refactor as guided by Andy
- Add new change in series for local dev variable with input from Andy
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-7-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 38 +++++++++---------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 5415efc7bf48..22d26980baa2 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -517,25 +517,19 @@ static int ssp_probe(struct spi_device *spi)
 	int ret, i;
 
 	data = ssp_parse_dt(dev);
-	if (!data) {
-		dev_err(dev, "Failed to find platform data\n");
-		return -ENODEV;
-	}
+	if (!data)
+		return dev_err_probe(dev, -ENODEV, "Failed to find platform data\n");
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-				   sensorhub_sensor_devs,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,
 				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
-	if (ret < 0) {
-		dev_err(dev, "mfd add devices fail\n");
-		return ret;
-	}
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mfd add devices fail\n");
 
 	spi->mode = SPI_MODE_1;
 	ret = spi_setup(spi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to setup spi\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to setup spi\n");
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
 	data->spi = spi;
@@ -593,16 +587,12 @@ static int ssp_probe(struct spi_device *spi)
 	enable_irq_wake(data->spi->irq);
 
 	data->fw_dl_state = ssp_check_fwbl(data);
-	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
-		ret = ssp_initialize_mcu(data);
-		if (ret < 0) {
-			dev_err(dev, "Initialize_mcu failed\n");
-			return ret;
-		}
-	} else {
-		dev_err(dev, "Firmware version not supported\n");
-		return -EPERM;
-	}
+	if (data->fw_dl_state != SSP_FW_DL_STATE_NONE)
+		return dev_err_probe(dev, -EPERM, "Firmware version not supported\n");
+
+	ret = ssp_initialize_mcu(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Initialize_mcu failed\n");
 
 	/*
 	 * Managed shutdown action for the SSP device lifecycle.
-- 
2.34.1

