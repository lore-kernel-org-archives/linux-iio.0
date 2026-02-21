Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED71BBBE5
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683191; cv=none; b=WVnh6gw7PUu6DDDbhL/EDCxx8IIIP+Fqo2d8tCRRZ2dWJjjMLJuEQaVZZ7E343wXIh/34F/RCfWcDwLwQAUf9OSPe5Np1B7CYA4Yvj9U2p8i6xL1ZTlNZZEvqcWi6FpdUHceXL/RPcjj93Kn8yM5465/5fyQEJfObDiP2JShFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683191; c=relaxed/simple;
	bh=jygn9hfhuwiAljKBRe7Yu0fCo7DdMqIwgB/WQt9+uSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdyXa9ypnod8lYPMyLNvn1Y26ZR1ppn4oE/03M1t2hs/Iw1uTvhqdavBjQ+QAjHzBkiR/A/T/5zYsJ6DGMcQEB/tH8CNCJsUGVUUdxY1gZ2cRRZ+e7wWi3AxDJglcAEvkcww/fw54aMUi+hC31lV1pWoqyw3hRXFfyLi8M8672o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a68gP2WT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a68gP2WT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso25189395e9.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771683188; x=1772287988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Det23t3gXSrsxwybIdE4hiHLe2ZCpMnMdOVYGU14wcw=;
        b=a68gP2WTetzwnxFbBtS56jjAGl4OvZjWSA1uUBvUMWBv9+0vqgKNdI0UA8VxWUyE/9
         vcbfx0FY1GZrxe48Kfd4AH3IlJkWKAhmwYv5CcNlj3IMfNlsB54DpD3/PLPt2NUgN7PW
         Tl0y6va77wB0b2mRbSJVkwQw46sO6MCiHbw5gAYTng/GI78XJvjGHJNNdd+6AYd3KzCe
         ksX5oPg5jGZi9D49C0FFQ+UjkkzD0v7ArtiuqkkWooa1vkrxittLVMF8NEuAcloDBRzS
         ktTv8HCW4Jm5CPc3ndz3D7HeOwl5C/LWhjWJZJZGm7iFoxQfdXZBzSzPlm4LIs9usWG1
         NrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771683188; x=1772287988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Det23t3gXSrsxwybIdE4hiHLe2ZCpMnMdOVYGU14wcw=;
        b=KwqLr5e5Rqd5SEnqTq3Y+NgDnH1Vj7d36hKglTdW7csY8qolXXwSFB7N+un/iudzLC
         oTDL+ONYyoYUiakRAM09qcJnj9NTn1b7l/jN4w46CiS3HDL4jA4mdRJJxn82Rv7k2ZnO
         XyRPEUn1QEQLCHprVLtPLXvQhM/gmOgpsOMg+lU/D4rCZR6ThTgrQyDX97vO7vXw2LQI
         bXSZFXwZNzkmtDO/i1TNjSYeNlqfOICZIZaWZGtOboB7hfPsdn74SBSI5uUaUU10Gfbj
         2MHyo5nCZJITU9/krTLfrBMQmjkysRoUfBmupmXmkyZfakDqaijS/D+B5m+ti7K9p/o8
         ENgA==
X-Gm-Message-State: AOJu0Yz6AJbiqXc/8FO9FbDiE7ZkhcZgX16NVwdTkNjZYDooGKs5JAyS
	5NI4zzI1qlu2kIXcr7TSMDfKAjirkqBvV8JgdEtg+r/NGYDywpzMHA+Sdr84aOLj
X-Gm-Gg: AZuq6aL83KDcIJJlnyFUgTwl5QCWd5FwReLJYhdFMATs4xM+DbYyCy4goeZVQKiAjPU
	z2bzjQG9o9eYaVQHoyi9X01fOi4sqHvrVRvEyDa+PZ7GFqEzN//HyAesGKvpHHhJVJXsCP9ZpW7
	zejZgPgYHUAUcoazyBecCcReZopGAyZ8jdfc4ivrabg7/lsADi4GzDp65wwA6VsKkIWjvAMD2SN
	YVE6Du5A+KXWaI5ARFwDQCzxpgFZ4xhfh0sows54sLTJc1XeUWnREfVFWGz4l/ZLweUKl6YhXL5
	FV+pZvJP+K3YH1LV8Igb99P3qmEqDAZOx8FtXU0/IuRbVAcpqCoMaRlh3sVS9qx1SiuCdba2FWF
	HcoRyVDnf39MpydT48QXtmJNwXKCTOc8c17MUirGzl88Cr5yjiRdwjGCekHZi3EJ3/jOAqpI2mW
	YOZEvxlC5gGi9ErjKJwaILqcSBfPhuMRqpEbinovYa+YLfq0nSSOp53TM1M/Y/+g==
X-Received: by 2002:a05:600c:820e:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483a95eb591mr49289755e9.2.1771683187714;
        Sat, 21 Feb 2026 06:13:07 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e01c27sm50169825e9.9.2026.02.21.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:13:06 -0800 (PST)
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
Subject: [PATCH v4 1/4] docs: iio: adxl345: fix typos and grammar
Date: Sat, 21 Feb 2026 14:12:44 +0000
Message-ID: <20260221141251.34855-2-0rayn.dev@gmail.com>
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

Correct several grammatical errors, typos, and pluralization issues
throughout the ADXL345 documentation. Key changes include:
- Changing 'generic' to 'general-purpose'
- Correcting 'axis' to 'axes' in multiple tables and descriptions
- Improving phrasing in the device attributes section
- Fixing 'latent' to 'latency' in usage examples

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 Documentation/iio/adxl345.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index bb19d64f67c3..3ca6a78feb5b 100644
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
@@ -90,11 +90,11 @@ listed.
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
@@ -118,9 +118,9 @@ listed.
 +---------------------------------------------+---------------------------------------------+
 | in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
+| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes     |
 +---------------------------------------------+---------------------------------------------+
-| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
+| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes    |
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

