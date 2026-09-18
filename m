Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4E397949;
	Fri, 18 Sep 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713610; cv=none; b=IDLZpquisBGxXue2ZuGUm+ze0KJBNGIrnvzhLz46303ikHlgDIBqjvlQDtIqTJxfsl5b4veGR4BPW6U/O8eY6gWKVfQ+JqhITivGu4JDpxP4oQRGDjz6bE+l5FbOcfq56KP8+cH82vooYVhPJvlfJa1KWFM1QbhEO+IX4zNwLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713610; c=relaxed/simple;
	bh=qH80mGE9pCwDhwBrlDfTjjf9ew0D0sIRmxCNxFsJE7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piIPtJ2+okAE44hyoqiPb4vi3THLn2BHVT5j5U2L0r/17i9ncB3IW5zjMZA8XGn3oDVr223LL4pPpkwFR+0kqGDkwlvCNcWsIURFAbx6pSzZ8qabzB9HolzraL6wh92nsTxBgMF+vzlqpnDmkNCZnA6RApLGK70e/0g+5v28vOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhxD1Y+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhxD1Y+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE98C1F00893;
	Fri, 18 Sep 2026 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713608;
	bh=THnFdyTeq0KsVfc/2yhY0wS2msxeEvDxKlZCMnDU5UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IhxD1Y+eG3fxALQgFkFo2XLbW64HqLJNRzjmbOs/Ikg9+PONsCFrD9QDsnEVouFtt
	 GudWuCnVij2L/v17xwmSJwVzq1b5bvF5NCm8HsjMqkPLi+c3SG5qECyRlptHwYE1RE
	 i5yk8Hq7z8fnB0DGgQnZkTZZYD5e11WmZh4sgj3gvS+K3D0qo9STpuS8e6FBp+Xjhx
	 j4eWxnZ13irnAO8ZbbbLjT0qOOBoXlgw1NXQ22udx23Hf/T6qhlmCIg8e2xntf34/q
	 Qv2SwRMlmB8tPsm7A9pMSYcZKW3ahYhnlI1adxMOBhN83PQOzEens4su2tCJi0x2P6
	 0s9gjw5iGkRPQ==
Date: Fri, 18 Sep 2026 08:40:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Allocate ext_channels with
 ARRAY_SIZE()
Message-ID: <aqzcxf84JEdoyzwA@lore-qca>
References: <20260917211350.i.934-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbQJT2YbkD8xj2MZ"
Content-Disposition: inline
In-Reply-To: <20260917211350.i.934-kees@kernel.org>

--wbQJT2YbkD8xj2MZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Kees Cook <kees+treewide@kernel.org>
>=20
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
>=20
> This is allocating a copy of magn_channels, which is an array of struct
> iio_chan_spec, but the size was taken from the whole array, which would
> make the allocation type a pointer to the array rather than the
> "struct iio_chan_spec *" being assigned. Allocate ARRAY_SIZE-many
> entries instead. The resulting allocation size is the same.
>=20
> Build tested ARCH=3Dx86_64 allmodconfig with GCC 16.2.0:
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.o
>=20
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=E1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: <linux-iio@vger.kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index d6a1eeb151ca..cbc47fa5b101 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -766,8 +766,8 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  			IIO_CHAN_SOFT_TIMESTAMP(3),
>  		};
> =20
> -		ext_channels =3D devm_kzalloc(hw->dev, sizeof(magn_channels),
> -					    GFP_KERNEL);
> +		ext_channels =3D devm_kcalloc(hw->dev, ARRAY_SIZE(magn_channels),
> +					    sizeof(*ext_channels), GFP_KERNEL);
>  		if (!ext_channels)
>  			return NULL;
> =20
> --=20
> 2.34.1
>=20

--wbQJT2YbkD8xj2MZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqzcxQAKCRA6cBh0uS2t
rI17AP0fAoZ0k4l8NkWBt1GT/hkmsWRWMZ2bReA5VRyYonj21AEA2AEKuZmVysDv
uxhbCT+fCsUIVmBlGYCPLXgeAMfbtwk=
=VerI
-----END PGP SIGNATURE-----

--wbQJT2YbkD8xj2MZ--
