Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358E23EAB8;
	Tue, 27 Jan 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538775; cv=none; b=RvcB3mzuf6w4lHBIWMEYuiVaVtMXrjApVXqSjAt0p2FZKmtpkp6xxBPoD9HGdDadPejfuJ7Fs4L5qcLqvLA0pEHNX5MMPyCNq9Guya+uLhpk2oaXNVcrcIUXtXe3dK6E9BSjpk/14mElZzFCiYbnmQ/ooW4fW90Iny6iZjWlcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538775; c=relaxed/simple;
	bh=0GjKgsBfe/7at6w6QEmAwXPwLGTILTm0SaVUxhGMgX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YarsEHsr70XqEY3MfxbDMdngm7xBaWvQT6f3H2P2lxCNaxptCsgWB3wZ4p4GbhZAPf6g9bcjaElqpkKm7psi+Pq37oFFXC+20W38idHumY43+O9zLLeY4/ASWYhfD6Du3nACnCwQ7YScDCTd2x49IcdA4k71jH9dgOp8OVhrMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ymH4b7yV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ymH4b7yV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FifP6Ih6cJBFoWQfgXG1pllp8GkSYlM1pQ5MGEtgoFs=; b=ymH4b7yV/fqg6RjMqINGq1+PzF
	4PxhOErnK1KTSxwF8u7q0q9nS9Ta6XQGUC8jEr8y5/WR+q+OWv9yj7qdM8ww58a4sijTPOVmwUqWr
	lg8noxMTsBMYunecFXUWIfYy0UXBhTbQKDxcXtBBVDmDJRzrUBGqhoNMxLTGIWkcXZ/PplhFuwD5+
	dtdDq1t9U23+4PlXuzLXB+vCNyqcGePPqdwXF/4Pp3Ci6xJfoGHZfD17ShutmDP5Hx3FFwXC44yaf
	NpJRvEMLOTXdHhLFIZViy4dLLOKN+XBXzT+EaKuhyI13k0iOXdqBQboETRwkgzfcx1Ar/YDdxdStY
	rekV/XqQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknrq-0000000EpAq-0lcU;
	Tue, 27 Jan 2026 18:32:46 +0000
Message-ID: <aabb78a6-aea2-4080-89fe-8e00c593b607@infradead.org>
Date: Tue, 27 Jan 2026 10:32:44 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: adxl345: Fix typos, units, and grammatical
 errors
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org
Cc: me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127173543.72423-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260127173543.72423-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/26 9:34 AM, Taha Ed-Dafili wrote:
> Clean up the ADXL345 documentation to improve technical accuracy
> and readability:
> - Fix "latent" to "latency" in double tap descriptions.
> - Correct the threshold unit from "g/LSB" to "mg/LSB"
>   to match the datasheet.
> - Standardize "axis" to "axes" for plural references.
> - Change "generic purpose" to "general purpose".
> - Fix minor subject-verb agreement and punctuation errors.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/iio/adxl345.rst | 104 +++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> index bb19d64f67c3..020b512cdb74 100644
> --- a/Documentation/iio/adxl345.rst
> +++ b/Documentation/iio/adxl345.rst
> @@ -12,16 +12,16 @@ This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
>  * `ADXL345 <https://www.analog.com/ADXL345>`_
>  * `ADXL375 <https://www.analog.com/ADXL375>`_
>  
> -The ADXL345 is a generic purpose low power, 3-axis accelerometer with selectable
> +The ADXL345 is a general purpose low power, 3-axis accelerometer with selectable
>  measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
>  
>  2. Device Attributes
>  ====================
>  
> -Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
> +Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
>  where X is the IIO index of the device. Under these folders reside a set of
>  device files, depending on the characteristics and features of the hardware
> -device in questions. These files are consistently generalized and documented in
> +device in question. These files are consistently generalized and documented in
>  the IIO ABI documentation.
>  
>  The following table shows the ADXL345 related device files, found in the
> @@ -42,7 +42,7 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>  +-------------------------------------------+----------------------------------------------------------+
>  | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
>  +-------------------------------------------+----------------------------------------------------------+
> -| in_accel_y_calibbias                      | y-axis acceleration offset correction                    |
> +| in_accel_y_calibbias                      | Y-axis acceleration offset correction                    |
>  +-------------------------------------------+----------------------------------------------------------+
>  | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
>  +-------------------------------------------+----------------------------------------------------------+
> @@ -68,7 +68,7 @@ present, simply assume its value is 0.
>  +-------------------------------------+---------------------------+
>  | Channel type                        | Measurement unit          |
>  +-------------------------------------+---------------------------+
> -| Acceleration on X, Y, and Z axis    | Meters per second squared |
> +| Acceleration on X, Y, and Z axes    | Meters per second squared |
>  +-------------------------------------+---------------------------+
>  
>  Sensor Events
> @@ -78,8 +78,8 @@ Specific IIO events are triggered by their corresponding interrupts. The sensor
>  driver supports either none or a single active interrupt (INT) line, selectable
>  from the two available options: INT1 or INT2. The active INT line should be
>  specified in the device tree. If no INT line is configured, the sensor defaults
> -to FIFO bypass mode, where event detection is disabled and only X, Y, and Z axis
> -measurements are available.
> +to FIFO bypass mode, where event detection is disabled and only individual
> +X, Y, and Z axes measurements are available.
>  
>  The table below lists the ADXL345-related device files located in the
>  device-specific path: ``/sys/bus/iio/devices/iio:deviceX/events``.
> @@ -87,45 +87,45 @@ Note that activity and inactivity detection are DC-coupled by default;
>  therefore, only the AC-coupled activity and inactivity events are explicitly
>  listed.
>  
> -+---------------------------------------------+---------------------------------------------+
> -| Event handle                                | Description                                 |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis     |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]                   |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_rising_en                      | Enable activity detection on X axis         |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
> -+---------------------------------------------+---------------------------------------------+
> -| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
> -+---------------------------------------------+---------------------------------------------+
> ++---------------------------------------------+------------------------------------------------+
> +| Event handle                                | Description                                    |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_en               | Enable double tap detection on all axes        |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latency in [us]                     |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                    |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5 mg/LSB      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_falling_period                 | Inactivity time in seconds                     |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5 mg/LSB      |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis           |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5 mg/LSB |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5 mg/LSB   |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_rising_en                      | Enable activity detection on X axis            |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_mag_rising_value                   | Activity threshold value in 62.5 mg/LSB        |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axes        |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axes       |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis          |
> ++---------------------------------------------+------------------------------------------------+
> +| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis          |
> ++---------------------------------------------+------------------------------------------------+
>  
>  Please refer to the sensor's datasheet for a detailed description of this
>  functionality.
> @@ -133,14 +133,14 @@ functionality.
>  Manually setting the **ODR** will cause the driver to estimate default values
>  for inactivity detection timing, where higher ODR values correspond to longer
>  default wait times, and lower ODR values to shorter ones. If these defaults do
> -not meet your application’s needs, you can explicitly configure the inactivity
> +not meet your application's needs, you can explicitly configure the inactivity
>  wait time. Setting this value to 0 will revert to the default behavior.
>  
>  When changing the **g range** configuration, the driver attempts to estimate
>  appropriate activity and inactivity thresholds by scaling the default values
>  based on the ratio of the previous range to the new one. The resulting threshold
>  will never be zero and will always fall between 1 and 255, corresponding to up
> -to 62.5 g/LSB as specified in the datasheet. However, you can override these
> +to 62.5 mg/LSB as specified in the datasheet. However, you can override these
>  estimated thresholds by setting explicit values.
>  
>  When **activity** and **inactivity** events are enabled, the driver
> @@ -148,7 +148,7 @@ automatically manages hysteresis behavior by setting the **link** and
>  **auto-sleep** bits. The link bit connects the activity and inactivity
>  functions, so that one follows the other. The auto-sleep function puts the
>  sensor into sleep mode when inactivity is detected, reducing power consumption
> -to the sub-12.5 Hz rate.
> +to the sub-12.5 Hz rate.
>  
>  The inactivity time is configurable between 1 and 255 seconds. In addition to
>  inactivity detection, the sensor also supports free-fall detection, which, from
> @@ -312,10 +312,10 @@ Configure one or several events:
>  
>          root:/sys/bus/iio/devices/iio:device0> echo 24 > ./buffer0/length
>  
> -        ## AC coupled activity, threshold [62.5/LSB]
> +        ## AC coupled activity, threshold [62.5 mg/LSB]
>          root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_mag_adaptive_rising_value
>  
> -        ## AC coupled inactivity, threshold, [62.5/LSB]
> +        ## AC coupled inactivity, threshold, [62.5 mg/LSB]
>          root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_mag_adaptive_falling_value
>  
>          ## AC coupled inactivity, time [s]
> @@ -330,7 +330,7 @@ Configure one or several events:
>          ## doubletap, window [us]
>          root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_reset_timeout
>  
> -        ## doubletap, latent [us]
> +        ## doubletap, latency [us]
>          root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_tap2_min_delay
>  
>          ## AC coupled activity, enable

-- 
~Randy
