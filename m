Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C51A317D;
	Sun, 17 May 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026772; cv=none; b=OpfOS5LtE62SHQSwuxkq3iWzyXLKVgjn19w+2gs/bOuFliBdT5j1f17a/so15GCDieJyuDGxt1SptPd74NoGQMaJcq/b5E99XSy2BugkGNNDKJnFZCQJRFbIPAschWyRbfN6T466KP4l4jtIhZOcMTYMQyVyD4ZTW3IJKpPJeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026772; c=relaxed/simple;
	bh=FIiY2oPaiBzktkc4Vzqp8+JoSCv/G20YsbKJJZKYKSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbBrwmJSbXuNpO8j7dv7ImDHtz9c0oZFZgxeZreRiAAAdOY/B6LPTVH5U0pKnfjPFfa05ekeBnTyyPwzsrL3YCQUlBJA3qtDxZJ+KqK5Kl4Mm6e+tFLQtYawXsfD+D/CJq9p8h2ljeGM2m8Ypx9yQ3QBYPyKOv2O/tODN34QkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJf13g3k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJf13g3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E1C2BCB8;
	Sun, 17 May 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779026771;
	bh=FIiY2oPaiBzktkc4Vzqp8+JoSCv/G20YsbKJJZKYKSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OJf13g3kilIuF4SitePqmLNhEIsZoAt6LUTZpHSh4Y0BFJMq2DKfDCr9muu6KAEzj
	 +jTAab7N7bB91RoJIIpyONQZ7pRiRxjbHVjhnedPZ9R4CaOdKnjcFB4VypAMIYhMkH
	 MKnix6qi5Z8IbuQE+5QeFkkb3ec7hzcPM5EP+EV0GAfqGqoBCq8GQ8HZL2pSSPrA3S
	 AxGxxnKip8T2WOYxVNic7MMuIaW5uIqPw+Jwo4iIE2PfyhWlarywvwrjgiyX2Wk+SU
	 FmV6o5Mb1lMt/NTCHP0KWbybdkPPjM7vxo8BCpdGWtHJ0PNBqcdWlArAbUs9zaems9
	 OHECNScnGTfPQ==
Date: Sun, 17 May 2026 15:05:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v13 08/12] iio: frequency: adf41513: driver
 implementation
Message-ID: <20260517150559.5209154c@jic23-huawei>
In-Reply-To: <20260517-adf41513-iio-driver-v13-8-bb6e134a360f@analog.com>
References: <20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com>
	<20260517-adf41513-iio-driver-v13-8-bb6e134a360f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 17 May 2026 10:14:03 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
>=20
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes;
> - High-resolution frequency calculations using microhertz (=C2=B5Hz) prec=
ision
>   to handle sub-Hz resolution across multi-GHz frequency ranges;
> - IIO debugfs interface for direct register access;
> - FW property parsing from devicetree including charge pump settings and
>   reference path configuration;
> - Power management support with suspend/resume callbacks;
> - Lock detect GPIO monitoring.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

Took another brief look. Seeing as you'll be doing a v14:

- check the headers don't need updates as I spotted one I think should be t=
here.
- the named initializer for struct spi_device_id thing is just to preempt s=
ome=20
  future cleanup.
=20
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makef=
ile
> index 70d0e0b70e80..53b4d01414d8 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -5,6 +5,7 @@
> =20
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
> +obj-$(CONFIG_ADF41513) +=3D adf41513.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
>  obj-$(CONFIG_ADF4371) +=3D adf4371.o
>  obj-$(CONFIG_ADF4377) +=3D adf4377.o
> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..20ea7e82818f
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c
> @@ -0,0 +1,1106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADF41513 SPI PLL Frequency Synthesizer driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
Give this another look.
array_size.h is missing for instance
That seems to be the most common one people miss so is my smoke
test for whether includes are probably correct.

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>


> +
> +static const struct spi_device_id adf41513_id[] =3D {
> +	{"adf41510", (kernel_ulong_t)&adf41510_chip_info},
	{ "adf41510", (kernel_ulong_t)&adf41510_chip_info  },

Though better still (and this is a recent thing given some of the work Uwe
is doing) - given you are respinning please use named initializers like
you do already for of_device_id.

It might save us a patch in the future.

Thanks,

Jonathan

> +	{"adf41513", (kernel_ulong_t)&adf41513_chip_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adf41513_id);

