Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51219 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbaHFWjR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Aug 2014 18:39:17 -0400
Date: Wed, 6 Aug 2014 17:38:42 -0500
From: Felipe Balbi <balbi@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Felipe Balbi <balbi@ti.com>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140806223842.GG3556@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408061815140.29646@pmeerw.net>
 <20140806214222.GB3556@saruman.home>
 <alpine.DEB.2.01.1408062347350.7595@pmeerw.net>
 <20140806221823.GE3556@saruman.home>
 <alpine.DEB.2.01.1408070021420.7595@pmeerw.net>
 <20140806223045.GF3556@saruman.home>
 <alpine.DEB.2.01.1408070032040.7595@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
In-Reply-To: <alpine.DEB.2.01.1408070032040.7595@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2014 at 12:35:11AM +0200, Peter Meerwald wrote:
>=20
> > > > ok... but then that brings up a doubt. What would I use triggered b=
uffer
> > > > for ? I already setup High/Low limits (thresholds) through
> > > > .write_event_value(). Isn't that, pretty much, a triggered buffer ?
> > >=20
> > > a triggered buffer reads data from the device and stores it into a bu=
ffer=20
> > > whenever the trigger goes off (you are interested to capture all samp=
les)
> >=20
> > Alright, so something like a contious capture starting after a GPIO goes
> > off, or something ?
>=20
> right, one capture whenever the GPIO becomes active typically
> =20
> > > events are created on certain conditions (you are not interested in a=
ll=20
> > > samples)
> >=20
> > And this would be more like e.g. "tell me once I have 100 lux or more" ?
>=20
> yes

cool thanks. I'll wait for some more review comments before sending a
new version. Latest is kept at [1]

[1] https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=3Dopt=
3001

--=20
balbi

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4q5yAAoJEIaOsuA1yqRE9mcP/R19HBACTff0MoNG3uyPIywR
OWu7QoGU1KhTWOEIJjZqZGQqroPFr0jLfgOUldJC1/zcNRvPk6WfJHzWekcMvCxq
NoVfbaz3zZpO1v+tfRmsjV9yxchopAjsWIxE2uyI14MIYujmxNYbXWxWhFvpMk5s
ln0YCm32jWo3Z7baS3rAnpVogpW5F1eD45KAvvBPMmwHU2vWsvLKyVdxhQ1kSU3m
WwpD1nUm3jGeKN323Hjq+i9DDfsvKK05ikxclMR9cJgb/dgZ2fm/eQ1bqkvu9N0j
Qez8SCa+LksRT4yd9BuF5I3acVR02KL2/IJ1oFsE1itdcJFUtWXv/lQ6xZwZD5i2
pJ/HrB1Sm0WoReU+xhbvjLOR6huCjfMjFnpQxR4QLhpDPw6OC/pCEIZve2vf0ezF
EjFxeJmfhS3tIag/X5fcB1rKytyopYzNScdiJgcHrElpcbAfBf+KDNe5ScF1sMaZ
Ym6RSug0lxz1lpDlVfYOxwOybnkfes69rPwgEq8v8ZEW14n9H8hqf4H6dggzEumP
DaDyiK021fUVT0Wry7SvZWqd6wOFIyxWtH7mfxlQtco5gyDGZK4m228LVvcBur8g
xXSuyNSGB+4eNJ4rEYGtOnbZW3NmXrHQbUF6QAIrQFCF5MEt6bCF5KF0iCxGtgc9
lj/UD7KRQEdna+GJo1a3
=L+NS
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
