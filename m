Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeDOPTO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:19:14 -0400
Date: Sun, 15 Apr 2018 16:19:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] staging: iio: ad7746: Add dt-bindings
Message-ID: <20180415161909.34877620@archlinux>
In-Reply-To: <1523637411-8531-9-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-9-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:45 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This patch adds dt bindings by populating a pdata struct in order to
> modify as little as possible the existing code. It supports both
> platform_data and dt-bindings but uses only one depending on
> CONFIG_OF's value.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Please reorder the patches in the next version to put the bindings
patch next to this one (before preferably, but after is fine as
well.)

Hmm. I can see why you want to minimize the effect of the older
code, but given that we will probably (eventually) drop the
platform data option, I wonder if it wouldn't be better
to move the data to a sensible location rather than faking
platform_data.

The pdata is only used in probe and only two bits of
it at that so it would be fine to use some local variables and
fill them from platform data or device tree as appropriate.

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 54 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index d39ab34..c29a221 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -666,6 +666,43 @@ static const struct iio_info ad7746_info = {
>  /*
>   * device probe and remove
>   */
> +#ifdef CONFIG_OF
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct ad7746_platform_data *pdata;
> +	unsigned int tmp;
> +	int ret;
> +
> +	/* The default excitation outputs are not inverted, it should be stated
Please use standard multiline comment syntax.

/*
 * The...
 */
> +	 * in the dt if needed.
> +	 */
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	ret = of_property_read_u32(np, "adi,exclvl", &tmp);
> +	if (ret || tmp > 3) {
> +		dev_warn(dev, "Wrong exclvl value, using default\n");

Seems a little odd to have the check in here rather than generic.

> +		pdata->exclvl = 3; /* default value */
> +	} else {
> +		pdata->exclvl = tmp;
> +	}
> +
> +	pdata->exca_en = true;
> +	pdata->excb_en = true;
> +	pdata->exca_inv_en = of_property_read_bool(np, "adi,nexca_en");
> +	pdata->excb_inv_en = of_property_read_bool(np, "adi,nexcb_en");
> +
> +	return pdata;
> +}
> +#else
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
> @@ -676,6 +713,11 @@ static int ad7746_probe(struct i2c_client *client,
>  	unsigned char regval = 0;
>  	int ret = 0;
>  
> +	if (client->dev.of_node)
> +		pdata = ad7746_parse_dt(&client->dev);
> +	else
> +		pdata = client->dev.platform_data;
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -739,12 +781,22 @@ static const struct i2c_device_id ad7746_id[] = {
>  	{ "ad7747", 7747 },
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, ad7746_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ad7746_of_match[] = {
> +	{ .compatible = "adi,ad7745" },
> +	{ .compatible = "adi,ad7746" },
> +	{ .compatible = "adi,ad7747" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7746_of_match);
> +#endif
> +
>  static struct i2c_driver ad7746_driver = {
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> +		.of_match_table = of_match_ptr(ad7746_of_match),
>  	},
>  	.probe = ad7746_probe,
>  	.id_table = ad7746_id,

