Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdICNs4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 09:48:56 -0400
Date: Sun, 3 Sep 2017 14:48:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: adc: mcp320x: Speed up readout of
 single-channel ADCs
Message-ID: <20170903144851.154b295e@archlinux>
In-Reply-To: <19d008a9c19b9888b74a01adb4541a30acdcab62.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
        <19d008a9c19b9888b74a01adb4541a30acdcab62.1503407738.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 15:33:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Single-channel converters such as mcp3001, mcp3201, mcp3301 and the
> upcoming mcp3550/1/3 lack a MOSI pin, so there's no need to call
> mcp320x_channel_to_tx_data() for them.
> 
> Moreover, instead of calling spi_read() for these converters, which
> generates an spi_message and spi_transfer on the stack on every readout,
> it's more efficient to use the spi_message and spi_transfer[] included
> in struct mcp320x (as we do for multi-channel ADCs), but initialize the
> spi_message only with the receive transfer.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Looks good, but I'll hold this for now as the fixes will not show up
in my upstream tree for a least 3-4 weeks.

Please give me a bump if it looks like I have forgotten it, or include
it in updated versions of the rest of the series as appropriate.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp320x.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 071dd23a33d9..790d3e857c80 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -78,10 +78,6 @@ static int mcp320x_channel_to_tx_data(int device_index,
>  	int start_bit = 1;
>  
>  	switch (device_index) {
> -	case mcp3001:
> -	case mcp3201:
> -	case mcp3301:
> -		return 0;
>  	case mcp3002:
>  	case mcp3202:
>  		return ((start_bit << 4) | (!differential << 3) |
> @@ -104,18 +100,13 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  
>  	adc->rx_buf[0] = 0;
>  	adc->rx_buf[1] = 0;
> -	adc->tx_buf = mcp320x_channel_to_tx_data(device_index,
> -						channel, differential);
> +	if (adc->chip_info->num_channels > 1)
> +		adc->tx_buf = mcp320x_channel_to_tx_data(device_index, channel,
> +							 differential);
>  
> -	if (device_index != mcp3001 && device_index != mcp3201 && device_index != mcp3301) {
> -		ret = spi_sync(adc->spi, &adc->msg);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = spi_read(adc->spi, &adc->rx_buf, sizeof(adc->rx_buf));
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = spi_sync(adc->spi, &adc->msg);
> +	if (ret < 0)
> +		return ret;
>  
>  	switch (device_index) {
>  	case mcp3001:
> @@ -330,9 +321,13 @@ static int mcp320x_probe(struct spi_device *spi)
>  	adc->transfer[0].len = sizeof(adc->tx_buf);
>  	adc->transfer[1].rx_buf = adc->rx_buf;
>  	adc->transfer[1].len = sizeof(adc->rx_buf);
> -
> -	spi_message_init_with_transfers(&adc->msg, adc->transfer,
> -					ARRAY_SIZE(adc->transfer));
> +	if (chip_info->num_channels == 1)
> +		/* single-channel converters are rx only (no MOSI pin) */
> +		spi_message_init_with_transfers(&adc->msg,
> +						&adc->transfer[1], 1);
> +	else
> +		spi_message_init_with_transfers(&adc->msg, adc->transfer,
> +						ARRAY_SIZE(adc->transfer));
>  
>  	adc->reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(adc->reg))

