Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 10 Feb 2012 10:30:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to
 IIO_EVENT_CODE_EXTRACT_CHAN
Message-ID: <20120210183033.GA18845@kroah.com>
References: <1328897701-24032-1-git-send-email-lars@metafoo.de>
 <1328897701-24032-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1328897701-24032-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Feb 10, 2012 at 07:14:59PM +0100, Lars-Peter Clausen wrote:
> We call this field "chan" throughout IIO with the exception of this one=
 macro.
> Rename it to be more consistent.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/events.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.=
h
> index bfb6340..416800e 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -96,7 +96,7 @@ enum iio_event_direction {
> =20
>  /* Event code number extraction depends on which type of event we have=
.
>   * Perhaps review this function in the future*/
> -#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
> +#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))

Nice, but then you just broke the build:

drivers/staging/iio/adc/ad799x_core.c: In function =E2=80=98ad799x_write_=
event_value=E2=80=99:
drivers/staging/iio/adc/ad799x_core.c:259:2: error: implicit declaration =
of function =E2=80=98IIO_EVENT_CODE_EXTRACT_NUM=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
cc1: some warnings being treated as errors

Please be more careful when sending patches, I've dropped all 4 of
these...

greg k-h
