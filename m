Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6B3C345F
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041914; cv=none; b=Fzk6kJBsg0ksk6ScZt4VpOIO16lK9dwVjlxgY14ToBzFDNXM8T9v7tcJWRhPSvSWb3e2Z1vJFW5nrWQWO6iCgMvodPqnrzEPEANWz7w2BQjQl0WJMtHYWkV7HBShpq6/LGkGgf7dObq+I6EwI8z4r6LqEjgLqaNXKU1EMEGE2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041914; c=relaxed/simple;
	bh=jMaxL+lkdri/M+fKkvGNkjtPGnxhg7f3ihACoPlbHZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY448Wkggn7BNT6h0cVuDsSPFadT7VyYFn75TPk9F/7Ut1W/wtHmkqxzrkzS0wuvLxzRLtU2GXsuNffY61pP7Fa8ukzSbXjFnKYizZPiUEkAoUEDzB06LC53oNqRMvT5hu7xWSPh2sUMLsFnrovZkncRn7U2jdGNMvVogUyTU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aHpGgwin; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aHpGgwin"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-434e69e943bso1315514fac.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041911; x=1779646711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6UxGHyqTBFAbz6gyJLQjZxvD5Vh1uuTNWv0BztIsXk=;
        b=aHpGgwinzY3nYe3lstn1gOA6SDBIaldb2qtBmwuv/59pN+hewgRljfpUkGJzsO5t6n
         ToAqZJwFxWuGJ35voalJ/xtYGN4UF92CcgMwchylIM3rAA4pzaLlCyoWB7ZeQIZTnATQ
         bHFx/6NN+Q6+Qxa0GWFpaZSPUrB1xkLln6kfK5P2Www543sbwZgSy3XQtHq/nxo2bThE
         LWu8CHYZ/V9Fxv9f+9JxRZv2CxaXxJVBEyQ/eQHMbIpL7bdYUDVqJHI4jVElFKruDVMN
         l3fVaLNpHiCzOzA7pfF403YF7OFIeX8YnZ6M2m5otY+IC2jhnRo91ditzp/tOLHLbEIQ
         oLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041911; x=1779646711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G6UxGHyqTBFAbz6gyJLQjZxvD5Vh1uuTNWv0BztIsXk=;
        b=g3ViQzEuIIeuM3X8rwFqyHi0qgtkHIZFRqT330xzE50rifVPgpbQtb/ksjRUF+rhxT
         yyrpwIWCKCH8rVoDV/k5pivWUaHN1gBkD2Xm6OzxJpLOHRvkhAKe1H0ZjDo0AVItpLSR
         i2p0tG86VxSAqCwB3Nrr8XuUjQygOyWV5OVqggzchoJzUGVuMlQMy8AFdIs1KLzhds4X
         5wrVGtV3x4B1Ley3kvRyE81naBoersKbUPFnvbNYSe3T8pZKjsi7raU9cxR2M+X+CO5R
         d0WneYud4pdVrCXmOCR15JFMFdWCrVqsrIiTL08bYpooQNTfSi0FFvL1NR+97YhnSp1/
         qz1w==
X-Gm-Message-State: AOJu0YwnuAvJuPz17z4yr1R+NzGJmBCdpMxj6moQf/rqi2Cc1hzu+tDa
	NhP1pmBjAPtbsy9LErUZCnFAzItqa8STja6l6oSoc9vfKIdtDLtrOIm4aIPHMhjyWsk=
X-Gm-Gg: Acq92OFOf5Aw42sfTGtDrfd9HuLp9NAYWeJDhIFZVKlT/ap5ktK0qkWDQsRTflx52/a
	C4o1kvT7YR1cY24aLcnV1XMIJTuCGP1sZVlhFAcC2/hKxfdgVxkaFsRYIdEZPN7z3eq1sMb1cPm
	dOdChLz+K5gaypwq5vsJd7TPlDyItRrGFTQWXgn2YWMSVqCflDp6H/3u7dQ1N+h+sRuUljahmNE
	fgQR+aX6oUsmQEOpgVt5ddAhdHgvwe+HwqMciC8GLBWF70Hottg8gjbLx9VpvkNuPOLROJU8hWE
	6WUUuhKP+wRP4450m0PgQCK2yIVaGGYXv8k0XZM4Fx28rHzFlnlLfKCXx5ft4vUyxMtg5HHBQ2C
	LgLuU3/RQVxn6EOabUNDZZh06a5Tiqbv63wAxvbsK/3UJRJN0APlNoHWokSsgx61oMy4vK7qfNe
	W/Ca8ogBGLP7yAjnM3BRm6pSpU17523dny1Mfjng==
X-Received: by 2002:a05:6820:6ae5:b0:69b:94ac:da1d with SMTP id 006d021491bc7-69c94373aa3mr7665754eaf.38.1779041911234;
        Sun, 17 May 2026 11:18:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:21 -0500
Subject: [PATCH 4/8] iio: adc: cc10001_adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-4-61fb908c11c7@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=jMaxL+lkdri/M+fKkvGNkjtPGnxhg7f3ihACoPlbHZ4=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLK42Lwuqlm/LFjzrVdp+58P61ccz7ZW2e2/qC23Qn9z3
 bJVJRxmnYzGLAyMXAyyYoosbyRuzkvia74250bGDJhBrEwgUxi4OAVgIlP62f/ZLFZfcLFibrc3
 L59V+K3MP4681b2Wy4+dNUxVc0yRUV3H/aJx8zJ1P7sj6lFPb562tff/oLnrSySLgKhv/mxTR7m
 nkhfDlfo0+sL5NizIzBdl+3rFy/2XxEvrnwUlzj9DXoSJ3r1toXztdeLZdS8Yw8KL0vLiPbVqwu
 Y+3yT/u//QlDc3ngocPe/GckMkWUxYSFq+5ar8aaZncVJRotZ3daYv/i9+kkW3sZKnL6M5SH837
 9RdT17PFssTckpp46z7c/2oiTZ/wiatj4Zrl/L4ZAifEK+QNHl42d/YO2nqvTPcUp6cX+ua3sXO
 7/onvHhaMOeZJtGpwbGqf6UyPe3FNVk27JE9czA1UuoxAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/cc10001_adc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 2c51b90b7101..9ca6a6b33740 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -262,7 +262,7 @@ static const struct iio_info cc10001_adc_info = {
 static int cc10001_adc_channel_init(struct iio_dev *indio_dev,
 				    unsigned long channel_map)
 {
-	struct iio_chan_spec *chan_array, *timestamp;
+	struct iio_chan_spec *chan_array;
 	unsigned int bit, idx = 0;
 
 	indio_dev->num_channels = bitmap_weight(&channel_map,
@@ -289,13 +289,7 @@ static int cc10001_adc_channel_init(struct iio_dev *indio_dev,
 		idx++;
 	}
 
-	timestamp = &chan_array[idx];
-	timestamp->type = IIO_TIMESTAMP;
-	timestamp->channel = -1;
-	timestamp->scan_index = idx;
-	timestamp->scan_type.sign = 's';
-	timestamp->scan_type.realbits = 64;
-	timestamp->scan_type.storagebits = 64;
+	chan_array[idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(idx);
 
 	indio_dev->channels = chan_array;
 

-- 
2.43.0

