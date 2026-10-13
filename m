Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE25158B9
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902430; cv=none; b=sjrM4XllviaUSSMkHwSI8LFKIV4CtMvbCLVKBl9yG+XrATUouEVcHYf5DnKyAcp9RkcxAEbwldaJeAvyLJZyK6efDUs6ixKPG1oacGZSkn6pFi86xcrwcI3N4uYfvXFbrOlTUfYMGqdhdxMK4uBl8PG2cvKwuy2FQHuDOPzOmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902430; c=relaxed/simple;
	bh=blN9ABMC02XSNQ5QGaDACQCA7ymayQdtQYeWAR1oV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pblv9uuCfvUM9epuJLa4tsS0SlgUWt4mPBaKbKCVlQNEJHoKs50pCl2uaHURfGOT72vbOE0i3rIZahEf2xNNuM9VQqqywu3TieKMr0rxbIu1x8ZgoiFwnNIoibEdD1PNeYaTKRtV1jDWMyQCW9ZgPngBz53yAolwuNre7h58kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0OA54wb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0OA54wb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so26431565e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902427; x=1792507227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMllP9hBRztcOqtqSzVJ6pL2lFuGOqSiZoCqm6sWCA0=;
        b=f0OA54wbWNLTBcKULszZ+PcMWAXy+zQ3cmSRibpCMI69mffkIfrkDn1ez5fOiY54n2
         v6qGv3ET2cnS1QZQ99gU9yR2cQc5RQ6Pz2WjmmbOuGy8UAR3+aVQzpCXhdK9oUGifykz
         TIaleniUUm1x3F2R75N6kac+3sh5tEKo+AXyTWpc51Nj0L0qox05PSzihPwhnejrqtlc
         ZiShacR7LsHxQVNDLsQyCqzHFyw037WqQ8ciNo3TJS50ndCACdCAUn4TVHCiaLc8K0OV
         Tbs0SvYinSdZwmZSW9pzgub58AIRb5RvWhPgEL3Mud6TfpYl+BBxdzI/BWW1dP+oLwIH
         5dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902427; x=1792507227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMllP9hBRztcOqtqSzVJ6pL2lFuGOqSiZoCqm6sWCA0=;
        b=nPXuo/u3MvRtc7+Lc986YOt08aVQpSslQBaLF1jUAGkoNw8epDeY6aNL5EUlt1VgiP
         Hnp6dgkkNV1urSLm8fGMQKvyLOebAY8SIa8/DqjoP0MWAjvozndBuDL+YQJx/FnVMov7
         c3x1oJ957ap3wQqhrqOtKglqYXZMGb3ew4kiPNmHjXBLRpUuEE57+VmYETaVkb687Ila
         jfPku2t/CvNaPZfNuu1c8ite1QJajvzvqCXaO3Ce8iVYKc4IS7dvSdzikWPDb/mZ4ZNa
         jEYmqaTgjk8GgFBj9wDi32d6YY8BP1SslXSBFVMYy0DO7v7B7XgXFvoUPbq/RP6aEiCc
         wK1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzr3r/WA9TFAvgJ4wLj5mpN31oH4NujNovbrz5qNuQcbCaJAIjFZNyx/hdKKhFFSmVYa/Tm8sPCGwM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIRn3P52hRwONwp5BY007gYcuP8vZoP0lLI6+utoWbg1kQNUnJ
	T3q3Kq1xjwE1iB1+nQo1bOW2sWm61B8ZLn7bKxlBMPt5bGSV2QCnalIk
X-Gm-Gg: AYBFou1+4r6jGavLh89z/MDTSQkjX+X93dgzj/A5cs7ZGtM69CVhyPFNlQvPeFNDKBd
	CrqEhG8TrjEV6u+HFcmQ2yWoZ17SJVQ2YmSP0TFNyTq2+FDozeO+6fdMy2ZMbVqkUnAEJcq2h2f
	IU9/N4ydHc/08fVLnGyG5nR56W93neVSoS5p5QvnUkOL13tQS79wpV/TJMw9vmrOseBR8qgHVy0
	/mllKOYsAz0FMCffg7pwuBhCfLnfiteFo2Cry0su9u4JKkl3IoA31BBXb0SU5MSfmvoQ2T7zl1i
	WAmVulCNtYULmqEsZxtfDx6lX7dw6UqwjtXSSDuWXawNKEhX87wvONSHsHeyXHJY5qKD2zzdfBv
	Z6wCM5i1Q748oGzjZfY0fXRDGlkeL6BGk88S39lnuGOkcPh5SGr/buUE+WO3z5mdhf/V35yId84
	x9/B5LCcBGaghCwmwCv6B2JG+fIo4TFxcSPuCir6XB4hhF7BEO7vrAWSEOcxGwPiSj2Nmo9CWJD
	4kOcO3ywNjh+s8fMWMEeqGGNO3ZISjk
X-Received: by 2002:a05:600c:c3c1:10b0:4a1:ac66:5f93 with SMTP id 5b1f17b1804b1-4a1ac666305mr34581155e9.8.1791902426392;
        Tue, 13 Oct 2026 07:40:26 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:26 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH 4/4] iio: light: tsl2591: improve lux calculation precision
Date: Tue, 13 Oct 2026 16:39:43 +0200
Message-ID: <20261013143943.436816-5-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143943.436816-1-ciakval@gmail.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
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
index b780b236897c..82085bd06850 100644
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
@@ -383,7 +384,7 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1, als_max;
 	u64 lux;
-	u32 rem;
+	u32 diff, rem;
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

