Return-Path: <SRS0=tzo9=AU=pmeerw.net=pmeerw@kernel.org>
Date: Tue, 19 Sep 2017 08:17:51 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: =?ISO-8859-15?Q?Stefan_Br=FCns?= <stefan.bruens@rwth-aachen.de>
cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] iio: light: vl6180: Move range check to integration
 time setter, cleanup
In-Reply-To: <20170919031144.4968-2-stefan.bruens@rwth-aachen.de>
Message-ID: <alpine.DEB.2.20.1709190817310.8589@vps.pmeerw.net>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de> <20170919031144.4968-2-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="324302256-550275656-1505801871=:8589"
List-ID: <linux-iio@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324302256-550275656-1505801871=:8589
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


> This improves code uniformity (range checks for als_gain are also done
> in the setter). Also unmangle rounding and calculation of register value.

nitpick below
 
> The calculated integration time it_ms is required in the next patch of
> the series.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
>  drivers/iio/light/vl6180.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 6e25b724d941..57577d5d18ac 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -386,16 +386,21 @@ static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
>  	return -EINVAL;
>  }
>  
> -static int vl6180_set_it(struct vl6180_data *data, int val2)
> +static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  {
> -	int ret;
> +	int ret, it_ms;
> +
> +	it_ms = ((val2 + 500) / 1000); /* round to ms */

outer parenthesis not necessary

> +	if (val != 0 || it_ms < 1 || it_ms > 512)
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	ret = vl6180_hold(data, true);
>  	if (ret < 0)
>  		goto fail;
> -	ret = vl6180_write_word(data->client, VL6180_ALS_IT,
> -		(val2 - 500) / 1000); /* write value in ms */
> +
> +	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
> +
>  fail:
>  	vl6180_hold(data, false);
>  	mutex_unlock(&data->lock);
> @@ -411,15 +416,14 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (val != 0 || val2 < 500 || val2 >= 512500)
> -			return -EINVAL;
> +		return vl6180_set_it(data, val, val2);
>  
> -		return vl6180_set_it(data, val2);
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		if (chan->type != IIO_LIGHT)
>  			return -EINVAL;
>  
>  		return vl6180_set_als_gain(data, val, val2);
> +
>  	default:
>  		return -EINVAL;
>  	}
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
--324302256-550275656-1505801871=:8589--
