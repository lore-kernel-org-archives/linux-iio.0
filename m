Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66176412BF1
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137631; cv=none; b=NlBXv2BapSUS/0Chqot9YyQPaVfSvwqanYZdDxVMpQhQVQH6bTcCnJxD2illiG/vuYP/leb8o6epUFQtVW6qeUnokDIcWhgpRWSuQWi5kvzf/0UbeR7ctl97vuTG+zwWTEpscWLfy2kGqlNRDR0kLaw1ahQUwF6VvnFwmhFoV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137631; c=relaxed/simple;
	bh=YVVtnr0A9jYmk/5Usqe+bn6itPUyapVzTFfPGrl90gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JN/dhEeyWHbAQZTWC9uHXFWl3T9SNw54nJgW4/a4J/yuh1DcqM+OQlkMxlBXHXLEyW3JuQ+w8mgAInrP5AQeVWGOtMXmenF6V2aJUEfFccnljPjLWQVdVW0Qnr77VvhPrEXR74ordKqM2H5+YtbqOEIoHu8Ua1QwEe0Tm4qx35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IDaFnoMm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IDaFnoMm"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-45837e52d8aso1324857fac.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786137629; x=1786742429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hciBT8CJBuG+LRuJCBFyHKaU7nB64CsMQkGbuYhQTKM=;
        b=IDaFnoMmiYfF5VwBo67dpprDYmO83utYGFSopu1sx22brTbC4J+PrzfQDLeIuctQFy
         cpS0aiAJXwAdNvVX3ZYcr/05/s6PaH/txcV+9inGy/4N30Dk5yc1UHCu5FZ9DH8Wm6/D
         TpUL/tWZUKv46/NLcdGIIwoXocZtNlzyw9Ru+YcDLc+DE/JDb0ModZ1uuSRBqjIpE6oi
         k/WaZ4rpQ8OGpOwVLvvwGTAzVZit0AR0mHhv2gINBZWFd9M0l8eX4EJaDL/MMww86ook
         dIblvnjoTTvUCceK76E3p0bJb45uLLnX0tDSHjq3L6fcrMiKKOTziOu+SmZxEU689vuI
         Xunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137629; x=1786742429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hciBT8CJBuG+LRuJCBFyHKaU7nB64CsMQkGbuYhQTKM=;
        b=G6A6eX+4qnL77C1qTunug0YJrh6073Gte4bCGW17+mNvld1HVxnHMYkMgzHc7vt7MJ
         hcqRiYJqrHsyeYLoaPmILL/wbcfpYqnmATbQvzAaVWRNZ30oP3QoPU+Zx2EOfH1Yw+7U
         KLQPtEBfM9V+em4M/Kdi9zoNXX9uory6ARfyhhhNyFLNvoQaNfWoTOzlDA9rsKJbOsv4
         yMONCfSv4MOVlP/AEXwIHagrUyZkXNzgnRFRPzFfNkOCbowR3weI7kecYqmv9lLHJ3wZ
         z9zLUTELufCSlKCZRFJVdTMZ/QYy6NbPcXZNzm+cyviWFZXdZKJQKnh26NdmlRSMV9Q2
         AQCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSXSSVKlkldjhcQU6U/yZZzINoIa3LcjCDIElx7MiA66/T1Jtwxd6eV2/jlKaC4E0WTIrdW08MM24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOoTrCeBA2Ns7vmlii5cGYdcy23Mnv3Hmj24S5W2KIWxVDEct
	GDmlqzFudxlDaqYEyZ0441RHMi8mjK52NaazI1re/oblb3rsu4bu1ytlV69c1hc1QSg=
X-Gm-Gg: AR+sD126n2BqzfGxcyREFENCwBEogqiroiosd6afez1AZOQWQ9GCg5pRTkqFCWN8tpf
	R/Iu+GdNqj3YZhAknY3YhROpnw/Dy2a1vQH3xpCWFWMlnBscuqcWhv0mJ0NhK4VID7+k2HxAp1w
	3MCUFCLGt4Hrc9SQXYuB0o49XYLyfrCSJdUHd48JeaiMrXNS1b0hQqX4Katjz9kijFBWnJIKvkw
	W4+HJd/HOQSVqk0AbTV1xCakp0U+6+dSpYv/LJutuKdKu1MhjIp3rnnm+UZZPqEofnOe6nC3Uxx
	f52xtmqszjwQkthnnSn/kJBHH/SZ4fasgrcTVWYFeB3XdU0S8AjGATJDhiEuSr/EEHtwP8Au0ZK
	g0LjIyRq+T8MKVtlVJC5V5hsGS0jTZKgbXw2ik1j+RlvQB6D7br8Awe/0WuWfshViWr6jF2pm4M
	Rs3FTBtsuPpvAcpB5bP6GW1VTQZ0eiqiWIyp7FL1wNOwGhLG8OS9vlmp0fG1KZPMSK
X-Received: by 2002:a05:6808:1986:b0:4a3:fb6c:9adf with SMTP id 5614622812f47-4afae067fe6mr16133623b6e.12.1786137629212;
        Fri, 07 Aug 2026 14:20:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af0bafa1sm508068b6e.7.2026.08.07.14.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:20:28 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 16:19:47 -0500
Subject: [PATCH v3 2/3] iio: adc: ti-ads112c14: create data read helper
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-2-76e0d30e6c6b@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YVVtnr0A9jYmk/5Usqe+bn6itPUyapVzTFfPGrl90gg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdkwD3Y5HUVzc0t++GLovebvO/JMdDgOSD919Q
 0yGW6sgQUuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZMAwAKCRDCzCAB/wGP
 wLvkB/kBS41YEs/bpaovaBkybq6qa+d6y7ZqxGOwZtYJv1arqjKRcPju5ztLcA4V7LdIQmEQXYF
 H17zonptRwKZ6VhpBJpzq6d5OXxoL0nIogJr4iZt6a5Ft6s4GTRjUWEmDoUUxIY1A4wlktKva+3
 BK9B39J/pn8xgbcv7WaLRJR464c7BIbRhTaJonfrkHYgU0RZV/2dNUVKC7USwEW4nyoEY6GHvkz
 OwAx4OutiIwhdCNjbhSQqCJma/z9hu8ln3QjtLMkzCtXLPNBsAt6pBYkXsHce22UHohYx0Jh++m
 MUJIui3Ccxg8GHnbi8Bo5xJaU4x0JXs57w+CUDpzNf9SSFVB
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor a few bits of code into helper functions. These will be reused
when continuous mode support is added in a later patch.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 457d2db28d3f..8481012c9e3d 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -601,6 +601,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_prepare_channel(struct ads112c14_data *data,
+				     const struct iio_chan_spec *chan)
+{
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
+		return ads112c14_prepare_measurement_channel(data, chan);
+
+	return ads112c14_prepare_sys_mon_channel(data, chan);
+}
+
+static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
+{
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	int ret;
+	u8 len;
+
+	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
+	if (data->i2c_crc_enabled)
+		len += 1;
+
+	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
 {
 	unsigned long remaining;
@@ -644,15 +670,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		ret = ads112c14_prepare_measurement_channel(data, chan);
-		if (ret)
-			return ret;
-	} else {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
-		if (ret)
-			return ret;
-	}
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
 
 	if (data->drdy_irq)
 		ret = ads112c14_wait_for_conversion_irq(data);
@@ -667,17 +687,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	 * with CRC errors, but rather leave it to userspace to decide what to
 	 * do.
 	 */
-	if (for_scan) {
-		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
-			 (data->i2c_crc_enabled ? 1 : 0);
-
-		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-						    len, buf);
-		if (ret < 0)
-			return ret;
-
-		return 0;
-	}
+	if (for_scan)
+		return ads112c14_scan_read(data, buf);
 
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),

-- 
2.43.0

