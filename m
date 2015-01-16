Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1421360702-1488-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1421360702-1488-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 16 Jan 2015 11:38:16 +0200
Message-ID: <CAEnQRZDCaWcs-Kqfh6EfW_Ax24KmkdAycu=6XC0AnGh+2zri_w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: tcs3414: Fix misindented lines
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 16, 2015 at 12:25 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/tcs3414.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index a9e449b..71c2bde 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -149,8 +149,8 @@ static int tcs3414_read_raw(struct iio_dev *indio_dev,
>                 *val = ret;
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
> -       i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
> -       *val = tcs3414_scales[i][0];
> +               i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
> +               *val = tcs3414_scales[i][0];
>                 *val2 = tcs3414_scales[i][1];
>                 return IIO_VAL_INT_PLUS_MICRO;
>         case IIO_CHAN_INFO_INT_TIME:
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
