Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41825 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJKOqC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:46:02 -0400
Subject: Re: [PATCH 6/6] iio:dac:m62332: use dynamic scale
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1440459082.git.knaack.h@gmx.de>
 <59133cb6c4c826e9fff4ab5504eb42c16d40fe70.1440459082.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A7628.4020203@kernel.org>
Date: Sun, 11 Oct 2015 15:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <59133cb6c4c826e9fff4ab5504eb42c16d40fe70.1440459082.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/08/15 22:59, Hartmut Knaack wrote:
> Some regulators can supply multiple voltages. To take changing voltages
> into account, the scale needs to be calculated on every read access.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
This is a pretty common situation, but just because it is done
less than ideally in a lot of places, doesn't mean we shouldn't
fix this one!

Applied.

Jonathan
> ---
>  drivers/iio/dac/m62332.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index fdb3e042c14d..76e8b044b979 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -31,7 +31,6 @@
>  
>  struct m62332_data {
>  	struct i2c_client	*client;
> -	u16			vref_mv;
>  	struct regulator	*vcc;
>  	struct mutex		mutex;
>  	u8			raw[M62332_CHANNELS];
> @@ -89,11 +88,16 @@ static int m62332_read_raw(struct iio_dev *indio_dev,
>  			   long mask)
>  {
>  	struct m62332_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		/* Corresponds to Vref / 2^(bits) */
> -		*val = data->vref_mv;
> +		ret = regulator_get_voltage(data->vcc);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret / 1000; /* mV */
>  		*val2 = 8;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
> @@ -218,11 +222,6 @@ static int m62332_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &m62332_info;
>  
> -	ret = regulator_get_voltage(data->vcc);
> -	if (ret < 0)
> -		return ret;
> -	data->vref_mv = ret / 1000; /* mV */
> -
>  	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
>  	if (ret < 0)
>  		return ret;
> 

