Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37374 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdBSMEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:04:04 -0500
Subject: Re: [PATCH 8/8] iio: maxim_thermocouple: Set parent device
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-9-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <59df1f71-dfbd-45ec-9a34-5a849afca079@kernel.org>
Date: Sun, 19 Feb 2017 12:04:02 +0000
MIME-Version: 1.0
In-Reply-To: <1486816461-28618-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/17 12:34, Lars-Peter Clausen wrote:
> Initialize the parent of the IIO device to the device that registered it.
> This makes sure that the IIO device appears the right level in the device
> hierarchy.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks for cleaning these up Lars,

Jonathan
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index f962f31..5572142 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -231,6 +231,7 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
>  	indio_dev->available_scan_masks = chip->scan_masks;
>  	indio_dev->num_channels = chip->num_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &spi->dev;
>  
>  	data = iio_priv(indio_dev);
>  	data->spi = spi;
> 

