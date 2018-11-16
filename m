Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbeKPWBY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 17:01:24 -0500
Date: Fri, 16 Nov 2018 11:49:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: potentiometer: mcp4131: use
 of_device_get_match_data()
Message-ID: <20181116114918.52b82372@archlinux>
In-Reply-To: <20181116094722.1070-2-sst@poczta.fm>
References: <20181116094722.1070-1-sst@poczta.fm>
        <20181116094722.1070-2-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Nov 2018 10:47:21 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> Try to get the device's data using OF API. In case of failure, fallback
> to the spi_get_device_id() method.

The removing of the OF config guards is a good change, but probably wants
to be mentioned in the description.

One way I think this can be improved inline.

Thanks,

Jonathan

> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/iio/potentiometer/mcp4131.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
> index b3e30db246cc..55f526a59215 100644
> --- a/drivers/iio/potentiometer/mcp4131.c
> +++ b/drivers/iio/potentiometer/mcp4131.c
> @@ -42,6 +42,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  
>  #define MCP4131_WRITE		(0x00 << 2)
> @@ -254,7 +255,9 @@ static int mcp4131_probe(struct spi_device *spi)
>  	data = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  	data->spi = spi;
> -	data->cfg = &mcp4131_cfg[devid];
> +	data->cfg = of_device_get_match_data(&spi->dev);
> +	if (!data->cfg)
> +		data->cfg = &mcp4131_cfg[devid];
The devid local variable is only used in this path. I would get rid of the
local variable entirely and just use spi_get_device_id(spi)->driver_data
directly here.

>  
>  	mutex_init(&data->lock);
>  
> @@ -273,7 +276,6 @@ static int mcp4131_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_OF)
>  static const struct of_device_id mcp4131_dt_ids[] = {
>  	{ .compatible = "microchip,mcp4131-502",
>  		.data = &mcp4131_cfg[MCP413x_502] },
> @@ -406,7 +408,6 @@ static const struct of_device_id mcp4131_dt_ids[] = {
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mcp4131_dt_ids);
> -#endif /* CONFIG_OF */
>  
>  static const struct spi_device_id mcp4131_id[] = {
>  	{ "mcp4131-502", MCP413x_502 },
