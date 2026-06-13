Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84539657A
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377843; cv=none; b=Q+1B1YcpsJpjLit+0N4tpcQPVb+dxdslgszNtIp3trfhe0IP7KSR4uS23W26uW40N3fkS3PI/QM1kLHB0SahDHIJbxWyx3Cf70MGB8rfqBZrHvZp+wMKfY+/D46MBX5ieVX3Dst9Rc4B3kUCTjcYI5frm1VqOuMHKUInO0idZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377843; c=relaxed/simple;
	bh=P7pHfBuzRGXNEHM0qtcu5fedmFVFkDeg8kglyBrhLbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMpLJtg+08GiGynw6p9Az0A59kSDDrAEDwKvGnoZSc3dchv7t6HWyP6MywUEA5xQEab+gSNOoPo3tEbNaujRtDQw3Nyyev5NmHBmSGxd4z+0ae6r60MDDn7IB1aM2ua8bo0tvNOAr3STsEv5snoe9oobj98c/Ol8g4qSEfxvXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEUAXmcj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEUAXmcj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-beeba001887so279339266b.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377841; x=1781982641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjXinVBWr5oKzZT7R8oqfYcCkCKQtwdSjnXjkSKyW/w=;
        b=nEUAXmcjD3ATLqvi+Hu8IBVjxVJwlSTOq7SA+trCzFT/H63cQNEzubMeCFIO15NKQ/
         VLwKVmbjBrOaGA8t9zcL6GqdY5HH6r1UaB/Y4ok1zCzEgfZpkvW81vaj4c4vTIlhnn5R
         9ymjOCXBORRPhTowj7oq5mSruqyiWtuLe+XX2pPOSsc1ucIrTENaup6WD+i39WQ/qtjt
         FStphAd52lPYvQfIvnqjmiXvJ+01dGkxfoomja7h63DYM1UDTGu2IBgZOmWZi19XZmTR
         4gRFnJfnuHWXh+ViIkfO88fYAzkGq/k7+hEa3ctkRqIy++fMKypmPwfP2kt5o0ReBgXq
         Cnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377841; x=1781982641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjXinVBWr5oKzZT7R8oqfYcCkCKQtwdSjnXjkSKyW/w=;
        b=dskbQxEXqbPvOYCJQ4AmN4RXO46R3EPcdj1NKAIHvQNeJ0bfCg7jA/wr14aNSkyl1h
         WULb5mIyuU7ekrCUWNRnAUmQCubzC+a6OzNF25CFAHEA42XkqXUexPf3hDy9AKDmqaWA
         lMNQBqsLhxMwsYptO//M3kS1Aaz8B6LT0obG4fPVxB+U38PX7iXj94nyg/C0T+GKV2kO
         q27EhiQPn4tMsewOJkdRHqD5PrzKW72D5/1U/1uLODW/6eU4DCd7OtT3ysVawRIyJVDy
         18VnqQW8T6Zc5HmSmTvMoJUmRgUHSCjkSR3gr1eqk9ZYPvJTrFuBUud7L1akbmgd7cc3
         mNgg==
X-Gm-Message-State: AOJu0YyOnBquNnoTmk9Rpg/7BSG874ViUAj2HGEA8zMe1utBvu4tKJrZ
	JhH0k2RNcojD3Ci+2nN5Nq7dk5f830YuQRl+4Zx7K2+0BJongFtlwWJN4GKDmxKS
X-Gm-Gg: Acq92OFuRzcTRhjUtZaf4XWBDIXCqEbn8DxIvCEB8CumcA/px1GvEYFgwTrB5Pr8zvs
	UeEX9gYqEufQz0g5wMQcuzeSlkVWSEFj/ATzwgzmZt6DlaE+SQ8kdySG1vlssQK7rYm/WRm+ASS
	NkhdQjVZKZG/9lKYl6rr0h+6cPtWFQqk4qpKDJj2Ba7f6Z6lS3OOQ4Y+gKCE3lv1lMfoKbmFiTr
	3M4Gyadm4HXfivbEUpEM8Icjtts0RMY3lH7vOeEcFFl6OD9i5gFWvLnbQXNiFZ8CS5kUwTWkuDX
	V2vGB7DuoKeUI5JnmoKGX+8Evwron60v5P5TbtJxuApMx3kO2x5XYqF6NLuiY5UORi8KPJvqsuO
	1egVAHJ1Ll1tUMy4Or6FIObL9gP2nUbRlAwQYy5/x1zqn8qbTZ+wcpMxkXErZ1bJMrE75SoMKME
	yJPl9SIW/JzIFBxHRHQP5C5hXnT/QoUSQ7Hjp4aw/3cR8aHfRbglOPGgrWQA==
X-Received: by 2002:a17:907:9414:b0:beb:7979:47dd with SMTP id a640c23a62f3a-bff4bbfb265mr241347866b.27.1781377840480;
        Sat, 13 Jun 2026 12:10:40 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9790:7740:8855:4d8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b2276fsm237193366b.17.2026.06.13.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 12:10:40 -0700 (PDT)
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
	krzk+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	joshua.crofts1@gmail.com,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v3 3/3] iio: adc: Fix incorrect reading when datarate changed in single mode
Date: Sat, 13 Jun 2026 21:09:57 +0200
Message-ID: <20260613190957.654798-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
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

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/ti-ads1100.c | 55 ++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 76de2466dc53..195394665cd1 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -123,6 +123,36 @@ static int ads1100_get_voltage_microvolts(struct ads1100_data *data)
 	return ads1100_get_voltage_milivolts(data) * MICRO / MILLI;
 }
 
+static bool ads1100_new_data_ready(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+	if (ret < 3) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);
+}
+
+static int ads1100_poll_data_ready(struct ads1100_data *data)
+{
+	u8 buffer[3];
+	bool data_ready;
+	int datarate = data->ads_config->data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
+   // To be sure we wait 5 times more than datarate
+	unsigned long wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
+
+	/* To be sure that polled value will have value after config change */
+	i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+
+	return read_poll_timeout(ads1100_new_data_ready, data_ready,
+				 !data_ready, wait_time,
+				 ADS1100_MAX_DRDY_TIMEOUT, false, data);
+}
+
 static int ads1100_data_bits(struct ads1100_data *data)
 {
 	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
@@ -165,6 +194,7 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 {
 	int microvolts;
 	int gain;
+	int ret;
 
 	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
 	if (val)
@@ -185,21 +215,40 @@ static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
 	if (gain < BIT(0) || gain > BIT(3))
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
 	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
 
-	return 0;
+	ret = ads1100_poll_data_ready(data);
+
+	pm_runtime_put_autosuspend(&data->client->dev);
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
-		if (data->ads_config->data_rate[i] == rate)
-			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
+		if (data->ads_config->data_rate[i] != rate)
+			continue;
+
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0)
+			return ret;
+
+		ads1100_set_config_bits(data, ADS1100_DR_MASK,
 					FIELD_PREP(ADS1100_DR_MASK, i));
+		ret = ads1100_poll_data_ready(data);
+
+		pm_runtime_put_autosuspend(&data->client->dev);
+		return ret;
 	}
 
 	return -EINVAL;
-- 
2.47.3

