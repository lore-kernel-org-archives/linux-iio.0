Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C862BDC0E;
	Sat, 21 Mar 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095496; cv=none; b=SUyN6t3QXHwI7j9xYYO5kmflG2oR28SVqpLCnHD3OmkH2go+thRPHopbeUyFA7yBJ37APqwBg+lynAI0HvanRQsCg96AqvXHptQZXvMdRzAF0dsX4XRo88ClCBSzqvFXSX9wRxCpJQ+qTwP4UXdO0xhlAr90knI794ieQd+7XWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095496; c=relaxed/simple;
	bh=LtUoyBjDt/JnLku/fE5VjoCpYSOnmTDDgCzWuxTQLa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbnOsClhiAuyUNkf0iRfS6w1HUPkKyis/Ge+v9jDuHR5oiWM02i/ramA/GKAcwsDFL0CrV3mQbb6SBjeXw/w4L8INrw/9JqYeeYpE/XSY48YGUM/caVlhgtJe2PBH5VBevJrJw/Hzi3Uo3MEka3/O57F1xoKUFeLJJUUw3TCtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL4t8FNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL4t8FNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19076C19421;
	Sat, 21 Mar 2026 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774095496;
	bh=LtUoyBjDt/JnLku/fE5VjoCpYSOnmTDDgCzWuxTQLa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EL4t8FNUH5GhRvEbrltbsNKY7ITrLDV/tUsjONCQNBd0wLWdjbMXNxpuY19ohVUf+
	 w00+EcXEk12gPPAYfQZPRHs5SZq81BOB5Hlgt2ZBeN5ZFBWPsUCKKMNNu1NzrPWafw
	 t4lp6k2Nu274OpKcdDua1qkdVyn+LbUoLvicPcr3XHf2kb6jqzAxQrfRX5AFvZggfx
	 WhhUPWSKN+7Mma/Guh6Rjlpv1Uwzu6noYy7k0eTnli/aX/xi5spSwz7wVZZPTb7++Z
	 pyxTOJbJhVhEjxcPtLYR8OVanouHK4fPUzQNjRVXNHYiaXbz4Gcp4P+kjxKzgLCDqA
	 P/KD06HzXRI+A==
Date: Sat, 21 Mar 2026 12:18:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260321121806.3bc18f53@jic23-huawei>
In-Reply-To: <20260321100154.1258-5-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2026 12:01:54 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.

Silly question - can we be sure that they both are on the same SPI bus?
I think it's reasonable to assume no one would burn pins to wire the
control interfaces up to separate busses. I'm not even sure how we'd
do a binding if they were on separate busses.

Otherwise, a follow on from the 'is it one backend or two' question
on the binding.

That long discussion between you and Andy has me looking at this a little
more closely.

Jonathan

>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v7:
>   - Drop debugfs_reg_access for dual-channel AD4880 variant
>   - Pass struct device * to ad4080_properties_parse() instead of
>     using regmap_get_device(st->regmap[0])
>=20
>  drivers/iio/adc/ad4080.c | 231 ++++++++++++++++++++++++++++++---------
>  1 file changed, 181 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cf3b6ed7940..8767eef418e9 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c

> @@ -632,9 +752,10 @@ static int ad4080_probe(struct spi_device *spi)
>  	indio_dev->name =3D st->info->name;
>  	indio_dev->channels =3D st->info->channels;
>  	indio_dev->num_channels =3D st->info->num_channels;
> -	indio_dev->info =3D &ad4080_iio_info;
> +	indio_dev->info =3D st->info->num_channels > 1 ?
> +			  &ad4880_iio_info : &ad4080_iio_info;
> =20
> -	ret =3D ad4080_properties_parse(st);
> +	ret =3D ad4080_properties_parse(st, dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -644,15 +765,23 @@ static int ad4080_probe(struct spi_device *spi)
> =20
>  	st->clk_rate =3D clk_get_rate(clk);
> =20
> -	st->back =3D devm_iio_backend_get(dev, NULL);
> -	if (IS_ERR(st->back))
> -		return PTR_ERR(st->back);
> +	/* Get backends for all channels */
> +	for (unsigned int ch =3D 0; ch < st->info->num_channels; ch++) {
> +		st->back[ch] =3D devm_iio_backend_get_by_index(dev, ch);
> +		if (IS_ERR(st->back[ch]))
> +			return PTR_ERR(st->back[ch]);
> =20
> -	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> -	if (ret)
> -		return ret;
> +		ret =3D devm_iio_backend_enable(dev, st->back[ch]);
> +		if (ret)
> +			return ret;
> +	}
> =20
> -	ret =3D devm_iio_backend_enable(dev, st->back);
> +	/*
> +	 * Request buffer from the first backend only. For multi-channel
> +	 * devices (e.g., AD4880), all backends share a single IIO buffer
> +	 * as data from all ADC channels is interleaved into one stream.
> +	 */
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);

So this is the interleaving bit.  Follows on from my question on the binding
and whether it is appropriate to represent it as two separate backends
vs a single one.  With a single one we'd need to make the control interfaces
take a parameter to say which 'front end' we were configuring - though it
kind of maps to channels in the particular case and we already have
a parameter for that.

The other option might be to make the dt-binding take a phandle + index to
say this backend, with this front end interface.

>  	if (ret)
>  		return ret;

