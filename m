Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D80433030
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058460; cv=none; b=JqdeEAhqPXFPFABcVdtbepMbkvWZ83TlJ/NZlUwBdW/mWr0lWXd5Wgp9ra1S1BSnNvWx5es4xUhEeHD7058Hybfgox4J4d7cm8NHvlnEUFs2tLFBr2kPF2pQHLOri/aoXngSi4vfSLOxMNp+uaeCGuIPXgYAXkaqpY/GrG8ASN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058460; c=relaxed/simple;
	bh=L5cKDZ3oZuREEsG/FL4nnHJOHClGwu35C6UP+h/6c9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F94y7MLwGozCBuBCFisgHKNE/9IkhW2HjySuDYOo6FoD4KVAa2q4TT8hcgB6X8iAJbvXuDPTgEDy3JWe37HXYCYt1XjQ3fp23oWbd/25fl/38dQcVX5g5p1gazTj1tOGeJvVbF5nC6/vj1HY/BO84hMw+214n1x87fv0yy+sqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjPZq8Cu; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjPZq8Cu"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1468200e87.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784058457; x=1784663257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7F0XFPsWY8E1IJTSA8IwnIWALBfCdqYZnCek7z6Ufx4=;
        b=gjPZq8CuPlLCIa3fzC+IHNZ7nHmi9rMToMCcFQ5fBoJJhjaFB61tbUl6jDrld5x3PR
         qm148FrGD7PXyWsP3x6C+Qw2Xb13H6YXUdeKiuwFfs4HdOS/SkN5vbt1277Y+R8uw/uh
         I8S38kOjvkbMaDsiHqp1EXnYB52Wq4o49A9P7aTzhkmuWyrz59CF/rgjFu2ubUifHu3Q
         EJfKyaZoidtLvPU9bBS6UVoXJ1sgRoMLoJG9ES2DIDadEABdcxe6Wt1rT+1NCkFFrtMd
         6k0+orTgNaEbO4KzKYNWRWh3RNoo81ItheQ1ANiEEmU1MChwLSQ//n+73n2QrNwbst92
         SjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784058457; x=1784663257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7F0XFPsWY8E1IJTSA8IwnIWALBfCdqYZnCek7z6Ufx4=;
        b=elVpub62Znpl4jYMw8ruO6KvYsYYO91FdyL0A3Dyjrvont1C6rNu0qILgGHoV9clqR
         mjkzO+KPMrTQFvnseL/+DpJ8tllv92qPRQQosTSsjzUkM7Gf3UgPFw+iplM7dIIzzAio
         X3Z2qpkFCwGcWuIW4K9Qdw76UMB1fxoBCp8oMYtk56rqZtjwsRyRkGYMsAp36k0LuVG4
         1WeQ1tEHA7Xdg/bfv45Amu/SCG+GYcchEzfdQ7bizbuqmt5yXFcP70qNHDR80ZKOz+dl
         EHhPWTwCTdNVu8kS46uIFD/9ctbzcPywVlvdN1CAxYEnbNyCLLVvln0wJsAHH1meM1NA
         J7Hg==
X-Gm-Message-State: AOJu0YxEGEzewq1/AQU1MYHS9lNzyrAohH2O645ExZwFVzW1MLb2WPhx
	LpomXogdueu3g7wG0oJVfN+kHhhxlL6lDVbPXyE3pY4eoMkyX5LKCjDlOA95QkZO
X-Gm-Gg: AfdE7ckaV9hF9GbllKdLN1c2Fc0FZmQqbDjSlCjJgS3DtWsdVYxSQrYQ4qt3zAVGzei
	KH0b9qagz23UnvOT98poCcHCoWmkHuNbYzC1RYaqDlKA5xY1hfTzyd3pksUm4U0JnUXXsQTkVui
	KqtipIyR7avoUzCJ4g6FTWO06CJgVcf2ilB+J4BDF7oz++frPsmXrbgSZsUm5Mn+kboDkNjkTZJ
	zWFI+vhJPq5EJErQPpNKzWGOK9bLljNvadx01Qc37VMoc6mHBj0cB5v/+cVYSNqHDlO07J7APSW
	z9jt3O5RNtLwFN+x4wRdG9aUAQL6km4ikqlHhBATFn0+k3m6LOeVaL6maEO8aA9o3Yys4roqBny
	DNahgrlhbeKk2iEpdgLwnzjYOi5Z6PCXzhLceH33apli0jQMJRT95JeKdSFWbZE6sRLMbKUudz3
	rYabZXkvKNWy022Mrj0ldf5giMs3FAH8uaDaA2g75B3BUVycPllZXOQkeW1w==
X-Received: by 2002:a05:6512:3345:b0:5b0:1959:d877 with SMTP id 2adb3069b0e04-5b023698daemr3222763e87.41.1784058456644;
        Tue, 14 Jul 2026 12:47:36 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:822e:374d:22e8:16cf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca50a8esm3780287e87.28.2026.07.14.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:47:36 -0700 (PDT)
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
Subject: [PATCH v7 1/3] iio: adc: ti-ads1100: Fix incorrect reading when datarate changed in single mode
Date: Tue, 14 Jul 2026 21:47:15 +0200
Message-ID: <20260714194717.596193-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
References: <20260714194717.596193-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device is suspended and it is in single mode then changing
datarate doesn't make it actually wait for a new measurement, so to
be sure that read after change is correct functions that changes
datarate and gain will wait for new data.

Fixes: 541880542f2b ("iio: adc: Add TI ADS1100 and ADS1000")
Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 71 ++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 9fe8d54cce83..f0a30ae139af 100644
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
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	/* To be sure we wait 5 times more than data rate */
+	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 5 * data_rate_Hz);
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
+	if (ret)
+		return ret;
+
+	return data_ready < 0 ? data_ready : 0;
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

