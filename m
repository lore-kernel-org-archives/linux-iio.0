Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F83115B1
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535374; cv=none; b=V24cp9vRNAEH4QEJiylvIVeA4dQfoaCDlXJDmcmmHgsoI4HVdyH7o1RfJ77qN0TejxMN00cwaCDXwM3lWIwMGa/N6ssc6UuFhrNbfsVG0jureWeF8BD9sJLY95+auFqAaxtipOm9KI8FDyf+4jvTAfQM4WEWVtcWMORDlLu6RC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535374; c=relaxed/simple;
	bh=/SjArWhl91MYDI90bvd0/eW+OI/xdQ6cfMLtNYKxT40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKzBFgAADtb8CpLqXorfcOPjFtH4AAKCWEUdn7grqTFvbJLoti+gSJAObdYK96Jew+mOUEvYyQQ0YYHlkrj7uZOsOZyEVB4JvnawHsIMMpaRYNgTtivAOgpT9zYBwNqrDuu1Ys/XQAo+EQERq/C6PKStGqH/8+LVy8sUPpK1yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PskTMlI9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PskTMlI9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so46597295e9.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769535369; x=1770140169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxXfz+R2HYXLp2KDrxuAaoGBhmk4g7IaH8iP247DXBY=;
        b=PskTMlI9fiiA67OGNeV/FB8hPFMa9NIueuYtGsh6yg43iUgb3sSJbnmijXMiAiUIJU
         Zk2+ue+aRHAx8se0IT5M4dll3qtTx6XqtcG4blDcUOD2xi8MKgsy+Xcs4p/uimW7Rhod
         AasLmN1hyCiH4ImkeDt0BVsw86UDxSW2a7nqSBou9y/G0YV3ANn4OyD59VIfjiKOdvjS
         NDV+8V57gKpuEfdCA0B9nKOYCTvmCP1iDwyY/FB+NX8M/jSvcOHhl1dOgP1kyxO+Y5uI
         70rKX2Aq5E3LwoU6tsmCa++XZGfENewE78pAxh/LL9xc+rqk9NxyFQYrhFPsLIbz3+tE
         IKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535369; x=1770140169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxXfz+R2HYXLp2KDrxuAaoGBhmk4g7IaH8iP247DXBY=;
        b=HvwapxvxYqCgiNwvfBkfhWJoN3rb4JGIV1wIT5yXy/kTUEdoauq2vOmGx3dvT9xPb+
         splH1enPHiqowczt/ldq9HuR/A0BbpPVkZwG+pLOOZfHzWDiBULsBX7o9pAsJuDV30E9
         x3ivAA3o/Xg9N9T5XlgsiTldd9PQIMXnRnCLqEV/h4vXnR1087AoULPxbcpN09WIMC9+
         VhgwpwQp/OuHjxk7e4Jdm9mQTc0T2ZKpL+gNyaHjKYJ0QCn0XoArPdzNF5eQKeMneve6
         LRa77nop144dzUp4rOWgDtSX8WcYd/Ds3WQ3nUTGN4L+xAFFdHcYkH0aiFb1+1YIOXyH
         ID4w==
X-Forwarded-Encrypted: i=1; AJvYcCUPhVUChYPgKijP1DLKBXCONpChbjFtvMZw4iUz9h3x+Xo0/EOATZuSvkyGj7YP7SwbEFT5NsqQ83Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oRZS+Gsye6P+NKc6wUXwqcjNS49bN90MxH9UXf2DSF34p1EZ
	sgI/6611Ywfd9WPw8U+Rs3/8VGRIAB0jYFGy9yYTpM6IYJ+xJttDTdXt
X-Gm-Gg: AZuq6aIho9EF590bVX3+hqLQ58hPV2KDz1COdhJmLt75ly5HrtXlTiKwECKmMtJXbop
	yqSoKXvvc1PbIez+14CArsRvcZ8SeeJi6J4WHnWG8mNX7n9S8MfQ/NV0jBtiJ/2i9VSE/ZcslaM
	eOC1VPZ/YaZuxEhTbm/lOg3fv71sjDqNuRzyQmeEZ9Tjd/A7Z696P4b4EeiIvZ2HnvaIWs3FXw1
	vCm9hOlJ3SeKBYTGY26Ja41sswgp8DSDrRou9zAQvjOAU503LMLIq5b+cikvcRkS+28JDZlJY9P
	ZjNr+6g9jp/8KPwWT5q2nkM2IhzN4FJzLMiPvCNJyfC5QFQ6ID9UhouTlc9C0QPLnYLmvwFIdlU
	FQ9/e4xZ1x2VIpp1tnyJ98S1hMo8i9vHZZbjTrpBAwqT4Y08SGAMc78EVnjj1LSD4ft+kb64KMV
	9BS/D2U1aLOiBhSrHMqLlGVtfDIjS/sblKRHWdT2IJPqKLiA==
X-Received: by 2002:a05:600c:3113:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-48069c3fb40mr33003035e9.6.1769535368338;
        Tue, 27 Jan 2026 09:36:08 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c4f3edsm72156975e9.15.2026.01.27.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:36:07 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH] docs: iio: adxl345: Fix typos, units, and grammatical errors
Date: Tue, 27 Jan 2026 12:34:51 -0500
Message-ID: <20260127173543.72423-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up the ADXL345 documentation to improve technical accuracy
and readability:
- Fix "latent" to "latency" in double tap descriptions.
- Correct the threshold unit from "g/LSB" to "mg/LSB"
  to match the datasheet.
- Standardize "axis" to "axes" for plural references.
- Change "generic purpose" to "general purpose".
- Fix minor subject-verb agreement and punctuation errors.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 104 +++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index bb19d64f67c3..020b512cdb74 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -12,16 +12,16 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
 * `ADXL345 <https://www.analog.com/ADXL345>`_
 * `ADXL375 <https://www.analog.com/ADXL375>`_
 
-The ADXL345 is a generic purpose low power, 3-axis accelerometer with selectable
+The ADXL345 is a general purpose low power, 3-axis accelerometer with selectable
 measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
 
 2. Device Attributes
 ====================
 
-Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
 where X is the IIO index of the device. Under these folders reside a set of
 device files, depending on the characteristics and features of the hardware
-device in questions. These files are consistently generalized and documented in
+device in question. These files are consistently generalized and documented in
 the IIO ABI documentation.
 
 The following table shows the ADXL345 related device files, found in the
@@ -42,7 +42,7 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_y_calibbias                      | y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                      | Y-axis acceleration offset correction                    |
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
@@ -68,7 +68,7 @@ present, simply assume its value is 0.
 +-------------------------------------+---------------------------+
 | Channel type                        | Measurement unit          |
 +-------------------------------------+---------------------------+
-| Acceleration on X, Y, and Z axis    | Meters per second squared |
+| Acceleration on X, Y, and Z axes    | Meters per second squared |
 +-------------------------------------+---------------------------+
 
 Sensor Events
@@ -78,8 +78,8 @@ Specific IIO events are triggered by their corresponding interrupts. The sensor
 driver supports either none or a single active interrupt (INT) line, selectable
 from the two available options: INT1 or INT2. The active INT line should be
 specified in the device tree. If no INT line is configured, the sensor defaults
-to FIFO bypass mode, where event detection is disabled and only X, Y, and Z axis
-measurements are available.
+to FIFO bypass mode, where event detection is disabled and only individual
+X, Y, and Z axes measurements are available.
 
 The table below lists the ADXL345-related device files located in the
 device-specific path: ``/sys/bus/iio/devices/iio:deviceX/events``.
@@ -87,45 +87,45 @@ Note that activity and inactivity detection are DC-coupled by default;
 therefore, only the AC-coupled activity and inactivity events are explicitly
 listed.
 
-+---------------------------------------------+---------------------------------------------+
-| Event handle                                | Description                                 |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis     |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]                   |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_en                      | Enable activity detection on X axis         |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
-+---------------------------------------------+---------------------------------------------+
-| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
-+---------------------------------------------+---------------------------------------------+
++---------------------------------------------+------------------------------------------------+
+| Event handle                                | Description                                    |
++---------------------------------------------+------------------------------------------------+
+| in_accel_gesture_doubletap_en               | Enable double tap detection on all axes        |
++---------------------------------------------+------------------------------------------------+
+| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                      |
++---------------------------------------------+------------------------------------------------+
+| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                     |
++---------------------------------------------+------------------------------------------------+
+| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                    |
++---------------------------------------------+------------------------------------------------+
+| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5 mg/LSB      |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_falling_period                 | Inactivity time in seconds                     |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5 mg/LSB      |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis           |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds          |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5 mg/LSB |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5 mg/LSB   |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_rising_en                      | Enable activity detection on X axis            |
++---------------------------------------------+------------------------------------------------+
+| in_accel_mag_rising_value                   | Activity threshold value in 62.5 mg/LSB        |
++---------------------------------------------+------------------------------------------------+
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis          |
++---------------------------------------------+------------------------------------------------+
+| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes        |
++---------------------------------------------+------------------------------------------------+
+| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes       |
++---------------------------------------------+------------------------------------------------+
+| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis          |
++---------------------------------------------+------------------------------------------------+
+| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis          |
++---------------------------------------------+------------------------------------------------+
 
 Please refer to the sensor's datasheet for a detailed description of this
 functionality.
@@ -133,14 +133,14 @@ functionality.
 Manually setting the **ODR** will cause the driver to estimate default values
 for inactivity detection timing, where higher ODR values correspond to longer
 default wait times, and lower ODR values to shorter ones. If these defaults do
-not meet your application’s needs, you can explicitly configure the inactivity
+not meet your application's needs, you can explicitly configure the inactivity
 wait time. Setting this value to 0 will revert to the default behavior.
 
 When changing the **g range** configuration, the driver attempts to estimate
 appropriate activity and inactivity thresholds by scaling the default values
 based on the ratio of the previous range to the new one. The resulting threshold
 will never be zero and will always fall between 1 and 255, corresponding to up
-to 62.5 g/LSB as specified in the datasheet. However, you can override these
+to 62.5 mg/LSB as specified in the datasheet. However, you can override these
 estimated thresholds by setting explicit values.
 
 When **activity** and **inactivity** events are enabled, the driver
@@ -148,7 +148,7 @@ automatically manages hysteresis behavior by setting the **link** and
 **auto-sleep** bits. The link bit connects the activity and inactivity
 functions, so that one follows the other. The auto-sleep function puts the
 sensor into sleep mode when inactivity is detected, reducing power consumption
-to the sub-12.5 Hz rate.
+to the sub-12.5 Hz rate.
 
 The inactivity time is configurable between 1 and 255 seconds. In addition to
 inactivity detection, the sensor also supports free-fall detection, which, from
@@ -312,10 +312,10 @@ Configure one or several events:
 
         root:/sys/bus/iio/devices/iio:device0> echo 24 > ./buffer0/length
 
-        ## AC coupled activity, threshold [62.5/LSB]
+        ## AC coupled activity, threshold [62.5 mg/LSB]
         root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_mag_adaptive_rising_value
 
-        ## AC coupled inactivity, threshold, [62.5/LSB]
+        ## AC coupled inactivity, threshold, [62.5 mg/LSB]
         root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_mag_adaptive_falling_value
 
         ## AC coupled inactivity, time [s]
@@ -330,7 +330,7 @@ Configure one or several events:
         ## doubletap, window [us]
         root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_reset_timeout
 
-        ## doubletap, latent [us]
+        ## doubletap, latency [us]
         root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_tap2_min_delay
 
         ## AC coupled activity, enable
-- 
2.47.3

