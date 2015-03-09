Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38919 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbCIJZQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 05:25:16 -0400
Date: Mon, 9 Mar 2015 10:24:41 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 0/8] imx25 adc and touchscreen driver
Message-ID: <20150309092441.GC3632@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <54FB4249.6070801@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
In-Reply-To: <54FB4249.6070801@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 06:24:09PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > Hi,
> >=20
> > This series adds a driver for the Freescale i.MX25 SoC internal ADC uni=
t which
> > is used for touchscreen and ADC. The driver consists of three parts, th=
e MFD
> > driver which handles interrupts and some central configuration register=
s, the
> > ADC driver and the touchscreen driver.
> >=20
> > v7 has some modifications in the probe functions to use devres irq requ=
ests.
> > irq checks were fixed to check for irqs <=3D 0. The header was cleaned =
up to have
> > a more uniform presentation of the bit fields. Detailed changelogs are =
attached
> > to the according mails.
> >=20
> > Best Regards,
> >=20
> > Markus
> Almost there as far as I am concerned.  Just that one unbalanced regulato=
r_enable
> that needs dealing with.  The bindings are pretty simple so whilst a devi=
ce-tree
> ack would of course be great I guess it could be taken without.
>=20
> This wants to go via mfd or I suppose the freescale/arm-soc tree.  Either=
 is fine
> with me.

Thanks for your review. I will fix the missing parts.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/WbZAAoJEEpcgKtcEGQQZZMP/2U+HtuU0et/wosvOZ2YFd+K
pSDXn2zruTEVh1+LGZG4rD6MoQj6UnG29CTZiQDnC6UNPjp/SiXGexRsuMCJVWuz
hohqnf31zm4bmX6ZJlocxSb7jjldmk9P1nuOkzg/zF7sKI97JVG+s8ZIsH8r2BpM
IZodzn30nlpqLJZ0h5nq0+jug+4ie+n1RUXG95i9sHnkarLVBJ1OernmetyF6YcM
076e6RbzQp2jvXMUTFGz+wqUhYpIE27DY13fans/QgVe+GvN3Bo1hL1ik3BfgsiJ
VNPADOCfmKbVcPeqwVopCy0fByBPOJEkDp9q5I8mIpEt2cqSVLC23th0okHM52OV
EThSPB+cLRFC9TnjIQx+9EDDwDFKShC2C1VMwQxIpLxo+BlxE10NGcOBsw1DaLzU
fwsEIxhQIMJ+qLP+/+9J7AUOxt1ZA1RgGEpAgGtc4VGrFCPQo+VY7xPtWL+K2qFI
WLxfWyMz74kaYUOsAGZce4ewrvyP+a5swso6YrtCS2nFJQ32EYZnIoM36ov9VKTI
2rqY1+o2bJxc2PPVctneekL58Np7/bKaEXWmKu5D+60/dT1jQ7VSsHbJcOn4qktR
/h8xzHlHMtbJE/3q+BrhopFjC4S3F4nMjyqClKiUJJ2Xjf6Ja1GdjoiiCNgni+oi
eWvL+iHU/zms2zSOw0F+
=K/6l
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
