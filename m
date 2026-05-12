Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D7230264
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549021; cv=none; b=qjN3LdcFqSLRKSTb1MXg9X+SleQ28/4OlePAOsBqNW2cvRMagRbHPu+r5DyPrJnAXVayE1LppBYUJUE7x6mNvQ0QUqe6ae3nekOlTUJgX79e1UGdze0fcbNnw76qBUM0xKD852C/ryHDHI+nNBGhiB03cJTN5wYU1mbj1s9jNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549021; c=relaxed/simple;
	bh=Dnn1CGS+4OZOJShrWTbuyQ6nfUqx5TGkH6Z+F5fnlXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2rAvzWvhlBzqfsb+oIf2KZykTbb1wVxNPa78KYclJ/vMpL5Csbnz7XOP7KzbYfHjKlDeZad68qov9qSkiqmGtis++0nxd0vkYTM3YTFstmH8SSbz9UAcKara7gX8EAdEgYqLNtYkIOvq14XfycPsojS3VwTr8eFZEiPC5c8FaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=DxLdhC77; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="DxLdhC77"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so7553252eec.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549020; x=1779153820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=DxLdhC77GJ+mFq7nEckkO0W/rH4GUrUN7Jd1EUu/uWO7J66ek19zoAaYsXjiJrYJA9
         14b9YgC9pwgK30u1AHOprc29qK0vneWXzp4BG0e3R6V2wK1Qmg89iM0V7tCtUkB9LhxK
         Xb0RfhGFTWcWjj5hnfShzM4dnA7rFaYDUmp4QQXHsKhWd1UzaO+gmFIBMtVNdLO6D+Nd
         /ndqCHPes7gUwnzWisHJNvdhXa4f9n6dCSCLxskODkbDidZF036z92mimnmJR9duA0C1
         5Hm8er4If0CMPJ+5FFfW5j7FWmEh8uNnvQ0SYyeFVVQHyxbfLbSCjfV5cw5s86CaO2ay
         T6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549020; x=1779153820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=V94bS3ZMpqpahXw8G+Q5a9FIkWnb0dp0RZWBU4c02BErI+byLTblMqKSvcd1ntiqL1
         yPk8N8CDLQOO3DJ6+9WjHwQpHRuqRE3a/98XnZm/OQCbuwVxR+U3tyBr1bw+2FTYSzyP
         3MWfyGQO07CBHv+ejeuVTo38/r4Lcn7FCJTKY+PtW9aBbvSC4hFY+nhpjGka/eGQcVXV
         S7AvtnESgXwcyg2fWXSkcQe5CsdwsQMebOWC+xeYBNpfsWxx06SQA2geGsHenHhN7/zP
         mNvL39h1lbLMB1ALa6O3wX6Kf+vFhIqNLLgFvol/dYPOkd0YX2AG8i7bOtHLSvlP54y8
         TsiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oZv8wRJutFGVHGChY+z6OEgLlunnwhm8R2vMV5uLq+KI5YOV7niPtV9f6VntHYRWdp5KHsoz3qh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGwN56po4zN4CiyLfn/zhG08uGc51aS29HFU0Nim6+h9SxfkN
	jXrbxIOLyV5Js4SPxKeX1QZ12hGaZrREObtyAZEVpPzC6b5ggHAEEvzbQ7sDPP0a81g=
X-Gm-Gg: Acq92OE5Cix2MiVytotTn89bBjrEfXt1OnWD8BQDi19dEliTw0tz+gxs1F1tx/ZYnHk
	5IrBVTa5GWJaGvfVsWylHN4A0mNKMdvgk/OzOmihDf09aC2+l+2CfTeVREDeACg5pv8kgUH9yB5
	1WwxD2L5Iwg+WzGVr/Wln/d1om0QnwSdDgZmMQL40CZ/rM44Yvek3JZBu5ZDqhgOrQUcH/CXybk
	m/OotEc5pnUXS1e0O9vFLN42fwPLpFTRt6ExhKXy9vdzihqus+Mes1k/fXoyoH/BifmSpJas/Kp
	nbAIFztDrfs9ODGK9vc30N1bOp0e+AlPiDSaLm/8jQxUBpYRy0GGGQwqgl/lx/kxIdXJzzMGpi7
	D35IYhG6JYZhDFLsUs7CbWdkk+i95QR/DavGMr9ys3wW1C1aN1akjoKl/Kgdpwp99Fn4tVj8Q2i
	n51Sbc/80khiAyfjJX202tlHm6QlajSQ==
X-Received: by 2002:a05:7300:ad10:b0:2ed:e17:d50e with SMTP id 5a478bee46e88-2fb4c3e3eb8mr5838968eec.33.1778549019774;
        Mon, 11 May 2026 18:23:39 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:39 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 5/6] iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:21 -0300
Message-ID: <20260512012302.20883-6-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local magn_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..3b26dc41dd4c 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -132,17 +133,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,9 +408,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
-								*chan_count,
-								st->magn[i].size);
+				_channels[*chan_count].scan_type = (struct iio_scan_type) {
+					.format = 's',
+					.realbits = BYTES_TO_BITS(st->magn[i].size),
+					.storagebits = BITS_PER_TYPE(u32),
+				};
 			}
 			(*chan_count)++;
 		}
-- 
2.51.0

