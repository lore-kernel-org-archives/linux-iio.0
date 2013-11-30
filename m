Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45952 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751684Ab3K3NkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 08:40:03 -0500
Date: Sat, 30 Nov 2013 14:37:13 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Brian Lilly <brian@crystalfontz.com>,
	linux-iio@vger.kernel.org, Brent-Crosby <brent@crystalfontz.com>,
	Jim Wall <jimwall@q.com>,
	Hector Palacios <hector.palacios@digi.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and 9
Message-ID: <20131130133713.GA3002@lukather>
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com>
 <5299D6E6.2080100@kernel.org>
 <5299D7D1.3050801@kernel.org>
 <CAHXqBF++HsFLG84vQjWeb=QmgE4yjJqYEj_zLS34m2WMDJ2CRA@mail.gmail.com>
 <5299D9B7.3090404@kernel.org>
 <5299DA42.2030508@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <5299DA42.2030508@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 12:29:54PM +0000, Jonathan Cameron wrote:
> On 11/30/13 12:27, Jonathan Cameron wrote:
> > On 11/30/13 12:24, Micha=C5=82 Miros=C5=82aw wrote:
> >> 2013/11/30 Jonathan Cameron <jic23@kernel.org>:
> >>> On 11/30/13 12:15, Jonathan Cameron wrote:
> >>>> On 11/19/13 10:36, Maxime Ripard wrote:
> >>>>> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>>>>
> >>>>> The mxs LRADC is able to read an internal die temperature sensor. T=
he
> >>>>> temperature has to be calculated from the value read on channel 8 a=
nd channel 9.
> >>>>> To be able to expose the result to hwmon, implement iio channel 8 as
> >>>>> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
> >>>>> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through t=
he in kernel
> >>>>> provider/consumer mechanism.
> >>>>>
> >>>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.=
com>
> >>>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>>>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> >>>> As this is still in staging, I think we can get away with the result=
ing
> >>>> ABI change from this patch.
> >>>>
> >>>> Applied to the togreg branch of iio.git
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan
> >>> Having said that, there is an odd bit inline that I've just dropped w=
hilst
> >>> applying the patch.  Shout if I've done this wrong.
> Given issues below and the substantial changes that have occured in this =
driver, could
> your please rebase it and repost.

I will.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSmeoJAAoJEBx+YmzsjxAgcp0QAIdXizIVWnZIfJnMN/0DFjsT
xvFQJ5lPBWuRuWp67ZWX8hoUhb1z0+RU++1rfOk31TqXon1MPd0FXbQp3Mae+uxx
OFp6H1N+hhjXAUYBj5oCxcdA7N9AfWF2dioRcoPZBnbNzlRBLvaKzV7yYjEj24ET
4o1prG+87lfyPJgNl6CirXXUSY4NWXwnTTyj0W9IGjbmWZjM+KsntZA5kvzjEGAN
pmXemx4C24H2YSV5O1gz1I2uqeKpDQsmqmRjWinHsGL9QoGOaOBzbiDWBtkiPuao
YeB4T1SmKTyHXkqRaZYoLKK1WtgNI3xfhFMgE8HnvG7wyoaEhL0qGUGWnUBT0DTA
q5Eah/nCNI6pKJwPe0ucU5S4AOGnWWGXg9BtVWi+fn5Gav0GxzCR5a2tgKCVWLAA
kZ2Bk3l7yz74+DYHoH5+gp3K0CRmMJAx88DKzBvKLGmP4S8XtmYg8Hb3GflodJvL
OC8Shad69DFSk6f/7+FWqW9ehXuRNvfUKZ7i/CTd5KV0z8IuzHJV+nua+l8QWVUY
By0YTGykHIxR8RyyODttQ38bQKmS9+0N9eUqIWQ4setgIzfReXmtzbZm/jEorEfY
VoOjDwd9a8FwSgtAQxGlBPw8lIO27MpXox+dfntZaoYDz1IIyHzHiE2E9a5aJYlD
pO7gIWyU/wxqjNZnnOTw
=QcH0
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
