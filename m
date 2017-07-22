Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdGVVB2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 17:01:28 -0400
Date: Sat, 22 Jul 2017 22:01:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] iio: Convert to using %pOF instead of full_name
Message-ID: <20170722220123.702ab8d9@kernel.org>
In-Reply-To: <20170718214339.7774-28-robh@kernel.org>
References: <20170718214339.7774-28-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 18 Jul 2017 16:43:08 -0500
Rob Herring <robh@kernel.org> wrote:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/max9611.c      |  4 ++--
>  drivers/iio/adc/meson_saradc.c |  8 ++++----
>  drivers/iio/adc/ti-ads1015.c   | 16 ++++++++--------
>  drivers/iio/inkern.c           |  4 ++--
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index b0526e4b9530..b1dd17cbce58 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -549,8 +549,8 @@ static int max9611_probe(struct i2c_client *client,
>  	ret = of_property_read_u32(of_node, shunt_res_prop, &of_shunt);
>  	if (ret) {
>  		dev_err(&client->dev,
> -			"Missing %s property for %s node\n",
> -			shunt_res_prop, of_node->full_name);
> +			"Missing %s property for %pOF node\n",
> +			shunt_res_prop, of_node);
>  		return ret;
>  	}
>  	max9611->shunt_resistor_uohm = of_shunt;
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 83da50ed73ab..9dffbb3bf62f 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -572,8 +572,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	struct clk_init_data init;
>  	const char *clk_parents[1];
> 
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_div",
> -				   of_node_full_name(indio_dev->dev.of_node));
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_div",
> +				   indio_dev->dev.of_node);
>  	init.flags = 0;
>  	init.ops = &clk_divider_ops;
>  	clk_parents[0] = __clk_get_name(priv->clkin);
> @@ -591,8 +591,8 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	if (WARN_ON(IS_ERR(priv->adc_div_clk)))
>  		return PTR_ERR(priv->adc_div_clk);
> 
> -	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%s#adc_en",
> -				   of_node_full_name(indio_dev->dev.of_node));
> +	init.name = devm_kasprintf(&indio_dev->dev, GFP_KERNEL, "%pOF#adc_en",
> +				   indio_dev->dev.of_node);
>  	init.flags = CLK_SET_RATE_PARENT;
>  	init.ops = &clk_gate_ops;
>  	clk_parents[0] = __clk_get_name(priv->adc_div_clk);
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 884b8e461b17..7972845b3823 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -505,24 +505,24 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
> 
>  		if (of_property_read_u32(node, "reg", &pval)) {
> -			dev_err(&client->dev, "invalid reg on %s\n",
> -				node->full_name);
> +			dev_err(&client->dev, "invalid reg on %pOF\n",
> +				node);
>  			continue;
>  		}
> 
>  		channel = pval;
>  		if (channel >= ADS1015_CHANNELS) {
>  			dev_err(&client->dev,
> -				"invalid channel index %d on %s\n",
> -				channel, node->full_name);
> +				"invalid channel index %d on %pOF\n",
> +				channel, node);
>  			continue;
>  		}
> 
>  		if (!of_property_read_u32(node, "ti,gain", &pval)) {
>  			pga = pval;
>  			if (pga > 6) {
> -				dev_err(&client->dev, "invalid gain on %s\n",
> -					node->full_name);
> +				dev_err(&client->dev, "invalid gain on %pOF\n",
> +					node);
>  				of_node_put(node);
>  				return -EINVAL;
>  			}
> @@ -532,8 +532,8 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  			data_rate = pval;
>  			if (data_rate > 7) {
>  				dev_err(&client->dev,
> -					"invalid data_rate on %s\n",
> -					node->full_name);
> +					"invalid data_rate on %pOF\n",
> +					node);
>  				of_node_put(node);
>  				return -EINVAL;
>  			}
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index da3d06b073bb..617372cc73e6 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -205,8 +205,8 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>  		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
>  			break;
>  		else if (name && index >= 0) {
> -			pr_err("ERROR: could not get IIO channel %s:%s(%i)\n",
> -				np->full_name, name ? name : "", index);
> +			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +				np, name ? name : "", index);
>  			return NULL;
>  		}
> 
> --
> 2.11.0
> 

