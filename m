Return-Path: <beomho.seo@samsung.com>
Message-id: <53191428.1090900@samsung.com>
Date: Fri, 07 Mar 2014 09:34:48 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: cm36651: Fix i2c client leak and possible NULL
 pointer dereference
References: <1394098390-11213-1-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1394098390-11213-1-git-send-email-k.kozlowski@samsung.com>
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/06/2014 06:33 PM, Krzysztof Kozlowski wrote:
> During probe the driver allocates dummy I2C devices (i2c_new_dummy())
> but they aren't unregistered during driver remove or probe failure.
> 
> Additionally driver does not check the return value of i2c_new_dummy().
> In case of error (i2c_new_device(): memory allocation failure or I2C
> address cannot be used) this function returns NULL which is later
> dereferenced by i2c_smbus_{read,write}_data() functions.
> 
> Fix issues by properly checking for i2c_new_dummy() return value and
> unregistering I2C devices on driver remove or probe failure.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks,

Acked-by: Beomho Seo <beomho.seo@samsung.com>

> ---
>  drivers/iio/light/cm36651.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index a45e07492db3..e7e9a597159f 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -653,6 +653,11 @@ static int cm36651_probe(struct i2c_client *client,
>  	cm36651->ps_client = i2c_new_dummy(client->adapter,
>  						     CM36651_I2C_ADDR_PS);
>  	cm36651->ara_client = i2c_new_dummy(client->adapter, CM36651_ARA);
> +	if (!cm36651->ps_client || !cm36651->ara_client) {
> +		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
> +		ret = -ENODEV;
> +		goto error_i2c_unregister;
> +	}
>  	mutex_init(&cm36651->lock);
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = cm36651_channels;
> @@ -687,6 +692,11 @@ error_free_irq:
>  	free_irq(client->irq, indio_dev);
>  error_disable_reg:
>  	regulator_disable(cm36651->vled_reg);
> +error_i2c_unregister:
> +	if (cm36651->ps_client)
> +		i2c_unregister_device(cm36651->ps_client);
> +	if (cm36651->ara_client)
> +		i2c_unregister_device(cm36651->ara_client);
>  	return ret;
>  }
>  
> @@ -698,6 +708,8 @@ static int cm36651_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	regulator_disable(cm36651->vled_reg);
>  	free_irq(client->irq, indio_dev);
> +	i2c_unregister_device(cm36651->ps_client);
> +	i2c_unregister_device(cm36651->ara_client);
>  
>  	return 0;
>  }
> 


-- 
Best Regards,
