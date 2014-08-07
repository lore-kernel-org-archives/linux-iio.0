Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757509AbaHGOkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Aug 2014 10:40:19 -0400
Date: Thu, 7 Aug 2014 09:39:43 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140807143943.GB24581@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
 <20140806214222.GB3556@saruman.home>
 <53E35018.1000900@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
In-Reply-To: <53E35018.1000900@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 11:08:24AM +0100, Jonathan Cameron wrote:
> >>> +				OPT3001_CONFIGURATION); +		return ret; +	} + +	/* wait for conve=
rsion and give it an extra 5ms */ +
> >>> usleep_range(opt->int_time + 5000, opt->int_time + 10000); + +	ret =
=3D opt3001_read(opt, OPT3001_CONFIGURATION);=20
> >>> +	if (ret < 0) { +		dev_err(opt->dev, "failed to read register %02x\n=
", +				OPT3001_CONFIGURATION); +		return
> >>> ret; +	} + +	reg =3D ret; +	if (!(reg & OPT3001_CONFIGURATION_CRF)) +=
		return -EPIPE; + +	ret =3D opt3001_read(opt,
> >>> OPT3001_RESULT); +	if (ret < 0) { +		dev_err(opt->dev, "failed to rea=
d register %02x\n", +				OPT3001_RESULT);=20
> >>> +		return ret; +	} + +	exponent =3D OPT3001_REG_EXPONENT(ret); +	mant=
issa =3D OPT3001_REG_MANTISSA(ret); + +
> >>> opt3001_to_iio_ret(opt, exponent, mantissa, val, val2); + +	return II=
O_VAL_INT_PLUS_MICRO; +} + +static int
> >>> opt3001_get_scale(struct opt3001 *opt, int *val, int *val2) +{ +	int =
ret; +	u8 exponent; +
> >>=20
> >> I guess OPT3001_RESULT is only valid AFTER performing opt3001_get_lux()
> >=20
> > right. I'm only interested in the exponent part. It'll latch the expone=
nt from last conversion, 0 being default.
> Given you unwind the scale anyway in your read raw, I'd not bother
> having a scale interface at all (assuming I'm right in thinking your
> read raw is returning the value in lux?)  Also as you are in lux, it
> should be the processed form not the raw one to indicate the scale
> does not need to be applied to the value to convert to lux.

alright, I'll switch to processed and remove scale.

> For a light sensor, the conversion here is actually fairly straight
> forward. Almost all of them have to use the processed interface
> as they are horribly non linear.

:)

> >=20
> >>> + +	if (opt->mode =3D=3D OPT3001_CONFIGURATION_M_CONTINUOUS) +		retur=
n -EBUSY; + +	if (chan->type !=3D IIO_LIGHT) +
> >>> return -EINVAL; + +	mutex_lock(&opt->lock); + +	switch (mask) {
> >>=20
> >> is there no way to control the scale?
> >=20
> > yeah, but the HW does auto-scaling which works pretty well. Why would y=
ou want to control the scale manually ?
> On a slow device like this you probably wouldn't but for quicker devices
> the overhead of converting into a standard form in kernel might be
> excessive.

hehe, even when you _do_ set the scale, you still have the top 4 bits as
exponent, the difference is that you know what they are before the
conversion is done :-)

--=20
balbi

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT44+vAAoJEIaOsuA1yqREKjQP/3rYVGwo6BH8wxUg72tlLmPw
MHgu/GMCaigxcl1sv1WevUOzIGbZf8dSIKzfYiaZJm3yaJXiwORCt4fniHBpnF9d
mGNuDn/14tK19kpi8RWviwkOC5/8u3GneVaBmR3Ow8cBXE2MwQiH9RGaQd2lHqGF
njAKqJlCf795esvH/XvRV+wCY5fd2CkV6nC5H90lP7zHRLR6Qf+jipK42NvRqSAO
Fo64PcU3KjRm1J2J1tpE9XJWU2ItonVgPehQt2poe7BFkIYohxqOO3SDcL1pdEYp
+1Fvqgn+boZDO57FNPNEGlWrgNIvBqNGDmqkiKOwY2T2nwWy5kKF4wSXzGd1FiFC
LMxd0Asdd9ugqgiku53SaNSBYrN9atJpQHp0FLBey7yY6HQO0Bq9hBS7elRnTAZg
X2CGPJuAiaMGNPVVtdEcIvt22boTaVVOVs2CnNsJ649yD1FexxVscj78LP4fqTiP
s8PjcoIMLEQktp/u9F5tlYUbkoU22abxaMEOl/lBTAKTHFwT72a1krKS/vxAaDSm
xyqWVSUGZ+5gF9V0dA2ew3u98ZgdizkTIUBMNSlFUNaJirnBIDRcyK+m2PKVKHE1
dZWCTB3daxrAjXjUzte9nTxDpg7fw7TYHSMzd+gAKSraqkhdL+yjhQi9f0vmvCKe
xo8heLgcEnxDDcy1EUj3
=adpv
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
