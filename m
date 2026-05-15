Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3E34D911;
	Fri, 15 May 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856759; cv=none; b=tJSQtKh75UVRUdcQqnMvaal3bFsTsTwfgCTQqQOIiheaNJSDNhj3fwWgOxr8cbqoNO63bdQQs4iKSpFibwIhdatVkIvwL+aypfmNmeW9ULeTjZuUaWJHOazVnbsuI3VPb5tYSRp9NN/kZLlPq/iVlflfoM7lXzQDoW4LytTG2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856759; c=relaxed/simple;
	bh=Deq94Q86YtrWVwAjV0vnOIT7XEETYWroUWK6+vysAqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDGB9SjX544h8wY/7jwnun37IZ/JNLbWG3hCgm4OynJ8skqdaXgpHCJXEsW9JbKgBXnCxgEqU1Rd/OdPJ589OstDhw1bOb1qW0tSedozXRIg5LueCeOyfHsa2SJCAkJ1feBl5VaMZLegCHoILfSY6a3d+mW9CPnLv6RGN1dUcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdg8bMaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdg8bMaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D9CC2BCB0;
	Fri, 15 May 2026 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856759;
	bh=Deq94Q86YtrWVwAjV0vnOIT7XEETYWroUWK6+vysAqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdg8bMajncjZV4FPqPVs6xM1YbvHnth/UZJnEDke77k8qMRH4MCNjLx6zelMRLTKu
	 T2sviRuC2vzPdTS2mG3mtvHX8FgF9Xm+GfraG8XbdXDMnmzNrSmAPR58PaACicKWon
	 AmptG3dkwpz0fJgLDImXUhrWK7EjpnBUzCk7LSqu6v4sH6hrz2CLDqyQ0wwTEqL31P
	 eSdYy67TDXnDZoMaRECVktJtcmsiYINHGfO3QDdDFdfmkb6hgD+rqKeQ1qandPcJEB
	 81S1ZhmkECfIXs4+KDD5FHdNc0IfvsO8SHlzGC8oapv1TG0QcDRHYrBeIeAHerNkrq
	 a5LRwEGQ08RGQ==
Date: Fri, 15 May 2026 15:52:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Daly
 <sam@samdaly.ie>, stable <stable@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ad7768-1: add bounds check to
 ad7768_filter_regval_to_type index
Message-ID: <20260515155230.6d7402db@jic23-huawei>
In-Reply-To: <2026051423-snowcap-excusably-2b68@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
	<2026051423-snowcap-excusably-2b68@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2026 18:23:22 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Sam Daly <sam@samdaly.ie>
>=20
> ad7768_filter_regval_to_type has 12 elements but the combined mask
> AD7768_DIG_FIL_EN_60HZ_REJ |=C2=A0AD7768_DIG_FIL_FIL_MSK spans 4 bits
> and can yield values 0-15. If it returns a value >=3D 12, this causes
> an out-of-bounds array access. Add a bounds check and return -EINVAL
> if the index is out of range.

I think this needs some more explanation as that's a sparsely filled array.
Now we are considering hardware returning values it shouldn't it gets
more complex.

So whilst it's not going to cause an out of bounds read, if we
get say a 5 then it shouldn't map to a SINC5 filter, but instead
return an error.

I suppose we could do it as a pair of fixes, but it feels like explicit
value matching is to ones we expect may well involve switching from
an array to a switch statement and once we've done that what is
being fixed here will be a natural side effect.

Given it's hardening against stuff we don't expect I'm not that worried
if it takes a little while to get the more complete fix in place.

Jonathan



>=20
> Assisted-by: gkh_clanker_2000
> Cc: stable <stable@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Sam Daly <sam@samdaly.ie>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/adc/ad7768-1.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index e16dede687d3..52e95017d36b 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -897,7 +897,7 @@ static int ad7768_get_filter_type_attr(struct iio_dev=
 *dev,
>  {
>  	struct ad7768_state *st =3D iio_priv(dev);
>  	int ret;
> -	unsigned int mode, mask;
> +	unsigned int mode, mask, idx;
> =20
>  	ret =3D regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
>  	if (ret)
> @@ -905,7 +905,11 @@ static int ad7768_get_filter_type_attr(struct iio_de=
v *dev,
> =20
>  	mask =3D AD7768_DIG_FIL_EN_60HZ_REJ | AD7768_DIG_FIL_FIL_MSK;
>  	/* From the register value, get the corresponding filter type */
> -	return ad7768_filter_regval_to_type[FIELD_GET(mask, mode)];
> +	idx =3D FIELD_GET(mask, mode);
> +	if (idx >=3D ARRAY_SIZE(ad7768_filter_regval_to_type))
> +		return -EINVAL;
> +
> +	return ad7768_filter_regval_to_type[idx];
>  }
> =20
>  static int ad7768_update_dec_rate(struct iio_dev *dev, unsigned int dec_=
rate)

