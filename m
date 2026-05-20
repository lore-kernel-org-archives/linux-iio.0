Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13F1A6801;
	Wed, 20 May 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291488; cv=none; b=O6BG8A8Jr+gGF3VDF+i4nzO7qwDwxy4d9fOmMNZZQjoUo+83VaaPieCLQgnYrF3PvNFNfqJi73CMP+h34VlAkygX0KIJRlDJCrz/27+HkqpXDtn8vlHtJftER6HTXun1KxD9FZed5RN6GGPlO4wJ9PI9s2DhKC8d0GsHydLxNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291488; c=relaxed/simple;
	bh=9uF7y53xIFa9DDPzkuuwjbr1xA2uuyJIbqolHoxcqjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzuBoL02EarqEwsPG66+jOaDcKvyhUn2yPbCQe9x7l7S9fftlELaWoQaOYvk6aBnCSJqvBIa8A1wXk61g8Gp1dXvsEWITzjRnMkC10kfCabEoi5gmNvJwI1Q4Ug5m9xegjLKG6Qsm4kOrlJw9iv0x+GcqcIPJx19Fk10KPLStOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuRvz2OG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuRvz2OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8091F000E9;
	Wed, 20 May 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779291487;
	bh=bCmROYsNvBzhQd8KlroK6vk7lGodGsrc7QcY46vZRpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OuRvz2OGf4FJA8qqMAVVmItSZTjVz31vaS0JY3iq/deq2rzSBVZGTUQsKh3iUTS60
	 kmJ/cmWVhl82LBdqPIAw5t/b9wx7mly9MSJEy9EjculJ/3qxOtfTlLNJFKjD3AgREZ
	 +abgad0nFfeJ1a5WZ6IIWGfSHU/zZ74k4Wh7qZu1+ohD9LR2LRxUbuTk73XUnK93uS
	 we7ZzZK+tTcKH1AT2Bh/bXNZWZoL0IT9mH5+PCvX+KqAZ3hPHgsrgRdLsOLp+lq6g8
	 TkQTlrg5Fy8D0LDYEAIJYRKTMbCDghs3VfBajQEMD2aby9kbJ7kRmZtbJKsABbc3Xr
	 fFL7BMqGHTRsw==
Date: Wed, 20 May 2026 16:38:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 5/5] iio: magnetometer: ak8975: make use of the
 macros from bits.h
Message-ID: <20260520163803.161541e3@jic23-huawei>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-5-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
	<20260518-magnetometer-fixes-post-pickup-v8-5-088d610108a0@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 09:50:29 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Make use of BIT() and GENMASK() where it makes sense.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

> =20
> @@ -858,7 +851,10 @@ static const struct iio_chan_spec ak8975_channels[] =
=3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(AK8975_SCAN_TS),
>  };
> =20
> -static const unsigned long ak8975_scan_masks[] =3D { 0x7, 0 };
> +static const unsigned long ak8975_scan_masks[] =3D {
> +	BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),

Ah. Here it is.  Fair enough.
Maybe I'll remember it next time!

> +	0
> +};
> =20
>  static const struct iio_info ak8975_info =3D {
>  	.read_raw =3D &ak8975_read_raw,
>=20

