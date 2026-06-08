Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92837AA82
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922444; cv=none; b=AqvecR9aR10CGH7gREOgRdOrsu0Pg53AYFbhq4JJuKbmuTOeKa8PTZX/vv4hHYwh5m6S4MxK5+8Kiie67w5iOWxEQ+qwPKaNLBAepiUZHnQI/hLJXHH/yZcYpanz1RQDt3ndS48B26g577TLXV2x8/dtww3GGwjS4DfbH5BLNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922444; c=relaxed/simple;
	bh=lGL7GSdtHRMI+HNvPwU1u33xrTAtbBK5lVOTzDJnZl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqkF6ZGAL4WQ/X/rTCFCYkjwU+bxh2O4MTTBupix1OiUw+bpKna06cTJgMARdmpJSNXFRb7qWABK5gOQSUlwDW6Wlxfik7SjL26Rb6juBxHHIlJiA3Tj7/YY6WSZ8TELM7r2Qb1koB3YleBf9MAlNVr4dW27iAHCHf+URO7RmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422524cb38so1350866b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 05:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922442; x=1781527242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77HqUEi5e8rzezFCwkWmHLh/pvgxLHcUn0OIuKWMAv8=;
        b=LB/DAxbVeoBCdIw07c8UOWF/ST7u9a9zjdf28R8odltzus9wJ0L8yavGRWw3JNx65D
         rLzeu6I2r6tn0QNgtnRDEMiwekeG7fYwb2e5AQ76vwH7hWUw8PjDLNQQxhAPAz6C4Rij
         BGAVUqwEQ77BJrA4Tg1qPPrLc2rzfIzRMhWfDMz45SxAHbwLVEjxys3CwEBc2Ki/JeEs
         4F8NEkVE8NhAwsn7I+7gsI6aNlNJJs7uUn6OBYToCLKEnX/UmUO45Alx/q87KXVrHMGn
         KDvoYqeXxjza2NsqB6o4Y47EOhVkvZOc9iqb+APue59JhAxOEpFRILMNcGLUNjGja/oQ
         pCLA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ca1QXUWfdhQw7kK8Cb7tFe6Xo9fWDTo+Qzjf4H31q5IAD6uYvxY4SKwcZFb7cJTgXYn1D9C+3GTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wd8UhSgH8lwmnBYumUI4jHDRvRM9pWZQq7ST9i9/yOcJfmjs
	ZGQdHDHAM5H1AJIcH7KHxIzQMAqn9fwh4Ap6QkvRvYuDNGYgfhYZwhggXdLWrWuOPNU=
X-Gm-Gg: Acq92OEikFp2StCDUSpa6fuw/Dk8T9lTYS/oIZBOvcMqzeIEA2ZXgWP2auZOcnO10Sm
	zMnR0VzKMsix6A26VBJ7PC3UMfs5IgxpZ7RZZ55cW8NVfgnEEhgLP1PKC77YZdniO85RGAWF1qy
	keUepiRi9WxRGbzf28h/Ub9aB/74kHvRV/aF2PoaEWDklePuOO127nIBu2FK+Ud1SxQVlb1sdMB
	CitM+6+yKMoEcK+6Gg9tuCX++IJslngguvbLUNjsZO27LKiAjpXFolvoOJuM2jWFj0BhqYvv/AQ
	KVS9PFEufunyYCc5f+DtECN9vpIGWUcEGs+7RgTorZR00b9oIiePFiiUTVTuvasSPnOqmbcS5c0
	199gk1lxGBgmpvxAK2sQnmTbu7A9pMVfZxtSWcgV63Yl/4qBARyfx4yTTFXncXJ3V8tbWYwjOfK
	2JopeN16VztWkycikphhNgb7hNiDfVV99GE4UJdLlKWiCT43MXK48eCKC22P9KDx/hDjp4gwx9r
	IiG+NbJP8nuP7K8pLmIOQrIDM4cTac/G9iEKSvMnN8BN/CUw58=
X-Received: by 2002:a05:6a00:194a:b0:842:7476:236e with SMTP id d2e1a72fcca58-842b0fd2828mr15993708b3a.41.1780922441644;
        Mon, 08 Jun 2026 05:40:41 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372a16sm21648665b3a.18.2026.06.08.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:40:41 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Mon,  8 Jun 2026 18:40:22 +0600
Message-ID: <20260608124027.35879-1-email@sirat.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
argument alignment. No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Siratul Islam <email@sirat.me>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 36 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 4d9cb3983dba..ed83999cf735 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -43,6 +43,7 @@
 #define VL53L1X_REG_SOFT_RESET						0x0000
 #define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
 #define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
+#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 #define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
 #define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
 #define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
@@ -64,7 +65,6 @@
 #define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
 #define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
 #define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
-#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
 
 #define VL53L1X_MODEL_ID_VAL		0xEACC
 
@@ -191,6 +191,17 @@ static int vl53l1x_stop_ranging(struct vl53l1x_data *data)
 			    VL53L1X_MODE_START_STOP);
 }
 
+static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
+{
+	unsigned int val;
+
+	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
+	return regmap_read_poll_timeout(data->regmap,
+				       VL53L1X_REG_GPIO__TIO_HV_STATUS,
+				       val, (val & 1) != data->gpio_polarity,
+				       1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
+}
+
 /*
  * Default configuration blob from ST's VL53L1X Ultra Lite Driver
  * (STSW-IMG009).
@@ -230,10 +241,9 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
 	}
 
 	ret = regmap_read_poll_timeout(data->regmap,
-				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS, val,
-				       val & BIT(0),
-				       1 * USEC_PER_MSEC,
-				       100 * USEC_PER_MSEC);
+				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS,
+				       val, val & BIT(0),
+				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
 	if (ret)
 		return dev_err_probe(dev, ret, "firmware boot timeout\n");
 
@@ -261,12 +271,7 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
 	if (ret)
 		return ret;
 
-	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
-	ret = regmap_read_poll_timeout(data->regmap,
-				       VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
-				       (val & 1) != data->gpio_polarity,
-				       1 * USEC_PER_MSEC,
-				       1000 * USEC_PER_MSEC);
+	ret = vl53l1x_wait_data_ready(data);
 	if (ret)
 		return ret;
 
@@ -461,14 +466,7 @@ static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
 		if (!wait_for_completion_timeout(&data->completion, HZ))
 			return -ETIMEDOUT;
 	} else {
-		unsigned int rdy;
-
-		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
-		ret = regmap_read_poll_timeout(data->regmap,
-					       VL53L1X_REG_GPIO__TIO_HV_STATUS, rdy,
-					       (rdy & 1) != data->gpio_polarity,
-					       1 * USEC_PER_MSEC,
-					       1000 * USEC_PER_MSEC);
+		ret = vl53l1x_wait_data_ready(data);
 		if (ret)
 			return ret;
 	}
-- 
2.54.0

