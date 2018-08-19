Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:25675
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbeHSKNV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 06:13:21 -0400
Subject: Re: [PATCH 3/3] iio: potentiometer: merge calls to of_match_device
 and of_device_get_match_data
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
 <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
From: Peter Rosin <peda@axentia.se>
Message-ID: <0a8aff9e-51fe-96a5-bcab-cc472be92dcc@axentia.se>
Date: Sun, 19 Aug 2018 09:02:42 +0200
MIME-Version: 1.0
In-Reply-To: <1526896150-27134-4-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-05-21 11:49, Julia Lawall wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> The semantic match that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> local idexpression match;
> identifier i;
> expression x, dev, e, e1;
> @@
> -        match@i = of_match_device(x, dev);
> -        if (match) e = of_device_get_match_data(dev);
> -        else e = e1;
> +        e = of_device_get_match_data(dev);
> +        if (!e) e = e1;
> 
> @@
> identifier r.i;
> @@
> - const struct of_device_id *i;
> ... when != i
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> 
> ---
>  drivers/iio/potentiometer/max5481.c |    7 ++-----
>  drivers/iio/potentiometer/mcp4018.c |    7 ++-----
>  drivers/iio/potentiometer/mcp4531.c |    7 ++-----
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 320a7c9..c051ee0 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -147,7 +147,6 @@ static int mcp4018_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct mcp4018_data *data;
>  	struct iio_dev *indio_dev;
> -	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_BYTE)) {
> @@ -162,10 +161,8 @@ static int mcp4018_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(dev);
> -	else
> +	data->cfg = of_device_get_match_data(dev);
> +	if (!data->cfg)
>  		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index df894af..d87ca85 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -360,7 +360,6 @@ static int mcp4531_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct mcp4531_data *data;
>  	struct iio_dev *indio_dev;
> -	const struct of_device_id *match;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_WORD_DATA)) {
> @@ -375,10 +374,8 @@ static int mcp4531_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(dev);
> -	else
> +	data->cfg = of_device_get_match_data(dev);
> +	if (!data->cfg)
>  		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index ffe2761..6d2f13f 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct max5481_data *data;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> -	const struct of_device_id *match;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> @@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
>  
>  	data->spi = spi;
>  
> -	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
> -	if (match)
> -		data->cfg = of_device_get_match_data(&spi->dev);
> -	else
> +	data->cfg = of_device_get_match_data(&spi->dev);
> +	if (!data->cfg)
>  		data->cfg = &max5481_cfg[id->driver_data];
>  
>  	indio_dev->name = id->name;
> 
