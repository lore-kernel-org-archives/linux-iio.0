Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03029ACCD
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941845; cv=none; b=P4PoE4Ik3mep9Wdzp0tjilxA3cmQwI4NodjoP52rgJT0z+UtfdLSCvudUH89x6rzKORXHf5FO7Y/xCRBlYiONDFwYWDVJVr4ghzTL0Lo0k3UT7urA63XeZfH7j3DA78M/iGbsJLg6BZz5buGF8mAT6Arzv0b3T3u6GzAYyqyEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941845; c=relaxed/simple;
	bh=pQavWAYPpsey0yQqgVWWpFe8QdmDgqTBdo0zNEICEsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0ZP+YKAg4zNJ6nAw5WgVlno79Pdj5BLQPO5QoIiiMsB2x+xjNp5rYeechfniz6tZD1F6ZUrYGobwBxV0Tf1e3yROXk8qHwCyiAp+WQF/dF0qfH2TMdHlMLqvNIbWQu791wNsbqp8G99Dnzdzr0Yy+m0aKrr1lfyG7YPiLnBhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0UIijTd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0UIijTd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48069a48629so57078125e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941842; x=1772546642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBPp/39SgW1yz4SiSW0HB6Or3cMOFZIagn+ooTwLYE=;
        b=R0UIijTdn4zZ5CTj58056vieMdKpwLzA3/zUN6dJoK2UNN6V0Y0Nkg4IZmB7ilFZTD
         f6w0s5SEwUeBlDh4vYR6G7/OPg+dmXdrKWPkZz8ARzn/VF5IQZeeMVXWrAq4SsL0YLm9
         bQiZwoRo3CjshbWk2vZ8t02CYR2xSTUR9LAiJy8bJx6t+zDF7WjXBojM09YoPnS3+rKg
         X8VcdBw9lmMqE6RwSBc/sJeKwr3dwbzYuHkj0YWQ07zF/ju56ZWGU8yNFnNta8ZTK+GF
         E9Vd9ANz4bVkyXRahvTrPAJ1z149/sRACXIsPVdGfbrFfxA9qH6isRldX3l/IqQ3wRAB
         s0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941842; x=1772546642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYBPp/39SgW1yz4SiSW0HB6Or3cMOFZIagn+ooTwLYE=;
        b=bhtquVMOK/YizywP5zY39tp5HVE8niEZOEiCgpQDmmR/+K5xfo+vXQargntrZ6q2k2
         5XPjOxHwstsGmdeyM8OU6VBep/U65UdZpB+pEgOh7Ckw85h4HeZ1720AEE7cuJ8RR7Xe
         WhBpurUVEgoEuVBJo0I+x5IyuBtHdI+9CkmlFAY1kLv7DBBtykpbliex4IzZ6nHnku5W
         gVoLtGKphbLkcLehN2N47R7ZARDI5sxAODLZENy7v/+pasUZzoOg7SluSlmR64t/lvGc
         ZZUwhln1nyaMjGMy77tec+nBgwB4f27vU8+PzB5N7MtIcqPWqQTAqcF9ebtt2I421PVm
         giiQ==
X-Gm-Message-State: AOJu0YwzfymwWp9YSK7ROFv1SnKt5KMyh4hrWEqyNW4oFh5ipe+YcXrE
	QrOyVq+qF0Qwhc9XFfcfocDszEc2b0nqOVDkvDKdGzEocB7o/OubBapKD1jS389c
X-Gm-Gg: AZuq6aItpeR3mHGzW/k/KCaFlTdHXTkIxvo0q/gDGKMHRVBPBK8bs7JptE4YxR++NVV
	2WHTHwaVlNnn3uhb2LZvfkfsvRIFpBLHG2SOU8Oby3ghXLSQmclXBGD47VZBRtObQewIlZHrk0j
	Cyv/BubbZjdt4bcFOeQykv7zNnYOevpdshHo2yO0Rv5D1ZjAUebqZjPmRP++2hGqwig5U34yIrr
	sEBMhV8YR5SL5NuE1wW16TO1DjFbuJQlfQALRE5trAz4TG45mHgnUooL0f5/MSebtrNKblyBzgs
	weHyx+JodH+pV3WHmpkDZuA9KiCoBYBoGjqIEDEd2zssEL2a8VcmP4RvlFZkz6JzKC8FcTzrzFs
	c69+NUFAvmnBWmdatJWpmHrt4Q+OiEFGZv7iCmAVSbWLEPs5w28jyW+Lm3W8CqaIyvmqFvycvdT
	Lw4SEsGH7d2wGqHBYX66yfN54IYwqQN3WlTm5iVx4yoEQ03/6wwcBWqDwuEU1zF2sbExwNHakG
X-Received: by 2002:a05:600c:1e28:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-483a95fe96bmr179774455e9.32.1771941841959;
        Tue, 24 Feb 2026 06:04:01 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:04:01 -0800 (PST)
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
Subject: [PATCH v5 1/5] docs: iio: adxl345: grammar and formatting cleanups
Date: Tue, 24 Feb 2026 14:03:44 +0000
Message-ID: <20260224140351.27288-2-0rayn.dev@gmail.com>
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

Correct several grammatical errors, typos, and pluralization issues
throughout the ADXL345 documentation.

Key changes include:
- Changing 'generic' to 'general-purpose'
- Correcting 'axis' to 'axes' in multiple tables and descriptions
- Improving phrasing in the device attributes section
- Fixing 'latent' to 'latency' in usage examples
- Sorting the existing event attribute table alphabetically for
  better readability and to establish a clean baseline for future
  additions.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index bb19d64f67c3..0e8977345e9d 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -12,16 +12,16 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
 * `ADXL345 <https://www.analog.com/ADXL345>`_
 * `ADXL375 <https://www.analog.com/ADXL375>`_
 
-The ADXL345 is a generic purpose low power, 3-axis accelerometer with selectable
+The ADXL345 is a general-purpose, low-power, 3-axis accelerometer with selectable
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
+X, Y, and Z axis measurements are available.
 
 The table below lists the ADXL345-related device files located in the
 device-specific path: ``/sys/bus/iio/devices/iio:deviceX/events``.
@@ -90,37 +90,37 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | Event handle                                | Description                                 |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis     |
+| in_accel_gesture_doubletap_en               | Enable double tap detection on all axes     |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]                   |
+| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                  |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
+| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
+| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
+| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_en                      | Enable activity detection on X axis         |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
+| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes    |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
+| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes     |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
 +---------------------------------------------+---------------------------------------------+
 | in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
 +---------------------------------------------+---------------------------------------------+
@@ -330,7 +330,7 @@ Configure one or several events:
         ## doubletap, window [us]
         root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_reset_timeout
 
-        ## doubletap, latent [us]
+        ## doubletap, latency [us]
         root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_tap2_min_delay
 
         ## AC coupled activity, enable
-- 
2.47.3

