Received: from skycaves.subdimension.ro (skycaves.subdimension.ro [157.180.79.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D3368291;
	Fri, 30 Jan 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.79.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773943; cv=none; b=BjvLrFKm1mrGMYNKjZhpN9gY+j8IpN4gTE3SLd2voRq6jzcC8B7n9KCw4yZ2Tjf/SmV8dX8eeWmtwtvHgDWfbtKxDQxEl2NdXEoib9LVvYuO/PWu3IpuQ1FO87A9bOu37gYZLqT5QCfoxdTxjqT+hhtqM3zAP/x3LwfI7priniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773943; c=relaxed/simple;
	bh=5ORs/MhtBZU2bRCi/4A3n8dzgwjRGsW9J/7WVyXKG3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrPFOI1/kT1A/ZCf0AIePM9QRvonjUu9iy4TjpsuJ/rHt9yhhv9MIJqJC52Sc0eGSu8uw3EjyAysDdtY812S0RA/hSSyPdlQZpbbknrmNJ+QTcf4ymcQerGl7vbf1iJhKEfjU+EAVyBWUx6sZK0IeuTacEOFZoEQvPJhcpNxPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; arc=none smtp.client-ip=157.180.79.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3d08:a700:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by skycaves.subdimension.ro (Postfix) with ESMTPSA id 3AEE96546D;
	Fri, 30 Jan 2026 13:46:20 +0200 (EET)
Date: Fri, 30 Jan 2026 13:46:17 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: hsc030pa: Improve i2c_transfer return
 value handling
Message-ID: <aXyaCTZfJ8WC-rcq@sunspire.home.arpa>
References: <20260129181452.57628-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FxrO91ofccmuop7h"
Content-Disposition: inline
In-Reply-To: <20260129181452.57628-1-antoniu.miclaus@analog.com>


--FxrO91ofccmuop7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Antoniu,

On Thu, Jan 29, 2026 at 08:14:52PM +0200, Antoniu Miclaus wrote:
> The i2c_transfer() function returns the number of messages
> successfully transferred. The function sends 1 message but checks
> for ret =3D=3D 2, which can never be true.
>=20
> In practice this has no impact since the caller checks ret < 0,
> and the erroneous return value of 1 is not treated as an error.
>=20
> Improve the return value handling to properly distinguish between
> I2C errors and unexpected transfer counts.

thank you for the patch, much appreciated.

Tested-by: Petre Rodan <petre.rodan@subdimension.ro>

best regards,
peter

>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> v2:
>  - Changed subject from 'Fix' to 'Improve'
>  - Clarified that the bug has no practical impact
>  - Used explicit if/return pattern instead of ternary
>  - Dropped Fixes tag
>=20
>  drivers/iio/pressure/hsc030pa_i2c.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/h=
sc030pa_i2c.c
> index a34ef4653f34..3500bda03d75 100644
> --- a/drivers/iio/pressure/hsc030pa_i2c.c
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -34,8 +34,13 @@ static int hsc_i2c_recv(struct hsc_data *data)
>  	msg.buf =3D data->buffer;
> =20
>  	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	if (ret < 0)
> +		return ret;
> =20
> -	return (ret =3D=3D 2) ? 0 : ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	return 0;
>  }
> =20
>  static int hsc_i2c_probe(struct i2c_client *client)
> --=20
> 2.43.0
>=20

--=20
petre rodan

--FxrO91ofccmuop7h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAml8mgIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHQrJ6djOkljlAwP/RpqaY2rFHB8d3hR463A
8xGKYGtgoXZxHBB9mhq0sKsg5/8Orh5+a/7PYig4Ksu9RBHODSiV0/p7hra2Zp8Z
JhMh4HwqqnoXNJ9AqFY+WxsHhb4cmz9Tu8Bz+8VKt7lE0dfgoP1gtxiooKLh9PIg
1HWpAu9x7MTmtCSR52eH+/qNsPsPb+j1rKPh/CZbQDSziz3GPVgsl2HzuFX2Gfbq
1BlhaGGwbnPckgnNzUVVbMvlrgjyUNrp370mtZmJj1W4SZjX3nsdC2U8YkHmxyjA
ceX4N92qwnVZJCQW9iYLi8bh6YJEpx1TnsmONCJMCG9pZesZHYXNoNtBaVxabh9o
1BMKZHXPgGvDpdbtBGG4QqFSLjiuMWM1sC4JybhPjvm5nTayViUASHXgRhCupJ36
nOW4t9geCZhn6VSIARVCKw+tTuBo21rz4GNw+Xs+jGoNZ1rqhK2Gh6XFPQPFtUW8
AQNxWJBDiDGl2RJvNG93ND2BzDwt9x+gMtB8nKXQcoc2ZRFzf5x+wBBZ7xqi26tC
cl427GRNp3mKEDhNGDyVH8IDlwNJardok0yYxeuRNshDwCKBF/TcotqPKIVVGM3T
p3tRjquyPkhAmDnNb0LD+0hLseRxezDbWAddoYl6IQjz0z7J4ekVjFzRxbkwP6uD
nKnJL2QrmPqd6+qjeSqTcmVx
=hIqm
-----END PGP SIGNATURE-----

--FxrO91ofccmuop7h--
