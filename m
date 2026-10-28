Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151994;
	b=49mrJ7wLtRdKyObctjDoW+0lKQiWf/bMhnj+pU4rRsSVVVcZcE8e+YYo2VpypkMYqvY1
	 j9MROmvhEAM87YC1v4uhM4EiixQ0+EGZnXNbxPC/8qL6e7DlYng7JloRl6aKrl7NYt1VY
	 KGCHMn7ZEnxig+UfMyX81hVbEdhT7VU3NsPdaasCaI+3kAxDDYES9h6gIGtAc48hNk0bN
	 AySGqyXll0QWDAZAkaN5EVQN1RyTbjH5GTOexN34hDGW0KOhnoPhk5m/QoXuT5WEAvRUo
	 pNzmXZKrsLxMOcsfXVjBNL+x3W2V+v/lKp2e+eo4gVfRNBHvelD4rAS7DRcGN5nhh8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HhVgMwDF/XYzF1S4bXhT7dEgzoMg0MoK8ytAJuC4oTg=;
	b=bkMDSmY0YxCqY1TEvVciA8+iwJQembtRkb5c37dvoeS+e9Mz457+o9HrfEebqZDds9fg
	 OXR7DLEMCN4r0UAOfZUhCWF/ShCA2SG8CItJqzmkvF8X/W7Qz57eAzI/Iner8gC6X9sqh
	 bhOMr6hhNlXJjCq4RS20gqnGt06uYqSsKCz82dexZFAmUkFFhhMWxWhmzU2fNX5l+CDIr
	 3fZ0abQ8AndXYpuUnnzIpMIgG9hahG+x+mZNtN+UaLcbMrt2Lem60Z+fyx4NO/eRSEwT4
	 1q06Sd0P5542+G6OMPdJUQRZ5ncgX608L28uFhzXouRFAJXPNKgbXGV1GKC+3B1NEyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6TBaF45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68671606A31A;
	Wed, 28 Oct 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6TBaF45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4091F01825;
	Wed, 28 Oct 2026 01:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151994;
	bh=HhVgMwDF/XYzF1S4bXhT7dEgzoMg0MoK8ytAJuC4oTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P6TBaF45s40DeWTgldpqO1+bizR/xXy9w/EM4SKzr6QWeN3ygfozlJINicJUJb86j
	 TzBwdXkaqz6aY3t6hn+tAJFeXbTd6t9OIwQD+Y62g5c5KENtkzHURMEzG7x/vzbUmj
	 75OO3lkd58d7VeiNbQizJt2eQ2xmGAfi9mRQotSOsw/CktUEC5NQzJf8YSb9Alz//s
	 8iwQ5whJKFSkyd8IMcs7ITiFNTakGgTKSwdRJvY+eX5zcJXVId5T+ozZ0SDRJNrfs4
	 3TDGs4Q1mZo1ZvS6zwqMQyrw8ED/QcEMhcJyeJJAMd05Sthuk1fDAc+xvMoS9A2sJ3
	 SEEey4/Lm++OA==
Date: Wed, 28 Oct 2026 01:46:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Jyoti Bhayana
 <jbhayana@google.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 14/15] iio: scmi: use 64-bit divisions for rates and
 intervals
Message-ID: <20261028014626.4187905f@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-14-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-14-0d818334f6c7@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:19:18 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> do_div() only uses the low 32 bits of its divisor.  Two divisors in this
> driver need more:
>=20
> - scmi_iio_set_odr_val() divides by the requested sampling frequency in
>   micro-Hertz, which exceeds 32 bits from 4295 Hz on.  The update interval
>   sent to the firmware is then computed from the wrong frequency.
> - convert_ns_to_freq() divides by the update interval in nanoseconds, whi=
ch
>   exceeds 32 bits from 4.3 seconds on.  The sampling frequency and the li=
st
>   of available frequencies of a slow sensor are reported wrong.
>=20
> Use div64_u64().  A requested frequency of 0, which was a division by zer=
o,
> is refused with -EINVAL like other values that cannot be represented.
>=20
> Fixes: f774117c96f9 ("iio/scmi: Adding support for IIO SCMI Based Sensors=
")
> Cc: stable <stable@kernel.org>
> Cc: Jyoti Bhayana <jbhayana@google.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

We have some other fixes in this area. They don't completely overlap
though much of the content does match.

https://lore.kernel.org/all/20261006045244.13993-1-kapoorarnav43@gmail.com/

> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/com=
mon/scmi_sensors/scmi_iio.c
> index 442b40ef27cf..0e51e9c16b90 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -161,8 +161,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_d=
ev, int val, int val2)
>  	do_div(sf,  MICROHZ_PER_HZ);
>  	mult =3D scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
> =20
> -	sec =3D int_pow(10, mult) * MICROHZ_PER_HZ;
> -	do_div(sec, uHz);
> +	sec =3D uHz ? div64_u64(int_pow(10, mult) * MICROHZ_PER_HZ, uHz) : 0;
>  	if (sec =3D=3D 0) {
>  		dev_err(&iio_dev->dev,
>  			"Trying to set invalid sensor update value for sensor %s",
> @@ -237,13 +236,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_=
dev,
> =20
>  static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
>  {
> -	u64 rem, freq;
> +	u64 rem;
> =20
> -	freq =3D NSEC_PER_SEC;
> -	rem =3D do_div(freq, interval_ns);
> -	*hz =3D freq;
> -	*uhz =3D rem * 1000000UL;
> -	do_div(*uhz, interval_ns);
> +	*hz =3D div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
> +	*uhz =3D div64_u64(rem * 1000000UL, interval_ns);
>  }
> =20
>  static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *=
val2)
>=20

