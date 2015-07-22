Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Wed, 22 Jul 2015 12:18:19 -0500
From: Michael Welling <mwelling@ieee.org>
To: Denis Carikli <denis@eukrea.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: Fix NULL pointer.
Message-ID: <20150722171819.GA18251@deathstar>
References: <1437581064-9733-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437581064-9733-1-git-send-email-denis@eukrea.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 22, 2015 at 06:04:21PM +0200, Denis Carikli wrote:
> Without that fix, adc->chip_info is NULL in mcp320x_read_raw
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/iio/adc/mcp320x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 8d9c9b9..fccb2dc 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -299,6 +299,7 @@ static int mcp320x_probe(struct spi_device *spi)
>  	indio_dev->channels = chip_info->channels;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> +	adc->chip_info = chip_info;
>  	adc->transfer[0].tx_buf = &adc->tx_buf;
>  	adc->transfer[0].len = sizeof(adc->tx_buf);
>  	adc->transfer[1].rx_buf = adc->rx_buf;

This issue has already been dealt with.

http://www.gossamer-threads.com/lists/linux/kernel/2214469

> -- 
> 2.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
