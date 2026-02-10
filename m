Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3E332ECC
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756409; cv=none; b=aKMVIXeKtxmxmMPvwbuTB5Sp+6XFQmAYOFqjBwoNcXCggoN+xYoH6srQYySgweVCm+AFyTpm/8s6twytlo+Gq35yTMS4sph4uMxx7vQW/FPOhTn/xAvMCHvAMV/nUdwhr7BrkGCTvPN6b5sfE3pS1neFVhKwBj3WCLTbx56zJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756409; c=relaxed/simple;
	bh=L2xsjNTQ2sKBAoSEbdRhmHvgPTTi44GQ14ajC31jI9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moljeKD4adx3RtCxcgSgWNgcRdL/qU2/cb3SDecxCFtfa89CfVufFWqwCvzomGg1pzWKPTWAmGB4PQEVtEL99xLtsB3bFSDLZbMgN1LDKQLyOyqxn9+SD+9hRAAB4MCknQ6mrlvTGLpvUFSLyAn5RKEB+azHcXu+XA9Lexc90A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDO0fcyc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDO0fcyc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso2243945e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770756406; x=1771361206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUZ/YRPT1sN8gt3KA41XFNZVcdYG5u6xhlqAIrhH5jc=;
        b=QDO0fcycCir1m/MKpzkiZSleQV357ZqE+Lh7Q6Uu/5+R5P7rA6bWXTC4w28ZcGFOPT
         vY63c9xb5+YZL2KvMtD0z1ePE04X7YrqFhBpBCE1L+v+ULv9MMa8Ll32bdmG61qYmBO1
         YudVtxFvodGbguCEjdIug9Dz4wzFBq+/3qPgyGBIqAL1pjHROM268d6S5tJ1swZ9AIO2
         CvquMaAq4Wk66MoxwEcRlpD0jZiPShZ44cBGkjgay4IqGdu5WCBwNMGXoNMnnXq2qXwW
         691ryol9zXuTIfZ0bZKgaRBQepJUKj/2z4YqQVmMhhlt36UlPNPsai5f5ul5RZhyiKcr
         T1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756406; x=1771361206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUZ/YRPT1sN8gt3KA41XFNZVcdYG5u6xhlqAIrhH5jc=;
        b=fnjQKcRaK/2h02qDH4fniFLXb7Yim9QmpFXwJWydBn6lzZlmqKV5E5/s1LameK1m2+
         wy1SogUPaNcEnjsX58SaNEKQjW48Wlgbx8Nml+VQF7yoLAXcpHLCzqTaFZG8vAxlwIti
         wUVZVHfOP+JOphhlsWXYJh+4MzwgoE+WfGHQW4faA0jG0fi/uf2hTwdjJQicnV1+agUk
         IFN0JuUW4bGTpkEOOxt9PpuneRZiXxUz+3VU+r7ARwj622coufUo1DRhD2NYzjl+ERfL
         2NMWpCI+3PWr8FXsFmJBYM5V/bzAMfTQ2nq/OIxReU0DxQVeXEu1usNy7caJS2a7Nn0Z
         X7zg==
X-Gm-Message-State: AOJu0YxQaea9h0+RaDx1r/OR+LguemUsWB789cv8UqUaxdtAgfJA3OOA
	gNNWOeAL0zaQ8B/L9R7XAn7cTLacne2GF5d4I4fFItLys4Lg2oW2eBGN
X-Gm-Gg: AZuq6aKC3RXlbeYB3D76R69n8indH7ysfos6mJTbJ8WwmyHzCTc3h3JgvZ8Px1nPvWK
	kZ7TqWYWvQu17vG+dGYOn28wdaiVWeRv/Hx3VWQzJDnf7E5BmcUCtCLzrnla8YbUV/Ue01vN4pV
	uuTkeeFK4rgr2E6UlZoXOle7MNKZ4sBbaWKqtL0uaqaKRWBBVOxrWUxpjfLnRyhbg09JwHyL4tV
	ceVJjUbHovKEb6IwGQHPhxvfdn9vSkvZXhqJGn7MyLlVihQXZNXnUMRAnpbDfnqwbh7hkcqKvMC
	dB2ZVvCWBfOFrDmHfDJ0IjVW+etp+qg1RxoBln5brSURFWToOnT2ne7bHaQjD+7I29w5v8p3S9P
	14nYg5cPjOqHDfNK7PUqLEZog3j1RuoJQ7W5JfNWZmIZFiWcEAy1xJoFvN7644r6Tui6qamz06W
	byMWFht3JarxXpJ/KLXO864aF6PQ==
X-Received: by 2002:a05:600c:820c:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-4835054f3f4mr58429895e9.18.1770756406345;
        Tue, 10 Feb 2026 12:46:46 -0800 (PST)
Received: from [192.168.8.10] ([2a00:f502:160:28bc:a26c:adcb:8da8:2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d6f3esm71451965e9.9.2026.02.10.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:46:45 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 10 Feb 2026 22:46:11 +0200
Subject: [PATCH 2/2] iio: light: vcnl4000: add support for Capella CM36686
 and CM36672P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-cm36686-v1-2-aef68dd46ad4@gmail.com>
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
In-Reply-To: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Add support for Capella's CM36686 and CM36672P sensors. Capella
CM36686 is an ambient light and proximity sensor that is fully
compatible with VCNL4040 and can be used as is. For CM36672P, which is
a proximity-only sensor, also remove the IIO_LIGHT channel.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index a36c23813679..97dd930d57f6 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
+	CM36672P,
 	VCNL4000,
 	VCNL4010,
 	VCNL4040,
@@ -240,6 +241,8 @@ static const struct i2c_device_id vcnl4000_id[] = {
 	{ "vcnl4020", VCNL4010 },
 	{ "vcnl4040", VCNL4040 },
 	{ "vcnl4200", VCNL4200 },
+	{ "cm36672p", CM36672P },
+	{ "cm36686", VCNL4040 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
@@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 	}
 };
 
+static const struct iio_chan_spec cm36672p_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.ext_info = vcnl4000_ext_info,
+		.event_spec = vcnl4040_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
+	}
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
@@ -1867,6 +1886,19 @@ static const struct iio_info vcnl4040_info = {
 };
 
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
+	[CM36672P] = {
+		.prod = "CM36672P",
+		.init = vcnl4200_init,
+		.measure_proximity = vcnl4200_measure_proximity,
+		.set_power_state = vcnl4200_set_power_state,
+		.channels = cm36672p_channels,
+		.num_channels = ARRAY_SIZE(cm36672p_channels),
+		.info = &vcnl4040_info,
+		.irq_thread = vcnl4040_irq_thread,
+		.int_reg = VCNL4040_INT_FLAGS,
+		.ps_it_times = &vcnl4040_ps_it_times,
+		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+	},
 	[VCNL4000] = {
 		.prod = "VCNL4000",
 		.init = vcnl4000_init,
@@ -2053,6 +2085,14 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 		.compatible = "vishay,vcnl4200",
 		.data = (void *)VCNL4200,
 	},
+	{
+		.compatible = "capella,cm36672p",
+		.data = (void *)CM36672P,
+	},
+	{
+		.compatible = "capella,cm36686",
+		.data = (void *)VCNL4040,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);

-- 
2.53.0

