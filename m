Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72623C4FA
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673200; cv=none; b=YrqCutJqnjGJetzdk3MBbk3UDWRq+8Ndn91qvK7aAeZkRc9or9DPZFOJo9B6+xnx1TF5SV0jYsSgiRQYy58mNb6PlASd9HF1lIYtw1uXG9MHNX9A4YvI9WeSLz+5C8vbjc621Oie5HJDDFQsCa4jdCpR5r74GZdw7mwYUd5DngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673200; c=relaxed/simple;
	bh=a5s5z+cub3SAmh1xynpckVoWZ22C7+19bL3gHnAgtKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rx3pr2Au1o0CjqWzkJbASHcVzsnju2XypJFBH6Iu9CUpa51hUJ3aai6oxFbJjO78g+PstnRQUapNS87PeNsGQH9t6Ejw074uGgZXVov0Yk2gUaJ6WyOLDNMgE6xzuleS399CnETQ6yGY1pXTf3mJbqGEvp7IWAbIEQWpdqLZNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FKTSMYWG; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FKTSMYWG"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de7c57b52cso8103871a34.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673192; x=1780277992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkaH77BKXkVbsk7oK6FTHGHPATCcUs5m7bHAn/ge5ys=;
        b=FKTSMYWGLQZXd/2EW8n8yhjRCTpaukSWMPmBfwktwQ/FxJVQd4zVGr1h8sDgjBfPV4
         uQ0oFJOh0z5GT0h9bgBdLnZN/uLhKJgUszWYovelPMlfu8qM+I8PvGInp2zRGYmBf5nR
         xyHAhgBHpiqUH72rUZtJ+e1+Cfgpg+DuLf8NWoy9jKK5J1RvEBxl8deOqodAL5DTieBZ
         pAcH3ouBd2/MBXFm+Ym39rmIGJaeB59ktvE3HI8v0dY57X4layyhKaI/svue/B7uaZga
         /Z8ZCs9CSQYZOscyUPbpp+NgmPJOG6JDsR0TvtnUI2bUaROWgEIPPGF/Cr8CFS1TYod2
         o52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673192; x=1780277992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkaH77BKXkVbsk7oK6FTHGHPATCcUs5m7bHAn/ge5ys=;
        b=HFdhAymF9X+nYJm0WYSZaWIPOIbHwE5stn7OiIPz1iP1HbfZcjTKCbm6uRMijrw7vk
         8RtFODFs2HuMv+Nn0wOkJorM4+FjdK6uAE9AKpD0eFTKcyffdUcV5UUfPGgJKnI4xbnN
         dnCXFpDiPDf6pzAb3D85JaZS5UrSfeI5sPCAQBvKcAWWzzh2ehEFWvU3cQ0Ra4FlAdLl
         o2D7rODjadJFsLUgHCbnOPcT54rWQDs3sitXkQiXEbYu9VqQN8Uol6+B+1ZH/M65qsbc
         EvQea24gp/NR9E39WN8EtrDp4cyWGTibMC0/dLmIjD1RgmSM2J9la8Q5SmFNUX0YQI6o
         akDw==
X-Gm-Message-State: AOJu0YxDynTsSYENyQA8klfgpSm3fbnvXb+o/5x8FqYiDiSlsjkFfIad
	YBJtTt5+3XT6Dc9sveNw74CAOBS33ezbeVeiTrL/MpbsvAcxkAW/q0/nICHs7DPlDAE=
X-Gm-Gg: Acq92OE8TztjJiKRqQKEKvGT784UUfb0AnfcrM3DvWhgwZmeBITvPAnosDoIare6/bZ
	lfCDXoL7o/JuDpN7PFMRhqQDe8STvyv1q2fDV/vzTt6SpyrGi42cBtqRR91NXujlDKmwSlf/HfN
	BrjolVgcMqD+OSXuGo5SlD+0oucrE2YBkD5EUMzk+Dk+vWwS3T3u5sAL1B/1ATcR46eEXEBIzQW
	iGW5MOpJRnuUFVB9p2gqOmbfxQKIfTWiPap32GoKq5pt29tyuJpIGbajFeQb6uFtPaVil+Sv31V
	7muH8W0Z0qn43vmKmX59uH673+TAwKj4/KteQcQBg403WZTnNd8MydnT7JGW8gzC5+mP3fW97oU
	s66b2cIflLJOhEK92Ymk7f67tQnCQ6M3ELB5CtFICy+EHX1LMMBTw1A4G7jDrF6zqDSkssXywAr
	iwYRExAZCpMLwVscSX0cSaEn5dIyHO
X-Received: by 2002:a05:6830:67eb:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7e5fedf1913mr8821807a34.11.1779673192588;
        Sun, 24 May 2026 18:39:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:37 -0500
Subject: [PATCH v2 5/9] iio: adc: cc10001_adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-5-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=a5s5z+cub3SAmh1xynpckVoWZ22C7+19bL3gHnAgtKo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6g/yjb213zQLbMwk6iuHebY91dnjXtb+FUCD
 vvtjZPSn4+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoPwAKCRDCzCAB/wGP
 wPwgB/kBmXUguncTbHCacyEQoFcxVZzlf/TOYZUKfnV2TLLum71flgDtMY1b0gdyXRmp3fM/OyK
 GuIvva8ImnHI+QUy7DVup2FJijaxuRZL4liv8BzuDmz+jrk+tGdFxjou/iziU5yzpsxn3h0UReg
 crutlwGxtN4TM7gBRUBqtvDGeGuTAtMiyHz3lJidkFemL9Vnwdy11RXMoLo6xpspnIby3loNKcM
 rwkb03JkzYTPV90rUuc1zVI4NWRdGhcSJ6QcGg25nQV8e+pjnmj4ZPxBeI518VkgGwI2bg+ySOG
 7EkIojBOcPvtAZMyAu4+KQxGhDwPFUmM2l1bB+pLFJTdoSgq
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
index 2c51b90b7101..d42b747325aa 100644
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
+	chan_array[idx] = IIO_CHAN_SOFT_TIMESTAMP(idx);
 
 	indio_dev->channels = chan_array;
 

-- 
2.43.0

