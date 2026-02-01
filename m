Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2852882C5
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970834; cv=none; b=bP6pW2tn4olVCUXs3S3jZP8mqqN4ZUY7Ivx4zSrq/+CUKhvAwJDszFeECAueUnN1Y0ysMx1+i4LU2tyb0Ce2j8qar90yKK/4e4t4LGPZZOiDWt1F0JJNilsxSOF47LzykmkWEjT+07Sejoapi5ppgnJOKdguC9NS4NLQlGWmXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970834; c=relaxed/simple;
	bh=NTtrU9ALUW0H2U3GdQ0runI6luxdsHByzTjH6ivbrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3liXKrocuY1+KT1M7FWF9/ww2T9NG9Hrb7IEKss2b7dubHP59KmG4bjz8d5SUKCBhcIqbm1QoXkrdFBJkvd90YdiF05zujefi7UyGrbz0Cddbc+BX4/JovJuB8ffqHrdUJ4WhHPYvOL+BnN8IJRB2bD03Qd9SNDH+mX4zuls7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki5c8XGe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki5c8XGe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso4345115e9.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970831; x=1770575631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE8QDa+6YuW+XTKb20xWh2n+IRJ7xpzuDbFeuNPC7Q4=;
        b=ki5c8XGePA382RFGWVi7BpJYx98HiLojahqpMeswg/TkGt82lic4rohm5jlTCc1lJy
         mDpvq0a3b56yTpvlNc2LELiGaiF4Uhnhzo8daymxhgbPYjD5At0Zuxv1rNaygliySZhb
         PiYveRyqo0deiKVzwVKQocrqHNY+uPewG6m+sPKo3rnF7u/3EWPdQQdpe9IphEhnUW5w
         M1plSuhAC7+7X5ueylNV9wF2q6lfpRA19b2gnmmMrS6/HNCCdgNxRFZOvmjre3geI/rS
         Lc99Ner9PyKFLXwWp61Gw+u0cdZaS12OZYoNUfHxaRaTB739tjFWKFLJ64Hgt7o6zorh
         Ocvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970831; x=1770575631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HE8QDa+6YuW+XTKb20xWh2n+IRJ7xpzuDbFeuNPC7Q4=;
        b=sMSKslXUcWD2sZkkMj0tRjNbK6c5O3xw76qtlYSgvWo/4JytdrRm3alwW3JrLgjFdk
         wW4tUEv43ATbK/eYZEraWl9qiNIsvddkuh+5IatHVKLjXpS/7NC8CiFNeiOmOBoM8x2e
         lLSjLRY84wnicRmsn4wrrqXSe61514Q6oHuhwEfp4TWu2sH3XqXE2DHDT8oHV1MQ9cA+
         ZxEeQT6h8IIHNcy14jE63S02/65cpBrfIMJ5zrSOLjeCb1NsbM7R/oKocSZlWB8tzBrC
         jB7g3OGQ9nr5SailOYyjShFwuh+t/HMeSRVZvzqIHy7g7bFAobgVlJ+fKGC5lMkB+AjU
         +HRg==
X-Forwarded-Encrypted: i=1; AJvYcCX0xgreRYGmCjkaAw+wbnjUlubBY9vROPE5njMX1s+SKKKzc+t58EAb56gouIu3zJtTcY31BXRP2Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy36oCmIOHWIlptK3HCLUvRXNSk/sVx7yoA70jdRZks49vPRl
	nGvsuzSt7WCBZ+ybTucbIjHReaSjYCQ3se8rkGQckHTm3k6xBSf8IdqA
X-Gm-Gg: AZuq6aKJbPjgNNr+bFqMRvqxgp4OsPcwM6GWGdjP7/7232nddHjnN1JeKcu3QCJO59I
	kHTTE8dpDf51LGWiuyactJx07j28mPeDzeaz9esbgGWOVY0yg3aIQxKqOLJmGY2Oaex8VdvkPNI
	xo0WVHf6EhAlC9q3n/ZcYs0u4Qa18RsQTXD8WYwebZ69awzZuBK+tAyy/UeBGDxzJ06Pc+Hj41s
	bmbnnp/M4mqSZFTZTKa9yNy5iCMfa05VwFdb7ZwYyxCrdR8lrH6uedfp7JEvc+IDgnJrPz9dSZE
	NvwIQWItKF4adjxEP56p1NzZlOYiBw2Vu5trVqeBa7TMlSnmrM9joEc/Km5bCcHOaYZWqatUeUf
	8V4Rd+YJrslq0FpgwRpms6AZDgXvCL6t9oLtkRY+mu+ohVDUVcERgUrVNNzgcYemuZviAQFAa++
	G44uGsoPcaCMwek8ztbv7IbaVdlOt3nMJr7c0eVfgCK8ZQrg==
X-Received: by 2002:a05:6000:24c5:b0:435:aaba:b904 with SMTP id ffacd0b85a97d-435ea06715fmr17840324f8f.8.1769970831095;
        Sun, 01 Feb 2026 10:33:51 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm41400084f8f.13.2026.02.01.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:33:50 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	rdunlap@infradead.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 4/4] docs: iio: adxl345: update math and examples for scaling
Date: Sun,  1 Feb 2026 13:33:13 -0500
Message-ID: <20260201183320.27023-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201183320.27023-1-0rayn.dev@gmail.com>
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the documentation to reflect the addition of event scaling
and correct existing technical errors inscale values.

key changes:
- Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
- Correct decimal precision of in_accel_scale and
in_accel_scale_available to match actual SI unit (m/s^2)
values reported by the driver.
- Add sysfs example showing how to read and interpret the
newly implemented event scale factor.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 41 +++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 41d209a4dccf..2f51a2a4fbd0 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -13,7 +13,11 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
 * `ADXL375 <https://www.analog.com/ADXL375>`_
 
 The ADXL345 is a general-purpose, low-power, 3-axis accelerometer with selectable
-measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
+measurement ranges. The ADXL345 supports the following ranges:
+- ±2g  (approx. ±19.61 m/s^2)
+- ±4g  (approx. ±39.23 m/s^2)
+- ±8g  (approx. ±78.45 m/s^2)
+- ±16g (approx. ±156.91 m/s^2)
 
 2. Device Attributes
 ====================
@@ -98,23 +102,28 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
+| in_accel_gesture_singletap_value            | Single tap threshold value in               |
+|                                             | 0.612915 m/s^2/LSB                          |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_falling_period                 | Inactivity time in seconds                  |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
+| in_accel_mag_falling_value                  | Inactivity threshold value in               |
+|                                             | 0.612915 m/s^2/LSB                          |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in          |
+|                                             | 0.612915 m/s^2/LSB                          |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in            |
+|                                             | 0.612915 m/s^2/LSB                          |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
+| in_accel_mag_rising_value                   | Activity threshold value in                 |
+|                                             | 0.612915 m/s^2/LSB                          |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
 +---------------------------------------------+---------------------------------------------+
@@ -140,8 +149,8 @@ When changing the **g range** configuration, the driver attempts to estimate
 appropriate activity and inactivity thresholds by scaling the default values
 based on the ratio of the previous range to the new one. The resulting threshold
 will never be zero and will always fall between 1 and 255, corresponding to up
-to 62.5 g/LSB as specified in the datasheet. However, you can override these
-estimated thresholds by setting explicit values.
+to 62.5 mg/LSB (0.612915 m/s^2/LSB) as specified in the datasheet. However,
+you can override these estimated thresholds by setting explicit values.
 
 When **activity** and **inactivity** events are enabled, the driver
 automatically manages hysteresis behavior by setting the **link** and
@@ -270,13 +279,13 @@ Scale range configuration:
 .. code-block:: bash
 
         root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale
-        0.478899
+        0.004789
         root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale_available
-        0.478899 0.957798 1.915595 3.831190
+        0.004789 0.009578 0.019156 0.038312
 
-        root:/sys/bus/iio/devices/iio:device0> echo 1.915595 > ./in_accel_scale
+        root:/sys/bus/iio/devices/iio:device0> echo 0.019156 > ./in_accel_scale
         root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale
-        1.915595
+        0.019156
 
 Set output data rate (ODR):
 
@@ -312,10 +321,14 @@ Configure one or several events:
 
         root:/sys/bus/iio/devices/iio:device0> echo 24 > ./buffer0/length
 
-        ## AC coupled activity, threshold [62.5/LSB]
+        ## Check the event scale factor (0.0625 * 9.80665)
+        root:/sys/bus/iio/devices/iio:device0> cat ./events/in_accel_gesture_scale
+        0.612915
+
+        ## AC coupled activity, threshold [0.612915 m/s^2/LSB]
         root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_mag_adaptive_rising_value
 
-        ## AC coupled inactivity, threshold, [62.5/LSB]
+        ## AC coupled inactivity, threshold, [0.612915 m/s^2/LSB]
         root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_mag_adaptive_falling_value
 
         ## AC coupled inactivity, time [s]
-- 
2.47.3

