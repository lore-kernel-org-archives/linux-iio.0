Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:2526 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751097AbdKYWF2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Nov 2017 17:05:28 -0500
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Maciej Purski <m.purski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 2/3] iio: adc: ina2xx: Use LSB specifier instead of divider in config
Date: Sat, 25 Nov 2017 23:05:20 +0100
Message-ID: <10724508.HbtmiQSdq3@pebbles>
In-Reply-To: <20171119161503.4f7bbbdd@archlinux>
References: <20171028211249.24148-1-stefan.bruens@rwth-aachen.de> <b1ed2d5d-f548-4d88-b563-58a86008e661@rwthex-w2-a.rwth-ad.de> <20171119161503.4f7bbbdd@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21598568.FYJ4GB4bDr";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart21598568.FYJ4GB4bDr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, November 19, 2017 5:15:03 PM CET Jonathan Cameron wrote:
> On Sat, 28 Oct 2017 23:12:47 +0200
>=20
> Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > While the config uses the physical value corresponding to the LSB
> > for both the power and the bus voltage register, the shunt voltage is
> > specified as parts of 1 mV. Use the LSB physical value for all register=
s.
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
>=20
> Applied

Hi Maciej,

I think you will have to rebase you calibration register patch on top of th=
is=20
series ...

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart21598568.FYJ4GB4bDr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWhnpIAAKCRBvf0o9jP6q
U61SAJ4h3xBC4QPQY2hUlSDcxE0l/BjDbQCdH7AQ9RsNCpBuGmYVtait/CqWMjc=
=sndb
-----END PGP SIGNATURE-----

--nextPart21598568.FYJ4GB4bDr--
