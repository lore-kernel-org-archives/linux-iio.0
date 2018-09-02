Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeIBWLv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 18:11:51 -0400
Date: Sun, 2 Sep 2018 18:55:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Convert to using %pOFn instead of device_node.name
Message-ID: <20180902185505.330efb32@archlinux>
In-Reply-To: <20180828015252.28511-22-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-22-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Aug 2018 20:52:23 -0500
Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c |  4 ++--
>  drivers/iio/adc/rcar-gyroadc.c      | 12 ++++++------
>  drivers/iio/frequency/adf4350.c     |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index b093ecddf1a8..c30c002f1fef 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -708,8 +708,8 @@ static int pm8xxx_of_xlate(struct iio_dev *indio_dev,
>  	 * mux.
>  	 */
>  	if (iiospec->args_count != 2) {
> -		dev_err(&indio_dev->dev, "wrong number of arguments for %s need 2 got %d\n",
> -			iiospec->np->name,
> +		dev_err(&indio_dev->dev, "wrong number of arguments for %pOFn need 2 got %d\n",
> +			iiospec->np,
>  			iiospec->args_count);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index dcb50172186f..4e982b51bcda 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -343,8 +343,8 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	for_each_child_of_node(np, child) {
>  		of_id = of_match_node(rcar_gyroadc_child_match, child);
>  		if (!of_id) {
> -			dev_err(dev, "Ignoring unsupported ADC \"%s\".",
> -				child->name);
> +			dev_err(dev, "Ignoring unsupported ADC \"%pOFn\".",
> +				child);
>  			continue;
>  		}
>  
> @@ -381,16 +381,16 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			ret = of_property_read_u32(child, "reg", &reg);
>  			if (ret) {
>  				dev_err(dev,
> -					"Failed to get child reg property of ADC \"%s\".\n",
> -					child->name);
> +					"Failed to get child reg property of ADC \"%pOFn\".\n",
> +					child);
>  				return ret;
>  			}
>  
>  			/* Channel number is too high. */
>  			if (reg >= num_channels) {
>  				dev_err(dev,
> -					"Only %i channels supported with %s, but reg = <%i>.\n",
> -					num_channels, child->name, reg);
> +					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
> +					num_channels, child, reg);
>  				return ret;
>  			}
>  		}
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 6d768431d90e..f4748ff243f7 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -388,7 +388,7 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>  	if (!pdata)
>  		return NULL;
>  
> -	strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
> +	snprintf(&pdata->name[0], SPI_NAME_SIZE - 1, "%pOFn", np);
>  
>  	tmp = 10000;
>  	of_property_read_u32(np, "adi,channel-spacing", &tmp);
