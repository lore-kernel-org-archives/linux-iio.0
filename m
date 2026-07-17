Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73138424D
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314260; cv=none; b=NHIfhPSgm3HFZRqck0HcFSQOILLbhUuirPvms2JnBi3U3gG411E8scrFrtSfR+4KER/ryBlKtOWNliMFe4oWKNiezuBLlZlHj+SMmAgLU9Q8cOYhYNVV7ZaKRoFBYQ38zVh7YbMe0sSa/se13nl5KDE0N42gUX3yGz6isFAdNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314260; c=relaxed/simple;
	bh=7ma1G64BJEU3Nefd92S7MV6+k++rrF4S0zC/dSz9Xgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s69jN3HywkKr5GTGIJ0amehEJiQgR+h+DFHAmoEPqPgwYWOtb0Jdi8E4y3blSYucy+aFW9qbv7HfFG6xOCirxkbMGDDBWUkKCwcv4tbl4UTjegdJzIKV30d1KphlHn+OZmBLDJX2mzeajx5X0e0Yf0SIOK3DyyMwq9JrZkAmKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR8SYRJl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR8SYRJl"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9452243cso47799681fa.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314257; x=1784919057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi0gxj3tpRQmo8mc69jkt7+C/RQR070orMLktPWEIAc=;
        b=aR8SYRJleFklCYKwclOZIb0WjZLTO5pGyIpjwMTvBJfY5r1crpiy5eo82gOmvJp90N
         2OePAd2/uE118o05x4007ZiEos/+vEIFkKAYPyev8ljh7MlVLtDbdQQeO4DuzjCXGf6R
         13u17n/rzdWYsYNdRRx0xIlmVr8k4r3g32y7SgZRqR+1hk5EnNSdDtpDlSUD6LYGnBEn
         pju56B3+GWAvjnX3mLSOHcd+MogiUl3nHsjWA0w1F1Ht9r5swEV7VhTm4uQvGWku+ZzI
         Wb1qnT+QiOH1v6eqVqw/bcsdXxQESoO1v9ZGWwSah0F23H7QTaYm2Z5/WGeUfbZ1t2+K
         4sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314257; x=1784919057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bi0gxj3tpRQmo8mc69jkt7+C/RQR070orMLktPWEIAc=;
        b=kUXDddOzTWEBRGyyasSsNJTb8n9WNodGegTb/JWBpaDR5Gi+vVj08gNH9bnghrX54m
         xaE7qRsDdonLfu449QYsjYkQU04gpU12sCVuTJy4nWAhh6fCcQsm7FqLdRB2CM7SNA+w
         b/4e9e3qUbnGR+Y4WM3A+Xs8ekY0HuHr3ntsDePPf8wJZoeiWLbiow/3n+2mfY/PM6V5
         uxcocNBy+wn+QPQm23joPFwsDgBbc0dlvljFIS0FXZfhonYohYNmIBvn4tz22pAWd+sH
         VWXwgYhUHoRYE9dq2EpuHz5HRTWkq/gt5R0A1vkOyD3IFNjT7ZaS9RnrJELp9mu9WWiT
         n2wQ==
X-Gm-Message-State: AOJu0YwVv1BniGdjs02m5iM6dEkKZg++WXyCIiYg9xVCyMmvePFhmddL
	niW0IZzG51fcbAZzSMGsSPotO6HAoekKUTrpeBIGxDP99XTDgrPVElWC5X1/wAEu
X-Gm-Gg: AfdE7cmeRLXJETFpzqq72cxt0LYnabdQu9ksFgehLaFRd2/Zwgz2AqFPYt/6+33vHfz
	G76CGIk1w5+9+nVBhiX33aaOlCatDOgSr7G/r/njOlo6PgrwU36rl291WCfMeQ/B99GyEIlrBFF
	Pt/gw/K0XxcKKZoxVOZTsYGlCVq29yhEHIMJVanHMEo7UNUxD6iTVIqv5Yr3rZ2MacQqarjd++V
	sm7BZpx7KAP6xVTTOcaYaGHzwF6lmE6KSQNnCxW0t96sinef32tfo96LrmrOmyH0B+kT1S/Y7lG
	y/W2UlQb70HLH697bEUXipWwjFaYJY/YHuxnLb5EnmXW28K1pcv9J4GhhQvD+F87zy+tY6X+axd
	ynfNRUzkxbZZnHkikLE9qzyRbqNBHWdXc8qw2LggReXbb0OyNeMPuAOiFdVKAwZLKRPDWpGSc2r
	QavT5p6L8sDRXNBvdCllSLYAgUiqbJv0xnG5m4
X-Received: by 2002:a05:6512:1092:b0:5ae:c201:c3d7 with SMTP id 2adb3069b0e04-5b28f87312emr983886e87.8.1784314256632;
        Fri, 17 Jul 2026 11:50:56 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9d0c:8f55:3d10:318d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4fd4ba2sm3431721fa.24.2026.07.17.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:50:54 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v8 1/3] iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode
Date: Fri, 17 Jul 2026 20:50:31 +0200
Message-ID: <20260717185033.246580-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
References: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device is suspended and it is in single mode then changing
datarate doesn't make it actually wait for new measurement, so to
be sure that read after change is correct functions that changes
datarate and gain will wait for a new data.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 71 ++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 9fe8d54cce83..363f790ca5d5 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -15,10 +15,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
@@ -43,6 +45,9 @@
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
+/* Timeout based on the minimum sample rate of 8 SPS (7500ms) */
+#define ADS1100_MAX_DRDY_TIMEOUT_US	(7500 * USEC_PER_MSEC)
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
@@ -123,10 +128,50 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 	return 0;
 }
 
+static int ads1100_new_data_is_ready(struct ads1100_data *data)
+{
+	u8 buffer[3];
+	int ret;
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]) ? 0 : 1;
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	/* To be sure we wait 5 times more than data rate */
+	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 2 * data_rate_Hz);
+	int data_ready;
+	u8 buffer[3];
+	int ret;
+
+	/* To be sure that polled value will have value after config change */
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	ret = readx_poll_timeout(ads1100_new_data_is_ready, data,
+				 data_ready, data_ready != 0,
+				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
+	if (data_ready < 0)
+		return data_ready;
+
+	return 0;
+}
+
 static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
+	int ret;
 
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
@@ -135,6 +180,11 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&data->client->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	microvolts = regulator_get_voltage(data->reg_vdd);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
@@ -149,22 +199,35 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	return ads1100_poll_data_ready(data);
 }
 
 static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 {
 	unsigned int i;
 	unsigned int size;
+	int ret;
 
 	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
 	for (i = 0; i < size; i++) {
 		if (ads1100_data_rate[i] == rate)
-			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
-						       FIELD_PREP(ADS1100_DR_MASK, i));
+			break;
 	}
 
-	return -EINVAL;
+	if (i == size)
+		return -EINVAL;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&data->client->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
+				      FIELD_PREP(ADS1100_DR_MASK, i));
+	if (ret)
+		return ret;
+
+	return ads1100_poll_data_ready(data);
 }
 
 static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
-- 
2.47.3

