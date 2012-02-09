Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Thu, 9 Feb 2012 19:15:10 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	linus.walleij@linaro.org, maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20120209191509.GM3058@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-2-git-send-email-jic23@kernel.org>
 <20120209181056.GA957@kroah.com>
 <4F3411BA.5070401@kernel.org>
 <20120209185754.GA10284@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="75WsOQSofUOhcSOp"
In-Reply-To: <20120209185754.GA10284@kroah.com>
List-ID: <linux-iio@vger.kernel.org>


--75WsOQSofUOhcSOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2012 at 10:57:54AM -0800, Greg KH wrote:

> So, would the "keep looping until all dependancies are met" patches from
> Grant that have been floating around for a while, solve this issue?
> Modules would properly initialize only when the needed other bits are
> present, which solves the problems the regulators and other drivers have
> today.

> If so, then I suggest we get that code into the tree soon, and then all
> of this "wierd" logic would go away, right?

Could you identify the logic you're talking about here?  Looking at the
last patch set I can find[1] this all looks very vanilla for this sort of
subsystem?  You've got a mapping mechanism and a get function but that's
about it which is all pretty normal.  Grant's changes make module
probing nicer in that you don't need to worry about the order in which
things get registered but I can't see anything here which is
particularly related to that ordering.

All the code is doing is providing a mechanism for drivers that need IIO
facilities to locate the thing that's providing their IIO facilities
(which is in the general case going to be board specific on a totally
unrelated chip in a different part of the system and discovered through
reading the schematic) without requiring custom code in every single
single IIO using device to do the mapping.  Instead the boards use a
standard subsystem facility to tell the IIO core what's wired where and
then the core matches things up for them.

This is nothing to do with init ordering, it's all about the two devices
finding each other at all.

[1] http://article.gmane.org/gmane.linux.kernel.iio/3287

--75WsOQSofUOhcSOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNBsfAAoJEBus8iNuMP3dO/oP/2sDm0kcVUEch3ggd6CCG3jv
lIREs6qmhqzuDpL/ZiQx3PSaui2tewSOlqaCuD6gdDgDXHjX1BTUYL7xsRaCQvLW
Y1S/I72i+hPF+yWK7iroiv1D+rKkR8/t2K1LxaazElgk0g+CkE6UTb59viTW643P
0vVc5rQ+iKSYLufJrXA4dI+Fb6NPNj2cc1BNw4rdwmDHnckvvGEYcqIkS+C+iSOx
ySgO57mg0FxXHIObHX8ZHGWUlmQHJzpVKYVXZDYG+SJR+6KmMU3VYWhU3cSZu3fm
Fok6Ze4bjqKrANu7ZdYhmuuw9LufMQwp2JMFxYQUQtn+LkxpZ5SgZwD6xNZ6IaXE
Y8GxdpvrzvEWhOMNDpP3OFRJnsMdc4gqLyWSFl2ErspfXa9lbEZ74+rK1ddBBhE6
a1r1kaldgNdk6Tjar8Rxy9CHh+W0UobjeS4Cm8MOraQou0hWtYnfv/RcwInfpGjZ
xIxaBhOo+rlBSMA31B6DbTrGqHDZ4mfNetdaGSG2XFPkwXgzYbbvX2ru5QYqz1hS
TKVK7YqiifuVtpOH0XcGCvHc5Bu/uWZR/Gy8aGqvbVD8c8SWlku/ZwNylvgLqJd3
otLM+TqnU44hWkO51SKLPpPsHThpho/Hvvlik8ReJ4CRPsHFoInyDZL15WY9w7YY
LrhRkaMhmbtFVvsykPXQ
=pOeY
-----END PGP SIGNATURE-----

--75WsOQSofUOhcSOp--
