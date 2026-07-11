Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34373463
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783795474; cv=none; b=ogPc4tqDct5WcIfxHRP31rS3GXJ7WvXHOdj8jMY9xua8xYJT/QT2qIdZB2SKrvZ3XKDFwOZRZO35uxO9lWq+iEX+HbbhQDB9QBzSXvGLz6y2/mbWasNBIIL1gvl50Lhnmg1c851mK1JqXsmU8zZN4thB91jTr5BpbUBg+YUN/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783795474; c=relaxed/simple;
	bh=H/8M0Q+XxyDtOOH0daHp5Jymw38SW+bgm+J0XGp/zL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeoLRuGLX6tzGjHx2iHHzicvr+dZbqcXr2iBb78pqnNpEi2OTERpFY0dX4GKOSddtWD9ThW5Va5AWKDCAOQfqaMW+YyiU6aDXzE8dn47nLMIdyeLSNKn2HaI9tNdjw8Q8wklcKBPyKRjIBvlL+YDYwu7f3bs+l62KW/bCP7sYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qW3nSqN8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW3nSqN8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e4cccd8dso8090615e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783795471; x=1784400271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKmns4C+8GnDKgq+vZyK7ZfI3p6VrWPkoZ+9vneICuQ=;
        b=qW3nSqN80y7FRQnfWv4RlgPPoKc9UipyvwHfY1degdqJp3cXhuN60XF4DeoNmn6Poy
         8RKHz9XU9TIOguNWN4ACT2QdALjxhIifmFamor0VD+gAP/JwJciWFnxKEmVyBJrkzRDn
         gDTOs3HDBrPfUwPAbXPAAsea7d69UlRiN6CQlEFKhaYP3IuLA8d6cb4K0Ag6PdKoaoqf
         1KHFpcndwWnptm2GiYaAuzc4+qfn6UtiK7RDmHHLdN2SPMMKuMtkcPPLa6QWErth8lB8
         mw5R9f+WNZ1KI+H9q5b0xlAEs+QVPnM5+MSkizU9tPqGGL/2zRP5QR7Rt9AuX2KtBvz6
         PzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783795471; x=1784400271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKmns4C+8GnDKgq+vZyK7ZfI3p6VrWPkoZ+9vneICuQ=;
        b=Va24+pxF28RVNk45d9VcwITvb4i2kvNksxiGOJTJc0YGT+5FEw2ekxAgYJ8+9FwIqk
         mqe4nOFvZ9K3NAGafhopN6K8IZA1BBrymtlgbpYhY0fgLFrFP7ocXu2Vv4JLurV9q/Br
         1rBER1Q1LzZAQL6LuImDYfB4VvK7qC64gJajdQ4JbLhGesC4QmJoGAawR3dJXGMjWPcG
         XwLJz8RCpepJsMpTbYUsZHWzK5GHnpR8aDxrCmBYbFchtj54RzAQHLORuNQLs3Uo82eL
         kyz3F3u0tmPMDdJAYCAKOrJJ+A07LozN4lo0+61EaKgF31ArCcYnpiybZeJBL2z2GhiE
         +loA==
X-Gm-Message-State: AOJu0YwTrEyziiYzp38hnmoJ0K3cgTWw/dpzjzTpkqbVFhfZzhwuxrUT
	l6Wz5weKvvT8J5jOJ9xoI8Y2oVcFIJgCUO2OnC+WLVUAt9ooYSMJ3hbjT8m22ACt
X-Gm-Gg: AfdE7cn9nUgJkzDnLuk6YxmKA/T5P0PJlZ9AsM6W4FwBFhlwANlvp3Mjg0wUa5MdrQE
	NhBPkMDDXlcWz1J6k93imu1ukjX99KUmWoRZLXg+jjjBydhRChP5fdKmYQKXVH2ADwgWVEL7LTp
	8oKb8MhIMuwCNalfGOm66Cy0KCSxkE8Lplg/zHAC9FJY+irDyhLayCGM2PkqqzIUfkp579SvBp5
	niPXOYvGESMjC6LXI5Uv7UDUTZOz+KB4YMBUSMWx/UMC6qH4ydApYvfwymu80aRUkAgsMaM7ydI
	jXlQfqmLIbMuRMGJmQol64YULOUpLlxN/FGbCBSD4hv8x7F8bZOW9QVTg8Y0nLXWYeD163DTlFi
	qOl2nJZkgy6P1rkm+zJzZ5nkFRKkCOiA7NJNzoj/fMGbFoknIs7A8Mn6uBptmniiRqb/I9Ed7vF
	V9gtGSixlWzkiAyiEtzkkLGJW9xIKh0V/dOHHvQzPKgB9twMcxnpGd3ne2AQ==
X-Received: by 2002:a5d:5f92:0:b0:47f:2634:b5a with SMTP id ffacd0b85a97d-47f2dcd7cc2mr3520044f8f.33.1783795470853;
        Sat, 11 Jul 2026 11:44:30 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:e6c9:27be:161c:632d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm70825745f8f.11.2026.07.11.11.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:44:30 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com,
	joshua.crofts1@gmail.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	jakubszczudlo40@gmail.com,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v6 1/3] iio: adc: Fix incorrect reading when datarate changed in single mode
Date: Sat, 11 Jul 2026 20:44:12 +0200
Message-ID: <20260711184414.1013686-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device is suspended and it is in single mode then changing
datarate doesn't make it actual wait for new measurement, so to
be sure that read after change is correct functions that changes
datarate and gain will wait for new data.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 67 +++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 9fe8d54cce83..6ad80d42d390 100644
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
@@ -123,10 +128,46 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 	return 0;
 }
 
+static bool ads1100_new_data_not_ready(struct ads1100_data *data)
+{
+	u8 buffer[3];
+	int ret;
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return true;
+	}
+
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	/* To be sure we wait 5 times more than data rate */
+	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
+	bool data_ready;
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
+	return readx_poll_timeout(ads1100_new_data_not_ready, data,
+				 data_ready, data_ready != 0,
+				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);
+}
+
 static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
+	int ret;
 
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
@@ -135,6 +176,11 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
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
@@ -149,22 +195,35 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 
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

