Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:60045 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754406AbeFTJQA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Jun 2018 05:16:00 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 2A0C62115E
        for <linux-iio@vger.kernel.org>; Wed, 20 Jun 2018 11:15:58 +0200 (CEST)
Subject: Re: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
To: Leonard Crestez <leonard.crestez@nxp.com>,
        Harinath Nampally <harinath922@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
Date: Wed, 20 Jun 2018 11:15:53 +0200
MIME-Version: 1.0
In-Reply-To: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
Content-Type: multipart/mixed;
 boundary="------------D2EA9B289B1D020A999BAE92"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------D2EA9B289B1D020A999BAE92
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-07 20:52, Leonard Crestez wrote:
> Interrupts are ignored if no event bit is set in the status status
> register and this breaks the buffer interface. No data is shown when
> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
> crazy.
>=20
> Fix by not returning IRQ_NONE if DRDY is set.
>=20
> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
> multiple events")
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

At least this does no harm to events. So if this solves your problem:

Acked-by: Martin Kepplinger <martink@posteo.de>

thanks,

                            martin

>=20
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Perhaps this whole early-exit check could be dropped? It is not clear
> how it helps.
>=20
> If for some models we want to ignore unsupported events then maybe this=

> should be checked for each individual bit. Instead of
>=20
> if (src & MMA8452_INT_FF_MT) {
>=20
> Check for:
>=20
> if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA=
8452_INT_FF_MT))
>=20
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7a2da7f9d4dc..5485b35fe553 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, v=
oid *p)
> =20
>  	src =3D i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>  	if (src < 0)
>  		return IRQ_NONE;
> =20
> -	if (!(src & data->chip_info->enabled_events))
> +	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
>  		return IRQ_NONE;
> =20
>  	if (src & MMA8452_INT_DRDY) {
>  		iio_trigger_poll_chained(indio_dev->trig);
>  		ret =3D IRQ_HANDLED;
>=20


--------------D2EA9B289B1D020A999BAE92
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFrystwBCADHbgV1brDLZDyFVnYzlhd1sI3eDgWQMuCV8CFnKM4+VK8dK3T7
IuA56+xW5cLsNNhpsCHgyl1/hoZFStaEt2aOSeUoNwlxLhBX3zS6KMk6R1cpsq+L
TgnoU+yFez2yh0RlZcOI0cYCEPG9FyolrQ1Xmx12mUDP62G+EEM+7ln+3J9e/QWo
ubdygiiSBsvHp7kQuHt09FdS74ey+dUghtczIJChH1BNgko7WDooXHBcrwj5rG4j
OHetOm6DZfuNtAlYI/XQsjerZtvimT+OLoBLHZ2POITHXhNLnsYQvducqeMbLW6G
H6FVaHjAMmE2vYL+Gsk+0X1so7Hft3AiFcuLABEBAAG0JU1hcnRpbiBLZXBwbGlu
Z2VyIDxtYXJ0aW5rQHBvc3Rlby5kZT6JAVQEEwEIAD4WIQS0F76hydj1GXEYJVOh
2YOPZcMl0AUCWvKy3QIbAwUJAeEzgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAK
CRCh2YOPZcMl0AGVB/sHTB8m5D/YIqVQ1cDsUFu9jqNbsxxvPN5UNA7u3/FrQI2y
fvOxxIdrKWbZUhMzbjhlZWXYyPhzDIShyusbIG9eBUxcabVFXHN2UwfoGyBT5htN
bNoLBi1LV9a22IF3sowJRC7tjVs2AFnUyC2IAX8qX8w4kwB2a2nn7LRrEWq2cBbd
+dlIcKROVkFpqBpxO3Echx8MnspYDZOmLrSzxJ2yjQjUHENrVtUzVOyjfUjmr42Q
Fa9+8pMg2fuoW0rUe8s1PdxsyQJGBIB7uPVeRfhb5VQd9TNNcp1VTTid0F+UbcJz
YISYUhVr6p6KyP3lO6TB2qm03DOks7lvAqmShBV0uQENBFrystwBCAC5FF+kLz9O
329d32O5jKeddYNHOljPjCQtA7irZPYgYT0pfgx8NM9FhVACiV3s1s0PYBe6kP7p
s4SxKN06Xo5SSXmTNuSWIAOY2iGnZueEB9PRXPDiz3+Nqk/z2QbOcDLzSutxoNUe
p2Zxu4bvK8ieAk0/H9ZlYCGfw7fC4v+yiqD4mWVWiYEwiDIbV08eRYo5DyGzT+oY
aVP66NI9DtxXRGDK5Fa9HfjQj3dm29ehr640CowF/aGpsdiIdzQ1BDtjY5odaw8a
FBhSNUg/53GVi0qOeiq3+z8l7WzesTtTRQXsKkLfm+D35gg4PMs8L1pXnKAHuok4
pgeDZ4VFlX1BABEBAAGJATwEGAEIACYWIQS0F76hydj1GXEYJVOh2YOPZcMl0AUC
WvKy3AIbDAUJAeEzgAAKCRCh2YOPZcMl0ML9B/9eZI8Og2+jvIgDwSXApL/7Vscl
rz/QB/JW3uCmNeud2Y4022kaYSgiMnuR0ceg47JMHxl2I6Rye2pjI7nVV2Ia1nbM
ycNnxpSGgFKkN6y6zqlt7ms8MO9Ph09DnLHJRbHDJI7l7MP1k7Ri7NzRZmVkh6ES
y+yd6AQbINujvDw16wIIDoL7cmM+kyCBPKhH2iPiknLTaaC0UTGs22e4xhr7WOku
T0pnuoPe4Dn2lFsbkP7LDOfSgij5AlcH6dyOAjv7yXJFXYmomI2JTh9PbgvAG9j0
KnKObElXGxN2dqd3z11N0u0NXL5izbmTBtZB+F6Fk1PVdu8bnImM6Wwa7io8
=3D55tu
-----END PGP PUBLIC KEY BLOCK-----

--------------D2EA9B289B1D020A999BAE92--
