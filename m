Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945B1F419F
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683197; cv=none; b=BU9rzkFCqYgnMkEqDnk33Bb2F9bl57K2gRGDaVbdk4PwVxV8GJSZ2cg674SxR1f6f9QGOFuO0CCkrXvfK4RgGAtQL4JyDxTSQxj6yHQO+DUVzwzT8AJuAR8DOpzRPeMrVNIYGq6Ea5qlI25hAAOzo38h4vX4b4g5YXrF8bpIuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683197; c=relaxed/simple;
	bh=bfZp8VUpAavl7rFGwG+PpAa0qeAiEIKKx1OJoyUuLR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCVkPjFB8ZFcSkfK5oWdsbdSAMTW2gP7u8yjNzPXUnAm19TAN2W/0bnQyV7hWsRBlG7lynKGMqbSpq/cxHQrb43hSvQMvZsnKwFDOUZOML7HYYIYPMjP3KxzPHFlZvG+vi3ERCdeenrDedxCfH8GXaze2GEPs9srBNktba55Qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIr1Yogr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIr1Yogr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf39419so29098655e9.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771683194; x=1772287994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyqb+z+OnykTCLriGqefxWwK68pFJ9wGyHSk2ev20ds=;
        b=CIr1YogrfCk9kz8LYR44CJTxKsag9W8H0vqLvRrt0fVHRp+V58K+SdEPI6wvK0lGSf
         UlgaTpsXsUCjvgk8iQtFeP6pqQxIQ5VjAznNRK8W+RUoT1Vowu3RPRj+h+lByvBt1WE2
         RkWn7kigNHoQp0OgnZkQT5axvXatyZuAQWidAiJjHt3FDB8FyS2Heh0RwdATCwVRoNUr
         zJlwyNfFG6z0/WRa/LRWvFSwQ6y9qXHfdoRFySZdqrWZWw4N5odtRJjw8zfBXO7KjuDk
         1Zo+zEwmL9+ZYe0pArnN6dRE/2n5MaEUWBD7I5kS5p2krTKGtSfV1hRolMRR2h5PFxCB
         g+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771683194; x=1772287994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uyqb+z+OnykTCLriGqefxWwK68pFJ9wGyHSk2ev20ds=;
        b=I6htyfatEpbVZ8xXuY8nGPcthetqMzTNAu09+fJEgJt6ZOMEdQtYV1OR2ILCRcuNht
         3RVezQP2MYhtIK4AT+uP1piHbw2VsCMVBeQxWQrAmxecjmHjVlm75+4fpPFl2c8ogj/M
         ukuTl1+oKv6i0mKA/KZ9A2gfl6gh0GIMzCQDsarfnTV4H0Xc8CRcjKmKJtOZx3M9tJ1S
         YlaChbdr0QunYcNu4opfpgRfj6aZtXs9m+OCkzDeMQxP3dm5Ghzb0T+x8xrEcKc/CQQh
         SjuWhx7N1L+I6BSRiBgbtSfcJBqZoATIYsiuDKMHBzabxrIEV8B5hNMA69+bZRtthgJy
         ObFg==
X-Gm-Message-State: AOJu0YzkCNvKwlcKOVo/UxY3PtKC2pfYba9MQk60kCHIrv75CUb01qMA
	VdOCLT9hPl6eXKCkRpT3+oqcGoVitmPCVsD58GWr+ped6yXmzTSpY4howB1+1A9s
X-Gm-Gg: AZuq6aJES8/cAGhezymomsPWStKJ8VlOMv8aFsLHKk891/HPl8rCFsocNRQNDgQ33sb
	As+nUbTh1qa0oGXUNvmRKTw222ZB+oA1i3S5aSXoO2GlMHkaE8iN039K7BnMI0Eg/UPTKc+anKo
	2H4o3xcNr1HZftZXJef63CW1sVywpkBaeQ5eDV7tRFyOHFuiBkrbOa6vuXRzFYAgQRrwA5C6Btc
	Tr8dW+9GM6dVul4OLRcpZI2p1fIGLmKj4vfqIXALHcASPKiLn9WyUASo92LA5LKNBpvkkvje0io
	eVhz0DE8jRcvdU8fOR6mnfcgv+D7uiZnJcsxWZSo3fJT4wmtu3qmTQEOGwAZ+ue7N64WtBuCHq+
	ClCtgqV+2ZU8esPF9WwW9LYo73DYveGqQGw+6sTAsiWJdIkxZmBtCIoDefUEbYDglheTaewnwHZ
	Q7lMhooLhzNtIGUqF1irq3cQYIiRxDxxQbc5Ll0YlUEd/YIUU1YVqLRLXbfO41+w==
X-Received: by 2002:a05:600c:5391:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-483a00a537dmr137444845e9.10.1771683193520;
        Sat, 21 Feb 2026 06:13:13 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e01c27sm50169825e9.9.2026.02.21.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:13:13 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v4 4/4] docs: iio: adxl345: update math and examples for scaling
Date: Sat, 21 Feb 2026 14:12:47 +0000
Message-ID: <20260221141251.34855-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221141251.34855-1-0rayn.dev@gmail.com>
References: <20260221141251.34855-1-0rayn.dev@gmail.com>
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

Key changes:
- Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
- Correct decimal precision of in_accel_scale and
  in_accel_scale_available to match the actual SI unit (m/s^2)
  values reported by the driver.
- Document the newly generated event scale attributes in the ABI table
  (e.g., in_accel_mag_rising_scale, in_accel_gesture_singletap_scale).
- Also sorted the existing table entries alphabetically as suggested
  by David Lechner.
- Add a sysfs example showing how to read and interpret the newly
  implemented event scale factor.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 57 ++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 3ca6a78feb5b..e830430e4870 100644
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
@@ -94,33 +99,45 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
 +---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_scale            | Double tap gesture threshold scale.         |
++---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                  |
 +---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_singletap_scale            | Single tap gesture threshold scale.         |
++---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
+| in_accel_gesture_singletap_value            | Single tap threshold value                  |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
+| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_falling_scale         | AC coupled inactivity threshold scale.      |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold             |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
+| in_accel_mag_adaptive_rising_scale          | AC coupled activity threshold scale.        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold               |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
+| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_falling_scale                  | DC coupled inactivity threshold scale.      |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
+| in_accel_mag_falling_value                  | Inactivity threshold value                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
+| in_accel_mag_rising_scale                   | DC coupled activity threshold scale.        |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
+| in_accel_mag_rising_value                   | Activity threshold value                    |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes    |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes     |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes    |
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
 +---------------------------------------------+---------------------------------------------+
@@ -140,8 +157,8 @@ When changing the **g range** configuration, the driver attempts to estimate
 appropriate activity and inactivity thresholds by scaling the default values
 based on the ratio of the previous range to the new one. The resulting threshold
 will never be zero and will always fall between 1 and 255, corresponding to up
-to 62.5 g/LSB as specified in the datasheet. However, you can override these
-estimated thresholds by setting explicit values.
+to 62.5 mg/LSB (0.612915 m/s^2/LSB) as specified in the datasheet. However,
+you can override these estimated thresholds by setting explicit values.
 
 When **activity** and **inactivity** events are enabled, the driver
 automatically manages hysteresis behavior by setting the **link** and
@@ -270,13 +287,13 @@ Scale range configuration:
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
 
@@ -312,10 +329,14 @@ Configure one or several events:
 
         root:/sys/bus/iio/devices/iio:device0> echo 24 > ./buffer0/length
 
-        ## AC coupled activity, threshold [62.5/LSB]
+        ## Check the event scale factor (0.0625 * 9.80665)
+        root:/sys/bus/iio/devices/iio:device0> cat ./events/in_accel_gesture_doubletap_scale
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

