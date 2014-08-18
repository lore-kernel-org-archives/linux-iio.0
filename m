Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55987 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbaHRQlg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Aug 2014 12:41:36 -0400
Date: Mon, 18 Aug 2014 11:41:29 -0500
From: Felipe Balbi <balbi@ti.com>
To: Felipe Balbi <balbi@ti.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
Message-ID: <20140818164129.GL9662@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407940605-12270-1-git-send-email-balbi@ti.com>
 <53ECE90A.8010609@kernel.org>
 <20140814170530.GB1445@saruman.home>
 <53ECF070.5040304@kernel.org>
 <20140814201744.GA4929@saruman.home>
 <53ED1CE7.3070606@kernel.org>
 <20140814205605.GF4929@saruman.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
In-Reply-To: <20140814205605.GF4929@saruman.home>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2014 at 03:56:05PM -0500, Felipe Balbi wrote:
> +static int opt3001_write_raw(struct iio_dev *iio,
> +		struct iio_chan_spec const *chan, int val, int val2,
> +		long mask)
> +{
> +	struct opt3001 *opt =3D iio_priv(iio);
> +	int ret =3D 0;
> +
> +	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS)
> +		return -EBUSY;
> +
> +	if (chan->type !=3D IIO_LIGHT)
> +		return -EINVAL;
> +
> +	if (mask !=3D IIO_CHAN_INFO_INT_TIME)
> +		return -EINVAL;
> +
> +	mutex_lock(&opt->lock);
> +	ret =3D opt3001_set_int_time(opt, val);

I just noticed (after further reading other drivers and testing more)
that I'm passing the wrong argument to this function. I should be
passing val2 instead.

In fact, I was complaining that the entire framework was in (in this
case) lux but integration time was in ms rather than in s, turns out
that was my issue. Do you want me to resend or can you fix this one line
when applying ? I just checked that replacing val with val2 doesn't
break anything and I can echo 0.1 or 0.8 to
in_illuminance_integration_time

cheers

--=20
balbi

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8iy5AAoJEIaOsuA1yqREUzIQAJFZH0kCUzlMYnJ4XDeaWaF1
UqfY1IdkdhuqHAP2cm21LdD+dRc69gIqvmUmEZyr4Q4RzIZ2YDOWoBUUqOaE3r+U
ZB/OlBJyxYQ1Eqi8A4mRftCilf1EUZrVKBvghA7D+eN/nWQNyBQCV4j2cZ3BMWzK
VeQw92la2dsT2KxFmZSS88jOfPTOFtrbvRvmH+QhP1f6Nfc7KfuR7uVwwEDRHgvc
8mYITzglmmWCWvsWj4aGuiGcU4uPEEdNvcq2x7uYb5bD1xMyUxL9/OGOQ5rXGriD
dx4SNnTxuH0Z+K28S31rbiFKsEoecM9G9mfpybSbEJxjxqylxCmpb3l97TVGk0pF
p+RhHYrVI1NnR4Cr2y/OGd1pMGeXOcVmRtVMecFEQtd8XdCEJB8OPu6YtFiWNBxc
YkspwTdgFdJ8byCsYsLC7eSdeyXLU6fzILAnCPw+gFvCwL0ci37mlfcNO3mm8dIV
B+S1YrfqGupLqaC3dahYKtV13R7PfVQKGkZ7VEQv4+PvBrJhwPBuLGHGriNeffDp
IeZiUHmfnwbINiL6i6G3CVl/yRJumlDRng23ahqC3uAZ7tXYHuhipTyKBna00LKe
1ZHKJDbpbtVlpcGR5DyifLNkmmTw6w/IZoECjBsD+48/X877eY9QwJGd9OJ1oiAI
ohrqPdcpH8pBpnBSFjEW
=B1XL
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--
