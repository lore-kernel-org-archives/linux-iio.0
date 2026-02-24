Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22D3A0B09
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941855; cv=none; b=NuTeR++xhOYEqTmUoW8p8o3rlfUZtJvrF3GujvgjQYgLgeRdfU8v6dHFZtt31zlsvCAvPvBTx8DixogJXGyixeQ5ryd740vVQTjolrePTvkcV223J3nTGD67OQqhFyvX9aIBDxO3t1r5ySXrPpAvuppEOsVajb/RRWyou4JRNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941855; c=relaxed/simple;
	bh=RCSd/4oQBDUWrPPJPkxgbdapWWuW2JQEIii1gWkOPuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkbqAxgJ3EsC++qw4RauQ0dFSU7N3FKaAzDZg8SXCwgo6zlYz/quD1CpGwtcpVySgLodHJImAnU2/7hUWxaAvgqHbYYW7m631heEcVDUvHlHUfdPI4DiClrABU9bUAyTo+ly1v5sO62K4aSaGu6N/nWeHSa9aSxyO1TafgnHnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX4jYyCx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX4jYyCx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837907f535so49841835e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941850; x=1772546650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jc+MOUwKatfWFOZ+bC1UaXsxiBEETn+4AvPc46kCF8=;
        b=iX4jYyCxV075TS1zJCpGSsvmhT+7cae19tJvRjGvz8/kKoxP6D5kGvXCmpQ2C7jrn8
         UDoi6FdRc5LRE7+Jp8TDM0w8XbnAl3+vfKc6Oq4ZwEVa12y8E/diC/+hcyyZKJ9WPnG6
         NDq2Upf7cfTNCvw6fTDuV83XNbqIIrHb1rWW9EOx9vNfT1dS2oP/y2fWms7V/XIlkiHA
         Yc6R9fRANbIv+DOs9x6KMVc+migLn1GLLCUjvyuYlEc3BSKA2LaAIX6JWqhmnszYEv8c
         bJOyyxs5hzf100rrkdYGdntcbexPdZDFp2XFlC1MsC9q3v8//3Muc2PYn8zZQi84uWHW
         bRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941850; x=1772546650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Jc+MOUwKatfWFOZ+bC1UaXsxiBEETn+4AvPc46kCF8=;
        b=hrNQFlfEFKVCzdnF084c4ch60mvMrjAHq1p+kJq/MxDgoVSwJLG8S5uvi59SDm3Qpy
         l1TO46gnPuEm8t0MY4tFHzqmbQ/BMydILDwPQWTDokmvs1I992NQTb0VscZVpUi72502
         w+6+NXfeskjWN57YBj4Pah8S/jKbKXNhse9kuCCglR3u6L8IYNBWSJmgEnndPjC3wifT
         Jgfnm+i899ajNsoTEmLlOl7LFCIyRbu1K8guxkj7KEWszZt6p4toMNZJZ/RG09nMj6KG
         HRDIXUfHcafsPrzPZ+jRKyjxCX1pnChZ+FbA82ukcKdUVepfifn9SrzhfSImf9yXnlIB
         aqAQ==
X-Gm-Message-State: AOJu0Yz8MVWsMuwTk8t9NPKshB/sQW7aiflMcu/CyVb4WNuibeJoVAJt
	9097Z4r8FIDUBji2nNxGCAgcO382SqDrEf33MDW7sU3yci31WmO/lMt/nCliH/Fu
X-Gm-Gg: AZuq6aKbYxG+EZdFQ6KQI69kwUnCqY/xZoCLw8p9OUlL7RruknbfJIy+i5X5EOgvBpD
	0J6e1/cBoYkeUpcGsPGk1f1QK3z5QXxiyxKLW0NkGP+3pX66IK8tYQaovt9a9DmCvBGaPhyGM7C
	dksq8fZpfTPGSEJFeVDeI+ftEZqKQaL6SnLeDL8Ugwm+NU+9iMWzSJlBi0DSeME/V3AhTk1tZFa
	v9y9NcI1J/B2eVw6qw/PxUvENNsXf1wcanQf9M6mWuYoVghGlJyq411ZAXXb8Gb8ViQVws/MTIe
	jGOcuQAlT58xxNdKOPZ66KiTDczMK6clAQhvZEFQd2TrkTDGELM92Z+qhbnF8+C0z0GhL6608j5
	xEZJsxoXtT00uZgxpzNj1E2cW1hgXlGBN9RkGIaPkQTcJV+IsiZtVal+qEKUydIwsKxJ1ZqbmRo
	n1zLlsIMSjBJ0jxnMLcffZYKl4qRACts79mpcc/80ENmyDhbyktLFOSfuXrwVDWw==
X-Received: by 2002:a05:600c:450e:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-483a95eb2ffmr193425535e9.22.1771941849568;
        Tue, 24 Feb 2026 06:04:09 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:04:09 -0800 (PST)
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
Subject: [PATCH v5 5/5] docs: iio: adxl345: update event attributes and scaling math
Date: Tue, 24 Feb 2026 14:03:48 +0000
Message-ID: <20260224140351.27288-6-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224140351.27288-1-0rayn.dev@gmail.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
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

