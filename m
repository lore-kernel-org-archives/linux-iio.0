Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E2213E89;
	Tue, 12 May 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584416; cv=none; b=rEsn88d7TzaNuDQAKziuJvBIzeMQoJrjdoDeJUQJ2nUyMr+KQvohWt+3xWVHSqRGP1nnYo+a0XiQn/YkiNZ4V61eIom4q9w/Z2omUTtU9lBL4yt+BbMchDgW1c+TwXwRH8MnxMZ1wHuBDY6wmzLw6lxQpyO9VyVD3MoFWSPjGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584416; c=relaxed/simple;
	bh=iB3ztN846EP3D59KRDHOP+RhbUQzpbIy6BVpmGbhx50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aICwRbHIDtu6ZsJf16k3npKgqXLmFwVWFJLKjCyZqoTSnOA7bhJrQCsyNrSq/baF8OB6POkr8VvzR4E+S/CBSQ43Gki9X5g4QGbuIVWvbEBMxbFU+liml1KZJR4uUUMcSU4uPWeixtM1BfturGPC+H4A3TcFHfjO/CRza1htgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5+9feBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5+9feBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6023CC2BCF5;
	Tue, 12 May 2026 11:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778584415;
	bh=iB3ztN846EP3D59KRDHOP+RhbUQzpbIy6BVpmGbhx50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5+9feBobw3jljJucygSeW/2oaK77sLWZTF7bHfRuO27Z0RDKtlHMBxPR7ptltB0Y
	 aNjX2cnl9YF8xpGIVNlamRcPSlVGwetz+llgTadrg6SJ0eD6gfSVEUmUlFNkMpTU/I
	 yZQuglo2+9WcHPQQe36IpO6dc3KP5Akz4V9Xaj9oxVfrNCad5HX6IlnM4lLwtcwm9T
	 DfpZQL/YLgXVIKDcR61khjrV93PKYCy0+nNiIRR8yLg28JW4VPb0nuzSXD3T3Q8/Kd
	 zddnoxWJXcPaqSrZtstpm3uc9oW1jzE9DRMQ/5wgD81m+G2AKS5elEx3s+HTH71CSN
	 aSCESBxyWhM5w==
Date: Tue, 12 May 2026 12:13:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Message-ID: <20260512121326.189817b8@jic23-huawei>
In-Reply-To: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 May 2026 17:00:38 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Commit 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous
> ready signals") introduced a new out_unlock: label for an early-exit
> path and moved sigma_delta->keep_cs_asserted =3D false there.
> Unfortunately it left both ad_sigma_delta_set_mode(AD_SD_MODE_IDLE)
> and ad_sigma_delta_disable_one() in the out: block above that label,
> so both SPI writes are issued while keep_cs_asserted is still true.
> keep_cs_asserted feeds directly into the cs_change field of the
> spi_transfer, so the final write to the device carries cs_change=3D1.
> The SPI framework only calls spi_set_cs() to deassert CS as part of
> message teardown when cs_change is not set on the last transfer; with
> cs_change=3D1, that teardown is skipped and CS stays physically asserted.
> No further transfer to the device is made, so the driver never
> deasserts CS.  The framework provides no automatic CS deassert on bus
> unlock or when switching to another device, so CS remains stuck low
> until the next SPI operation to that same device.
>=20
> On a shared SPI bus this is problematic: with CS stuck low the ADC
> remains selected and subsequent SPI traffic intended for another device
> is interpreted as commands by the ADC.  Devices like the AD7124 that
> multiplex /RDY onto the MISO line will start spurious conversions and
> pull MISO low, corrupting reads from the other device and causing a
> deadlock.
>=20
> Fix both calls by moving them into the out_unlock: block, after
> keep_cs_asserted is cleared, mirroring the existing correct pattern in
> ad_sd_calibrate().  With keep_cs_asserted false, both set_mode(IDLE)
> and disable_one() execute with cs_change=3D0, so the SPI framework
> deasserts CS as part of normal message teardown.  For devices that do
> not implement the optional disable_one callback, set_mode(IDLE) issues
> the last SPI transfer and CS is properly released in all cases.
>=20
> Also fix a pre-existing state leak in ad_sd_buffer_postenable(): the
> err_unlock: error path called spi_bus_unlock() without first resetting
> bus_locked and keep_cs_asserted to false.  Subsequent SPI calls would
> observe bus_locked =3D=3D true and invoke spi_sync_locked() on a controll=
er
> that is no longer locked, potentially allowing concurrent bus access.
>=20
> Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready =
signals")
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Actually - dropped again. I forgot to check Sashiko.
(Note please do this yourself in future and reply to the patch if changes a=
re
needed).  It raises some concerns about devices that don't provide
the callbacks and hence won't ever use that keep_cs_asserted =3D false call=
back.

I'm struggling a bit on how the max11205 works at all as there seems
to be a status register read on a device which claims to have no registers.
ad_sigma_delta_clear_pending_event() as the binding suggests this device
doesn't have a drdy_gpio

Anyhow, please take a look at the feedback and if it's wrong please provide
an explanation of why in this thread.

Thanks

Jonathan


> ---
> Changes in v2:
> - Move set_mode(AD_SD_MODE_IDLE) into out_unlock: as well, not only
>   disable_one(); v1 left set_mode() above the label where
>   keep_cs_asserted is still true, so devices without the optional
>   disable_one callback still had CS stuck after that transfer.
> - Fix pre-existing state leak in ad_sd_buffer_postenable() err_unlock:
>   reset bus_locked and keep_cs_asserted before spi_bus_unlock() to
>   prevent spi_sync_locked() being called on an unlocked controller.
> - Link to v1: https://lore.kernel.org/r/20260428-ad_sigma_delta-fix-v1-1-=
8e3f925ee8d2@analog.com
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index a955556f9ec8..a33a7e8c264f 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -441,11 +441,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
>  out:
>  	ad_sd_disable_irq(sigma_delta);
> =20
> -	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> -	ad_sigma_delta_disable_one(sigma_delta, chan->address);
> -
>  out_unlock:
>  	sigma_delta->keep_cs_asserted =3D false;
> +	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> +	ad_sigma_delta_disable_one(sigma_delta, chan->address);
>  	sigma_delta->bus_locked =3D false;
>  	spi_bus_unlock(sigma_delta->spi->controller);
>  out_release:
> @@ -578,6 +577,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
>  	return 0;
> =20
>  err_unlock:
> +	sigma_delta->keep_cs_asserted =3D false;
> +	sigma_delta->bus_locked =3D false;
>  	spi_bus_unlock(sigma_delta->spi->controller);
>  	spi_unoptimize_message(&sigma_delta->sample_msg);
> =20
>=20
> ---
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
> change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0
>=20
> Best regards,

