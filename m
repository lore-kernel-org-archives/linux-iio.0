Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeKPWFm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 17:05:42 -0500
Date: Fri, 16 Nov 2018 11:53:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer mcp4131: use spi_get_device_id()
 only when needed
Message-ID: <20181116115335.2d9fa9c5@archlinux>
In-Reply-To: <20181116094722.1070-3-sst@poczta.fm>
References: <20181116094722.1070-1-sst@poczta.fm>
        <20181116094722.1070-3-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Nov 2018 10:47:22 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> There is no need to find the device id up front, since the
> of_device_get_match_data() might return the correct data.
> 
Ah. That explains it.   This should just have been merged with the previous
patch :)

Anyhow, I'll apply them both but merge them whilst doing so.

So applied as one patch to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

As things currently stand it's not worth going through and doing this for
every driver as I don't think the other path is being removed any
time soon.  It's a worthwhile change if people happen to be doing other
work on a particular driver though!

Thanks,

Jonathan

> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/iio/potentiometer/mcp4131.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
> index 55f526a59215..efe035ce010d 100644
> --- a/drivers/iio/potentiometer/mcp4131.c
> +++ b/drivers/iio/potentiometer/mcp4131.c
> @@ -244,7 +244,7 @@ static int mcp4131_probe(struct spi_device *spi)
>  {
>  	int err;
>  	struct device *dev = &spi->dev;
> -	unsigned long devid = spi_get_device_id(spi)->driver_data;
> +	unsigned long devid;
>  	struct mcp4131_data *data;
>  	struct iio_dev *indio_dev;
>  
> @@ -256,8 +256,10 @@ static int mcp4131_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	data->spi = spi;
>  	data->cfg = of_device_get_match_data(&spi->dev);
> -	if (!data->cfg)
> +	if (!data->cfg) {
> +		devid = spi_get_device_id(spi)->driver_data;
>  		data->cfg = &mcp4131_cfg[devid];
> +	}
>  
>  	mutex_init(&data->lock);
>  
