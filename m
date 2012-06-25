Return-Path: <jic23@kernel.org>
Message-ID: <4FE8CB6A.6050000@kernel.org>
Date: Mon, 25 Jun 2012 21:34:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 5/7] iio staging: fix warning 'static but used in inline
 function'
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 06/25/2012 08:11 PM, Peter Meerwald wrote:
> iio_utils.h:367:10: warning: =E2=80=98iioutils_break_up_name=E2=80=99 i=
s static but used in inline function =E2=80=98build_channel_array=E2=80=99=
 which is not static [enabled by default]
>=20
oops.  curriously don't get that warning myself. Ah well.
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/st=
aging/iio/Documentation/iio_utils.h
> index d9439f8..9c7a5aa 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -27,7 +27,7 @@ const char *iio_dir =3D "/sys/bus/iio/devices/";
>   * @full_name: the full channel name
>   * @generic_name: the output generic channel name
>   **/
> -static int iioutils_break_up_name(const char *full_name,
> +inline int iioutils_break_up_name(const char *full_name,
>  				  char **generic_name)
>  {
>  	char *current;
>=20
