Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D89499F27
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584730; cv=none; b=OLGi3iZXlY6H4s1f77ysL7zs/EqbjNDZTRGb2wD5WhtM0+XvDyUVSJl4sMId2XN5Q7S2mohNnOmHidhb99ux5DvMFf236vRCfzxBKt307U9lruMLnY+cpltjhe/Z5DmpQ5jDhOM3fzvnlXdMZgrR/gSA8gXVR0BTPlKj+Rz+1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584730; c=relaxed/simple;
	bh=4uqeXdnRU/1UZNsHvp4XBofBIT9pDbRG5x20+z4/OTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACWrPLnKFj7Q5C32Nl+xdqr7vbZc6SEGbuxvCzVCRV9YoI63Ai+Po0NhgFgV3KKtuU8m+iT1pOw+TzQvulMDUVvV6L+7htwWnIZQNgw7rl4yKqCicE4lveFdEkyq4BnGy6gOh+CAC/Aj7TmQlU69edPix5sYFqiKybr0sfwRdz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=m6iYZf2A; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="m6iYZf2A"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98929bb8eb0so39575241.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791584728; x=1792189528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khCEw7C6hBWBoACe6eWgt6IH+9W6DFj2toNOYtuO/ZQ=;
        b=m6iYZf2ANIvs/WuDYGkMtJGQU/FnJr/i+2u+53i2/MxyxWUWVry984bJfvAaxVtrC9
         y38WHO+MEEdfZEcUZx0HH/X/SPVcefZO3lueC0i4kbZGJARwZzkjRcftIsUzGpa2piB3
         QcTo+AWCMct+kc6qXZWdbt7tjDBKqlVesBTgKyuNJCUK79juQlZWe8dqmRIR9gXhAnZh
         jisi99i6HFxB4dIDOViKlruwpCWt4EDnnjRSeiFxsH6Jah88NtiHx4p3n6ivhVLUb177
         zlJ6j+297yAGUktpEMsBCjGpReAUNUknhOOHwSRow0XP/U+r9UI5t0lUw19UyK2e/IKO
         zBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584728; x=1792189528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khCEw7C6hBWBoACe6eWgt6IH+9W6DFj2toNOYtuO/ZQ=;
        b=1vGH26me6fckllhwrVzTGWjc4GLh4joeCgqNwet3xaMwbdoVUxzzO+FYg67pzAZmp8
         uOxic3E4+W1OTXPAcGD/iyN7vI10JYhmVmJi29UmtxjYkbwnLB+NENOWcMPEXcYRitxj
         hny+gsJHdfCEIFkHKfcKZjdvSyloXYVzcEWmjqNyisfBQT1B6XEL54PYT80a1OXg//FN
         fOiVBhIEKCoaWiwtERhqcSO+oXm2kEAK96oQI6AR8lpjWHnIsl2+44NA7SSoMV7ezouX
         zyCKq0CkdmJ1hAh8RkWJ0WcPG2EaSRMsC9A7xabICzYa9kXTpkB0Y7anrluhTohw72kp
         1P9A==
X-Forwarded-Encrypted: i=1; AKwUvBwpLGOhDrChhdK5anmH9+EYa4OADSy1f8BncFsDDyTBRyO/Yx3UD4M6AvzfvxiujQI6scXzSL2DBpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXbfVJLIIvsZ+rsT4FpZVfG/4Gdbfer26ZPsch0fRI4jIMN9ps
	33CltcuWJCCuu63i+3AZvl3A6vpGGORzuRMcRM1X2GnhCvOqVnV+CacoJupVm6wm7WE=
X-Gm-Gg: AYBFou08ZCNl4BZQ7PXy7QLb3mbbz6b9UqWSACimIsbZI0aCk3XA/0g4ZaSjbhm8rhf
	raIM8p7RF8ZnUc/5s4LbrmQnubsfrntBOxN/FO/qV/0vf6Vpr7ey/Ii0njRCLt9ByZqZG3pZ4Xp
	JhDGQPJ0IP9KpNlTaX9hkp/fDcPNTND97yKBMdALG9WusqnjMLVW6TsvS3zJ3yqHos/EuOJEgU0
	NSCiRa8DrUC2iNsfho8Xn/HB7g69w5ikE8GEC1gV5dPVmS2JYSy0Hp7bqDvDASJoSl6oEdbNE+z
	W/6sWC1nLJikpgFpnW4tOK/zjRFFzRu9Ol8gB71HEAfiq99cOVCjyauRMPWvI1vY4uaAHI1JJ2e
	ZYkuL0Lw1/bjkQJraUc6/+r6Szdp880/gbZ7iTgDjClInez2NJnACKehDqScwO+7dAlj3Ko83Ie
	EAD8v4WcxqZYwxY+xEEU4LkcvgquEFXzBUdZMUyxaItRwqsW1M2Ec5veVYJ6b0rhjISOQe6Lb/L
	nY=
X-Received: by 2002:a05:6102:370c:b0:7b2:b159:98c3 with SMTP id ada2fe7eead31-7cb3739b2c4mr1184109137.28.1791584727707;
        Fri, 09 Oct 2026 15:25:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99007c130efsm2125418241.12.2026.10.09.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:25:26 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 17:24:57 -0500
Subject: [PATCH v2 1/2] iio: adc: ti-ads112c14: fix negative settlingtime
 check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-1-6b54a7378101@baylibre.com>
References: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-0-6b54a7378101@baylibre.com>
In-Reply-To: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-0-6b54a7378101@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=4uqeXdnRU/1UZNsHvp4XBofBIT9pDbRG5x20+z4/OTA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqyWnEvaRSJSJi2VN7Vwyv9dFT8Uy+4DJInDRFP
 WFYlVjuCteJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaslpxAAKCRDCzCAB/wGP
 wOg1B/9toJslPqhgbA4IO+TI6fRGS/ZhcL0HgHWP6LXIXNIiosgejyMTr88Nk1BhrpqY4iNwuMi
 nQNQkMO6RJTmKwl5GdGNyx7wzPsSI0DmL91A5R0Ckc0HKDdQBYq7ohpqcRMsiiMbmumbC5A1PCY
 /SKGRpHeqlVokIeJiWlyOlHJyqYWDCaKikX1aOr0LgDfas2InquZSCbGIkCVwMaN/Jmz11l/KKC
 O041MtytEobKOm0wtbXAU7BhdPoAN7P6EVaLME42sZFGzrLMP4JuGXnyMV3+kRx79c6v5KPy7SF
 HFmaA3PYOO1QHUrbmy2T9QztfHskoNgUboA5/7ugUIJ7tBnM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix checking for negative values when writing the settlingtime
attribute. MICRO is an unsigned long, so on 32-bit architectures,
integer * MICRO is evaluated as a 32-bit unsigned value. A negative
integer part is then zero-extended to a positive s64 and passes the
< 0 check. Large positive values can also wrap around.

Reject negative input before doing the multiplication and do the
multiplication as 64-bit.

Fixes: 839cbb1e2331 ("iio: adc: ti-ads112c14: add settlingtime attribute")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a%40baylibre.com
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 3c877126b0be..d8fa8d413e87 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -653,7 +653,7 @@ static int ads112c14_get_settling_time_us(struct ads112c14_data *data,
 
 static int ads112c14_find_delay_for_settling_time_us(struct ads112c14_data *data,
 						     struct ads112c14_channel_state *channel_state,
-						     s64 settling_time_us, u8 *delay)
+						     u64 settling_time_us, u8 *delay)
 {
 	u64 delay_us, delay_tmod_needed;
 	u32 fixed_latency_us;
@@ -719,7 +719,7 @@ static ssize_t ads112c14_write_settling_time(struct iio_dev *indio_dev,
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	struct ads112c14_channel_state *channel_state;
-	s64 settling_time_us;
+	u64 settling_time_us;
 	int integer;
 	int fract;
 	u8 delay;
@@ -729,10 +729,11 @@ static ssize_t ads112c14_write_settling_time(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	settling_time_us = integer * MICRO + fract;
-	if (settling_time_us < 0)
+	if (integer < 0 || fract < 0)
 		return -EINVAL;
 
+	settling_time_us = (u64)integer * MICRO + fract;
+
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;

-- 
2.53.0

