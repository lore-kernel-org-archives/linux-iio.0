Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60021 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758930AbcILOgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 10:36:01 -0400
Date: Mon, 12 Sep 2016 16:35:48 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160912143548.GL9449@lukather>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
 <20160912100719.GJ9449@lukather>
 <20160912104932.GF1873@dell>
 <c322d309-993c-a572-5ffd-bf4012e26134@free-electrons.com>
 <20160912135655.GC9789@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
In-Reply-To: <20160912135655.GC9789@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2016 at 02:56:55PM +0100, Lee Jones wrote:
> > >>> Then use .data =3D <defined model ID> and set up a switch() in .pro=
be().
> > >>
> > >> Uh? Why? It just adds a non-standard indirection, while using
> > >> of_match_device is very standard, and used extensively in Linux.
> > >=20
> > > You still use of_match_device() to obtain the ID.
> > >=20
> > > The "don't mix DT with the MFD API" is there to prevent some of the
> > > nasty hacks I've seen previously.  This particular example doesn't
> > > seem so bad, but it's a gateway to ridiculous hackery!
> >=20
> > How am I supposed to get the .data without of_match_node then?
> > What's more hackish in using .data field for specific data for each
> > compatible than in using a random ID in .data and switching on it? The
> > result is exactly the same, the switching case being more verbose and
> > adding complexity to something that can be done in a straightforward ma=
nner.
>=20
> I've already agreed that your implementation isn't terrible, but I'd
> still like to remain strict on the rules.
>=20
> Better still, can you can dynamically test which platform you're on,
> via a version register or similar?
>=20
> Failing that, see how everyone else does it:
>=20
>  `git grep "\.data" -- drivers/mfd/`

Just to make sure, you prefer something like

static struct my_struct data =3D {
};

static struct my_struct data2 =3D {
};

struct of_device_id matches[] =3D {
       { compatible =3D "...", data =3D <ID> },
       { compatible =3D "...", data =3D <ID2> },
};

of_id =3D of_match_device (dev, matches);
switch (of_id->data) {
case <ID>:
     function(data);
case <ID2>:
     function(data2);
};

over

static struct my_struct data =3D {
};

static struct my_struct data2 =3D {
};

struct of_device_id matches[] =3D {
       { compatible =3D "...", data =3D data },
       { compatible =3D "...", data =3D data2 },
};

of_id =3D of_match_device (dev, matches);
function(of_id->data);

?

This is the *only* time this is going to be used in that driver. I can
understand the need for a version if you need to apply quirks in
several functions, but here it clearly looks suboptimal.

And we are indeed using this construct in the AXP MFD, and it just
doesn't scale either and become quite difficult to maintain when you
have a significant number of variants, and then you have to patch
*all* the switch instances to get something done.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1r1EAAoJEBx+YmzsjxAgdLYP/21n1rPrX3+lhqWapdmAjKnG
TbN6FtgzwFDcdSgPHwYnEVIS53sAZNhgJQMW1KSopw/7kOsy7JYI1pdCUY7RFrcu
yET+YSjzYVdnvGhUtECuO7A5rCAEwK/q7jRrQhugxULGDsRqHzAMSpoKfDnn9o3g
9KNSK5c8BpUbBvSIYG+wJKzKDmJU3x8yMfzufd6soAqF7yNEZfmpD4RjB0Jl5xOI
AW1L5ofJzZh7vaJXAS4+na1fHPF5s7iyNZvMgPk9IXKYXtItlYQfa54E+2RznYx2
WQ+W2O/uiVrB2zceGimgdmRBvRNxiDZGGJ1MUfiSKlY+YDdxn3tJCEyv2dIx1sTj
uHyVqRUy/+TSBrBeKGlc+4JN46plMfJQ3WgwsJBUlE+Z7dcOzNQ/vTgeiFlYe8EN
DT5VSecpsE+1AgMyUUUmqLKQ+MV4GzJLWPVwmGCLmA82YwJPdlSUWraysEGhHdqI
mzHPxPk9zB8f3J/NWIQDuGxVA1BDol9NdbbyndFjK8P4+1qRLdrfxaj3nQxnl6VF
UzmdcZh4WkScXEKFr7aO62jkSzAidmV4gMFQasVNKVxWq7REmIM4UWWqaDGB3ZXL
tXsXNA7WDRbTpuDMoc/SOjTgxwxSxaNXqR40tN/loXGlKJBqollsKoYcExe6SdSk
CxacdnGFibhV9UL7tQtf
=iCsx
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
