Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48369 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbcJOOOY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 10:14:24 -0400
Subject: Re: [PATCH v2 4/4] iio: dac: mcp4725: add devicetree support
To: Tomas Novotny <tomas@novotny.cz>, devicetree@vger.kernel.org
References: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
 <1476194263-12015-5-git-send-email-tomas@novotny.cz>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a710bc16-24e9-8b30-5db0-8eff371a012b@kernel.org>
Date: Sat, 15 Oct 2016 15:14:19 +0100
MIME-Version: 1.0
In-Reply-To: <1476194263-12015-5-git-send-email-tomas@novotny.cz>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 14:57, Tomas Novotny wrote:
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Few small bits inline.

Jonathan
> ---
>  drivers/iio/dac/mcp4725.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 29cf85d..b8954f2 100644
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
> @@ -364,6 +365,30 @@ static const struct iio_info mcp4725_info = {
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
> @@ -375,11 +400,6 @@ static int mcp4725_probe(struct i2c_client *client,
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
> @@ -388,6 +408,19 @@ static int mcp4725_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->id = id->driver_data;
>  
> +	if (!pdata) {
May seem an odd way to do it, but I would use
if (!dev_get_platdata(&client->dev)) so it's obvious what it matches
against when it comes to unwinding this down below.

> +		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		err = mcp4725_probe_dt(&client->dev, pdata);
> +		if (err) {
> +			dev_err(&client->dev,
> +				"invalid platform or devicetree data");
> +			return err;
> +		}
> +	}
> +
>  	if (data->id == MCP4725 && pdata->use_vref) {
>  		dev_warn(&client->dev,
>  			"ignoring unavailable external reference on MCP4725");
> @@ -460,6 +493,9 @@ static int mcp4725_probe(struct i2c_client *client,
>  	if (err)
>  		goto err_disable_vref_reg;
>  
> +	if (!dev_get_platdata(&client->dev))
> +		devm_kfree(&client->dev, pdata);
Hmm. I wonder if it's worth freeing this explicitly rather than just letting
it clear up on driver remove.  It seems odd to use devm allocations for
what is a short term termporary variable.

Actually why not just use a local variable on the stack and set
pdata to point to that?  Then your cleanup is all nice an automatic
without having to do this slightly odd devm usage.
> +
>  	return 0;
>  
>  err_disable_vref_reg:
> 

