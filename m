Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638E3A3807
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234505; cv=none; b=JScI2YdctSzYJ5hURtev87a6IXWSXDjI5YkQBf/xoRL2wOusisKbIJfdjrULDq6dT5X1uqYEiSxUjM7SDKcWwM67lRvSVXqWcDdi6z3mheFjyal99Sq52d2i7hLqXFARp6Beck61F+OXGTAJpEg1JfFlXEpptoMRx3VvS4bztG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234505; c=relaxed/simple;
	bh=t62DpAaPNnoZZ/jlZXdUjwjPRqbxjIgCXI2RGSb7HZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrvpYvSJ7JgSg32ylr7VecjK53QDrNRIcYUOZyKIZ3lNOUhXXSciSXUbnVQr7aQA/LuF57EXaQNkXqOyftWrjWGjg8dsz/QFlRn3VMwzw3c9nvO1Wzccyb2aSZ5ZE9hNowNJkgfjSYeLIjr8K+XYgHabDQ836C3mMTftBozuaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=xGQGrSMY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="xGQGrSMY"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6b9bca48so65477861cf.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234502; x=1779839302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=xGQGrSMYHTWIfPqTlCbkJmZbkvHsvp4ahzO7qXw+rtiEP6AK7Qo+hzOlkG20ZFQPYE
         RoNykkSt52yaVDsQEPKlsw3RM3N9njNXFxVklXT7eHkuS6RIOuYdEtqZqa6yF0mbzn6S
         1NurRq5Xpmh+tH3mMYxu5g35zldcN6/KdlHbBDKyuki2xTTpXGk3wW8WfE/ij3vZN85n
         3hdjNmUsAksd/rWuuU+brrXR2DvjDb86QBuTP94A/+XxBzWXBF8L8Dzr6NIUIA1AH1Wi
         J3FWWQx/vEj5hOnIiupMgwMpXt1czYwMFQXG6MNz6VH7WEE6jpchD2zTAZgsZ6ZRkynk
         JG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234502; x=1779839302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=om4QHyPjlkzn82HD+wPrJlGogsqDJKMCikVxz9RE6FR5B5xnVc3/2WJdsVuWWmib/F
         x3+yRVL07oUX0YceSklMPMjgau5DKIcbpvVuOHnBCAygfrO+EK5tPxoZ7epbQpCDewjC
         otcFsGHWP5fbOHLlTvfVNQSL+0gc/i43PdHIX2qF/SjdRcWyi3OTRi+Z9nTNYRnnCquS
         bmoneMp3+yjPOAZ+vbn0o2SMeN7mmyFiHAHkJyaX1zfU8uv8flWOxW3+bSWYd9Q7Ezli
         OhtopLT8gDGuaRtA6Y1R0BALh+Xn2eabt5eRQgle5jIBamb8E6tCNhah479m7mKJFBfw
         FrnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/x7LsZijhlYcg7dSZfqr4keMswLKmVEpu2ZQEYUWjYeAjwZHBFuJOQwTtKBZU2yZdHSmWKFc89fRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRqNUdebAX/e5NktIADr3HTjlPRvRbsoQ9jCSjJEW9n04ms2I
	knxsxPXVEB4wh/Ao4znfH1Se/TCZfKPA+LhzRC4xtOqy/92HGY37bvi5Kr7H+sAQ7mU=
X-Gm-Gg: Acq92OHgkU2uR4r8p3FsjrZEYfzTT2Hp7Cu+MNRi8J2ttXuGuLo+SzonbQT4JNKycG2
	KcftaAeAoo+QpuTh1/sBQWj3Dz2PgJOhoBal7hH4/pwlSXVuaO5w2ahYu+3OWwpdCDqkWbdOrcX
	MpqYR3HxO0sjafHI68F+tAuFsFUlHTlhvjx+QR85KNnnqh2F56ph6VVI1+q5Xcx9C6zuC2J2x4g
	pxw9HH2hPH3AZVVMmDUvLWDktBZ9EylpDJLFpd/YzqSil/vaBwnTluZjxMcehowg07NnMDgEq5F
	j2cRWnp/p85e+E3mdiEv3mYiRz86AZBlJvJG89phEV8u5NibcbCalYhfrjJwI42D9mH+hEMWsSn
	1cEbYLlDBTvl0Sh4urhD0HAGq2Vr01rOlagBNbetb14TWZhV8N7XRAlvql3gssU414TSzT7P3jH
	l445P1EVPoIzxa8i3eJt0d/seB/kA0MBbQw7OlkT4=
X-Received: by 2002:a05:622a:4c11:b0:50f:bb11:df41 with SMTP id d75a77b69052e-5165a25a5c4mr302056771cf.60.1779234502439;
        Tue, 19 May 2026 16:48:22 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:22 -0700 (PDT)
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
Subject: [PATCH v4 3/6] iio: light: HID: hid-sensor-als: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:45 -0300
Message-ID: <20260519234752.23911-4-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local als_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-als.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..d72e260b8266 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -117,17 +118,6 @@ static const struct iio_chan_spec als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int als_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -335,7 +325,11 @@ static int als_parse_report(struct platform_device *pdev,
 
 		channels[index] = als_channels[i];
 		st->als_scan_mask[0] |= BIT(i);
-		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		channels[index].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->als[i].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
-- 
2.51.0

