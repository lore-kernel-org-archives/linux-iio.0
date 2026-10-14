Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE95452BC
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987435; cv=none; b=B0daZx54NJQHXf7gh6iw7IYeTk9NhM2T9qKbxWXjdQOevh5kcY6p+MlIqnwzOiSlbSpaaip/+e3p0/h3nmq8pjnUPmmRvflxEKiwK/RDi5c82RSkSwPpnpiebY3QIKKiDbTffwa/9Uz5xjNX/fyVOqThaGCWIFrbgY6RwAbQU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987435; c=relaxed/simple;
	bh=kDdNABE4gdDJtKdFbG4ZkDegZ19QpwxjwjKsqaDeB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZZUtMFQppRAsE9wFl2woAy84Q8MA71ATis+WgwMxqw4w9UBpqWuXxvCquvkKZ/lCq4SWO3TcaEeL0BwuhnQnjf/7XMweWzxQtLOPqB9o/4gsjN4s4D85zziHF0lku4H2tt/tOrXRXYSxLqM407IAS66dcHGp9kio+pFLUFWrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E97ywg2D; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E97ywg2D"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-486e70f2457so271087f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791987432; x=1792592232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Es68rB0owF7Uefi5zfeNthuy/yPE6eY6J90ps29yKtA=;
        b=E97ywg2DaIp7mW8L67g2XSk4hx+oYYWfxw180BnNBkktgT7QA3km+w/vBtE7QtBKpv
         DWDWxrnOcZDL83sPG2AILLXFONFufcJVJ6YjFucoXiCLdHSxzLQzWxRFeVOE4gfqaRmT
         zCX1xd159OfIroz/5U3qV7dCgu/ZP5YfhThx10ePwjp+CrUjtLH/q3GqgRA4TKmcWPuI
         XaR8TEcHARnr2euUX6QkSa6YxSk9AgtEnwiFOjvDPr2y8HdWr9E+pu7zIGh0sGHbfWOk
         9mXIXVoS+O7zRrZrIfv7+aMHDK+0Cv7pXttA4FccM+gID/URJrNEytTM5WNuc7SYn+sX
         JlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987432; x=1792592232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Es68rB0owF7Uefi5zfeNthuy/yPE6eY6J90ps29yKtA=;
        b=XppUvwLQ+G6EO9AO8PUK/V7c2S01xPL0pRl2fJuecDhfMHnyMp4MnYvqFPm4h184U0
         /NsWgspL6gpsynF96t6Ou/kmkWQRgo+AEm4WAXkxPWhFFzHX2MNGA4SrdjiZOUET60om
         DVOMBio846BUdgz9u0UAW2VauVC0m2Hm05yw0zY6zw0ac4lXbNFIYHstf2sOgnJJNqMJ
         bFAqUMjoEQ/Rs8A0WgW98VNdvSPxb9GwTa7WNVxl1JXTSOgrBUfSyzOjP68eXDJF9Lol
         75wUMtP5nNzVAp4yah1kYkFjJkSp3JHUvLfz+7HCTP3mEVdV0uZJwNF4834ks/JLwfL8
         uljA==
X-Forwarded-Encrypted: i=1; AKwUvBxNsmYpofBqfk/PQk9F6TM1QK5AERnVcnhBPJR0ofh5JkMstqm8o4naqPEspDVDGQj/gJMMN8x6BHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7ae+bItffhgfhnge/OjstvFpEmst/umUSQSGP2m0Gixgtefaa
	br3PN2s4/tTUKAwUN1U2lylLEFeKIFaRB8Klya9ndzT25+dN/J0V50Bv
X-Gm-Gg: AYBFou3TprilMHYUN8Qo7Usou8tWQQuUQ14yijPjxrWy9+sbvDRuQyCuhsC13UTVDxk
	E0OqfIlvko8ZqLbA6mJ8gh+xPNPcwUC6VgA40htV55BlAgqI3oz2wNo9rzVrinnw++P43p6CC4C
	x2Fzq2bYANRASoy1GrZKMOEflbKcTAXOkgCz1CahGmolIP0cw3PVWxzvxKnRGVITuKlVli08OEt
	PRKevOKapkuihqwUWZwaHwiVb0KlRoHmgpl4pXaGIWFWhlz0cW55b0eKGzvnWX1BZQcf3YQliDM
	DTDkDnS6cnDaVkDan739XRN5H68xGgVpMq7mpCmKt92fQQsqj8GuTK9TXMCCPSZlxR08FMzIQuD
	NccoKkzxnoJpudpPFpULjyXPmkWO21tFZ16F6zm9wboMWeo37iJjcwWE2oDv+OnAJew4+T0aTUL
	XIRj9SjjIQR5ZUjHlUK/atkFIZ5gxNLtV+fgD+vJLp1cTELifbotMVPh+cD3oQjkPzuBkpB1ZZe
	9O2aQ==
X-Received: by 2002:adf:ed8d:0:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48dba9c89b5mr21497028f8f.22.1791987431768;
        Wed, 14 Oct 2026 07:17:11 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d20:6232:49ca:4be9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm10999278f8f.1.2026.10.14.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:17:11 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH v2 4/4] iio: light: tsl2591: improve lux calculation precision
Date: Wed, 14 Oct 2026 16:16:50 +0200
Message-ID: <20261014141650.259929-5-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014141650.259929-1-ciakval@gmail.com>
References: <20261014141650.259929-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

