Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36713 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbdAaHIB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Jan 2017 02:08:01 -0500
Date: Tue, 31 Jan 2017 08:06:44 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 4/5] iio: light: lm3533-als: Support initialization
 from Device Tree
In-Reply-To: <20170130211719.31017-4-bjorn.andersson@linaro.org>
Message-ID: <alpine.DEB.2.02.1701310805580.1494@pmeerw.net>
References: <20170130211719.31017-1-bjorn.andersson@linaro.org> <20170130211719.31017-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Implement support for initialization of the lm3533 als driver from
> Device Tree.

minor comment below
 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Note that this patch can be merged independently of the other patches in the
> series.
> 
> Changes since v5:
> - None
> 
> Changes since v4:
> - None
> 
> Changes since v3:
> - Moved als DT parsing from mfd driver
> - Gave driver its own compatible
> 
>  drivers/iio/light/lm3533-als.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index f409c2047c05..eef9f06eb0b1 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -831,6 +832,32 @@ static const struct iio_info lm3533_als_info = {
>  	.read_raw	= &lm3533_als_read_raw,
>  };
>  
> +static struct lm3533_als_platform_data *lm3533_als_of_parse(struct device *dev)
> +{
> +	struct lm3533_als_platform_data *als_pdata;
> +	struct device_node *node = dev->of_node;
> +	int ret;
> +	u32 val;
> +
> +	als_pdata = devm_kzalloc(dev, sizeof(*als_pdata), GFP_KERNEL);
> +	if (!als_pdata)
> +		return NULL;
> +
> +	als_pdata->pwm_mode = of_property_read_bool(node, "ti,pwm-mode");
> +
> +	ret = of_property_read_u32(node, "ti,als-resistance-ohm", &val);
> +	if (ret < 0 && ret != -EINVAL) {
> +		dev_err(dev, "unable to read ti,als-resistance-ohm");

\n missing

> +		return NULL;
> +	}
> +
> +	/* Leave at high-Z, if the property was omitted or specified as 0 */
> +	if (!ret && val != 0)
> +		als_pdata->r_select = 200000 / val;
> +
> +	return als_pdata;
> +}
> +
>  static int lm3533_als_probe(struct platform_device *pdev)
>  {
>  	struct lm3533 *lm3533;
> @@ -843,7 +870,11 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	if (!lm3533)
>  		return -EINVAL;
>  
> -	pdata = pdev->dev.platform_data;
> +	if (pdev->dev.of_node)
> +		pdata = lm3533_als_of_parse(&pdev->dev);
> +	else
> +		pdata = pdev->dev.platform_data;
> +
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "no platform data\n");
>  		return -EINVAL;
> @@ -914,9 +945,16 @@ static int lm3533_als_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id lm3533_als_of_match[] = {
> +	{ .compatible = "ti,lm3533-als", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_als_of_match);
> +
>  static struct platform_driver lm3533_als_driver = {
>  	.driver	= {
>  		.name	= "lm3533-als",
> +		.of_match_table = lm3533_als_of_match,
>  	},
>  	.probe		= lm3533_als_probe,
>  	.remove		= lm3533_als_remove,
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
