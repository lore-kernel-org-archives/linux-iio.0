Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43886 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbFUN1y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:27:54 -0400
Message-ID: <5586BBD9.1020609@kernel.org>
Date: Sun, 21 Jun 2015 14:27:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 5/7] iio:light:cm3323: replace unneeded variable
References: <cover.1434578207.git.knaack.h@gmx.de> <0d0f805fe6e16a334f210fea614a2d558ea8469c.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <0d0f805fe6e16a334f210fea614a2d558ea8469c.1434578207.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 23:32, Hartmut Knaack wrote:
> In cm3323_read_raw() i is used as return variable for the integration time
> index. The also existing return variable ret however is unused in this
> case, although appropriate. Replace i with ret and drop it.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/light/cm3323.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 9cd7d2a..2c49ec2 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -153,7 +153,7 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
> -	int i, ret;
> +	int ret;
>  	struct cm3323_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
> @@ -170,14 +170,14 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		mutex_lock(&data->mutex);
> -		i = cm3323_get_it_bits(data);
> -		if (i < 0) {
> +		ret = cm3323_get_it_bits(data);
> +		if (ret < 0) {
>  			mutex_unlock(&data->mutex);
> -			return i;
> +			return ret;
>  		}
>  
> -		*val = cm3323_int_time[i].val;
> -		*val2 = cm3323_int_time[i].val2;
> +		*val = cm3323_int_time[ret].val;
> +		*val2 = cm3323_int_time[ret].val2;
>  		mutex_unlock(&data->mutex);
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
