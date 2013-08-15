Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44182 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758719Ab3HOTUq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2013 15:20:46 -0400
Date: Thu, 15 Aug 2013 21:20:44 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130815192044.GD12162@lukather>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
In-Reply-To: <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
> For at91 boards, there are different IPs for adc. Different IPs has
> different STARTUP & PRESCAL mask in ADC_MR.
>=20
> This patch introduce the multiple compatible string for those
> different IPs.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Overall it looks like the right ways, but I think we can take it a step
further.

I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
atmel,adc-status-register, atmel,adc-trigger-register properties (and
probably the triggers as well description as well).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDSoMAAoJEBx+YmzsjxAgHAEP+wapzwMALs2vhupXStJd7kEG
TQdrtDEf3Y8Bw9qhJk9/3Hk3+bumVqH/3inS8ekM8Nmxm+6a52T8gI18vsg9HpIR
xbrQxd8eDZoLvwIGPAkt5Uut79qydK2yAiDtsC4ONRDdxloi44kFCf9YqTF3hIc9
3tCqEITkbo9hRcBWh+B9+Qo7DejFlUhWN4prxzlfNO7aPs4D7wC/dZT/B8MhCKQN
OSILnqmV6ugS8asIjofo4SHTI8LYsiCdVvDMjXkB9N5VeZzgBgnWj8C/qRSMSx9O
E13nsx7NSw30Erc/cUa6xDBRiuaDQPx38rsN66yJstGP79PnrqhPyHlvktzLZors
0vtakHcBjy/UfqWStUDJvTbef17napFS3h/jM4ce9nU9CPqS6wDuEY/vDuq+akjD
XtamNPH3F8GFauQL5+tgGtCHc6fWCp6EXBResrXgC42BCCJB2WCwNE+0rAgMT9jO
kEEdCMr3vdH5nEga2pcRubaxr3TA6pBjyW0Dw/39cyYgOnG2TreQ4bO0sxMVdDWW
6x/ix0V15cSMj13FUwPbevsYNfByCpDbRTiNrnl95Sc2YFE/PumtI6DE72SjNFi3
SHRNSKvfvPg5PpFt2qk2aaKDn/kXd0V+7oYhT5/UPI9mBt1a4PJuYPKnGKiTgITQ
63NTydiJwgzaIUguaveH
=5eUG
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
