Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAF26296;
	Sun,  6 Sep 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718279; cv=none; b=fTTFO0vUzVYouvRQ1LFH1RyU99GGfNnLKNnXuo+I3mBa/HSMwkQZHuNKJjFyqwUzZq9tjq54iy3U0QD8owx8mS+X7YBlBkr3U9eiKPHe4aYSkJWc2inCMI8jeHuas5xj7PfS3N4vtBdGjF6Gl7ERXffFt4k2OqciJGRCbdlQSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718279; c=relaxed/simple;
	bh=ayyY4P4B0JdjimZU7+k2UrVYkQtTkxbijRUG9XbofEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ0Uw6Xid6UDNz0HOQ4kQTRnep45ZwwYVF9S9DsgpsZT6KJaGRFR0Ny8liVcuRitsWV1X4q2kL30oxP7GKujAWJHYRIv3XW0T0+znmo6k39hb0ez7VmmeeQ6x6iEiQ50AX3vH4narTwSLvOf7lAdna4vsYaeegSVqVQmK6QH2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSEVV7CO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSEVV7CO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F1C1F00A3A;
	Sun,  6 Sep 2026 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718277;
	bh=Pqrc6i5GK9fCGEEmsnSbCELRBGLCJ7kO3WHBf7CtZcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bSEVV7COj/DrkMsDD1EmqR2Yzp4Z4hg5jXCxBvdf/jBIJYULej6BHEDgw4XX7G+7Z
	 ddkIbWr03qO5Zwkor1STqSh7dJqmqcjo61QZvU8hQPd0ECV5eEgRCympm8jB1Iyx7Q
	 8iwS7+6dfOp7v2GMkAYGaD2HCko2St/KmjslVSwSO0scw6c5N324cIwdClPg8Rb5d1
	 eNjiebaWaw64YatwPyQ/ZE5UUnS2MKwkIq0r7YamsPw/NRwanBbe1hIIzLfOZT6hrc
	 BtNAyo1mKCO1kp+ewtF401k+B0h3Q2fAtVFNPeVRL5Y9YvrMpwDlz9uVsPf1FhGlw2
	 4bdGqQbpDogJw==
Date: Sun, 6 Sep 2026 19:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <20260906191112.7d554140@jic23-huawei>
In-Reply-To: <20260903114337.63541-1-salah.triki@gmail.com>
References: <20260903114337.63541-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  3 Sep 2026 12:43:09 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In ad4030_set_avg_frame_len(), the logarithm is calculated before input
> validation. Passing zero or negative values leads to an undefined result
> from ilog2().
>=20
> Validate that the input is strictly positive prior to computing its
> logarithm.
>=20
> Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Given it is an Analog Devices part and Nuno is usually quick to reply
I'm going to wait for a tag from them before picking this up.

Thanks

Jonathan

> ---
> Changes in v5:
>   - Split validation into two distinct checks with explanatory comments
>   (per Andy Shevchenko and Nuno S=C3=A1).
>   - Used 'avg_val < 1' to explicitly reject invalid values for ilog2()
>   (per Andy Shevchenko and Nuno S=C3=A1).
>   - Tightened commit log description.
>=20
> Changes in v4:
>   - Reordered local variables to enforce strict reversed Christmas tree l=
ayout
>   (per Andy Shevchenko).
>   - Rephrased commit log in plain English without C-specific terms
>   (per Andy Shevchenko).
>   - Converted AI assistance note into a formal Assisted-by tag
>   (per Andy Shevchenko).
>=20
> Changes in v3:
>   - Dropped the !is_power_of_2() check to preserve standard IIO attribute
>    rounding behavior, per feedback from David Lechner and Jonathan Camero=
n.
>=20
> Changes in v2:
>   - Added note stating the issue was identified with assistance from
>   Claude AI and verified manually.
>   - Removed initialization of avg_log2 at declaration.
>=20
>  drivers/iio/adc/ad4030.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 9c5f19321e3b..f1499b4792b5 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -746,14 +746,21 @@ static int ad4030_set_chan_calibbias(struct iio_dev=
 *indio_dev,
>  static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
>  {
>  	struct ad4030_state *st =3D iio_priv(dev);
> -	unsigned int avg_log2 =3D ilog2(avg_val);
>  	unsigned int last_avg_idx =3D ARRAY_SIZE(ad4030_average_modes) - 1;
> +	unsigned int avg_log2;
>  	int freq_hz;
>  	int ret;
> =20
> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +	/* Reject unsupported modes */
> +	if (avg_val > ad4030_average_modes[last_avg_idx])
> +		return -EINVAL;
> +
> +	/* Avoid invalid values for logarithm since it's undefined */
> +	if (avg_val < 1)
>  		return -EINVAL;
> =20
> +	avg_log2 =3D ilog2(avg_val);
> +
>  	if (st->offload_trigger) {
>  		/*
>  		 * The sample averaging and sampling frequency configurations

