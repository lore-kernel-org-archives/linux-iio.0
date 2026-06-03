Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEB47D94F
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512599; cv=none; b=GhZMGpk/9YSzF+x6ZoJ9rSleZhyAfmP7zgcPW3mkcRrZydij8AhUT2GAu26kPPK5aLTCjS3Ary52Dq9NZzfB3gASKgT9jJq0kDkwT0/pjreXN3EhJgnZzgKM+Lac5xsLt+4PvTjieiCsDGmsAZ4azVq7j4IHCMcN6Jr31QbYlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512599; c=relaxed/simple;
	bh=8sTc3ePfTO1HkNzwXZekmT2AeOdDHgPOdpy0VtjDF3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijroRSQfCWDpt0oHCb1F+iBeKMn75IfY2V2J1pG4RKGj+4vYvqrQWz5Nns1yR/+0kXLL+TG0MoAbiHrg6Dw0tpBlj+73iScnOAKI3uKWvwo0IbEUifyRwv2ZEQ9q/338qBZAPY+y/XIrLmxs0e/9CWG7h2BDpMP4fytDbhKVRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMWK9FZG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMWK9FZG"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c858961a8efso1862175a12.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512598; x=1781117398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTBVI1ML053TliZ0TwngU1Pm81C+cTmh1wKJVMjMXjs=;
        b=UMWK9FZGyn5aqZNwbAriEO048QBwpmTtpVSEIcQK/YtIKZZF25FfJusNJSweiQMBlC
         d9KjJfHlSewLHTMjNC5+KTtZT1wtzXCSauqu1anBXBqtmz/nqli1QwexzikRP89TEnEe
         84RYhjEu7eAKa6AGupUCPSDPaEBK6jOBDmbre5fRjsIJevQfecbfEJ1NuglswXEm8tgb
         Ca/mZubmlAL4DGTQaaGkrEUeTQG0dRyhDTmjJhHpIRJpeFZUegUJf2/MjGBphEKaPtsn
         xytxdjmm+87Jldjd7L23YpDpR6UWJTfgLVtwq3WV4nuhLM4lpbJwD3TmX2ca9fMsRjiM
         eVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512598; x=1781117398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTBVI1ML053TliZ0TwngU1Pm81C+cTmh1wKJVMjMXjs=;
        b=Lp5XwiHypQlkdc1sm3KLWQT+O7WQG6Nd/0k0zYcdQ6Z5smB2mF3KwB5XlNPzyhMmt3
         1PUv2r7MIHmvOpLLBkj8xiFt8bpoFP0OrSVxc6HFmpMJ37OsjQMwUoW5HNylEJCCBNh9
         uGzrV9TsTIbzXUFI1JBEbmGE2+vhdfLTWhZwEs7Mj+lIt3rtR2AmLkMeDTtSpDWqheQW
         kPmMqoMGmCdQ7I6lfQQ54IJkEwAZzRgS6Nep50iE3TPIpHV/vbYujzaM1QULRFTRjKQe
         R1wyEson+XH0O9qbAabqYSJG3SlMLIzWuhL4gFgX27/t9tv2fQ+IsrNDcUwzalZCsV2L
         r3ow==
X-Gm-Message-State: AOJu0YySkFEPq6wZvDEiXW71UFeq9Il5oV6Zz6O1rM37wgQykN21PMcO
	ogGdSz9CbYZQtAZ/FqGUegl/RiKWLZjQj3kY0p4WrM5j1M5H9jUIxoF3V/oW3w==
X-Gm-Gg: Acq92OGgQbG4+8lEqLbGpF8f6KefzqnfHyW56vVGMSjtOyAX1vwEXZ4YNgZb0t9b/kl
	7B11pXrhuM+wJsB68y1NYnoLO1RopctxJOgNkEt5uBILnMAbFvOLRn8Uy+vpTIEbc1ziWHwuFxb
	B6s/FGKvai7mJtlyEW26PVG/yUoDwuAtd7/6fLANmOyI48DKRLIuNrpd8t7wYAEZE8iqlUu7oKc
	OqSw1yIOxRkgeRHHf2C8y/l9VmR/b7jmS6DbMUS+wnG23GQclwp9ssDhiaOFgcAyz+nn+PZ6BkU
	a6jiEf+mtgH49aISL1pXTjCBolEVKQtA6NhYZMItj/XjF25/dnVkXThm+5bkTe0FC3HCLrX54SD
	v9bHVtMyQQgsLwIjKl08ry/K3IyCCHGkeI25siEexELONWVv5INFDR9JdfMO7MBM5jnb1DSf2kG
	uO2v9F365sEdqadP2/NjM9kXsNitrrffhWuq+JrO1g+AIj1IpyDGIDg+fUosqY7ol8ty118xqNf
	stWka+X2gJB952t461StLIyKB/xXmTwSUP8ztI4Leg8jyXJAL0xUQ==
X-Received: by 2002:a17:903:4b50:b0:2c0:a373:89b9 with SMTP id d9443c01a7336-2c163a24bf2mr49596335ad.6.1780512597506;
        Wed, 03 Jun 2026 11:49:57 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:57 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Thu,  4 Jun 2026 00:18:57 +0530
Message-ID: <20260603184859.89693-10-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 4ccb0bf2d71f..e5d842853b71 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#define HX711_DATA_BITS		24
+
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
@@ -157,16 +159,16 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	/* we double check if it's really down */
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -175,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

