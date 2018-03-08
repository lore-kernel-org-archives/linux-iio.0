Return-Path: <SRS0=697b=F6=cock.li=tomlebreux@kernel.org>
Subject: Re: [PATCH] staging:iio:ad7150: Align arguments to match open
 parenthesis
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20180308122244.28537-1-tomlebreux@cock.li>
From: Tom Lebreux <tomlebreux@cock.li>
Message-ID: <6019616b-ac91-6664-c3bf-11ee0da06aca@cock.li>
Date: Thu, 8 Mar 2018 18:23:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180308122244.28537-1-tomlebreux@cock.li>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi,

don't use this patch. I realized I forgot the signoff so I will be 
sending a new patch with my signoff.

Thanks,

Tom Lebreux

On 03/08/2018 07:22 AM, Tom Lebreux wrote:
> This fixes the following checkpatch.pl CHECK: Alignment should match
> open parenthesis
> ---
>  drivers/staging/iio/cdc/ad7150.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 2fe916c48848..947c088407a1 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -124,8 +124,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
>  }
> 
>  static int ad7150_read_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir)
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
>  {
>  	int ret;
>  	u8 threshtype;
> --
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
