Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153587;
	b=odzjhtOouK9XrIctep+x9uwjB1cUBaXFA8roVnLBWC4ycoHqU+zit5cv7cY+t7emZZao
	 msQ966G4MJQYNsAkRKUlZi2Pba88dCChih0BjPxgfganEcUlbtt5+hP+IKVjHrP9Dweps
	 cKBC2qEes1NVoAtN2A9dqS9bZTrmE7LzuZtITSlUZeSC6dQYrgPC5QfF7ZNY/a06Cdb/T
	 H7mG2e7QQZLlAN2Fl2d2pdy4wdHYxZjFXu7vjQMT69ZDp4P84mxC92ziB2bCxXx8vxk6C
	 2T3PV+ckq12dkM8tXedeUp2mV1PkJBEe+7O6AqxtP61DWMkvOQuF4o/Fr+rtmSL+ubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9k/l1F3j9ErOaEXfe5eV7mu872+xG0viZl1MxnggL7U=;
	b=quysC0LFbddbZF7r5DjOAzl147bun3ukDGkGhB7qWBoegnNPgUyG++Yb1XUb4TpBKaL7
	 /SJiHaIjPtPpPhmiDIOQOICShmZVFr7uWxaND71c62+0GSAlcyz1nNprbVR50x27dDFYK
	 ayvKi6jd3mdWJtHSYmDo6PmInVgWNasUbsZ2pZjz2VitfTQhWAgj1M8tDTLFqrGOfO0Ty
	 cuKZAvS52bjkxXpGaJvlpZJVQmqWtSghihWzQ2pTHEnwGmrAzzR433nd7oflR5hPoM/59
	 vaPUzonT+9OORE2DSg/AE0H+D5xvbSXC+5rY4lgYrcIQJUD0nDBW3GOzc8I0Zu3uc3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iy6j/YCz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B285606A31A;
	Wed, 28 Oct 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iy6j/YCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B91F01825;
	Wed, 28 Oct 2026 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153587;
	bh=9k/l1F3j9ErOaEXfe5eV7mu872+xG0viZl1MxnggL7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Iy6j/YCzW/RJbRpPPhlhTFz3CtdP/eKdE9QmL6xGjMvHWIb7t4G22bG7hjUjteFsg
	 x+cE5oREJk/10uXgFdhIubFtd9+weQFLCTzfjEc0A6LqwzDZcxbAmvhwAb/6fXvZdS
	 qpveLgFZc2OVVC/SNnPJ2rxuHQMhZH/zQArvk0J+GTOCs6YNeBJOa7HqaervEJ/j1s
	 Ocrr34GABgjHUQwDVDgfagBIHU95uTnc12FrLO//02m29jon7Y8CoOQDwDU+0xwbXt
	 69/TkOaPIwiDNmIu3GEFVO3DvnRYTKyMsdPyj6HTKbVLV+gL3Rr9ci+2iV9et/ZmsS
	 haFEjrsHJ499g==
Date: Wed, 28 Oct 2026 02:13:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lucas Rabaquim <lucas.rabaquim@usp.br>,
 Matheus Silveira <matheus.feitosa@usp.br>, Stepan Ionichev
 <sozdayvek@gmail.com>, Joe Sandom <joe.g.sandom@gmail.com>, Jan Remes
 <ciakval@gmail.com>
Subject: Re: [PATCH 10/15] iio: light: tsl2591: don't divide by zero with
 low gain
Message-ID: <20261028021302.0430a947@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-10-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-10-0d818334f6c7@linuxfoundation.org>
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

On Tue, 27 Oct 2026 17:19:14 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> The number of counts per lux is the integration time in milliseconds times
> the gain, divided by 408.  With the low gain, which is 1, and an
> integration time of 100 to 400 ms, that is 0 in integer arithmetic, and
> each read of the illuminance divides by zero.
>=20
> In that case, multiply by the coefficient and divide by the product
> instead.  The result of the other settings does not change.
>=20
https://lore.kernel.org/all/20261022-first-patch-v4-0-90b2fc6e8e28@mycroftm=
ind.com/

I have first few of that series queued up already.

Jonathan


> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation=
")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lucas Rabaquim <lucas.rabaquim@usp.br>
> Cc: Matheus Silveira <matheus.feitosa@usp.br>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Stepan Ionichev <sozdayvek@gmail.com>
> Cc: Joe Sandom <joe.g.sandom@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/light/tsl2591.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index 286dc09e170f..773b50c17e71 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
> @@ -424,8 +425,13 @@ static int tsl2591_read_channel_data(struct iio_dev =
*indio_dev,
>  		}
> =20
>  		/* Calculate lux value */
> -		lux =3D ((als_ch0 - als_ch1) *
> -		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
> +		lux =3D (als_ch0 - als_ch1) *
> +		      (1000 - ((als_ch1 * 1000) / als_ch0));
> +		if (counts_per_lux)
> +			lux /=3D counts_per_lux;
> +		else	/* Less than one count per lux */
> +			lux =3D div_s64((s64)lux * TSL2591_LUX_COEFFICIENT,
> +				      int_time_fval * gain_multi);
> =20
>  		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
> =20
>=20

