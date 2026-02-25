Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23463176F8
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055722; cv=none; b=Y3w8GwHhf2lnVBVH7s3zskKLr7T5psiGl4imzoT1xlGvPgQF4lQfIKu9CDsC9qv+KRwPQymegqhRUuBv3hel5toEZMPu81gmshiET3rm7WAf4I8TrppHKK0XaX7Dxeq5nfMc4XZChLTw6b+MU56UfEPupdjDFMcjAZzrVgnRKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055722; c=relaxed/simple;
	bh=rn1yNr3e5Ca6y6gw7QPpafjsRXHUR12oCNJvg7/XDhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oalivalVRLm3IRiP0VTnjgPFqKYM8Cr8rhJQLR0/KtggFkfsA2/4+28jz5CPlLpgDjg6R5yNQkU2n2TTcYtZ9VtaeMo6DU3NgQ9zyndh73T39XxNXjkrzRFOFjBrGoy4hKkRwuEzr137qLMuXKUS4ajnQ4pbBbbmb4fVWebcpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FuLY9zPl; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FuLY9zPl"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-67997ce9e1cso172738eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772055719; x=1772660519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHExTqcKSzKCsCsjB7WNC+kpLuvRbAoviw1XYEhwpoU=;
        b=FuLY9zPlIVOTIwHdasTA7Gew+Ad2AMT7lYV5F78BH38roxDzv64RF5o+UfRKAO7N55
         cUHGgxkJN0clyoZtxgF7EqNyltdjNtn2TnFntAJ5tjbskHisBcmie0WVLIzTVcOwnw70
         y1KsL2wlaWjnngUboYeHWb3Bl0UddRoLR2gwHtC/yZHZn+1d0g7a5to2PBvjgKGkEBeA
         B8c70hp0vbu/f5qqbyGbJp7FC/ni9Bh2/NWhI/2KGZTEbXp0NcD6F98YoOQfeprJnL5t
         jUR8LrRMO3xsI1COOy+bVVwB97HnGhjZgTM1vX7tc06rKS8ziYhN6S9q0hYFUI5CMB2e
         yy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055719; x=1772660519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHExTqcKSzKCsCsjB7WNC+kpLuvRbAoviw1XYEhwpoU=;
        b=mtl1gjUbbykKiuYQJjbDfA9xiRfRfqS7IoNXTYJsH6MqULYQxD+lL+CQydgWqvNq1T
         Ur+V14zKeAkJopdUFAvBlxBjo236Tia78UTfP3RO2xWmz04MQKxt34/njMVZCFs7dzPs
         8zfD+LQv276DSOtT/kF1iTPJvk6maPpdCddLFmCo+1QymsGJvU0yeTR98XEG1k6lg+oT
         /WVNKNo78TJdHrX99rk154bZdQYkx1kq0WBGY2napMNU8+sEeW7oUTuwe7U6pKU0MBTn
         Ucr6KcbVKR7ipxAdAh8JvCw5gTzEp+hacHbp+bCwGJHX/aSxfBWvywJigHE/KiHmbKdt
         rHoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8UCTU7w2ByZwt+lrsGArqBuzPxePuHKnwdANQ2fD7uVR12H1ADdJYYhnrUEdhtko60kqMwx17Ewg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HPBHJjaxwnnG+yTl0HmL+kA2pcOLY/fG5BNJ1jt+wQ/TtaUY
	QVCuZQeCQ6v3cHPWYnNIu8wb5DaD2i574kB+8iYVXEqc5hIhOLQ9ofHz3BRzFQBHwvw=
X-Gm-Gg: ATEYQzxbqDdQPEfn86mo2+Sf280bFZersJ8Md2chaW9pcMkEo3UFVjqlfahnTLH0F2a
	fP2xTHTrbwHN5VLcytn4mlfjGL3Cdel8xrUqltd0YJe+Ww9G+zPEqvFHBfpusoHh7XyLRGLVI5o
	DshWqpxnGNe4My5JQk6Xs7FPYILg0Bw5bjQtRlZnE5yLTtc/rFCKP5WNNSTYsA3vy/DSN3pA/oA
	NF+76BN3QZ+KUlmvPsrzg8wrHyTRnqFTfHvT520khev+ItH/TUL9yQSb3GDWZb06lmbO/t6B99V
	q5Av3zGPRTVYgCgs3UYIrsjXE7zrZ/LrqJKqTvPgsd8cBOs64HewbSTU5NokytIu0gJ4NAB1F3D
	ojIiQhzdVSjeiBpYGAyyk0k1vUGaL1OTRTa8C3qAhNSKYnVmnKWLQh0eyy3h/WrFTEAYoPorQPS
	q5+4PvBBx7ScQpwThsBVLmHbBodeAa7mndFUeAsWNTd6mzqohC2p7Bu1tqJI2dhscv2nxZ+Hg=
X-Received: by 2002:a05:6820:488a:b0:672:ef44:4f34 with SMTP id 006d021491bc7-679ef7e2a57mr780581eaf.5.1772055718597;
        Wed, 25 Feb 2026 13:41:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f? ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d85297sm175943eaf.11.2026.02.25.13.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:41:58 -0800 (PST)
Message-ID: <5531f3ba-dadd-4116-b1f9-0574ab110857@baylibre.com>
Date: Wed, 25 Feb 2026 15:41:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101814.2368431-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260225101814.2368431-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 4:18 AM, Francesco Lavra wrote:
> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/iio/index.rst                   |   1 +
>  Documentation/iio/st_lsm6dsx.rst              |  44 ++++
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 235 ++++++++++++++++++
>  7 files changed, 368 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/iio/st_lsm6dsx.rst
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

It makes things easier to review if we put the documentation changes in a
separate patch from the code changes.

> 
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index ba3e609c6a13..4e2ebe64f97f 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -39,3 +39,4 @@ Industrial I/O Kernel Drivers
>     bno055
>     ep93xx_adc
>     opt4060
> +   st_lsm6dsx
> diff --git a/Documentation/iio/st_lsm6dsx.rst b/Documentation/iio/st_lsm6dsx.rst
> new file mode 100644
> index 000000000000..7f11a0b7e5c0
> --- /dev/null
> +++ b/Documentation/iio/st_lsm6dsx.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=================
> +ST LSM6DSX driver
> +=================
> +
> +Device driver for STMicroelectronics LSM6DSx, LSM9DS1, ASM330, and ISM330 series
> +of 6-axis inertial measurement units. The core module is called ``st_lsm6dsx``,
> +and the transport-specific modules are called ``st_lsm6dsx_i2c``,
> +``st_lsm6dsx_spi``, and ``st_lsm6dsx_i3c``.
> +
> +IIO devices
> +===========
> +
> +This driver instantiates multiple IIO devices:
> +
> +* accelerometer (IIO_ACCEL channel)
> +* gyroscope (IIO_ANGL_VEL channel)
> +* (optionally) magnetometer (IIO_MAGN channel), if the device has a secondary
> +  I2C interface connected to a slave sensor device (sensor hub functionality)
> +* (optionally) sensor fusion (IIO_CUSTOM channel), which combines acceleration
> +  and angular velocity data
> +
> +Sensor Fusion
> +-------------
> +
> +Some chips supported by this driver implement an internal algorithm that takes
> +input data from the accelerometer and gyroscope, and calculates the device
> +orientation in 3D space, which is then made available in the hardware FIFO.
> +Orientation is expressed in the form of a 4-dimensional quaternion vector, whose
> +components are typically represented in an array as ``[x, y, z, w]``.
> +The sensor device outputs the ``[x, y, z]`` components of the quaternion,
> +expressed as half-precision (16-bit) floating-point numbers.
> +
> +The ``z`` component is not output by the device, but its value can be derived

Should be ``w``.

> +from the rest of the data, due to the following constraints:
> +
> +* the quaternion vector is normalized, i.e. :math:`x^2 + y^2 + z^2 + w^2 = 1`
> +* the rotation angle :math:`\theta` remains within
> +  :math:`[-180^\circ, 180^\circ]`, i.e. the ``w`` component is non-negative:
> +  :math:`w = \cos(\theta/2) \geq 0`
> +
> +These constraints allow the ``w`` value to be calculated from the other
> +components: :math:`w = \sqrt{1 - (x^2 + y^2 + z^2)}`.


...

> +
>  /**
>   * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
>   * @i2c_addr: I2c slave address list.
> @@ -388,6 +398,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
>  	struct st_lsm6dsx_event_settings event_settings;
> +	struct st_lsm6dsx_sf_settings sf_settings;

Can we spell out "fusion"? I don't think this is a common abbreviation.

>  };
>  

...

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..7033aaeba13e
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*

Copyright?

> + * STMicroelectronics st_lsm6dsx IMU sensor fusion
> + */
> +

...

> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
> +static struct attribute *st_lsm6dsx_sf_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};

Can we not use the .read_avail callback for this instead of a manual
attribute?

> +
> +static const struct attribute_group st_lsm6dsx_sf_attribute_group = {
> +	.attrs = st_lsm6dsx_sf_attributes,
> +};
> +
> +static const struct iio_info st_lsm6dsx_sf_info = {
> +	.attrs = &st_lsm6dsx_sf_attribute_group,
> +	.read_raw = st_lsm6dsx_sf_read_raw,
> +	.write_raw = st_lsm6dsx_sf_write_raw,
> +	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
> +};
