Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272229B79B;
	Fri, 20 Feb 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586141; cv=none; b=G/DGCVTfkj8dcAmZUHTwLoYU/dBXMCHyU/D8+CUiYJ0ZipGdEYKutWCdSIfCWI67jzBppSt48N/jaQUOBV9fjrXHkI3OmotIzrxwtK8e2V4vflRwQUrijZq1JN4UyXW0oT9Vzb5MEyHiuqgN4bV4I/pxL//ThnRsZJdKYSkb5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586141; c=relaxed/simple;
	bh=Fhg4pvzbeZdPLOARDlQ7RDz1OmUa8aNoDpTeYV95amA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGwuDtcG4OMT5QqgYBNkFXTycZKEjEMVy8pMLmunP4yllWYNt3DLy8E98ccc8uKz6uCc5po5j5xn0oopwKTI48a6XxSVN09QUfdpvHsdoo1i0YGJMh+gbA7n6Whm43KR6XkrcTSOg8VK6WC+aiFfSuFPHRiOgSCrjgeQZibUhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn2jb7IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn2jb7IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41266C116C6;
	Fri, 20 Feb 2026 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586140;
	bh=Fhg4pvzbeZdPLOARDlQ7RDz1OmUa8aNoDpTeYV95amA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mn2jb7IZ4Wq2GJGlLMznR9XXfNPaC3RP654QNIATXbil53Ne6OR9OCyf5NQp4iCIr
	 YGlKhy9ZU7PuIR499Hfj9YNsvInmBja6malLa8CBUCvn3hSOQiiWbJZcamct3RuvBH
	 c0ZoY6wZpsNjCSq6b+YMwamXRxCih9sHnrKJv8ntzERYmd+WG5A8jWCVheZmgsMo0y
	 Cxwazp4cj1/8s9X5HxIUm+ZrQtx213HxAgWCPROZRz+p0vvulEMSzYdLm7dUgDVD3W
	 6smvsOsEI46JhUVCz0QgTvi4MHGRMNI3hGrbsQK+ITG4hJ3/bMEzrZGhnUjKu7sLJw
	 ySdf3MMn/NNzA==
Date: Fri, 20 Feb 2026 11:15:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 4/8] iio: adc: ad4030: Use BIT macro to improve code
 readability
Message-ID: <20260220111530.66ca4382@jic23-huawei>
In-Reply-To: <5f62866d5c8d4a0ea80e24ba009a2d35b9cf902d.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
	<5f62866d5c8d4a0ea80e24ba009a2d35b9cf902d.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Feb 2026 12:00:22 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Use BIT macro to make the list of average modes more readable.
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Stands on it's own a good improvement so picked up now
as another one we can all forget about ;)

Applied to the testing branch of iio.git.

thanks,

Jonathan

> ---
> No changes in v9.
>=20
>  drivers/iio/adc/ad4030.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 68446db9bef1..def3e1d01ceb 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -232,10 +232,16 @@ struct ad4030_state {
>  	.num_ext_scan_type =3D ARRAY_SIZE(_scan_type),			\
>  }
> =20
> +/*
> + * AD4030 can average over 2^N samples, where N =3D 1, 2, 3, ..., 16.
> + * We use N =3D 0 to mean no sample averaging.
> + */
>  static const int ad4030_average_modes[] =3D {
> -	1, 2, 4, 8, 16, 32, 64, 128,
> -	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> -	65536,
> +	BIT(0),					/* No sampling average */
> +	BIT(1), BIT(2), BIT(3), BIT(4),
> +	BIT(5), BIT(6), BIT(7), BIT(8),
> +	BIT(9), BIT(10), BIT(11), BIT(12),
> +	BIT(13), BIT(14), BIT(15), BIT(16),
>  };
> =20
>  static int ad4030_enter_config_mode(struct ad4030_state *st)

