Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24716F288
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777101422; cv=none; b=gRmhCrUj359jlXCWshqS4hpgt0VZkqe8AvgGjn86o+LKn7KvxV2dz031dItobRrxXJkecvYrxOg/QY+QgCjJj3W2kIFaZuks+QutIiOoUn2LJpM0yS099oLCGfGPXrd/GObharzF43SvRMGCkLDSirz/QIDlApJf0AKsd9tTgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777101422; c=relaxed/simple;
	bh=6E1Jf0oOk5cW7P5rF7bAf1b1uPOSs0RvaPt6g4KYIv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGG86NzV0OPjyPraCD7DoKcclPDtF/590Yr4wTLqZRA5wv7Xu2dHfy6aKMyhi+h8j1+al7ZOxou1KKPr/jewgc+DxymLnHXjQZzKDcOvAPsqB/Kv/JEAd63IAKi/TftMCRNCYCrUbLKa4s0PH6FCpR1vtCsN4LvYLsnByvW5Caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjqsI+m2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjqsI+m2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483708b697cso12012865e9.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777101417; x=1777706217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Kw53BCBxBdhNeoNG4cmt19pVK6A3f+DDtPNjBafBg=;
        b=KjqsI+m2TClEJn4ZrQSms67QIbakGDvTm9FBPUSD+msb4rdNyS43MGIkCQE0sWsZfT
         0MwwusRPHaV5QTrINBpz6hsx7WRYmREVeTzRSvBW2JLpzQfL80cY0qmdKTPyV3F3HUIQ
         NThzgRC3txpbD6Guo7IkkaC8M2EtL/DFIO/R7ZmMJxXKqBA5d7sNvhkSggSyw0gIZlXQ
         KgYj2bNWNCMPEwBRZ+szjpYgZQnXLEh4nRMlI/FD9bhhVKjsBoTa9j0g+HzDVowso/DI
         XtTP9+pRB4rkAa8QH6zPfaHOMPrhMnf0tgMO7wkjRjMb1/sP9mGiFl221DWG+YiauQfq
         cLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777101417; x=1777706217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8Kw53BCBxBdhNeoNG4cmt19pVK6A3f+DDtPNjBafBg=;
        b=MbT9SebnNgtXM1UZcL/GUvPMjuhcRBtCJ9jWA92P7fUdlgMtLxERtqY4q70/pRtt+0
         BGK+rXEvf776VUErr16/6+iMOlEs6BhUToVpF8un30x445MI5gQWdFT1ijZVilkJCX/C
         lCeXUc64fPHgnPZQ1YtfFpIB/fgub6dtiavWQrW+trZ3S1T3hc5qwkVMiW5ZV0GGIaML
         PnC2BNDQTehfcuErAvB1bn0tIncseRtIOT9QlMYe2/ZWTfZ6km/tIdDFFFoebnkL5/zP
         iQBgx+lB0v/I+6SvhraoCXz03O/LsYt+Z6XDTzZ3Pp09cGNtfJdU0o9YhYZN6J9krMT5
         2pTw==
X-Forwarded-Encrypted: i=1; AFNElJ/INqRjJFMyzr6yqYdrg4fEBiNA2JQwUtDbo7BrBNTLnj77PH5EX2qfOd+FpV7Mh7yCQ/gWtUQrF3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3FmjTKRmnElrD1joCalEABBxuqt0issL6FMFEXaWYk934Lmz
	TGJfOdn43wUGmbsCRRGghG/EY6RjscONHNutEnRHxOiuFGflN8yrtPv9
X-Gm-Gg: AeBDievtaAksuZz5KCVkDOO1xCc1QWbN2ppQSuKepmrtFbvkGIRlZzAiwdFx2aQY7r/
	m8ipKXav49lUNwbcGaG4Kq6t1G6TSycTRhM4RX0I6LlsAyAx16/y6QT5hjQYs4N0vHdotrzH8Sw
	8bWl9RSsKN8xUr+IZBl/f27N5v5vFznO5KWoSjzc2qhRvTXh8gtzx5UWkDGflVCLzqGONxV+5t0
	9PSc+0nDCpjvt7GkpDKJCOVdGNZ6IAv4uJpLtji9klqhRfBqcC5kuLYThsov07pnK5xazibA21f
	bL/MwtjiHtuFv+VxS+OvfTFqs2j7GzdF25YSOiJt8FAVT8oqDn3b/qLceHWXU37NWR5G50KYZnj
	siueEXY5sRGyF3C2pE9yjHco91g2D9f8qdXBJv3nsHYyFTGPnUzobsPPUHzjaZroZF7ycZQzBLQ
	SNW298TEqq8IbJied8Yeh/R7KVammzP0aVADxMkIDOxJgJ+rQpuhlOWoq4MKIQ7Jkv6pL+eyGCT
	9f9jG/gGtYdDwC2dMdkoZC1XEhOf6zdXqvmyrN11WLyhNIqqA/JryiX+g84WysNkoAGG0PQdA==
X-Received: by 2002:a05:600c:4fd1:b0:485:3bc7:a224 with SMTP id 5b1f17b1804b1-488fb782af5mr254451455e9.6.1777101417154;
        Sat, 25 Apr 2026 00:16:57 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6124d7e7sm234129925e9.5.2026.04.25.00.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:16:56 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] iio: adc: ad7625: fix type mismatch in clamp() macro
Date: Sat, 25 Apr 2026 11:16:16 +0400
Message-ID: <20260425071615.20406-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clamp() expects compatible operand types. The period calculation uses
nanosecond constants, while the local target variable was narrower than
the upper bound expression.

Make target unsigned long and use unsigned long bounds, including
NSEC_PER_USEC for the upper limit. This keeps the operands naturally
aligned without adding casts.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
Changes in v2:
 - Make target unsigned long and use unsigned long clamp bounds.
 - Use NSEC_PER_USEC for the upper bound.
 - Avoid casts, as suggested by Andy.

 drivers/iio/adc/ad7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index 0466c0c7eae4..b5a7911c75df 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -175,12 +175,12 @@ enum ad7960_mode {
 
 static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 {
-	u32 target;
+	unsigned long target;
 	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
 	int ret;
 
 	target = DIV_ROUND_UP(NSEC_PER_SEC, freq);
-	cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
+	cnv_wf.period_length_ns = clamp(target, 100UL, 10UL * NSEC_PER_USEC);
 
 	/*
 	 * Use the maximum conversion time t_CNVH from the datasheet as
-- 
2.52.0

