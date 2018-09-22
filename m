Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIVPPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 11:15:08 -0400
Date: Sat, 22 Sep 2018 10:22:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: Fix leak of device_node in
 mx25_gcq_setup_cfgs()
Message-ID: <20180922102210.62576e11@archlinux>
In-Reply-To: <1537567082-7308-1-git-send-email-khoroshilov@ispras.ru>
References: <1537567082-7308-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 22 Sep 2018 00:58:02 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> Leaving for_each_child_of_node loop we should release child device node,
> if it is not stored for future use.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Seems obviously correct to me.  Given we are mid way through
the cycle and this doesn't strike me as super urgent, I'll
queue it up for the next merge window.

I added a note to the description to reflect this.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks and great to clean things like this up.

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index ea264fa9e567..929c617db364 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -209,12 +209,14 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  		ret = of_property_read_u32(child, "reg", &reg);
>  		if (ret) {
>  			dev_err(dev, "Failed to get reg property\n");
> +			of_node_put(child);
>  			return ret;
>  		}
>  
>  		if (reg >= MX25_NUM_CFGS) {
>  			dev_err(dev,
>  				"reg value is greater than the number of available configuration registers\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -228,6 +230,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			if (IS_ERR(priv->vref[refp])) {
>  				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
>  					mx25_gcq_refp_names[refp]);
> +				of_node_put(child);
>  				return PTR_ERR(priv->vref[refp]);
>  			}
>  			priv->channel_vref_mv[reg] =
> @@ -240,6 +243,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			break;
>  		default:
>  			dev_err(dev, "Invalid positive reference %d\n", refp);
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -254,10 +258,12 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  
>  		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
>  			dev_err(dev, "Invalid fsl,adc-refp property value\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
>  			dev_err(dev, "Invalid fsl,adc-refn property value\n");
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
