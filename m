Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E13ACF04
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385832; cv=none; b=MNFqdEvQr9O2g83GITb6XeIHjtOxR+pnbocOhtdctTMUThYcFOCgSR7B4aYow+8psziYQcvHuN89uLOMipd3wYGr+N8bMzHu40+eX+nESOhkCEOI4sKRplEHYp5ltWev0X+uZnkHN7vOd9w/xjoRUmWHwuDrgNAlq+3Wev7GlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385832; c=relaxed/simple;
	bh=wRhucqIfM2fhbSyvGdnCizYoM9SXfWt9teP5OpUFAl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTYQhyUx9a5c7k0KKyd7PbZEivWf/pTtOxQYZFiP94iu+9QqIGCy2nwzwG0cBOyjavXZzTEAdV7b00JGEXeshg6aRSf6JtXmjhp4Pi+zWmZf3/aV2jOIr4ds4j8UH/CKKwk8alN1M2cN0aLk+EmMXv6THKlsBzLtl02j5ZOUhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAN539p5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAN539p5"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3178350a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385829; x=1787990629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSuQAhAYCqHrgB20N7b1S9W04inmtK2cNpthLTEVjqM=;
        b=YAN539p573Di95sSY/OfT3hcCeo+zoA23sxn8IxP5EVolHNuHUUc4jJpsl1zr/Gkt8
         KcgngYfFieL/XGmEEcIxvQep76OMDSHBWafXRGL7jYvwkPtx+h2M63h6VlMMpS/tLRqk
         o0ctDscKclWRR4Nb6TavwYkpjeAsJEMF9/Ud6XAq0Hkd9klzFGHEW55kx+v2sSEM2AjJ
         kZ5BKQJbbfxNhQEzJ2n1+ZTqEyZRKC6N0ogg1PqSEIgSL0nRA2ZV14MpH981a9LhKtGY
         Y1+buGU/zBrH0Qj5KUSVjeoeEpEktStsd5FitRXe/iG9/8P9TcPHCc0+Md23Pw5r0+fm
         II6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385829; x=1787990629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSuQAhAYCqHrgB20N7b1S9W04inmtK2cNpthLTEVjqM=;
        b=QJ35eJhL98xF0SX0XActXlMkhJAsUCHeWhZU2dp8AwP5ZN+rnLXNvaqpcY6euoDRzS
         qrAWUcef6DYBKCkN8fWlWqER44ksE1KUBuZoB3CvQs9fo1Lo9LHa2JRRSU50Uu6ezslX
         okSdx+SNH9Y3+mWGrb1zVvoxzEb34mpbwEKfNqthviEZEbDrYzQYMIGYQRyz03xZpHr+
         w8nl61H/Foeqqur6jViiQwamIVzIJsMW/6uMdQGpxRgQJTcYryYth63OnpH+i6tyHxbB
         OQN688nb6+5GZTX+8TwvowFtdfRqF42Paw9MCAZqjPFtnpVB3YVjYKZ/8mx0r7rzn7Sh
         uLKQ==
X-Gm-Message-State: AFuF++lwEYJZCosYLzNxJBzWjO9fC4xLpYqxZ2Ut8cXixwtjwoGqiJBZ
	9nSc6k76fmHbeCzGBjd3pya847vSCEPeOlX5DuF1uqD53gqsWpBTP+dY
X-Gm-Gg: AR+sD12OvRIJEXc4xRdvA477o0q4uOzqhJfzT1QgffEeMit9wWfOU8QvMGDnjrcBHp1
	lItAMeYIIgOWzvyDy60YyHRPeQNX6rA2JmKteKqGCdA8/Z9ciQpreAgtlCa1xVC28O0N+g2VkDT
	to4ywNTvk/Kp0VZYGM/uWlQR7xREYriPVcLwwWFgYBJW1O3rsd83u534cyAnsilz4foF8KOop9i
	pqgc7lhi3nIDCN2PcrhyV6J73MTkAlGh5ucORFR9e4P3bwEbBYtdatoyZmwrNZt8RQafru94zS8
	YIJ6G2V32EwtrFRqC89Ld4Eu06C6Exp0csPVHmcK9xbv3jfFCWKu746XiblzDhhJSkm9i8jEID7
	OeOnJ/9RqSM6DyaQjF83bjaZCSGzXIBjf9SHCR4QNI7uDzKiLkVfftiVTgjmc4J+IB1V5kyUQ1g
	HshnI/jk7vUPq1wNnuxlvuA1cv0QoaBSbw0++2GJdbWLRJhJG+3sXNHz+/flo6s/AJuvkhPlg2d
	6j1cy2iekoQJ6/tAXXb1AXh1/dOHqLPGuUhArqk/Ov1TMWd1vyN/jYNSAFjbFWTJLY1VnHsUImM
	0ZmPLoHkmwoKs7GxqdDLovO+uOHQ6tvnsGP2rylxCHVrEt1oPg+OkcPTp2J503D7naAQmoEmFii
	jnFDg+iJNE7Vm23yuXGXYnZZB
X-Received: by 2002:a17:907:944b:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c24926a1cbdmr449697666b.15.1787385828811;
        Sat, 22 Aug 2026 01:03:48 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:48 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:31 +0200
Subject: [PATCH 04/14] iio: temperature: ltc2983: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-4-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1574;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=wRhucqIfM2fhbSyvGdnCizYoM9SXfWt9teP5OpUFAl4=;
 b=JO8E4BTI+W+t75Ky+Rk7iKbT1d/x5M986KICw6CZGR08seTVyHc5y/QElb/IpASYBJjA7wbLG
 Bkw2RW9x+i3DJy0JSo3G5D/aa2Y3ZkV7Q6DC3IVYfbGD2b/0MD5yvJu
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <asm/div64.h>: for div64 functions
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/errno.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/ltc2983.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fe9eec3058d4..0b1b442bb133 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -5,22 +5,26 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
+#include <asm/div64.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

