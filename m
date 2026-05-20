Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A94028F3
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302980; cv=none; b=E4LJvAdAyAcqPKH1QOnBBFXGMRciYWfq7ga28WaeWD7pSZD1LGFG18HNZcWkfwp9oo8qjQ42jqxAvp+/Ux30Hgu5oIurOER1OWlZFhAlueQIIs9BXO46U51j4Y0QI2lDAfo2IQSttQ4xcs/5G12vyUorjPVdg+qXjU2YlvLwEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302980; c=relaxed/simple;
	bh=J0LMFlWOctUVxFxjiVf/dseJRNuCaRqRgpJ/4PgLBCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sq84lXZ30T4PavF26n2233fktOaT17QulGOE4dU4H3CEOqw04ete1SgvpGtfrzswINDz4g4STNF4E+F9NjRZETct2/sFV3MjqFaxDqve9LWA1jkiPZSyBD1X/0yPvQtRgFFgtACECaBa9WKTg3rnZx6+49BBN43X05J3UFMmEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpp5eqiB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpp5eqiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951681F00893;
	Wed, 20 May 2026 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302977;
	bh=fpObeaUyH/d4i/7CkcUgGYkykLuluZoV1XzUwLAkzrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fpp5eqiBm4GNrmi8SzcJEYN3ZQqFqDev7KIZ+g4nm+eoG5d1MBSj8hbFUkTmibpiL
	 NhkGwzRKGrl8/oAmwCEdDVXVCFB29YIeGE+AWjZkImB2Frlhx+LttpG9FEtLIukLEH
	 g0i1fAWsfCQeF8eJHHyBiw6X6UBwxB2X8lqmNNJrG1eF6NhgqYkzIXIsK+KAv/NoX5
	 04Vt/Huo3b7JTIVZ9zHOdQqJ9NPgylUQXSRtfSXxxaWdQIgA+XQgD+XoXx6D16/eP6
	 jN0d+hNYruCb5YI9/2qN6pJig5lDGYnBs641JghCsMAxtv3rqcmpJTGaE1jkjDwU62
	 TXnixhJ04mmQQ==
Date: Wed, 20 May 2026 19:49:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <20260520194931.031830eb@jic23-huawei>
In-Reply-To: <deb5c310f2b9780329f6210b9c2af498b8e1c42a.1779181370.git.azpijr@gmail.com>
References: <cover.1779181370.git.azpijr@gmail.com>
	<deb5c310f2b9780329f6210b9c2af498b8e1c42a.1779181370.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 11:23:40 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add IIO driver for Broadcom APDS9999 ambient light sensor.
> 
> The APDS9999 is a digital proximity and RGB sensor with ALS
> capability. The driver implements the ALS/Lux functionality
> using the green channel, which uses optical coating technology
> to approximate the human eye spectral response.
> 
> Raw IIO_INTENSITY channels are exposed for red, green, blue,
> and IR so userspace can compute its own weighted lux.
> Proximity (PS) and calibrated RGB color sensing are not yet
> implemented.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Hi Jose,

A few minor comments inline

Looking good.

Jonathan
> ---
>  MAINTAINERS                  |   1 +
>  drivers/iio/light/Kconfig    |  10 ++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/apds9999.c | 337 +++++++++++++++++++++++++++++++++++
>  4 files changed, 349 insertions(+)
>  create mode 100644 drivers/iio/light/apds9999.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d8d4e2eab6e..d36ab614aa53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5005,6 +5005,7 @@ M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> +F:	drivers/iio/light/apds9999.c
> 
>  BROADCOM ASP 2.0 ETHERNET DRIVER
>  M:	Justin Chen <justin.chen@broadcom.com>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index eff33e456c70..c7256ffb972d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -119,6 +119,16 @@ config APDS9960
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apds9960
> 
> +config APDS9999
> +	tristate "APDS9999 ambient light sensor"
For such a capable device ambient light seems insufficient.
I'd go with ALS, RGB and proximity sensor

> +	depends on I2C
> +	help
> +	  Say Y here if you want to build support for the Broadcom APDS9999
> +	  ambient light sensor (ALS/Lux).

Similar here - but provide even more detail.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apds9999.
> +
>  config AS73211
>  	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
>  	depends on I2C

> diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> new file mode 100644
> index 000000000000..938e43b39ad5
> --- /dev/null
> +++ b/drivers/iio/light/apds9999.c
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for Broadcom APDS9999 Lux Light Sensor
> + *
> + * Copyright (C) 2026
> + * Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> + *
> + * TODO: proximity and color sensor

color part of this seems to now be supported.

> + */

> +	struct i2c_client *client;
> +	/* lock: protects als_gain_idx, als_res, als_rate */

Protect against what?  Can we be more specific on whether
something must be atomic, or not change during some operation.

Other than during init (where arguably the lock isn't needed)
only als_res is accessed with the lock held.

> +	struct mutex lock;
> +	int als_gain_idx;
> +	int als_res;
> +	int als_rate;
> +};

> +static int apds9999_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9999_data *data = iio_priv(indio_dev);
> +	int gain, itime_us;
> +	u64 scale_nano;
> +	u32 counts;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = apds9999_read_channel(data, chan->address, &counts);
> +		if (ret)
> +			return ret;
> +		*val = (int)counts;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
> +		 *
> +		 * The constant 54 is derived from the datasheet table:
> +		 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
> +		 *   -> C = 0.180 * 3 * 100 = 54
> +		 *
> +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> +		 */
> +		gain = apds9999_gains[data->als_gain_idx];
> +		itime_us = apds9999_itimes_us[data->als_res];
> +
> +		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
> +		scale_nano = div_u64(54000000000000ULL, (u32)(gain * itime_us));

That's a lot of zeros. Is it effectively NANO * MICRO / MILLI 

(the second part being conversion from msecs to microsecs as used on the bottom)
If so use those constants to express it rather than the many zeros.


> +		*val = (int)(scale_nano / NSEC_PER_SEC);
> +		*val2 = (int)(scale_nano % NSEC_PER_SEC);
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = apds9999_itimes_us[data->als_res];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
