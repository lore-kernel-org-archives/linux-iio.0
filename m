Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:54627 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756160AbeEIJ5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 May 2018 05:57:54 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 902EE20DE8
        for <linux-iio@vger.kernel.org>; Wed,  9 May 2018 11:57:52 +0200 (CEST)
Subject: Re: [PATCH v3] iio: accell: mma8452: Reduce sleep time when data not
 ready
To: Richard Tresidder <rtresidd@electromag.com.au>,
        linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, harinath922@gmail.com
References: <4a845aca-600d-2473-9b66-51dea9d1651b@electromag.com.au>
 <5aad5eff-b0f4-4795-7c19-e177d415ed8b@electromag.com.au>
 <58db7210-1c84-3f5e-472d-8fae2b77bdd0@posteo.de>
 <8128071e-3b73-e0b1-eb2a-f1b245aea3e4@electromag.com.au>
 <939563a6-19ff-b51a-3a26-e90f10c7bae1@posteo.de>
 <cd307679-19c5-1132-79dc-b28c96cc537e@electromag.com.au>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <7dc844c6-8666-c381-e6fe-d70dfebf2eeb@posteo.de>
Date: Wed, 9 May 2018 11:57:49 +0200
MIME-Version: 1.0
In-Reply-To: <cd307679-19c5-1132-79dc-b28c96cc537e@electromag.com.au>
Content-Type: multipart/mixed;
 boundary="------------FBD7E6CA0BF9695B465ADF3E"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------FBD7E6CA0BF9695B465ADF3E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-08 10:19, Richard Tresidder wrote:
> Modified the sleep method when data is not ready to allow for sampling =
> 50sps to work.
>=20
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
> v3: Changes from v2
>   * Removed fallthrough fix (will submit separately)
>   * Fixed some blank lines, trailing white spaces.
>=20
> v2: Changes from v1
>   * Remove whitespace changes
>   * Added fallthrough fix (subsequently removed)
>=20
> drivers/iio/accel/mma8452.c | 23 ++++++++++++++++++++++-
> 1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7a2da7f..5650b59 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -106,6 +106,7 @@ struct mma8452_data {
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
> +	int sleep_val;
>  };
> =20
>   /**
> @@ -193,7 +194,10 @@ static int mma8452_drdy(struct mma8452_data *data)=

>  		if ((ret & MMA8452_STATUS_DRDY) =3D=3D MMA8452_STATUS_DRDY)
>  			return 0;
> =20
> -		msleep(20);
> +		if (data->sleep_val <=3D 20)
> +			usleep_range(data->sleep_val * 250, data->sleep_val * 500);

line over 80 chars. please use 2 lines.

Also, have you run checkpatch on this? You seem to have DOS line-endlings=
=2E

> +		else
> +			msleep(20);
>  	}
> =20
>  	dev_err(&data->client->dev, "data not ready\n");
> @@ -544,6 +548,18 @@ static int mma8452_read_raw(struct iio_dev *indio_=
dev,
>  	return -EINVAL;
>  }
> =20
> +static int mma8452_calculate_sleep(struct mma8452_data *data)
> +{
> +	int ret, i =3D mma8452_get_odr_index(data);
> +
> +	if (mma8452_samp_freq[i][0] > 0)
> +		ret =3D 1000 / mma8452_samp_freq[i][0];
> +	else
> +		ret =3D 1000;
> +
> +	return ret =3D=3D 0 ? 1 : ret;
> +}
> +
>  static int mma8452_standby(struct mma8452_data *data)
>  {
>  	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> @@ -700,6 +716,8 @@ static int mma8452_write_raw(struct iio_dev *indio_=
dev,
>  		data->ctrl_reg1 &=3D ~MMA8452_CTRL_DR_MASK;
>  		data->ctrl_reg1 |=3D i << MMA8452_CTRL_DR_SHIFT;
> =20
> +		data->sleep_val =3D mma8452_calculate_sleep(data);
> +
>  		ret =3D mma8452_change_config(data, MMA8452_CTRL_REG1,
>  					    data->ctrl_reg1);
>  		break;
> @@ -1593,6 +1611,9 @@ static int mma8452_probe(struct i2c_client *clien=
t,
> =20
>  	data->ctrl_reg1 =3D MMA8452_CTRL_ACTIVE |
>  			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> +
> +	data->sleep_val =3D mma8452_calculate_sleep(data);
> +
>  	ret =3D i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
>  					data->ctrl_reg1);
>  	if (ret < 0)
>=20


--------------FBD7E6CA0BF9695B465ADF3E
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

--------------FBD7E6CA0BF9695B465ADF3E--
