Return-Path: <SRS0=vlDD=A3=lip6.fr=julia.lawall@kernel.org>
Date: Tue, 26 Sep 2017 17:17:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Aastha Gupta <aastha.gupta4104@gmail.com>
cc: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
    jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
    linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 2/2] staging: iio: adc: ad7192: add
 lock to protect hardware state changes
In-Reply-To: <1506437917-7219-3-git-send-email-aastha.gupta4104@gmail.com>
Message-ID: <alpine.DEB.2.20.1709261716480.2866@hadrien>
References: <1506437917-7219-1-git-send-email-aastha.gupta4104@gmail.com> <1506437917-7219-3-git-send-email-aastha.gupta4104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Tue, 26 Sep 2017, Aastha Gupta wrote:

> In this driver, private driver lock is being used to protect hardware
> state changes.

Similarly, in this case, why is this the good lock to use, and why is this
the good place to put it?

julia

>
> Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 096d29d..609a649 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -511,6 +511,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = -EINVAL;
> +		mutex_lock(&st->lock);
>  		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
>  			if (val2 == st->scale_avail[i][1]) {
>  				ret = 0;
> @@ -524,6 +525,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  				ad7192_calibrate_all(st);
>  				break;
>  			}
> +		mutex_unlock(&st->lock);
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (!val) {
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1506437917-7219-3-git-send-email-aastha.gupta4104%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
