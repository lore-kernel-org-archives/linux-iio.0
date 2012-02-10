Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 10 Feb 2012 23:44:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/4] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to
 IIO_EVENT_CODE_EXTRACT_CHAN
Message-ID: <20120210204452.GH4141@mwanda>
References: <1328897701-24032-1-git-send-email-lars@metafoo.de>
 <1328897701-24032-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
In-Reply-To: <1328897701-24032-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 07:14:59PM +0100, Lars-Peter Clausen wrote:
> We call this field "chan" throughout IIO with the exception of this one m=
acro.
> Rename it to be more consistent.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/events.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index bfb6340..416800e 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -96,7 +96,7 @@ enum iio_event_direction {
> =20
>  /* Event code number extraction depends on which type of event we have.
>   * Perhaps review this function in the future*/
> -#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
> +#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> =20
>  #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
> =20

Uh...  What?  This breaks the build.

regards,
dan carpenter


--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNYHEAAoJEOnZkXI/YHqRr5IP/0S5ejWpBc9i48yYWyRydxug
FpiEZGIXkvKVqinmAfMSzDRhD/OPlmrnfHw4OkDpAgzokrT0VLjf6/tLS9fNrolA
xmom6uNRlY7WnqwK2mSYdt8u/jJ1PNLw89fitX5ZS2WsgwKNvGhxLN63hwxgr+To
/T3TrDhyOyMWiiND7kq7UDXo4Vm0orpoevvWglqYSMlbVntWKyDVGWMaKf3MIj5c
jXrwisQwzgZLQYMGQQG0DAsOlMI5ruIM8AOAuyHIaFfL193HW8XughRIv02RJigz
Hhe9g3oALly7TCD8BC3uj6C05EqvA4BkVdAhzrp+CuuVxqIqPgQHBkyLOcrLGAnE
p98RX6kTFDSTLdtgeK05x6T5j0Xz6j+MGHJmp31Z30d5A9txBEWMR8P3+BGbet/l
7W5/Zte21mJBiAXb5tFK+pIwRuukxtbmLKOV4/jyZetiwcxmTMU+rRMCqxL+FFFN
bUY4Yb/MFy17rdiXRqeonvSmfYdbb1g0nB9uc0XlZNizxK1r9J5OgllNqmv/i/fx
aRc/PKTDMCInFW0XitM2XGX5bnJG3MasnqhZhaAisUgtj7zFAwiPUWlley55XN0G
oM3mS5lHsi97ROs2dzUPHb22ExQnQOoT+43eB4S6ZMgRLRjewtukNJrwsSW/ALjI
AKsoPk8+Z798IT27ks79
=Bke1
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
