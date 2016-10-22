Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54057 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbcJVS0c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 14:26:32 -0400
Subject: Re: [PATCH v3 5/5] iio: dac: mcp4725: add devicetree support
To: Tomas Novotny <tomas.novotny@tbs-biometrics.com>,
        devicetree@vger.kernel.org
References: <1476812589-18333-1-git-send-email-tomas.novotny@tbs-biometrics.com>
 <1476812589-18333-6-git-send-email-tomas.novotny@tbs-biometrics.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org,
        Tomas Novotny <tomas@novotny.cz>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4a635f3f-3429-130a-1e7a-ed7b2cb82d08@kernel.org>
Date: Sat, 22 Oct 2016 19:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <1476812589-18333-6-git-send-email-tomas.novotny@tbs-biometrics.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/10/16 18:43, Tomas Novotny wrote:
> From: Tomas Novotny <tomas@novotny.cz>
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Applied to the togreg branch of iio.git. Initially pushed out as
testing for the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/dac/mcp4725.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 83d431f..05f7f4d 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -364,22 +365,41 @@ static const struct iio_info mcp4725_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_OF
> +static int mcp4725_probe_dt(struct device *dev,
> +			    struct mcp4725_platform_data *pdata)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	/* check if is the vref-supply defined */
> +	pdata->use_vref = of_property_read_bool(np, "vref-supply");
> +	pdata->vref_buffered =
> +		of_property_read_bool(np, "microchip,vref-buffered");
> +
> +	return 0;
> +}
> +#else
> +static int mcp4725_probe_dt(struct device *dev,
> +			    struct mcp4725_platform_data *platform_data)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int mcp4725_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct mcp4725_data *data;
>  	struct iio_dev *indio_dev;
> -	struct mcp4725_platform_data *pdata = dev_get_platdata(&client->dev);
> +	struct mcp4725_platform_data *pdata, pdata_dt;
>  	u8 inbuf[4];
>  	u8 pd;
>  	u8 ref;
>  	int err;
>  
> -	if (!pdata) {
> -		dev_err(&client->dev, "invalid platform data");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
> @@ -387,6 +407,17 @@ static int mcp4725_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	data->id = id->driver_data;
> +	pdata = dev_get_platdata(&client->dev);
> +
> +	if (!pdata) {
> +		err = mcp4725_probe_dt(&client->dev, &pdata_dt);
> +		if (err) {
> +			dev_err(&client->dev,
> +				"invalid platform or devicetree data");
> +			return err;
> +		}
> +		pdata = &pdata_dt;
> +	}
>  
>  	if (data->id == MCP4725 && pdata->use_vref) {
>  		dev_err(&client->dev,
> 

