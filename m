Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695445;
	b=UI3z+z9khEUj8YzeAJT6SwfprWiy1js4Vwk+VTVuftwuXXcKceAANV3LFhXLotPfxk+y
	 AqfAQONh4hsI85lh+clQhbzZRZCloCRTErVUIY7mKvU+m35xU/Lw5o9cdyrKeRmSxo2XA
	 lNAvm8zz/D+wiJKGr2TXbmyN222WRspsUriQY+QRUxRelMWwXGiwY7e/4y7riqSKENVJi
	 8/QriTkd3Sl7PWpcikN0KXB0dV51ksfyaFsOSzRK7inKDs1EtthLcX1Id02a8h2buJXGg
	 KgIk5B6R1vXAGnSj+L/8L1ngj8ohLNmo3B53qa35bXRlPivP3nUWepXH++NCdsnuXbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wWGQ5IUiMr2Rq0O0QjY6wBswC7Qqsd6H5XtqpQqPVpY=;
	b=naOAUEs6G7TGA9aI1EmKj/FDLgfGt00J8tVvN+9pA+HlzEDKnvLUqaQCTySOyaAGMQgr
	 eBi3hO0lf0bDwxdSR5Hpk4Zz6jsLgCPxIGqj1ym7TnSUWPegsK58wVf9ACvcgIQX5I8ce
	 1qHuvP7Dh2WxSSwkcXQpXb5mDLT1K+swyVz/KieKB/+Y8mzvVPEv4Q3EZTO3CdKOYty8y
	 llQw8G1A8XxLLEiAYSYdtqen0gAjcbh8fQWaOLdoN3TGDcmmz3c1Lxpmu8y16DP+lDsxn
	 2emOI9f4HTa5XY8xDOH7xmfODPo8yvNB7ozY+MCmEU54j+emmL+6Min32zYDVJJwwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rfIpA7Hl;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10D60A260C
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 18:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB10D60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rfIpA7Hl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0759so81992f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695443; x=1793300243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWGQ5IUiMr2Rq0O0QjY6wBswC7Qqsd6H5XtqpQqPVpY=;
        b=rfIpA7HlDh3aKDf2GFatIv79JQRi2FaUbiwlZaNVMOATuaMrelBCJOFZyGv1A0ISgV
         lu80Muhu4RwVju6xTYCexV9g6SdDw7g1AqfSiK/Pw/OXCdPCNO4Ff8z9RexznKVCDcIx
         RozmOd+aUZxQUHJCR/jAE99foQ5f+EIYA0dVf549RZF+pl0OlzAml8ddQ++DrGuPgjpL
         3jFhTs52WwKmIANowdEGbZzQ52tLFBhU3LGzFKLBxGt5PQoD/DcgSiCe43vImQc399DD
         pb9c3C0mxtfQRQa18XXZKaxJJb2Nli7zaSJ/mRNsGN6uFwFi97Ro3w97c6DFT6AOEOBw
         8wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695443; x=1793300243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWGQ5IUiMr2Rq0O0QjY6wBswC7Qqsd6H5XtqpQqPVpY=;
        b=RA4Lx0ew4fOhT4n5AoBDcUHGO/7H1e4YxOSBJJ+QzuBRbqq7QvuEj8Mg00uIKrJdEe
         o3IWUAz9ebWpa2DGDDUDZp5xsYUWyHPxUJKcjCtsZZut9P6O5PYYykmV4sRKj4lf9t5W
         WortVexOqa3OoRrjBPvkx5UlYQpAyKE0PKri/8YWPOe0Qnn9cexM+r/A32ja8kRugsxr
         q4EqK/Bj57j2IhMy33we80V676vPOypEbuRLL/boCevnp+BgVy/I3pV/tpTkO8wj+mAS
         UN/itWEvP+ZosY73jIvsAqGe47a5icFwvx9jyLvDpxA0pIXLc4CbsGfX4w7aKQmje3mr
         6taQ==
X-Gm-Message-State: AFq9FYKkXWh31RybHQiIdSYnnm+AQ7dKT8EbHlyNqcaaWERTPuOZ9N/9
	kGEg5Y9U/yLD9i80O/KbY0aMICNJOQSoJbl3Voc+pDzj4xz0iAtMShXD
X-Gm-Gg: AYBFou2VAIJWXBFm9XZJjud9C1hjOgy6caGdNxNi5qEP7MUI6xIAU5ISGeJISM3xVpd
	DRzthbNRUgjLpEF9BkwG0TjO5H95vyJ700cQLHh3BwfYaSui8gACN3QASfH9tU3pF4WJyY+kIAC
	s60xcgPCs9EBy/DsrE86lzNhyIUseFRFW0SwdJoM1rIx36C8Vu79SxUnn41TPIDMWvQOc3rIu9Z
	szWXZAvzHc/1Ay375YEWbMbQvaLyRwtKFVKXWIE8fHSOQrVd3hWj0zFku0m+qRoGhugb8xsuXaf
	5vU7tZmVaxI2+A5/OGg4Wo8gp+X1KZ3OVFTRqbBh6yOd3N0CMy6uPJ90h8QGnEeu+Za+TIe+BnW
	vVKRB3dJKWO/nA6v0LTRqkNbBHowXSUjzUcteTONpnsviKgvOx+rAUqSfXgxhF3Jekyo+ah6YUk
	+qPyMoWoUQ5wxDljdXL27xYYx/R7kf1z9/Sc/WrtJfEvKZLcAsZCFOzJgN6X6hiO+8pDmcPLS64
	bpep9C3AkJxe9ts5WyFG4BGVpi1eb3BMDYBSv3+gDNjgi4pRK1ORw==
X-Received: by 2002:a05:600c:8b4c:b0:4a1:f0ca:2de6 with SMTP id 5b1f17b1804b1-4a1fdd1580amr126584375e9.14.1792695443077;
        Thu, 22 Oct 2026 11:57:23 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e379f448esm150664f8f.41.2026.10.22.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:22 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 20:56:43 +0200
Subject: [PATCH v4 4/4] iio: light: tsl2591: improve lux calculation
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
Message-Id: <20261022-first-patch-v4-4-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
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

