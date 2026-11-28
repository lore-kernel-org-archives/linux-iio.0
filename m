Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826504;
	b=yMNLw5y4cR5jOw1Jae4lTKmmliG9bTByZRmcgLDIOz0CwhqNgeHdzpAjdXhbilpFaqCt
	 Rq8sd+tXza4q6jX/AzQ2UUrSy5Z3x+8DKqJa/VoyWL5BuHIDcarcuBoGGp+jz2Dc/ixWL
	 AenEoljN74JXSE/XwzmgM2KYaeHSKK53Q0zLlVVWt7MRXOIF5BF5CoPaIC3dBWXAq9Vb0
	 /L63J4M5TB2N5AVAI8JwmwcniD1nZctEEoa5t1fOI1XYYZEufN1ubhu5RxKIHLpChnUqx
	 kb4X5amVKNCmGEnu/zAmyTMmRvf4nX8ZpQ2rAT3Rnj3E0JCQEInowfDBqqSJjmoiFfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=txZ40HwG5PBs2JaJtTTKqqOr9g+GgVI7bM74efqgyNM=;
	b=yUyKMMjsV0jEHmkm4MpuYhkXU/u1ie3Sm+aOHUxwPgbopfCfqxTXroDYiJF7xQoZt2rW
	 kBzuKY6cZTZr2w88gF5ahsAjl7iQBbY7sKwzJ/KemMbhfL0LP028KbJdIZXQFUWDHg8z9
	 qwmnKhbFollaoUy1CmxZiprJkNjhGurnrRK72CQ7uFvIUP99N68C992Wzbdekd37F6g4L
	 gE3H0DWmQrUSCS61vIiMfvP7rt+pPwYSnQfqcV1mW5OiOkH92sDTOBIK8jOJTxK0FJA/6
	 rYtnnhuMA2SgmuGKUmNNUvgoJLljZ24V0wWsVvVtnCRh3yl4QTEIOdiLXyANnilyp3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQMrUbQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC014606A31C;
	Sat, 28 Nov 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQMrUbQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DC1F000C1;
	Sat, 28 Nov 2026 00:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795826503;
	bh=txZ40HwG5PBs2JaJtTTKqqOr9g+GgVI7bM74efqgyNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZQMrUbQINs6zsEe+v2hZIPwrasMaaRVwJEjzp+1Ykm5Fow+ht7PqCykTyF0iaE4Cq
	 uChBArCXJVnU1AAYn/VJBhfSgjedoxgMXRJ4dNpSYR3sjoiXI3sOCdB6YpXac1xDQw
	 qqLyyfegWEDvvSqXEhFVjsS4bwLAltPceINTY/zvQSbW8+X1r08cBrQ1e1mt40teH7
	 QZcB7zLVh806GNxv22UkeBfPLadiaxkXjGoDQhJJ2JrK7JPEfpKQaiYS3yHG40MWQn
	 IvyccHCKthkSNNdUUvo3IBLrSz998jKDZ68h1tocZyhqwmbVaVft2Bj/5l/jorVDRr
	 Dw+4yIEsd38gA==
Date: Sat, 28 Nov 2026 00:41:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <20261128004139.4f4d3c36@jic23-hlaptop>
In-Reply-To: <20261128-upstream-iio-cm3217-v4-2-fdab04f40bbc@tsv-stahl-riesa.de>
References: <20261128-upstream-iio-cm3217-v4-0-fdab04f40bbc@tsv-stahl-riesa.de>
	<20261128-upstream-iio-cm3217-v4-2-fdab04f40bbc@tsv-stahl-riesa.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Nov 2026 00:38:57 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count. The second
> address always follows the first one. The binding lists both, but the
> driver derives the second one from the first instead of reading it from
> firmware, which also covers new_device.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers (drivers/staging/iio/light/cm3217.c in the 3.4 kernel
> rel-tegranote-r8 and the 3.10 kernel
> android-tegra-flounder-3.10-nougat-mr1.1). One value differs: the vendor
> header defines 4 T as 4 << 2, which is outside the two-bit field. On a
> Tegra Note 7 field value 3 gave four times the 1 T count, so the driver
> uses that. For the resolution, Capella gives a range of 0.01875 to
> 119156 lux. The driver takes 0.01875 lux per count at 4 T and 800 ms.
> This matches both the upper end (65535 counts at 1/2 T and 66 ms) and
> the 0.3 lux per count that the NVIDIA 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.
> 
> Tool use: Claude Code wrote this driver from the downstream drivers and
> from my measurements on the device.

As before. Unless there is something really unusual about the tooling,
push it below the ---

Otherwise, I nearly picked this up, but I won't for now as I'd like
you to take one more look at the includes + good to leave some
time for others to review before I apply and by conincidence you
sent it just as I was starting reviewing today.

Thanks

Jonathan

> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab P1988
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
> Svyatoslav's Tested-by was given on v1. Since then there was no
> functional change apart from how the driver gets the second address
> (v1: fixed 0x11, v4: device address plus one, which gives the same
> 0x11).

> diff --git a/drivers/iio/light/cm3217.c b/drivers/iio/light/cm3217.c
> new file mode 100644
> index 000000000000..5edd4d21d08c
> --- /dev/null
> +++ b/drivers/iio/light/cm3217.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Capella CM3217 ambient light sensor driver
> + *
> + * The CM3217 has no registers. It answers on two fixed I2C addresses:
> + * writing a byte to 0x10 or 0x11 sets command byte 1 or 2, reading a byte
> + * from 0x10 or 0x11 returns the MSB or LSB of the 16-bit light count.
> + *
> + * Copyright (C) 2026 Patrick Fischer <admin@tsv-stahl-riesa.de>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
We tend to try and avoid including that 'grab bag' style header.

There are  more specific appropriate includes such
as dev_printk.h

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/ktime.h>
> +#include <linux/mod_devicetable.h>

That shouldn't be needed. It is now assumed to always come via
the appropriate bus header.


> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define CM3217_CMD1_RSVD	BIT(5)		/* reserved, set to 1 */
> +#define CM3217_CMD1_IT_T	GENMASK(3, 2)	/* 1/2 T, 1 T, 2 T, 4 T */
> +#define CM3217_CMD1_WDM		BIT(1)		/* set to 1 like the vendor driver */

> +
> +static int cm3217_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct cm3217_data *data = iio_priv(indio_dev);
> +	unsigned int fd_it;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		scoped_guard(mutex, &data->lock)

For this sort of case I prefer we just take the guard for a bit longer and add
scope for the whole statement. It generally ends up more readable.
i.e.
	case IIO_CHAN_INFO_SCALE: {
		guard(mutex)(&data->lock);

		fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
		*vals = (const int *)cm3217_scale_avail[fd_it];
		*length = 2 * ARRAY_SIZE(cm3217_scale_avail[0]);
		*type = IIO_VAL_INT_PLUS_NANO;

		return IIO_AVAIL_LIST;
	}
> +			fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
> +		*vals = (const int *)cm3217_scale_avail[fd_it];
> +		*length = 2 * ARRAY_SIZE(cm3217_scale_avail[0]);
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = (const int *)cm3217_int_time_avail;
> +		*length = 2 * ARRAY_SIZE(cm3217_int_time_avail);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}



