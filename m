Return-Path: <jic23@kernel.org>
Message-ID: <523F4329.6020901@kernel.org>
Date: Sun, 22 Sep 2013 20:21:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
CC: jic23@cam.ac.uk, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 3/3] iio: ti_am335x_adc: cleanup error case
References: <1379838005-15158-1-git-send-email-zubair.lutfullah@gmail.com> <1379838005-15158-4-git-send-email-zubair.lutfullah@gmail.com>
In-Reply-To: <1379838005-15158-4-git-send-email-zubair.lutfullah@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/22/13 09:20, Zubair Lutfullah wrote:
> Driver is functional without this error case. Cleaned up.
> 
> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Applied and pull request just sent to Greg.

> ---
>  drivers/iio/adc/ti_am335x_adc.c |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 4eb63eb..8fb5429 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -323,7 +323,6 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	int i, map_val;
>  	unsigned int fifo1count, read, stepid;
> -	u32 step = UINT_MAX;
>  	bool found = false;
>  	u32 step_en;
>  	unsigned long timeout = jiffies + usecs_to_jiffies
> @@ -353,15 +352,6 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	 * Hence we need to flush out this data.
>  	 */
>  
> -	for (i = 0; i < ARRAY_SIZE(adc_dev->channel_step); i++) {
> -		if (chan->channel == adc_dev->channel_line[i]) {
> -			step = adc_dev->channel_step[i];
> -			break;
> -		}
> -	}
> -	if (WARN_ON_ONCE(step == UINT_MAX))
> -		return -EINVAL;
> -
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i = 0; i < fifo1count; i++) {
>  		read = tiadc_readl(adc_dev, REG_FIFO1);
> 
