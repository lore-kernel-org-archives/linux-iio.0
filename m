Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeJMUVe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Oct 2018 16:21:34 -0400
Date: Sat, 13 Oct 2018 13:44:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ina2xx: fix missing break statement
Message-ID: <20181013134429.1f450ba7@archlinux>
In-Reply-To: <1884341.stJYpOWv9L@pebbles>
References: <20181008210904.9362-1-colin.king@canonical.com>
        <1884341.stJYpOWv9L@pebbles>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Oct 2018 12:42:39 +0200
Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de> wrote:

> On Montag, 8. Oktober 2018 23:09:04 CEST Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > The IIO_CHAN_INFO_SCALE case is missing a break statement and in
> > the unlikely event that chan->address is not matched in the nested
> > switch statement then the code falls through to the following
> > IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
> > break.   While we are fixing this, it's probably a good idea to
> > add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
> > too (this is a moot point).
> >=20
> > Detected by CoverityScan, CID#1462408 ("Missing break in switch") =20
>=20
> Although it is good for code clarity to add a break statement, the code c=
an=20
> never return anything but -EINVAL in case chan->address is not handled in=
=20
> IIO_CHAN_INFO_SCALE:
>=20
> -----
> switch (mask) {
> case IIO_CHAN_INFO_SCALE:
>    switch (chan->address) {
>        case INA2XX_SHUNT_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>       =20
>        case INA2XX_BUS_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>=20
>        case INA2XX_CURRENT:
>        ... return IIO_VAL_FRACTIONAL;
>=20
>        case INA2XX_POWER:
>        ... return IIO_VAL_FRACTIONAL;
>    }
>=20
> case IIO_CHAN_INFO_HARDWAREGAIN:
>    switch (chan->address) {
>        case INA2XX_SHUNT_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>       =20
>        case INA2XX_BUS_VOLTAGE:
>        ... return IIO_VAL_INT;
>    }
> }
> return -EINVAL;
> -----
>=20
> The addresses handled in INFO_HARDWAREGAIN is a subset of the ones in=20
> INFO_SCALE.
>=20
> I would prefer an early "return -EINVAL" here, as it matches better with =
the=20
> other "switch (mask)" cases above.
>=20
> Kind regards,
>=20
> Stefan

I agree with Stefan on this.  It is more in keeping with the local
style to use a direct return.

Colin, would you mind doing a v2 with that approach?

If not I'll get to it at somepoint if no one else does, but it may
take some time!

Please also change the title to make it clear that this is beyond unlikely
as I think it is impossible (without a gross bug somewhere else).
This is worthwhile as an improvement to code clarity and false warning
suppression, but it's not a fix I want to be pushed back to ancient kernels
as in that circumstance it's really just noise.

Jonathan

>=20
