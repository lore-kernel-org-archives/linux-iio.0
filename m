Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56980 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdIRI1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 04:27:15 -0400
Date: Mon, 18 Sep 2017 10:27:03 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 6/6] ARM: sun8i: h3: add partial CPU thermal zone
Message-ID: <20170918082703.riqntqilakzhirc5@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-7-icenowy@aosc.io>
 <b41a80ec-23d5-a614-f6cc-d09c5a459e03@free-electrons.com>
 <20170916151734.10968b7a@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dmmblfkwzntjwbo4"
In-Reply-To: <20170916151734.10968b7a@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--dmmblfkwzntjwbo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Sep 16, 2017 at 03:17:34PM -0700, Jonathan Cameron wrote:
> On Sat, 16 Sep 2017 12:05:49 +0200
> Quentin Schulz <quentin.schulz@free-electrons.com> wrote:
>=20
> > Hi Icenowy,
> >=20
> > On 14/09/2017 16:52, Icenowy Zheng wrote:
> > > Because of the restriction of the OF thermal framework, the thermal
> > > sensor will fail to probe if the thermal zone doesn't exist.
> > >  =20
> >=20
> > Oh no, that's not good.
> >=20
> > We discussed about it on IRC and I even proposed a patch for it, telling
> > you I would post it on the mailing list soon after. Of course, I forgot
> > and you definitely should have yelled at me for not doing it :)
> >=20
> > I won't be able to test the patch soon. I can send it to you so that you
> > can test it and integrate it in your patch series so it won't block you.
> > Otherwise, we'll have to wait for a week or two for me to test it.
> >=20
> > Thanks and sorry for forgetting to post the patch you need,
> > Quentin
>=20
> Other this outstanding issue I'm happy with the series, so hopefully
> with Quentin's patch added we should be good to merge this one.

We will at least need a v5.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--dmmblfkwzntjwbo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv4NXAAoJEBx+YmzsjxAgxUoQAL0Jvttq1BAdMC3f8pAjJd6F
CHZnGeuAMQCk2PQ5gupmtR7FeoNhCWUcmGJd0NrvrCqUUVy+LHJBWrB2uReDeQVt
4+JFdPBecFJ87raaa/WXVjnmn0PGuMcZrqssEV1U/USdJM7lOJUSWUycE15zxOvc
3HF2y1sRrzbafQkjLDihSRHzut4pkW09/vyhpxIIbY+KY9rWl3ccQ1Js1VIwLEND
NK3h9xV3Twc9gaKUupCIorxm5HWh6aUMJKZGdM0po//040qNqFGsbTLAzUy3UA6d
bDPvHCSIsfHUlaMMbnUMikevkTfS2yGh6sJemy9S7/F2UrOOiFXMG5Pj+5DHiEPR
lgz4QsrNVKeauipRYUh8Io+Ne000qyIWumqV8vb69j5qF3c1cmzLTsHbsB+vOzDl
65WTaG5m2/BpA4Z/+jNvyUt2o3uHU2uoa0CQqPlS5cQewx/6A1JVg9YzM3+HUoqi
EVmEDq5YPNnXSKx1KLUQYKWxA3SGMPmTHbXWGi6w293q2GGjx/tUUpFwMNWEes6H
RP1+moiqrbOHpAZUxtniGL1AyG0eEaL3FDvaC/OgIGOYUjw4L7rMzlhCg7R6My5W
crfnrYtl9MaSD/rMVr6ItFgcykwlMSGxQrBXr7YGT8ZZTlFrM95wV7Lc8NW5kSkM
B+HLkyuRcWsJdf+gSLqo
=so2S
-----END PGP SIGNATURE-----

--dmmblfkwzntjwbo4--
