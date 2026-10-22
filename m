Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695441;
	b=ehw8WZrcFzBs061IhWkFgBgXkBHf13Xbjw6JTtSITKYzZKGw391Kc8c7g1a1D/nzp3Wc
	 I7lzNgM0A9ObmEi8v0AQBukMmwg7MlFvB5yMJI+TptiwR5lRnKTJ1o2ltzIxj3f7kRs4+
	 rgiYZ7As9eJSt4IR9uuOThfZ+J2b3euisHGJEnep+C/q/wVRbh6+PgrAXZR6KwGE3L929
	 BQaMNRLtQOaCmMGGiXrxhWZhm5h952QEiMer5UX9i4eaL/Unn/R4mgggCYJSJp+9o0Elc
	 pC/w9tf3MOz2ZVTNe+VvRpR7gv6+IHyGK5fRjbZGf4jPd3nPmZeSOEgGnTCC5WeddsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
	b=l6t+/90Y+LICyljyc4NUCN5Pd4gfM8Y6+861vFdAhfHfzyFKvSQLU3J5XVQ7N1iB/JXh
	 i+YfGK5NT9YDNUlcVR5AE87RtAGYD1Pw0TFCC4MDInKkCxGigWbLflOetI+As7vkYCIP7
	 z6pYM1LYQI3Wzma9rTVBi4yvgyWUuQUE7VM3091hNayWsEDaUjbDgxIewOPJ5p2Akcefx
	 9ALOtLHbCgGqQYCWEaR6hPMLHKhPi7INyimPUYI6VCiSyqKullxBSpvaVSgh26BYACzU9
	 FSTf85D2HSMl8r4bl1zS4ZYoRdIaBIe8zIQwGfJOKvw1efstEqL4r0MqHuESmGK/fxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzRKjna;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CC606A323
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E3CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MLzRKjna
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso1491475e9.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695440; x=1793300240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
        b=MLzRKjna5tBlkK/Gjzbdvr9H5iYwVtu4YaemWrVLYuqP0k0eQXsYf4jp+ayNbNLacE
         Ry9e1xaNZwDTFONAUWYZe0feqk3Mb0ndNDRTyIBoLpxbM7y9QTmHn1RAtNGC5PMjNiZk
         6wZ8uMoEwwimYxC7pT1mFoVccRZQHgTAiNBWTwq7xhGTiY2pW5lJ1JJzUpI/iLIM/I9N
         O+aXcqYNwj8ZW7q6deN8xrp6RqmCilmWhWi8OaPHau8yY87dowJ3LoQ42dpMFMZm3k45
         2gGSWqsTnbeTYNgRMl9kKi9WhTWauHso7D6F4kfyGRw52msBzGzL3W9HHY43DA1dfwlM
         XmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695440; x=1793300240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6t6hNWD/TCa3KhqajK3ikKYHbg8LQCXp5YTHqmRyGM=;
        b=UVEIadKr++poELJyjMu+5y+F1OljNCaOJNanhsd8m0Ts1A8YesLSAuy/l2YKOe6yk/
         6LOzk2mNUvizjiGj48sIx8292moMleKqn4q0nSYh82bz4bAUUZR3OmJntRIhRbu3qGFR
         92OHcsWG/wJaLh+DYb9UHwMtNPTFnZsHo/O7gIhlpgMy5W/+WQNwfCzJ8TtLPtbWX6ch
         tx2xDZwe0Tn9lP9jsm+L2VpVipknDBffuhF+3X/x9KmRteJtEtqmlwBmNlhsexuWUlWb
         asal6tb7L3G7t97xktIzemuLnIsB7K7mkUt9ud0d2d4SLv+jtBIH2kvTHbNcvLHYyyzh
         dW8g==
X-Gm-Message-State: AFq9FYIpuEMEaKnnC16KvpP/oANVkRc4y6lBaMoDmkccVjKpqM7RuAPb
	Qdh8pfC0qIKnv4r7r2HCQmUPM04rtH1tPRX7jGy4AHt25lIjAhXcPEPc
X-Gm-Gg: AYBFou03YS+F/7UHH9Phj+/xwutx4JLqTKs/D9KGQLbSstnPBU0yngAMampY15AEyaG
	hChz1wnEBgYVtVT98bz7OuuWGcdhSeRMpnuD5/Rs2jgI0XzHqoTThOKjUoeJBJuYlV/ECf1+FgA
	KO089bY+xeWifoxhi6WbUVX8rnwkVURY7dPNwvm/XeXWh5ljivaT84BsIYiSRD/dHq7vl+ZjItd
	Awl8U9U8W/Utp+fgDHwPU1nZLsyOmzmR2wIBhSWiduHs4KhesyADcwCKFzw2ftjWOkiwPy8/470
	o4AE01+4+RKItA094tz0cvaBeyrriZKzmq9Owp8qA/arBvuIIwtQb2Ky6ZbSQyboq6zclJnTui8
	XNAt5JJN7ge2bFnX9ZxkiiYAWVqscaNiOWlk1Axw0KfLgwevODnyHAt0yAnP9SJpNZS74RW17T6
	V5u4zR9/7zu1nRTxSVc4Zb1+Bwqkup5xZTl9ibX06kr26QY7/LO/Zm4ofzKCh9UH37oBqIiQcho
	BgUSmnI+pQl26EXwC1JJ2dmoCAmc42Q9qBwEM6NyyzE7DQTKqtatoxK/IdfxncpvrZfjVHll1M=
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a1fdd245bcmr119483665e9.9.1792695439903;
        Thu, 22 Oct 2026 11:57:19 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e379f0695sm162442f8f.37.2026.10.22.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:19 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 20:56:40 +0200
Subject: [PATCH v4 1/4] iio: light: tsl2591: don't divide by zero
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
Message-Id: <20261022-first-patch-v4-1-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 stable@vger.kernel.org, Martin Triska <martin.triska@mycroftmind.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
calculating illumination from the raw channels requires division by CH0
(which can be zero) and by "counts per lux" (CPL) value which is also zero
for (gain = LOW, integration time <= 400 ms).

Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
almost complete darkness.

As a result, reading from 'in_illuminance_input' results in
division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
parameters result in CPL being zero. This results in kernel oops on
x86_64 and in reading the value as 0 on arm64.

Fix that by:
- reporting CH0 <= CH1 as zero (catches also CH0 = 0)
- updating the lux algorithm to only do the division at the end

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Reported-by: Martin Triska <martin.triska@mycroftmind.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index ef3ed9635a1e..f56d31404c25 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -362,6 +363,10 @@ static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
  * Scale values to get more representative value of lux i.e.
  * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
  *
+ * CPL is not computed on its own: at 1x gain it is below 1 for integration
+ * times under 500 ms, so the division by LUX DF is folded into the final
+ * division instead.
+ *
  * Channel 0 = IR + Visible
  * Channel 1 = IR only
  */
@@ -373,8 +378,10 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct tsl2591_als_settings *settings = &chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
-	int counts_per_lux, int_time_fval, gain_multi, lux;
+	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1;
+	u64 lux;
+	u32 rem;
 	int ret;
 
 	ret = tsl2591_wait_adc_complete(chip);
@@ -410,23 +417,28 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
-		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
-		/* Calculate counts per lux value */
-		counts_per_lux = (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;
+		/* No visible light, this also catches C0DATA == 0 */
+		if (als_ch0 <= als_ch1) {
+			*val = 0;
+			*val2 = 0;
+			break;
+		}
 
-		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
+		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
 
 		/* Calculate lux value */
-		lux = ((als_ch0 - als_ch1) *
-		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+		lux = (u64)(als_ch0 - als_ch1) *
+		      (1000 - ((als_ch1 * 1000) / als_ch0)) *
+		      TSL2591_LUX_COEFFICIENT;
+		lux = div_u64(lux, int_time_fval * gain_multi);
 
-		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
+		dev_dbg(&client->dev, "Raw lux calculation: %llu\n", lux);
 
 		/* Divide by 1000 to get real lux value before scaling */
-		*val = lux / 1000;
+		*val = div_u64_rem(lux, 1000, &rem);
 
 		/* Get the decimal part of lux reading */
-		*val2 = (lux - (*val * 1000)) * 1000;
+		*val2 = rem * 1000;
 
 		break;
 	default:

-- 
2.53.0

