Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623393AF66C;
	Fri, 15 May 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855961; cv=none; b=U7wr4Itu+2P0GCy1XiEyid1UxZPZcgp+Tdr4wzfN1QGFFM42jppmt+c99K/jCCfUZfBQExxi/odCWN0DVWcMSImUfGV9YRYs/nFz3Zarr3kiqg3it9hVxYb+GN2sYGfma2VOX6nxnyaxIt1eJJmB93gOzw8yh62KmoL+icqQCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855961; c=relaxed/simple;
	bh=R7wrkVv/t3mAwqqLTrzD3jzdlMpgVIyjdEvaX0QqR9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3/MGqZ3egh63RnE2oNd1bkqaz+YmEytc8VSbvAr6Cxk2FOSGS8bH5HBy5GjFACa+wZc7a9U5eTc07kjAl93+6sivt+sJRg7FSYX+BQowGnxXSjMeey0F+Ii2JFwfFUTfkbzrSBSBejikZvkAf2K1Z2ezOgFd+LiH2kSXhC/wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD67ln25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD67ln25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8619C2BCC7;
	Fri, 15 May 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778855961;
	bh=R7wrkVv/t3mAwqqLTrzD3jzdlMpgVIyjdEvaX0QqR9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dD67ln25kk+TVlcD1MzvrLuK/IKuhWXJumjh3GvGhArPCsIkUubW8VhnM89OuLim1
	 f9b7+WSrJabhX3u3cdLgPr81A1dTcZ9j/48xxVoPgu9qSn5yA6IERYOsJjrcE0ijg9
	 LnwlpFWi03XOXE7PyQ8WOJP4QZ7VNh5IHm/3C+xdTWMFo8p5dQC80/zzHToFrbmiYK
	 8UW7PPAcEyA8ScjZKNh/ETIbPX7oqb0HsihzVa31URkPj5tsMTFgJw/ZyTcECLDife
	 arLFSox8Ex70W9SkxRKd3PgAjAgIOaC7FVd3W4DGNV0WtSR3R6imjHiSgECE4yHBUX
	 zmXFnkHjnwHXQ==
Date: Fri, 15 May 2026 15:39:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Daly
 <sam@samdaly.ie>, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ti-ads1298: add bounds check to
 pga_settings index
Message-ID: <20260515153913.00150136@jic23-huawei>
In-Reply-To: <2026051420-strudel-graves-f6cd@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2026 18:23:20 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Sam Daly <sam@samdaly.ie>
>=20
> ads1298_pga_settings has 7 elements but ADS1298_MASK_CH_PGA can yield
> values 0-7. If it yields a value >=3D 7, this causes an out-of-bounds
> array access. Add a bounds check and return -EINVAL if the index
> is out of range.
>=20
I'll add something about the other value be reserved whilst applying.

Note that Sashiko has found a more involved similar case (I haven't
checked it)

https://sashiko.dev/#/patchset/2026051420-strudel-graves-f6cd%40gregkh

Whilst ideally we should harden drivers against faulty values from
hardware, sometimes (like that one) it gets rather involved to actually
do!  Hence I'm not suggesting we actually fix that one but if anyone
does want to take a look - go ahead.

Jonathan


> Assisted-by: gkh_clanker_2000
> Cc: stable <stable@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Sam Daly <sam@samdaly.ie>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/adc/ti-ads1298.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index ae30b47e4514..731792f06993 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -279,6 +279,7 @@ static const u8 ads1298_pga_settings[] =3D { 6, 1, 2,=
 3, 4, 8, 12 };
>  static int ads1298_get_scale(struct ads1298_private *priv,
>  			     int channel, int *val, int *val2)
>  {
> +	unsigned int pga_idx;
>  	int ret;
>  	unsigned int regval;
>  	u8 gain;
> @@ -302,7 +303,11 @@ static int ads1298_get_scale(struct ads1298_private =
*priv,
>  	if (ret)
>  		return ret;
> =20
> -	gain =3D ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
> +	pga_idx =3D FIELD_GET(ADS1298_MASK_CH_PGA, regval);
> +	if (pga_idx >=3D ARRAY_SIZE(ads1298_pga_settings))
> +		return -EINVAL;
> +
> +	gain =3D ads1298_pga_settings[pga_idx];
>  	*val /=3D gain; /* Full scale is VREF / gain */
> =20
>  	*val2 =3D ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */

