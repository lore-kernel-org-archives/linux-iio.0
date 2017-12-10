Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:32963 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751994AbdLJUyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Dec 2017 15:54:03 -0500
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 3/7] iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
Date: Sun, 10 Dec 2017 21:53:42 +0100
Message-ID: <1575331.Q2WhDFQurN@pebbles>
In-Reply-To: <20171210172733.4adaae77@archlinux>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de> <ed9716c7-5e15-461a-985c-eea93257928c@rwthex-w2-a.rwth-ad.de> <20171210172733.4adaae77@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4136436.38GVs6lrAs";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart4136436.38GVs6lrAs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, December 10, 2017 6:27:33 PM CET Jonathan Cameron wrote:
> On Fri, 8 Dec 2017 18:41:48 +0100
>=20
> Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > Although the datasheet states the CNVR flag is cleared by reading the
> > BUS_VOLTAGE register, it is actually cleared by reading any of the
> > voltage/current/power registers.
> >=20
> > The behaviour has been confirmed by TI support:
> > http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p/647=
053
> > /2378282
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
>=20
> I haven't checked the code thoroughly so there may well be something
> stopping it but have you checked the case where the only channel enabled =
is
> the timestamp?
>=20
> Obviously it makes little sense, but IIRC there is nothing in the core
> preventing that happening.

The timestamp is completely unrelated to the status register, so I fail to=
=20
understand your question. Can you please clarify?

This only removes a redundant read.

All channel combinations (w/ and w/o timestamp) work, but combinations not=
=20
including the power register use less bus time now.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart4136436.38GVs6lrAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWi2e1gAKCRBvf0o9jP6q
U6OeAKC00YYdam7/YAzd+Jhql8HP4Jd9KgCgks/ZUaQq7h13JUVFA7w2dQRpo0c=
=L8tW
-----END PGP SIGNATURE-----

--nextPart4136436.38GVs6lrAs--
