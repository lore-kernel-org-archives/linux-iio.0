Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60E35D617
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563140; cv=none; b=u5MdoKJi8EQlkDrSqsOkOQb9P0HRixOLfmwH+GTZtiKwBUW/wBcEv+ypE9xzH7ovpmym2p3HcebB94cbVk4Ejtg3cp0ldlZStfH4uKIiO7oA8KfRXRrZVhTO8VF3rqDx/fQknNTV8HUwfRxTMFkTvVcfW6Qp7oXI8SvN7ItLMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563140; c=relaxed/simple;
	bh=U0yREyMuA9zF5E01tEeHmGWl8udIXIY+aolKf/33vzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i54zyJwYCnvYEo8gbFATUrrZoG1nionsjf7+/9u2gq+xQjvwRFCglmUsFxz8D+tftkNm6xPCfM+Kp02LD2HkKIeebv4O/mPaKLp8lBoX4qdLFzrfMIB6zA7CG2eXQHf63bMAlzEW6WxldZJYb5MwGygbe0M4XbK3DZR4zHTINQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPUq4mkG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPUq4mkG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4833115090dso9035855e9.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563136; x=1771167936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d13IbX+Pqr5mAXxfWBXXantCifGt3HSpLvwuk8HyZUQ=;
        b=lPUq4mkGcr/7J0GR91QQiJZaymr0jwOb4S27tBhjuNy/yl7ht0LJt1akYK8mcTSaH1
         SD98gJ858oXXo4cxQDZ0T1elWELnm0dkM7v1vou//gC3YtwyjkmxRr+4oY8l8HC+ksjN
         dkXoJbrIqbXA1ZiHU/UyUgo4Z0eiBhKbSp41JZV5wY3YnDuSEC1lqHyw8m+xct0ESg1d
         9qiR16m1nmxqGvCAQ0bILcZfycM5/qVxE6gn1H8YE3EAy1RiE8RrghplZbw4psyDDqqD
         iPK40nYdRvB3ps9LRAA8fgrTja5dB9ywxUFDf8nCI5l3z3vO0Ko9/WCp0qMQTjGqmNq+
         1B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563136; x=1771167936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d13IbX+Pqr5mAXxfWBXXantCifGt3HSpLvwuk8HyZUQ=;
        b=mOqgusivNDtyfkJAU31PjB5E0DG0X2YTu8cuto8OGUXGB2wkpMi0ulc3SWGazBa5Hx
         HZtatGK3tAfSXGBZn11QJIV5t4PCxt62FBJih845+AedscmrsuIjM+sEraKcNWWVZ1BC
         wL3Qb1dvQr/tb9LgzRe9gCw6S55QxGiCUbHciINxJKPC0GYGmIvmXtTRtfa3PfsRwOZ7
         Vue1g7/bb9k3r4H0KbBXddX9m+u6cuigT8E8qjpzgP1EDdy9e6j/+tqpef2cIT2rAU4S
         esEITA45196TmISy7A1Sn9M2E2RkY4aP6bI5HlGXISySWEsS0HAsHoLQwpM5d6aWC+fQ
         z1kA==
X-Forwarded-Encrypted: i=1; AJvYcCVozMLMQlyAz9x/GQ5qzQvEZRA01MZ17nbTGnjmNma8eCMWjQbETPMvV5ysup2kfYuTw4RlmFOIR5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9uUQkfbK0JbcQ/PMqKXj1FnUE3nbwFbzn21sqC33b09nSpDb
	I+uXPkf+2U8biSRiZ2CAMm3wfu5uYIGcjM8QpDt6Tcs+mvM6/YRr8eTz
X-Gm-Gg: AZuq6aKfx0dpkDqK2WIh14QAv3f4fvu7t0S4pQWfhRpW7Azs9viLllUjaR/uwnP4t33
	BaoMZ19kvtka/y9qjlN5oYg9LZg32t3tgcEVULOBxr3mn2A0fnz4WesLvMhAXxFixu3xSvRyXnp
	LmqQApCUQQ5Vt2Thrf8FSN2Q1c5bLJWURaSD2aPXbxPuauGt/cFl0p2c3S1PwVAvbzSKoVoQ59n
	iEd4cXoE++m1WbZ26+zZn7AVwAGSp93iJgwiC56usZTFm5jGSEUzBI+ZHAUEkn3nMFB3uXEeiRL
	mBNTSne68fG/Bpuv0uzbTt9rkwIDwfW9GI5b58ur0KpIM9lcYksRW+rFYFvR1kBt9eFa0zGKt/o
	mnUeG1MbWQM11uULDb1XfTdwUgUkN1S3V/yqAmZ3WoMv5GwozVxX1TN4G5GYtvfLZfDky8aiade
	jiE4DmcwGx8EcBEFgQu4aSj9i3GD+Ib5/R3+SjZy8n7pgC3oGVeQ==
X-Received: by 2002:a05:600c:a10b:b0:483:361b:deff with SMTP id 5b1f17b1804b1-483361be0aemr32845895e9.14.1770563136324;
        Sun, 08 Feb 2026 07:05:36 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc7d3sm179326255e9.5.2026.02.08.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:05:35 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 4/4] docs: iio: adxl345: update math and examples for scaling
Date: Sun,  8 Feb 2026 10:05:05 -0500
Message-ID: <20260208150515.14798-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208150515.14798-1-0rayn.dev@gmail.com>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the documentation to reflect the addition of event scaling
and correct existing technical errors in scale values.

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
index 3ca6a78feb5b..321565699817 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -13,7 +13,12 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
 * `ADXL375 <https://www.analog.com/ADXL375>`_
 
 The ADXL345 is a general-purpose, low-power, 3-axis accelerometer with selectable
-measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
+measurement ranges. The ADXL345 supports the following ranges:
+
+- ±2g  (approx. ±19.61 m/s^2)
+- ±4g  (approx. ±39.23 m/s^2)
+- ±8g  (approx. ±78.45 m/s^2)
+- ±16g (approx. ±156.91 m/s^2)
 
 2. Device Attributes
 ====================
@@ -98,23 +103,23 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
+| in_accel_gesture_singletap_value            | Single tap threshold value                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_falling_period                 | Inactivity time in seconds                  |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
+| in_accel_mag_falling_value                  | Inactivity threshold value                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold             |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold               |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
+| in_accel_mag_rising_value                   | Activity threshold value                    |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
 +---------------------------------------------+---------------------------------------------+
@@ -126,6 +131,10 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
 +---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_scale                      | Tap threshold scale (0.612915 m/s^2).       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_scale                          | Activity threshold scale (0.612915 m/s^2).  |
++---------------------------------------------+---------------------------------------------+
 
 Please refer to the sensor's datasheet for a detailed description of this
 functionality.
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

