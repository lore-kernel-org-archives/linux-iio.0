Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FF25B0B4
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889674; cv=none; b=P/fODQ6ytQjUDLJzHhgAQoyoB3XZJx6m24UD3o8m3bSPK1cm10+YKh4Bmc7dBlleFsV5FndXEFg9UbB9fZCvLKfxOVVz6Y0ehW3Ni5y0CRlVRO+TGHjKBBELPDplGW5u/KMSwEYK4u7m2CTkl4nRbJpu90f5kLtehjDttw0QylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889674; c=relaxed/simple;
	bh=Wrzvc03qcJAI2fJFG5Y+43Rc2qKa7QvoUxtDVB+jgKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RriGs1droBE6Wj69Z1J6nDEolbgJqYcaxcpQV0sFNMJ3mbblXYGf8XiqdWLRJbqKNSKpnDTJNX5IhWi7PCKMDmkB/q7Ivmx+Ti2Qyv2EPxlTguXXMCk5X4wLZ2N6Nn9U0VlsJsH4314sbICzXEPz4i7CYLQFQAVqD82uYHOL8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso2189160a91.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 20:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780889672; x=1781494472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46YxaO4ofqI9vyglwTBha2ZlTUmES9KzjNe4ZaBWo1M=;
        b=YE9HV09msAsK7dZYePsLGmmf7Dqg/g/5B4QdrcklS2pnAoPVdgtCv5ZZen4Im4DasS
         UL1UcAJJXP50HoXhhzL0wEHq/Tf0Hi7i94o7lnFfdraM+tQ7aBiNq4bsPvxiNiAPtJ0g
         +FF/whmoSXQKlY83YRF9658OMIlgAYTUkuHO3ZGSs7Mz52DGBAKHtJLf5GV/6jyg5RlO
         y2TX2Jm7vJ0nd3ffooa8ke0/B6kpffW7jShltFjSJjuC4RAau36IPXgIovK8fEzQZOtQ
         Q5j+bv13igUopARZtHXgcTVkie0gC8XjeWlJgU3SXmSR5GVcqFn4U+QJTjEjj004bFJv
         cM8w==
X-Forwarded-Encrypted: i=1; AFNElJ/SBLimj/fKRjr2danZ67hup3FioX2+GhfjXoaiAREew3kGbIbw2u/KDWx0NGkmsy0sZJMsxdfR2Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdywtxbluVwoMFfWkVi3AXsx9CkaXvCneBs/AN2o7vHJb/aj77
	CANEVIgzAFODzVmWB+TbYqzbHzFyOzOh9ht+dRepIyJ6Mds7657FFGzD
X-Gm-Gg: Acq92OFu4JoI89drhpGCZuCXpAPlw+aMSaqS1VTNHxeS2cyilWgNlaCapGtFb57JyLc
	EimrM5Oe/w+uWquezcWIUJW5BYNMn2PIbUJCA0D+1kXM+22cr1NMSa8PVOus+3jBW7wGpC9N58o
	mcauhkyj4fvMgr4CZhqM8FR6hRZa/VG+notrdn4xg8CG/VK5zHRDhWsp7oG7+9iV0ZjHPiGysOX
	ACbM+rpWm92RXuy6S/xBRuGlCMOPr+PitxARXSkXHwsnVJw9+duO7HJTJmNLuDjhWoL6rRNzHMc
	TdWEDW7yLPZZX+Q/PTzKR2DaMI34qqJxiGFHqOVkw3r/Zn6svpgRPyVK84BGJzQP62rvtq5hGW/
	bkMaZYO2vg0KNrEwsrE1YUwFo7w6dJkYwUm2YYImKNVbgh5JvETqMp6idS9BOqjD9uNAy0FweRw
	Zrkl1FGeE1+ICC4zEV7tjnuOT+k3BiaikGrWf0HKHDsEs1T2uJZ+FHnsZaeuk3/DF9W+tUYJqYz
	l7lW5uPpnNB18WD6T4SoJs5tN9TUE05/bICuzXy
X-Received: by 2002:a17:90b:4b0b:b0:36b:a2cc:4857 with SMTP id 98e67ed59e1d1-370efdaca8fmr17829661a91.18.1780889672056;
        Sun, 07 Jun 2026 20:34:32 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c76f55asm14102286a91.7.2026.06.07.20.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:34:31 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 1/1] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Mon,  8 Jun 2026 09:32:06 +0600
Message-ID: <20260608033218.26514-2-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608033218.26514-1-email@sirat.me>
References: <20260608033218.26514-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Sort register defines list
- Extract vl53l1x_wait_data_ready() polling logic
- Logically split regmap_read_poll_timeout()

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

