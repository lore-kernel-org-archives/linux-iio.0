Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbaHGQhK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 12:37:10 -0400
Date: Thu, 7 Aug 2014 11:36:32 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140807163632.GB29964@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
 <20140806214222.GB3556@saruman.home>
 <53E35018.1000900@kernel.org>
 <20140807143943.GB24581@saruman.home>
 <53E3A90C.6080006@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
In-Reply-To: <53E3A90C.6080006@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 05:27:56PM +0100, Jonathan Cameron wrote:
> >>>>> + +	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS) +		ret=
urn -EBUSY; + +	if (chan->type !=3D IIO_LIGHT)
> >>>>> + return -EINVAL; + +	mutex_lock(&opt->lock); + +	switch (mask) {
> >>>>=20
> >>>> is there no way to control the scale?
> >>>=20
> >>> yeah, but the HW does auto-scaling which works pretty well. Why would=
 you want to control the scale manually ?
> >> On a slow device like this you probably wouldn't but for quicker devic=
es the overhead of converting into a
> >> standard form in kernel might be excessive.
> >=20
> > hehe, even when you _do_ set the scale, you still have the top 4
> > bits as exponent, the difference is that you know what they are
> > before the conversion is done :-)
> Then you can junk them and let userspace use the known value to deal
> with the raw data.

alright, I'll leave that to a future patch then. Auto-ranging is so much
simpler.

--=20
balbi

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT46sQAAoJEIaOsuA1yqREhzoP/juK1p4j2P4ZN6I05zluF028
xPvrMPt9Sl68YHOBwcRcCrv74389DiXeG9AQgGYTOLgrbF5THUMah6DtWlPgzQNE
6tsvDi1thfQ5ZtFxXmTtnyqAGmfE/kVL+VP4GnuD7WbM37tSTfPEafmuLTj3mIyB
37hjE10o204nuSwq9gEQBsfQnFglIUbYi/pEsWbMqh5Jt7/RCdSCjO7Cs/svkBX+
sjGR9FN5kzu+bIe2uMdQlTcmlCEX5fAwJSh1rlMYa6/DMhQcuWdTvGD91LHLUUrh
XESuiAd+i1qsAXbhweVlIg/j3zoPVRIPCIz4mgUP4JUIJyEzOSx1T5eXw2DM5akg
dYtBhgJuNgTw9t9dy2T+vyC98l7px+/4MuN7b4rP1pNsDC/8Y5jVtu3mZB7Ivj+j
EN2TSmyFpovJlO364YGXyUf++WDzMlLotx/9loItkx8eaKwSg+svXzsR5Fr5XXd7
Iu40FEMGy0vYR5x1Uld75NYJZ50qh9kOD5+QYASIM3FMrCo/P+/5OazGK+evwWYc
HxlpLu88mdvtnjeuYMZx9pFSA8isZieN3r7Sy3ipbTvxCiSvfO8znlf+lVT/PVIZ
CAJtq09f264Pvbm8we+C80NP9LRdQnpJi0cmmPG4zm0fHNSaf9OLbXS/LzdXiPZV
rEGeCR9MYdeXFOz+7uqz
=KH37
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
