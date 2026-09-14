Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664F1E32D6;
	Mon, 14 Sep 2026 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347418; cv=none; b=gduUNjc/kqaxuWqjAWCGYAZ+ap0XMVZ+QPfohCdbjB3O4thW7ch+Yqv3tz3JvnAKIun63beEHdz0FOeBZhCPV3VOd1+2zbjPruFIHe9iy2JEjnLID04OgsFGbLmAL+ZMqhgIt7rSoaffEO5NVxiS2ET2v9J2pmLl27SGz/BZrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347418; c=relaxed/simple;
	bh=+MkTzwfqhSJb/70CCTjbOLRTPi5UnSbW+UCf9mStgjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtJfIcvPI3EES6tdyQqvOY/GHciblwFL0A2VwBbyCOopERD/Rp2AnDQcGacemczISbWZ1avYEQ6a/COFZq/baxefInnxHl65S4Ehwbw1lfye7rahWAe3eBE3Ir3DFjEAr1yPNlszTb0twNjU+oX0Pgeq/aeYSMdYevwga887eWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFrRgqhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFrRgqhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01B1F000FF;
	Mon, 14 Sep 2026 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789347417;
	bh=SlxlFkaqeMHSCNUNSGnnPjIslXu3RAAtVEoKqxRIKps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lFrRgqhWaKT5uM1mkwc3lhoZ3FkiK5wzDVJoqsUkSRO9IjY9k7UefKqGInfYqucVT
	 3XXMotK4hFa2vH9hN/+y0B9sDSOe9nafdaTmL0Tt0r7jNrwYPJQadMcyBS5fbZ3EPj
	 V8QYIzjksvWnfsEmho8Wl9+1t2oI0vzy8jDj5qJab0T28FjezcOVmeezwSgnXsKUFQ
	 fNy0gbkc7c5yV11+OTs13WOtqBMBr6zUlUj5mzXvzGmAX6QPxRLNbQ3tcAAgRv3/Gs
	 H/U0oRq1UoD9Ebi3jBANm3eCq6SD7LJ2xKU7wltNQROQO4aBHh/gw8kju9JCxLD02M
	 r4mg2N6+Y+bIQ==
Date: Mon, 14 Sep 2026 01:56:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: adis16201: add ADIS16203 support
Message-ID: <20260914015651.70277ca2@jic23-hlaptop>
In-Reply-To: <20260913085307.13846-5-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
	<20260913085307.13846-5-shehryar.amd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 13:53:05 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> Add ADIS16203 from staging to mainline ADIS16201. ADIS16203 shares same
> SPI protocol and register addresses. Differing parameters are handled by
> adis16201_chip_info structure.
> 
> ADIS16203 specific support includes DIAG_STAT_SELFTEST_FAIL_BIT, which
> is supported only on ADIS16203, and a separate channel array.
> 
> Kconfig is updated accordingly.
> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---
>  drivers/iio/accel/Kconfig     |  6 +++---
>  drivers/iio/accel/adis16201.c | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 4094299e2..f884ec66f 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -7,13 +7,13 @@
>  menu "Accelerometers"
>  
>  config ADIS16201
> -	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
> +	tristate "ADIS16201 Digital Inclinometer and similar"
>  	depends on SPI
>  	select IIO_ADIS_LIB
>  	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
>  	help
> -	  Say Y here to build support for Analog Devices adis16201 dual-axis
> -	  digital inclinometer and accelerometer.
> +	  Say Y here to build support for Analog Devices adis16201 Digital
> +	  Inclinometer and similar
Here is where the names should be.
	  Say Y here to build support for Analog Devices Digital Inclinometers:
	  - ADIS16201
	  - ADIS16203

or something like that.  Key is that a new device being supported is a single
line added with no churn of the surrounding text.

>  
>  	  To compile this driver as a module, say M here: the module will
>  	  be called adis16201.
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index e0bf7df50..8e8e612fd 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + * ADIS16201 Digital Inclinometer and similar
>   *
>   * Copyright 2010 Analog Devices Inc.
>   */
> @@ -63,6 +63,7 @@
>  #define ADIS16201_DIAG_STAT_REG				0x3C
>  #define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
>  #define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
> +#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT		5	/* ADIS16203 only */
>  #define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
>  #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
>  /* Power supply above 3.625 V */
> @@ -232,6 +233,15 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
>  
> +static const struct iio_chan_spec adis16203_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(7),

As per the sashiko feedback on previous, this needs reordering so they are
in scan index ordering.

> +};
Otherwise this is coming together nicely.

Thanks

Jonathan

