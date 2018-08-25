Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYMdx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Aug 2018 08:33:53 -0400
Date: Sat, 25 Aug 2018 09:55:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: make vref regulator optional
Message-ID: <20180825095531.374af32f@archlinux>
In-Reply-To: <20180824202447.21804-1-marcus.folkesson@gmail.com>
References: <20180824202447.21804-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 24 Aug 2018 22:24:47 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The `vref` regulator is declared as optional in the device-tree binding,
> but the driver does require it.
> 
> Go for the device-tree binding and make the `vref` regulator optional.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hmm. 
If you do a voltage get on a stub regulator it will return an
error (IIRC).

So I am unconvinced this actually makes any real difference?

What am I missing?

Jonathan

> ---
>  drivers/iio/dac/ti-dac5571.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index f6dcd8bce2b0..bf21cc312096 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -251,6 +251,9 @@ static int dac5571_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> +		if (!data->vref)
> +			return -EOPNOTSUPP;
> +
>  		ret = regulator_get_voltage(data->vref);
>  		if (ret < 0)
>  			return ret;
> @@ -335,13 +338,21 @@ static int dac5571_probe(struct i2c_client *client,
>  	indio_dev->num_channels = spec->num_channels;
>  	data->spec = spec;
>  
> -	data->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(data->vref))
> -		return PTR_ERR(data->vref);
> +	data->vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(data->vref)) {
> +		if (PTR_ERR(data->vref) == -ENODEV) {
> +			data->vref = NULL;
> +		} else {
> +			dev_err(dev, "failed to get regulator (%ld)\n",
> +					PTR_ERR(data->vref));
> +			return PTR_ERR(data->vref);

That is as likely as not a deferred probe so it should not be
as noisy as this.  It may happen during a normal boot process a lot
of times.


> +		}
>  
> -	ret = regulator_enable(data->vref);
> -	if (ret < 0)
> -		return ret;
> +	} else {
> +		ret = regulator_enable(data->vref);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	mutex_init(&data->lock);
>  
> @@ -373,7 +384,9 @@ static int dac5571_probe(struct i2c_client *client,
>  	return 0;
>  
>   err:
> -	regulator_disable(data->vref);
> +	if (data->vref)
> +		regulator_disable(data->vref);
> +
>  	return ret;
>  }
>  
> @@ -383,7 +396,8 @@ static int dac5571_remove(struct i2c_client *i2c)
>  	struct dac5571_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	regulator_disable(data->vref);
> +	if (data->vref)
> +		regulator_disable(data->vref);
>  
>  	return 0;
>  }
