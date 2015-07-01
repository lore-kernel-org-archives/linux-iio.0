Return-Path: <knaack.h@gmx.de>
Message-ID: <559433F7.1080301@gmx.de>
Date: Wed, 01 Jul 2015 20:39:51 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org
Subject: Re: [PATCH 1/2] iio: sx9500: rework error handling of raw readings
References: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com> <1435663259-21998-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1435663259-21998-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Vlad Dogaru schrieb am 30.06.2015 um 13:20:
> Fix error handling so that we can power the chip down even if a raw read
> fails.
> 
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/proximity/sx9500.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 2042e37..ba1cbbe 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -329,27 +329,29 @@ static int sx9500_read_proximity(struct sx9500_data *data,
>  	else
>  		ret = sx9500_wait_for_sample(data);
>  
> -	if (ret < 0)
> -		return ret;
> -
>  	mutex_lock(&data->mutex);
>  
> -	ret = sx9500_read_prox_data(data, chan, val);
>  	if (ret < 0)
> -		goto out;
> +		goto out_dec_data_rdy;
>  
> -	ret = sx9500_dec_chan_users(data, chan->channel);
> +	ret = sx9500_read_prox_data(data, chan, val);
>  	if (ret < 0)
> -		goto out;
> +		goto out_dec_data_rdy;
>  
>  	ret = sx9500_dec_data_rdy_users(data);
>  	if (ret < 0)
> +		goto out_dec_chan;
> +
> +	ret = sx9500_dec_chan_users(data, chan->channel);
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = IIO_VAL_INT;
>  
>  	goto out;
>  
> +out_dec_data_rdy:
> +	sx9500_dec_data_rdy_users(data);
>  out_dec_chan:
>  	sx9500_dec_chan_users(data, chan->channel);
>  out:
> 
