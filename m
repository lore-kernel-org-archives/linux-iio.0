Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707E2F7F17
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426650; cv=none; b=GfiwVF6ONS8kh8TmeOaUkXgYZiWvyBalJ5wugGY47b/WSZhkJiNiUz885Ipa6Y2SGSGti5teZmVHZBGEGFrjg19GO95jkQpjtBgOksU0qbSyx0RW87xGtBq2sRcAOIGx9+CqAITBaVxULsjbCkXd85ZOh0l7wLknDeTNTX+ncZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426650; c=relaxed/simple;
	bh=BAkI0eLcky/GvrEcYO8Z7FTpXb6kIoeCsyNoxqU/39g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQlPiV0dALR35BEgFCtdB2sS6UNnKgVF/Ga0bsAWC4QE5cg7iCDid1vfIxrLd+X26xmTjFBKkjTsm+E94UXxQgUIbOpnNk746F9g2hwKXRyPe6g7VPOcufO2oBcUJ8tRPGm0y6VGlytieK/Newa/t499kmEJUyc1ATSgkdIpQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36da151a152so1678243a91.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426649; x=1782031449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ov7megdRvR6jJdocDniAp/XyozQiCYgcUrffpj6pgd0=;
        b=pbhrcrDyylIC/KLBuRQKlwsfP+02vtSE+s/KSXADi9rjzRiew27cdhXUeZguYvmKLb
         iXVNXzP48hyM6C2yWJG2D2fAk5JCPu50WgXdaXDs6GlRbZx8wkR/f7Dood5cdMBakIRQ
         96GlaeAKl8rQiW/1md6OvR/heedC7N2T0rqURq39x7Mu+pGUGRrOkP5YXYPmtiqSrcyH
         RIYNuGOZmsUZR42GGvWhR02KGPzaOTWR/r/sQE9ZG+99SUwIP9wVGhEFiffnHYlImDds
         m3PQ/5Ek8zLZKLXHjlWsVaTrXrkXlN+r4/zFK1SM9/uPbArleNJY9TFCyFbDcxXp5UwS
         wWrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9v8nCbbLVz8A/16XI5gFvqoH6JBvS5ncKu4A08ePpBHVfUgCG7fYq4odIbHfCfg7mM102ekhv8eQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9UW+0vQ65sWo1eOxcM3GUEmONrYMclsx9tAdB0H5lIsMI5bl
	mW9h+8n30dnXledzIVvWvC59z1K7ISwxkEvmKS5HUnI6rgTBVV6p9RbN
X-Gm-Gg: Acq92OHuChmzTUKxFHYbZLjc6wYlcRSwwubldWBiSuTfuF9JO5CsIUA440+mSshDlPX
	fHpwwc9jN9ISLfYw3Fo9iwpIg9bGissyOAGRcrBdsD0MwMLLkzmbN+XBoK1Wht72MGrMH71xGlu
	ls/0C5XRvliLVQkJMen5j8mGAGKKfI0L50J8KeWXw9iANzFaLpVJx/W9f4A5HQgCABtjTcHl96f
	pvljEvMHbTv5jlPtjcIIbpBLO+b/qFBbpEhhI5X9Wp5r0ujdf93M5nmirmTvawkWdm5fqTkIvTT
	cFGh4JWfm7FbmuNxJOWBcGvU8aZl0geTtO1/ihuo4ATQ9X4UATSsY5gPT6aGlnol8Mkt2tQHO+8
	adhpfT7bRmogV1gxl/LKOvFhZJJ6/sbdVPg51YgfQV7xzqPcKz9KMqlpQs3wy3Lng+G3dExmOD+
	6MGL1SwCZd9rjbiLZv3oarCrFTe8ms6Rxxr3fBS6ffjz4uIQeXOfLxCxJkzha0lOyKsw4zfUbAo
	oELcfmXz1qlY/jDzSzdpqIdq+gM2Q/BCOaCbGKO7OkP2qEPInRwGBSiCtwOPzH5Vup4lOOHLHf5
	IpBQ1PPtyA==
X-Received: by 2002:a17:90b:3a81:b0:36d:633a:e7e5 with SMTP id 98e67ed59e1d1-37c2bc5d64bmr6055523a91.3.1781426648715;
        Sun, 14 Jun 2026 01:44:08 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5dcsm7209056a91.9.2026.06.14.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:44:08 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 2/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Sun, 14 Jun 2026 14:43:40 +0600
Message-ID: <20260614084349.25823-3-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614084349.25823-1-email@sirat.me>
References: <20260614084349.25823-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
argument alignment, and add field definitions for BIT(0).
No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Siratul Islam <email@sirat.me>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 37 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index 8302e0049e7c..d081d8a88bcf 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -82,6 +82,9 @@
 
 #define VL53L1X_OSC_CALIBRATE_MASK	GENMASK(9, 0)
 
+#define VL53L1X_FIRMWARE__SYSTEM_STATUS_BOOTED	BIT(0)
+#define VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY	BIT(0)
+
 /* Inter-measurement period uses PLL divider with 1.075 oscillator correction */
 static const struct u32_fract vl53l1x_osc_correction = {
 	.numerator = 1075,
@@ -191,6 +194,17 @@ static int vl53l1x_stop_ranging(struct vl53l1x_data *data)
 			    VL53L1X_MODE_START_STOP);
 }
 
+static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
+{
+	unsigned int val;
+
+	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
+	return regmap_read_poll_timeout(data->regmap,
+		VL53L1X_REG_GPIO__TIO_HV_STATUS, val,
+		(val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) != data->gpio_polarity,
+		1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
+}
+
 /*
  * Default configuration blob from ST's VL53L1X Ultra Lite Driver
  * (STSW-IMG009).
@@ -230,10 +244,9 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
 	}
 
 	ret = regmap_read_poll_timeout(data->regmap,
-				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS, val,
-				       val & BIT(0),
-				       1 * USEC_PER_MSEC,
-				       100 * USEC_PER_MSEC);
+				       VL53L1X_REG_FIRMWARE__SYSTEM_STATUS,
+				       val, val & VL53L1X_FIRMWARE__SYSTEM_STATUS_BOOTED,
+				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
 	if (ret)
 		return dev_err_probe(dev, ret, "firmware boot timeout\n");
 
@@ -261,12 +274,7 @@ static int vl53l1x_chip_init(struct vl53l1x_data *data)
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
 
@@ -461,14 +469,7 @@ static int vl53l1x_read_proximity(struct vl53l1x_data *data, int *val)
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

