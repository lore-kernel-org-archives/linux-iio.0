Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdICN7V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 09:59:21 -0400
Date: Sun, 3 Sep 2017 14:59:16 +0100
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
Subject: Re: [PATCH 4/6] iio: adc: mcp320x: Drop unnecessary of_device_id
 attributes
Message-ID: <20170903145916.47efa30e@archlinux>
In-Reply-To: <f61c85ca59a45800672d8879f7ea715f134dbd51.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
        <f61c85ca59a45800672d8879f7ea715f134dbd51.1503407738.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 15:33:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The driver sets a .data pointer for each .compatible string but never
> calls of_device_get_match_data().  Instead, ADC properties are looked up
> with spi_get_device_id().  The .data pointer is therefore unnecessary,
> so drop it.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Hmm. The use of spi_get_device_id strikes me as fragile but I may be missing
something.  Seems to be a match on the name from devicetree against the older
table.

Can't disagree that your patch removes currently unused code though.

Jonathan
> ---
>  drivers/iio/adc/mcp320x.c | 75 ++++++++++++-----------------------------------
>  1 file changed, 19 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 790d3e857c80..6e10fa934aca 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -365,62 +365,25 @@ static int mcp320x_remove(struct spi_device *spi)
>  #if defined(CONFIG_OF)
>  static const struct of_device_id mcp320x_dt_ids[] = {
>  	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
> -	{
> -		.compatible = "mcp3001",
> -		.data = &mcp320x_chip_infos[mcp3001],
> -	}, {
> -		.compatible = "mcp3002",
> -		.data = &mcp320x_chip_infos[mcp3002],
> -	}, {
> -		.compatible = "mcp3004",
> -		.data = &mcp320x_chip_infos[mcp3004],
> -	}, {
> -		.compatible = "mcp3008",
> -		.data = &mcp320x_chip_infos[mcp3008],
> -	}, {
> -		.compatible = "mcp3201",
> -		.data = &mcp320x_chip_infos[mcp3201],
> -	}, {
> -		.compatible = "mcp3202",
> -		.data = &mcp320x_chip_infos[mcp3202],
> -	}, {
> -		.compatible = "mcp3204",
> -		.data = &mcp320x_chip_infos[mcp3204],
> -	}, {
> -		.compatible = "mcp3208",
> -		.data = &mcp320x_chip_infos[mcp3208],
> -	}, {
> -		.compatible = "mcp3301",
> -		.data = &mcp320x_chip_infos[mcp3301],
> -	}, {
> -		.compatible = "microchip,mcp3001",
> -		.data = &mcp320x_chip_infos[mcp3001],
> -	}, {
> -		.compatible = "microchip,mcp3002",
> -		.data = &mcp320x_chip_infos[mcp3002],
> -	}, {
> -		.compatible = "microchip,mcp3004",
> -		.data = &mcp320x_chip_infos[mcp3004],
> -	}, {
> -		.compatible = "microchip,mcp3008",
> -		.data = &mcp320x_chip_infos[mcp3008],
> -	}, {
> -		.compatible = "microchip,mcp3201",
> -		.data = &mcp320x_chip_infos[mcp3201],
> -	}, {
> -		.compatible = "microchip,mcp3202",
> -		.data = &mcp320x_chip_infos[mcp3202],
> -	}, {
> -		.compatible = "microchip,mcp3204",
> -		.data = &mcp320x_chip_infos[mcp3204],
> -	}, {
> -		.compatible = "microchip,mcp3208",
> -		.data = &mcp320x_chip_infos[mcp3208],
> -	}, {
> -		.compatible = "microchip,mcp3301",
> -		.data = &mcp320x_chip_infos[mcp3301],
> -	}, {
> -	}
> +	{ .compatible = "mcp3001" },
> +	{ .compatible = "mcp3002" },
> +	{ .compatible = "mcp3004" },
> +	{ .compatible = "mcp3008" },
> +	{ .compatible = "mcp3201" },
> +	{ .compatible = "mcp3202" },
> +	{ .compatible = "mcp3204" },
> +	{ .compatible = "mcp3208" },
> +	{ .compatible = "mcp3301" },
> +	{ .compatible = "microchip,mcp3001" },
> +	{ .compatible = "microchip,mcp3002" },
> +	{ .compatible = "microchip,mcp3004" },
> +	{ .compatible = "microchip,mcp3008" },
> +	{ .compatible = "microchip,mcp3201" },
> +	{ .compatible = "microchip,mcp3202" },
> +	{ .compatible = "microchip,mcp3204" },
> +	{ .compatible = "microchip,mcp3208" },
> +	{ .compatible = "microchip,mcp3301" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
>  #endif

