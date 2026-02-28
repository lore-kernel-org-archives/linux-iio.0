Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D52E8B71;
	Sat, 28 Feb 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296036; cv=none; b=OF3D7Mzn35BvtEQot8GCLKRQw3ec5qXjvOUIeklTV/Bz6vZEIYdSaGMPblUoNFFL7XPYziHeURCwVqV20AjVbRR3lfAIZmIV/fllMn0Eeb2F+xz5wVpndoQxlcWviwM8YaFxPtshgvr6eeOjlOVI8IMud+OK55+pKSC6UJeRwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296036; c=relaxed/simple;
	bh=4lPWh/DFvuZXEl2b06WYNmLoRprnHEnN0jaEofz6TxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqgTyiR1zkZrNavVZICkeaF2XHhPbKkE1N8X9Ix6x9ZoNWzZfd1X0Vr+TKkoyxFm0gRz6Tgm90P81X0TnvkBaJt8/esxZs/Aff8260l+edHSQL7oMbbHQwe54+31DHgjtZj3k6U7ABgE4bZ2Yqh5KljcSO7cPSdMtlkhdjtTBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isFMtRjt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isFMtRjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC7C116D0;
	Sat, 28 Feb 2026 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296036;
	bh=4lPWh/DFvuZXEl2b06WYNmLoRprnHEnN0jaEofz6TxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isFMtRjtNImO1nHrgipcHm9WBe8E2gcJFd6gpGvfMLgrm7K9z9jMrIoQEnKbWIYPj
	 uVGt7wjI2U7J+uhFxKuxR5hNu6YwJ2OEkt/WWqu6nUk5mm4DeqNjOPrRQnhK7iIK6v
	 vZiD2rb3ah5jexuPckvkSFELdDXIx2IgplCihAGRBRQJZPkgeVAqrdfNw0YxL+w3bp
	 I1xqjnF5xT53cDvRG1j7CdHBcamkZ2zyJ/g5Q4BF5Twmhs1YpoejlrL+mGck5cUxVJ
	 N8ePDPAb1nfGYIUFuW/SNcZ/Z24iHxdebtzzC1nIBMSoA5f233e0TlAaU30m+CProK
	 VA2gwSJJZKEJA==
Date: Sat, 28 Feb 2026 16:27:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
Message-ID: <20260228162638.00440b5c@jic23-huawei>
In-Reply-To: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2026 15:30:39 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the write
> path treats it as MICRO. Since no write_raw_get_fmt is provided, the
> IIO core defaults to MICRO when parsing userspace input.
>=20
> This means reading calibscale and writing it back results in a ~1000x
> gain error.
I'm not following this part.  What I'd expect to see something like
reading avail gets you
[0.0 0.0000030518 1.99996982]

Reading the channel gets you maybe 1.1333333333 and then when you write
back because of the lack of write_fmt it gets truncated and you
are effectively reading 1.133333=20

So I'd not expect to see a gain error, just a loss of precision.

What am I missing? Please provide a numeric example to motivate the
patch.

Thanks,

Jonathan=20
>=20
> Change the read path and available range to use MICRO to match the
> write path.
>=20
> Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/adc/ad4030.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index def3e1d01ceb..3d823648371d 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct iio_de=
v *indio_dev,
> =20
>  	/* From datasheet: multiplied output =3D input =C3=97 gain word/0x8000 =
*/
>  	*val =3D gain / AD4030_GAIN_MIDLE_POINT;
> -	*val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
> +	*val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
>  				AD4030_GAIN_MIDLE_POINT);
> =20
> -	return IIO_VAL_INT_PLUS_NANO;
> +	return IIO_VAL_INT_PLUS_MICRO;
>  }
> =20
>  /* Returns the offset where 1 LSB =3D (VREF/2^precision_bits - 1)/gain */
> @@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, vo=
id *p)
> =20
>  static const int ad4030_gain_avail[3][2] =3D {
>  	{ 0, 0 },
> -	{ 0, 30518 },
> -	{ 1, 999969482 },
> +	{ 0, 30 },
> +	{ 1, 999969 },
>  };
> =20
>  static int ad4030_read_avail(struct iio_dev *indio_dev,
> @@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indio_de=
v,
> =20
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		*vals =3D (void *)ad4030_gain_avail;
> -		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		*type =3D IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_RANGE;
> =20
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

