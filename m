Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60722 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbeGRL4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jul 2018 07:56:08 -0400
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
To: Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: anirudh@xilinx.com, sgoud@xilinx.com, Joe Perches <joe@perches.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
Date: Wed, 18 Jul 2018 13:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/18/2018 01:12 PM, Manish Narani wrote:
> This patch fix the following checkpatch warning in xadc driver.
> - Reusing the krealloc arg is almost always a bug.
> 
> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
> warning.
> 

This is a bug in checkpatch and should be fixed in checkpatch. The code is
not actually re-using the parameter. channels and xadc_channels are
independent variables, just checkpatch somehow does not realize this.

> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index d4f21d1..27b45df 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1040,7 +1040,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	unsigned int *conf)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	struct iio_chan_spec *channels, *chan;
> +	struct iio_chan_spec *iio_xadc_channels, *chan;
>  	struct device_node *chan_node, *child;
>  	unsigned int num_channels;
>  	const char *external_mux;
> @@ -1083,12 +1083,13 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
>  	}
>  
> -	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
> -	if (!channels)
> +	iio_xadc_channels = kmemdup(xadc_channels, sizeof(xadc_channels),
> +				    GFP_KERNEL);
> +	if (!iio_xadc_channels)
>  		return -ENOMEM;
>  
>  	num_channels = 9;
> -	chan = &channels[9];
> +	chan = &iio_xadc_channels[9];
>  
>  	chan_node = of_get_child_by_name(np, "xlnx,channels");
>  	if (chan_node) {
> @@ -1119,11 +1120,12 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	of_node_put(chan_node);
>  
>  	indio_dev->num_channels = num_channels;
> -	indio_dev->channels = krealloc(channels, sizeof(*channels) *
> -					num_channels, GFP_KERNEL);
> +	indio_dev->channels = krealloc(iio_xadc_channels,
> +				       sizeof(*iio_xadc_channels) *
> +				       num_channels, GFP_KERNEL);
>  	/* If we can't resize the channels array, just use the original */
>  	if (!indio_dev->channels)
> -		indio_dev->channels = channels;
> +		indio_dev->channels = iio_xadc_channels;
>  
>  	return 0;
>  }
> 

