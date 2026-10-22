Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670046;
	b=s8/ycrSMX8msOXgW/zrKE9hAGCd7B7T8dXhq1/nqzI1UZkDY8kxOwu9K3T35MHk6WTct
	 H0GeU4kFkr0iPaW6vp9ivzxR9nPtzRI5AM4FOOOBA7DMJmhVvqrFipnmtXFkHjYRIUH5l
	 Fqb4XDaJoL2qLJBcEKpnCe6oo1Y5oTpNSjGbPDRevrHSqLaCIGFdFm/2SU6ZdyA1VdOLP
	 J25MZm+6/h9Uad8BDE917UFVc0cmsQ5pywj56xCVnJq1/db/KkaFNi2PCZ78ymIwt2m9s
	 IRwHWRPOio8+BAHUro7B5zoqvAuXDwSeBNN0jpszRmfKoAuw3EMvMAF/gF+ii+nIHhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=peR+wtMRuf/Lbf3aBVnZb+FceQ6m+uCwk67vJ8kOWzU=;
	b=Ao+5GnisbGbFYL6vTWm9zHZ8u+T3giZFCd1p560k7Ygz+bdj0MYWBei0aJ2mmM5YzIYv
	 AAsF0xhBYqnh1HIpa2BaxFU4HfcXLUsRpSDqKUUo8e9gy0E/f81UfKcYWhqlFAUTDZaCT
	 iQZg1qTwJPEU/k/WriEGmyvt9o/2iWrG1o2t65OyorAYqUWhgRQ17+XWry4ezB9q8MPxn
	 BiUNcu7TZz4Xf7n00zEClLFPQOpjtTJCYxR7xy36Yp65EN7+HS/8dS4xWRkaiN43KCxIf
	 gdf7QTcC/kueIFuYCQ0ri1+1R0K5NSwTvJQahd8mRgho1ivFShwhAuS7UEWE86k31hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oRTKVgbx;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563A60A2603
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4563A60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oRTKVgbx
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d1da913so706001f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670045; x=1793274845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=peR+wtMRuf/Lbf3aBVnZb+FceQ6m+uCwk67vJ8kOWzU=;
        b=oRTKVgbxyBlIREX7nZMYP+04H0N8obAoqRFnsZsoK0olwGVDPe8k4ZtzBK+MY80drs
         TlZFP5ymKxgbUX2oCBuKze2R6SYmG0s7In9DeKQ54P2lAVdmka4SCB+fyFSfRJ9IcNw5
         m6QQVw0Nzeb5KocUfYHaue9nRZynhDxOBMkbUFx1+83G2M9uX4MVnQ5RTLy812IW1U89
         hVcXSyqz+UjgBLhhYlhl15g3DmMF8XlA2huFyKfdDFey0bGCB2DGjyhQAJqFdtVJoXBz
         JVUOEMX1VZjDIq2+QYHv6j9BAx2Yre4LDjYYNSJKYK/M0Wbb/jTLjCqXnAAo6OiWjlYU
         lGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670045; x=1793274845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peR+wtMRuf/Lbf3aBVnZb+FceQ6m+uCwk67vJ8kOWzU=;
        b=ESkWSvSvdasMxeAKinGKNJaQDAkqY9/26IshgofvpM1H/hH3DCvQT6D1jvV1HkfBaF
         KIkRu2OBkADwctQVg1gvb3wL7upUlsYVAXr+85vR5Q3bqJ+H5SXH+3CA1xQ/4qnuT88W
         Rm+pSG8io+CYQpb1/e3WD8TLNKBw/xiuwyBvnTuQGlRq83InCSopWczqY8upvqtedCxm
         RzbF3ZGPs4s/1yslWr2Jr17CAyobIHzSqMHV7YXEZdUkfp9DqU63fI97MS1wMNt2eM9y
         1wyOpW3ogvbDDunVeKduyrLpR5Y4iSFeHT7fcI87IdqkbTJjihIwKyEM9lLhEybr9FHp
         LezA==
X-Gm-Message-State: AFq9FYKiaB7DgJvGOEKmn/lIxg2ifzol++cUM4RotpavgIFoCeUIlmWP
	iNaeP8g9FUFveFGrz3fuUuv6pDwAT58vlE9L2vj5egUj3nHPN1Imwx8F
X-Gm-Gg: AYBFou2m3RZ0U+xiiFsoytqp60KxvXYKjHIenntMHA+XDcBzi1TTQfw+1a7U0qIenZ8
	5z60FTF35Tik3XbH/B/iGQ7E9Og+Iv6Z9nKF6WxL4MnWBeCkzWHPoIFNDEizZSXzFNuxfwDTrUa
	T2FxJaQE2Zt5jK+h7A/VBHQsKDZMg46g0ToIPm4ed4C9LuliGNjQ1GsfISAUA9UTmbuFptJkLVD
	iy3Jy/fTs10FpOSvdnytReUyTqdto5wh6Xpp1AiBkK9jhtR3iEhGVM65K4oUkGnwlnabjuuJpD/
	qvc19MKo94Rxj2PUzwOLLeLyn6kgQkLaD/gOr8mCNiSSbbmFDtuAO8oQHZry4T7z4d0dWQioX5J
	zrPs3CDHnxTOcUEQnlDJeBysckbJfGtJcbiaRGS9yS4ISxzMT+e9JXze7xvyXEl2/6hij9OewJ+
	SKKPnhyid/Tmtv/XUpRQb2AkieCXtMfnBUU2NlGXnN5GqcRXelgIesWKrfEXm1iuoPvTB2UrmKg
	QgmwZo/TaLoMRTLXo0fZg6gc7gpS+cZ0tHPIv2QwNXIN3r1nvcFyJX7GmSVT36EGgUa2mhd59Qh
	7wVnqgzeeQ==
X-Received: by 2002:a05:6000:2f8a:b0:48d:f160:efad with SMTP id ffacd0b85a97d-48e2d27f5ffmr5035811f8f.30.1792670044596;
        Thu, 22 Oct 2026 04:54:04 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25841fe4sm12371400f8f.53.2026.10.22.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:54:04 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 13:54:00 +0200
Subject: [PATCH v3 4/4] iio: light: tsl2591: improve lux calculation
 precision
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-first-patch-v3-4-b792e89a429a@mycroftmind.com>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

The lux calculation computes the ratio CH1 / CH0 as a truncated integer
(CH1 * 1000 / CH0) before using it. When CH1 is close to CH0, the
truncation makes the result off by up to ~35%, e.g. CH0 = 56097,
CH1 = 55973 at LOW gain and 100ms gives 1.517 lux instead of 1.118 lux.

The formula (CH0 - CH1) * (1 - CH1 / CH0) / CPL is equal to

   (CH0 - CH1)^2 * DF / (CH0 * ATIME_ms * AGAIN)

which needs no intermediate ratio. Compute it like that, with a single
division at the end.

Also report the result in micro-lux instead of milli-lux. At MAX gain
and 600ms one count is well below 1 mlx, so the milli-lux resolution
throws away information. The numerator still fits into u64.

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index e3092ae77a11..fce8cea08201 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 
 #include <linux/unaligned.h>
 
@@ -362,12 +363,12 @@ static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
  * Counts Per Lux (CPL) = (ATIME_ms * AGAIN) / LUX DF
  * lux = ((C0DATA - C1DATA) * (1 - (C1DATA / C0DATA))) / CPL
  *
- * Scale values to get more representative value of lux i.e.
- * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
+ * Since (C0DATA - C1DATA) * (1 - (C1DATA / C0DATA)) equals
+ * (C0DATA - C1DATA)^2 / C0DATA, this is computed in micro-lux as
+ * lux = ((C0DATA - C1DATA)^2 * LUX DF * 10^6) / (C0DATA * ATIME_ms * AGAIN)
  *
  * CPL is not computed on its own: at 1x gain it is below 1 for integration
- * times under 500 ms, so the division by LUX DF is folded into the final
- * division instead.
+ * times under 500 ms, so all divisions are done at the end.
  *
  * Channel 0 = IR + Visible
  * Channel 1 = IR only
@@ -382,8 +383,8 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
 	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1, als_max;
+	u32 diff, rem;
 	u64 lux;
-	u32 rem;
 	int ret;
 
 	ret = tsl2591_wait_adc_complete(chip);
@@ -436,19 +437,15 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 
 		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
 
-		/* Calculate lux value */
-		lux = (u64)(als_ch0 - als_ch1) *
-		      (1000 - ((als_ch1 * 1000) / als_ch0)) *
-		      TSL2591_LUX_COEFFICIENT;
-		lux = div_u64(lux, int_time_fval * gain_multi);
+		/* Calculate lux value in micro-lux */
+		diff = als_ch0 - als_ch1;
+		lux = (u64)diff * diff * TSL2591_LUX_COEFFICIENT * MICRO;
+		lux = div64_u64(lux, (u64)als_ch0 * int_time_fval * gain_multi);
 
 		dev_dbg(&client->dev, "Raw lux calculation: %llu\n", lux);
 
-		/* Divide by 1000 to get real lux value before scaling */
-		*val = div_u64_rem(lux, 1000, &rem);
-
-		/* Get the decimal part of lux reading */
-		*val2 = rem * 1000;
+		*val = div_u64_rem(lux, MICRO, &rem);
+		*val2 = rem;
 
 		break;
 	default:

-- 
2.53.0

