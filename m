Return-Path: <beomho.seo@samsung.com>
Message-id: <52F21E4D.1080005@samsung.com>
Date: Wed, 05 Feb 2014 20:19:41 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 1/1] iio: ak8975: Set name
References: <1391596181-21377-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-reply-to: <1391596181-21377-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hello,

> This creates the mandatory name attribute for the device.
> 

Already, I have sent same patch set[1].

> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> ---
>  drivers/iio/magnetometer/ak8975.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index ff284e5..c61a764 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -508,6 +508,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	mutex_init(&data->lock);
>  	data->eoc_gpio = eoc_gpio;
>  	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
>  	indio_dev->channels = ak8975_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>  	indio_dev->info = &ak8975_info;
> 

[1] http://marc.info/?l=linux-iio&m=139097191528544&w=2

-- 
Best Regards,
