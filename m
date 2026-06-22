Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F73793A8
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166576; cv=none; b=aacI6cPq1bDDOC3va1V4t7yq8GTVJ3/diYNbpRDausBIAWpgw8RAjlOlGJZr/aTiIIGQHmgzaSF5bANbuBjMt4zFEixjUCR22cSlZGAL6uKeRGkzoPMVdow+2bsOrjA2Ro22YiJvviVDwMzFTURSaG1y+t8YGfpfPbBx0iD+oTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166576; c=relaxed/simple;
	bh=Kn4F5KWEk/qmEp4CXKmcI43JoTG6Txr3sNUChHnbdmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThIHuo2Ux243GxgudGJNOUrhaF23TpO6hu8WzcOttmEWLJZ7v4kX0LleaFO7ZcHllIXq/BKDRykT4a9YPNm8Yvo3LRDC58bz0CDcBP6kgMjTC3G1x15X8Q+/0fbsHUZEwB4wXfSDMk425pbKjEODyG7O9mFobM1doiKrIkvKgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1+oKhRz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1+oKhRz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso4761183f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782166573; x=1782771373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQgx3z51gSeAl7SybMiSanpyxKloY3+DDUxB8bVZDcg=;
        b=E1+oKhRzLVjB535Za/2rD1L+Y0me9H6KnMiY6CBmrVuVLGAJl6FTQDFnBCS04MHJV9
         3ixzA8LomwwQ4JCaOHlLPFRJlprvFR/TOPzgOQo0c+6JAuOgiq04WgzRAjbdyz8+Fxvd
         Le7Ob3pkq83nOsqiRKogbALsIgVfsy6KUV/IjvnVxizvsqUSV8YjbCC7us3fWTxgAhXa
         41V0ewJUgGWkv6ySELX5RihL4Us13+VrPXtM0p8kcFKoJnwuuIKTQ33tb09DG5+4BlWY
         RkRf5MGlu6b/kdeqRklowBHcMciL0b0qIx9NFdOSBXtKEh8udANJJpwa4l0ieU2n8RNo
         G8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166573; x=1782771373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQgx3z51gSeAl7SybMiSanpyxKloY3+DDUxB8bVZDcg=;
        b=r9aXZDT1ZA7azw1V7bvkzLj49rWshTqZAsLze6XNoFYiMwjxuosWCBtovTrOdYxAj1
         Mdo01rwjnpDpOeF3di1lT4zZZrcWgXB6ifDgOTJLi3WvBQUuCM4f+tfe2qT04CIQCtFB
         JZb1CQl42SX6Od146v98exahd6tvCpItfYtS39xFD1jIQ0Mgf0WJCtXMT5GdELKiD2wg
         LqEvfyht5py1Gfln4OxG58Ac0bP6/1qsiJLmdw0MpxYGQ2vESfaDqpwvN5YUjxSjd54G
         umPLEjkMNPAurlEIj/k3VsD8/MqfYgGMdXHpp5MqoTN+D32JHB9DY908PjV43R/rleyx
         gJlA==
X-Gm-Message-State: AOJu0YwoZPkXm63bu/0cyBcT3HMihQ0yl6k0vuOe7xXQ91VEdD00b5wD
	R50PiOBkJKMbNHZSrE7kc8KSk1UpK4RR2kFVmO4mcHcbx1uAZnJ4Qt1rpL3Ngi3e
X-Gm-Gg: AfdE7cm3oqm1Qi4xnMz8/EjhcnJG1vqXANHX5Iibq/p9QiyDSh2WyxV60j9ZRTTJAij
	jHCXuQ2vabCSI2UQC8fy74iixk1ZTxxID88AmOIuz5KYhJNKf0j5oZCzxQVOdxQGM3bsgC7tTis
	Oo4rDIdZD/WftMP1A4AdmcD55djRRsIWWQgTtG0gLpuYZCRiF9Ifd7MFQmrWrIAIdUAmVMc4Do0
	uSj6ptxkv5Fz1HFN+CVhnY0s2Ha+LyDDUhSJlsEO2pkcRTgqbCXyYoif7geNUsaH7inQ+rxifVT
	i7OSeHwklT/y6p3cmSgq/8JhRLMsJgXqNRScpwH/anEK4IpitvqEU0gn7KPqxsiqB85mOO4+KiY
	KjWPbVEAFJj3nHfJopSNfJTw6mUYbbD8zeaJA5tSryTJrISQRXpKqT8J/8tkTD71vjwwMppsNNw
	+KMn+unGkNTtnrPgtTfLc1Dpq4RNEY
X-Received: by 2002:a05:6000:184c:b0:461:e27d:5690 with SMTP id ffacd0b85a97d-46adcda85e1mr43430f8f.26.1782166572948;
        Mon, 22 Jun 2026 15:16:12 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c53fdsm31319845f8f.10.2026.06.22.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:16:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate changed in single mode
Date: Tue, 23 Jun 2026 00:15:48 +0200
Message-ID: <20260622221550.374235-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
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
 drivers/iio/adc/ti-ads1100.c | 74 ++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 9fe8d54cce83..e3c801381434 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
@@ -43,6 +44,9 @@
 static const int ads1100_data_rate[] = { 128, 32, 16, 8 };
 static const int ads1100_data_rate_bits[] = { 12, 14, 15, 16 };
 
+/* Timeout based on the minimum sample rate of 8 SPS (7.5s) */
+#define ADS1100_MAX_DRDY_TIMEOUT_US	7500000
+
 struct ads1100_data {
 	struct i2c_client *client;
 	struct regulator *reg_vdd;
@@ -123,10 +127,49 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
 	return 0;
 }
 
+static bool ads1100_new_data_not_ready(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return true;
+	} else if (ret < 3) {
+		dev_err(&data->client->dev, "Short I2C read\n");
+		return true;
+	}
+
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+	bool data_ready;
+	int datarate = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+	/* To be sure we wait 5 times more than datarate */
+	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
+
+	/* To be sure that polled value will have value after config change */
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
+				 !data_ready, wait_time,
+				 ADS1100_MAX_DRDY_TIMEOUT_US, false, data);
+}
+
 static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
+	int ret;
 
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
@@ -135,6 +178,12 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (!val2)
 		return -EINVAL;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
+
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	microvolts = regulator_get_voltage(data->reg_vdd);
 	/*
 	 * val2 is in 'micro' units, n = val2 / 1000000
@@ -149,19 +198,36 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	ret = ads1100_poll_data_ready(data);
+
+	return ret;
 }
 
 static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
 {
 	unsigned int i;
 	unsigned int size;
+	int ret;
 
 	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
 	for (i = 0; i < size; i++) {
-		if (ads1100_data_rate[i] == rate)
-			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
-						       FIELD_PREP(ADS1100_DR_MASK, i));
+		if (ads1100_data_rate[i] != rate)
+			continue;
+
+		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
+
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret)
+			return ret;
+
+		ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
+					      FIELD_PREP(ADS1100_DR_MASK, i));
+		if (ret)
+			return ret;
+
+		ret = ads1100_poll_data_ready(data);
+
+		return ret;
 	}
 
 	return -EINVAL;
-- 
2.47.3

