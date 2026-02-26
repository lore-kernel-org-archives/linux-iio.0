Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DC3E9F9E
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118680; cv=none; b=l5CwTiLREfybg+W/8iUeocuRGRLuUx8tg2IwmujAcJm/pPzl79CnsCFNQg/dMknQuoWRyXwfnvukc3f/Ym9OZwudIz2e6mUfm5YOM5ftiANIt9Wf/jcCqTFOWnCQhL+otLUpPAyqZZKv3Thzm9sUQmglHGvamC+eXViOHFiZeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118680; c=relaxed/simple;
	bh=pQavWAYPpsey0yQqgVWWpFe8QdmDgqTBdo0zNEICEsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzUQuV+lSkfrlfWNsFybjbOQ1l10/oPq56wWN/PnczdnqsB6WFp+f2Xsmemn6j6j+EulI95mOOrzJajmCOaQjKDVIKN9DJ/tMzCQqWTnn7oBQjv4ZR+S10jDYtysUAZ1Ksk2Lsh0XtweM7wmIyIFDZSx8BYkdJOzVSccHRQUgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT5nKnzS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT5nKnzS"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb513e860cso98484785a.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118678; x=1772723478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBPp/39SgW1yz4SiSW0HB6Or3cMOFZIagn+ooTwLYE=;
        b=OT5nKnzSHgFw5Vli/3n0Ge6EvSATz9ajsi2jtffnELYnfmO1H5zmOBqBOiWQDeaTC9
         E6TKy7cpXIKc9unfX06umjnAo3UYGjtr4UASPBfzWTLttwayUFMheaC33pAowHXt5k2q
         MmnqSKTqtpac6/0BW3hs3QLTKWOJXarnzbMyGNzA8Pxuk8MYZIljtR7fV176M2tGw4PH
         aKRwfhTGwibylmdTc4BCrHxnfFziM6pEzxydI4qr7cpy2IUYWkEWTPnVHfAOJHdzK7kc
         06dG2ICa46p0I9+xbxV0Jd0mOE3a331UBb/eVKER/bBKb8hVFAxIugPZ9/pc3uM8JhlN
         kFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118678; x=1772723478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYBPp/39SgW1yz4SiSW0HB6Or3cMOFZIagn+ooTwLYE=;
        b=kHB6AYi/962MVOm9+pLrTvFFPczJ2ZXWhoUXPmKh3+0PMdeJCDfIqrBfDjz+ModiRq
         WBT0h7KVYHLPJCtrFen4LYDSln6kXnEHaajcobSrznJKVOrAJxo8u9dPLeFd0y9P5TMf
         c2mBg30B7MYvXNS3CrmCsKSMRZ1i4BbIj4y735VDtZFuOzzyrELJRiwCCoko7KzIAoLn
         BLzqAsaXXE7spjGyBfdWKVm7Un4/UpxxJd4SU9fd9r0ZweuGABOHvpJpZLH3xQM4zYou
         pJZfZyi8AXlbFI2XIxRDpCSwv8Qo+c8hubOCRW4juoKoXAYbS46IbNeAvGrtLW0bXD2w
         1phQ==
X-Gm-Message-State: AOJu0YzMmredGbgsiQUnIGpCLAABywzx4dQOEhSZ1+xM9tSiq9wRoyYt
	4HsfD6WK2u2Ewmq+ywUkYcyDGd/hF6rM+m7oPXhKKCZNGwnbmfPKLaPXNahp1fSZ
X-Gm-Gg: ATEYQzzkPtDpRz2x3hozsxZejfHVe6+n4KiqBHzn+Bhl6ia+1OK3b8Z8Yr0JNb96AG+
	+csXobCoypCMrfUJ8aVtSJcE31roWl/g09QXdxd6XPOSLI3a97PTeJYpaV2A/NvoUf8EngcKh1S
	79Q9+AyUvpz2Xkxt4dYbeM1B+knZMWf0fOfqRQupXYAaZeXI5Yad5XufzcmIULGo3uy2KZ/q31v
	RX7lN4MbASqM1sr/NuVMwWvPR/HlEjsI4FbJfCkYW1is8yup8oXe7A8dpWzFVa9k82yW2cexQu/
	cA1J0KAYC7zR7ww9Ggd0lOvAc/7VxhxOZP1s1OyGuKrpzHqpwjyJdyMsBzuwOxc6WlDYnKC6Ayl
	1YfVS3uBf1lD5bpEtzJAjFPwujmu6GFJ8634gHqOK+xucROTfSgW0p6YvQVhNJWHKUnvQhjZaEX
	hOgukj81rXpLsjhTmQB0FHrfmQP+1YalER2PrFtLTAD9saKLXeXxdCTK6h/F3vOQ==
X-Received: by 2002:ac8:5a54:0:b0:505:e448:1b0d with SMTP id d75a77b69052e-5070bb81df0mr247065861cf.10.1772118676885;
        Thu, 26 Feb 2026 07:11:16 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:16 -0800 (PST)
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
Subject: [PATCH v6 1/5] docs: iio: adxl345: grammar and formatting cleanups
Date: Thu, 26 Feb 2026 15:11:02 +0000
Message-ID: <20260226151108.22383-2-0rayn.dev@gmail.com>
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

