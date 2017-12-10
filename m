Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:48664 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752111AbdLJUWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Dec 2017 15:22:20 -0500
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 0/7] iio: adc: ina2xx: Rework CNVR alignment, fix busy loops
Date: Sun, 10 Dec 2017 21:22:13 +0100
Message-ID: <3257961.18rt8HF3Lz@pebbles>
In-Reply-To: <20171210173654.0d6cb19a@archlinux>
References: <8e8ef11e-37df-44f3-b4a4-06e995924ca8@rwthex-w2-a.rwth-ad.de> <20171210173654.0d6cb19a@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3257961.e8zfvudUVr";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart3257961.e8zfvudUVr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, December 10, 2017 6:36:54 PM CET Jonathan Cameron wrote:
> On Fri, 8 Dec 2017 18:41:45 +0100
>=20
> Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > Currently, the INA2xx driver may end up causing 100% load on a single c=
ore
> > and fully loading the I2C bus, which is caused by two different issues:
> >=20
> > The code uses a udelay to bridge the gab between two subsequent samples.
> > As the sampling interval may be up to 16 seconds, the CPU is busy
> > waiting most of the time.
> >=20
> > The second issue manifests when using the (default) "synchronous" mode.
> > The code polls for a set conversion ready flag, but fails to align the
> > sampling interval to the raising flag. The polling interval is
> > (rightfully) slighly shorter than the sampling interval, so after some
> > samples the sampling thread is continously polling.
>=20
> I'm confused.  Would you mind doing an asci art example perhaps?

Lets assume the conversion interval is set to 2 ms. If the polling is done =
at=20
the sampling frequency, it might be slightly to long due to differences=20
between the host and device clocks, so the polling has to run somewhat fast=
er.=20
Somewhat faster means 200 us, this is kept unchanged.

In case the CNVR flag is not set, the status register is read again until t=
he=20
flag raises. The time instant the flag raises is the reference for later=20
reads.

The following shows the timing for the fixed code. Each character correspon=
ds=20
to 200us, first row: real time (ms), second row: conversion finished by=20
device, third row: register read
s: status, CNVR not set
S: status, CNVR set
S: value register, e.g. shunt voltage
_: bus busy (each reads needs 400 us @ 100 kBit/s)

__0____1____2____3____4____5____6____7____8____9
=2E..C.........C.........C.........C.........C....
=2E.s_S_V_.....S_V_......S_V_....s_S_V_......S_V_.

At 0 ms, the conversion has not yet finished, but a 0.4 it has. Further rea=
ds=20
are done at 0.4 + n * (2 - 0.2) ms. The next read happens at 2.2 ms, the th=
ird=20
should at 4.0, but happens slightly late at 4.2. The read at 5.8 gets an un=
set=20
CNVR flag, so the sampling is readjusted to happen at 6.2 + n' (2 - 0.2) ms.

The old code does the following:
__0____1____2____3____4____5____6____7____8____9
=2E..C.........C.........C.........C.........C....
=2E.s_S_V_...s_S_V_...s_s_S_V_.s_s_S_V_.s_s_s_S_V_

The first read happens at 0 ms, it measures the time for the reading (1.2 m=
s),=20
sleeps for the remainder (0.6 ms) and reads again. The third read takes 1.6=
,=20
so sleep for 0.2 ms.

The old code does not differentiate between time spent in the status poll a=
nd=20
time spent for reading. Time spent in the status poll should not be subtrac=
ted=20
from the delay until the next read (well, halfway, only the time spent with=
=20
the poll returning !CNVR).

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart3257961.e8zfvudUVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWi2XdQAKCRBvf0o9jP6q
U+1/AJ0XlM7XXLtsmowdxnkDbPCJ14wv4wCeIW6NwlQLw8CHiIzMpPvbJClkEZs=
=N7EC
-----END PGP SIGNATURE-----

--nextPart3257961.e8zfvudUVr--
