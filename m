Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF983E9F9E
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118692; cv=none; b=uv7IY/ZEkQVUK+d3j/mB4kCS35GaXCcWNCXaIpzSsflvZNwbv1h4ZyTWQHV1fkW9d60QkkntpvIDUBtISFdXGIQ+CsoQSTjvbqzE9WnfUDMgjwjs7aaGOCQuaDl0IDZLNNBHZgV9UMXf9vleBOphbI0r2cZffG+5Kvf5vwzAmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118692; c=relaxed/simple;
	bh=RCSd/4oQBDUWrPPJPkxgbdapWWuW2JQEIii1gWkOPuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrjjlqozO1NGtBXOFbXJvxtX/wyfmBbqcrJsbzbaOfu8Apid6FpI+NZqdT1QeJvR04+v6Oc3zOn9bM1vk42Y4pB9MqlhHqemurBzwGpbpnPu/hI10jolJH7LDG6EYHNki7ehXHpbK1DOqPPWm8HQo5md5f+CQUDh28yW9Rz3J04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkIZPpjp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkIZPpjp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c7199e7f79so123347385a.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118689; x=1772723489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jc+MOUwKatfWFOZ+bC1UaXsxiBEETn+4AvPc46kCF8=;
        b=GkIZPpjp0nIW8SdUhZ9H0LLXf7/L18tizZmOLDaMWwmOoUYwdnxX8RY710O4u7g0Bn
         S3xS3H2R/xugoYGcm3iouT/XDnFvfMNBQ4Wlg2l2HNTPPLBI6Fiw0uT7bcKo2aS9Hvwh
         1EEfIQzhQVsoM9HPLAncxdh4fdAT2qcIzad0IfWWBIn/zglEjhJzyzKwDPgamMQH3Z58
         JWKT4Jj9RV7rIZdu511RINKq3eUmST+3d8s5yfeDU40GbLb6uFZDFzQyo75JtNFfcib8
         pJGEA1ceZQCSkNIu7qNFFNmZ8AiymT8zDl675avvXnQ/EDApJtdx6b/6reAfvZmSp2b2
         y5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118689; x=1772723489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Jc+MOUwKatfWFOZ+bC1UaXsxiBEETn+4AvPc46kCF8=;
        b=L63svq9+0OT4lK+pgX+V+RiW2ZHsZNL/BYAYzzIhWkMx815/XX633Jwr8hvqrdZ7hw
         W3WGIhZQRoeW2EGFm5Fcji2JCu+LNwROHdcXCTxTCe9ag386aVtNxNSrvNKFvKyKnMMF
         XKz16eJlFemyV4GogzraEVk1ksxQ6ghOshkwsH3gx7d+f00J6V945eDeMT6xukabbUxY
         DJJBBUCZrfdJuVAzo9jIcjvEJpbYeu54a6oaLetiJDWcW0sY9Rx8kmh2F9GR3VNIcP9w
         l5eotKFKwY9SWpI83WIoYPlHEi8xsFj6KcO8Uo7Os2OTcmViqSaxH6ESFKgnN02q0J23
         hBlA==
X-Gm-Message-State: AOJu0Ywu5KBnLr7mEDwfFXDNBvWcBZ8mLbn2vczvgZUNcFF9QVBB/gXH
	TrY6Z/EeKjF/xiH9XJ7Myp/U1hCjjNMcHd6o4B7XQdeqPtofhkAsN/fAEZurN5QW
X-Gm-Gg: ATEYQzwvqnNwtLev3oTlG4LqBQvIi0A/cH+K1hEdsQzM/KAzXrkneFItp9v3WeDKrKe
	Z8JzCM5iZw8f2Gy3IAmKTlH5m44mAbAglu5Qn3oc02txrTfWZH2k1dgq3RQs+e2Im0L/5NDj6GA
	+l8dqxpwy6wS3MG6hLyIUtoOKd1LywM4bQDd5BbNvUVF//C91i4mZaV1nB/r8XcWOejys87Ag3x
	6SArx5mnw97cmGYaSP/0/RM6w13nAtkH+W2hAGi9ciNWcVXQC81ZDcX9wEdRJOE/wzwtsm30AxA
	1C8UDO8xVaUkA87vV9umOC6nN/oNzNMpZ/4RbqGdB3u2KqGBSU4J+AMI6QIUdnicV6u73wEANYn
	el1LXHj+9dfTHnZRaQYLo0ZG2xwDYycMYEl5Oa2eg9khMmw+TQXpt1rJMyerIWNcFvfTXlVHV+F
	/tx8DdmZYctZGUUAVs3cL0n5EwUQqLIJB/m5q2O+ArZlex7mSt6XSBkxYqBo+qrA==
X-Received: by 2002:ac8:5855:0:b0:501:4446:2ce with SMTP id d75a77b69052e-50741f85459mr63908431cf.49.1772118689177;
        Thu, 26 Feb 2026 07:11:29 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:28 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 5/5] docs: iio: adxl345: update event attributes and scaling math
Date: Thu, 26 Feb 2026 15:11:06 +0000
Message-ID: <20260226151108.22383-6-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the documentation to reflect the recent driver additions for
event scaling and the double tap threshold value, alongside correcting
existing technical errors in scale calculations.

Key changes:
- Fix the 62.5 g/LSB typo to 62.5 mg/LSB and add SI unit conversion.
- Correct decimal precision of in_accel_scale and
  in_accel_scale_available to match the actual SI unit (m/s^2)
  values reported by the driver.
- Document the newly generated event scale attributes in the ABI table
  (e.g., in_accel_mag_rising_scale, in_accel_gesture_singletap_scale).
- Document the newly exposed in_accel_gesture_doubletap_value attribute.
- Add a sysfs example showing how to read and interpret the newly
  implemented event scale factor.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 51 +++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index 0e8977345e9d..978f746a8198 100644
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
@@ -94,27 +99,41 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
 +---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_scale            | Double tap gesture threshold scale.         |
++---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                  |
 +---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_value            | Double tap threshold value                  |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_singletap_scale            | Single tap gesture threshold scale.         |
++---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
+| in_accel_gesture_singletap_value            | Single tap threshold value                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
+| in_accel_mag_adaptive_falling_scale         | AC coupled inactivity threshold scale.      |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold             |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
+| in_accel_mag_adaptive_rising_scale          | AC coupled activity threshold scale.        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold               |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_falling_period                 | Inactivity time in seconds                  |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
+| in_accel_mag_falling_scale                  | DC coupled inactivity threshold scale.      |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_falling_value                  | Inactivity threshold value                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
+| in_accel_mag_rising_scale                   | DC coupled activity threshold scale.        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_rising_value                   | Activity threshold value                    |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes    |
 +---------------------------------------------+---------------------------------------------+
@@ -140,8 +159,8 @@ When changing the **g range** configuration, the driver attempts to estimate
 appropriate activity and inactivity thresholds by scaling the default values
 based on the ratio of the previous range to the new one. The resulting threshold
 will never be zero and will always fall between 1 and 255, corresponding to up
-to 62.5 g/LSB as specified in the datasheet. However, you can override these
-estimated thresholds by setting explicit values.
+to 62.5 mg/LSB (0.612915 m/s^2/LSB) as specified in the datasheet. However,
+you can override these estimated thresholds by setting explicit values.
 
 When **activity** and **inactivity** events are enabled, the driver
 automatically manages hysteresis behavior by setting the **link** and
@@ -270,13 +289,13 @@ Scale range configuration:
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
 
@@ -312,10 +331,14 @@ Configure one or several events:
 
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

