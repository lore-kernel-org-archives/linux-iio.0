Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 10 Feb 2012 23:45:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/4] staging:iio: Add missing event code extract macros
Message-ID: <20120210204531.GI4141@mwanda>
References: <1328897701-24032-1-git-send-email-lars@metafoo.de>
 <1328897701-24032-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
In-Reply-To: <1328897701-24032-3-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 07:15:00PM +0100, Lars-Peter Clausen wrote:
> Add macros for extracting whether the event is for a differential channel=
 and
> the second channel number from the event code. These were the only two fi=
elds
> which did not have such an macro yet.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/events.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 416800e..c25f0e3 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -97,7 +97,9 @@ enum iio_event_direction {
>  /* Event code number extraction depends on which type of event we have.
>   * Perhaps review this function in the future*/
>  #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> +#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) & 0xF=
FFF))
> =20
>  #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
> +#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
> =20

Breaks the build.

regards,
dan carpenter


--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNYHrAAoJEOnZkXI/YHqR2sQP/3ZGcA0zALSDqhhO1sLwkzOj
yKZDbqLfuYAY5hjjecpXPtBUf7p1WWRHN6Xf9soLnZvw7Gop4JnOn4OcOL0FMJkU
sF41UbcyafsQIXalOxgu4exAlQ+H4M1aCXkyqFmv0BMs+1ALx7GDlPKoqK616grP
zfN1rKHZ24CVtBvXYDtDjJx8RMJ20aoxM+rvISzxywIH8pU2CCQrQvWSbOLJw/MJ
LooDF1EGEOwbrspbXU8ScE5PrXRaMnIrQwbw/R2oZLLY3OedBLcJc3QZFZWCsAEU
0MlxOamqSVwSfz+M+ro4O5loLYaxR4/g/l2hBcghsSZyigykiBNt/EGca4+DC5Gt
epgWoL3lCPFVqeEf9zGAcnxa2jC3lAbnvBOl8rq2WoeuCT6i5P1XjlAriwMikthx
XY0ztfvNXOL9/mz3jc7/udAGHEdZj7dOA3ocrKla3hzm1P7uXWuTp7/f21h6qrlO
txLiqVTqCnJmwMCARC1SOJURqjOiF+C986aZEHYSjELPZWWUaQ4Is4kH/9a5f4xT
ecFy3sA++hOGM4DKD7wi8RtQSILew3KHvGA80Gsb8gGZFyxXUDcSVgjysKufbuQi
GCZlXvnpTzRUh7UyijRJl2C7JFFrNNpTXEBEG6z2r/Q2PlI+3qa2qSGkMmw8K8xX
BHv7+A0ScpHOuGIlitA8
=8diq
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
