Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57581 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbdEGWQB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:16:01 -0400
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: add MAX31856 part
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org
References: <20170506012828.22949-1-matt.ranostay@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <de566ad6-7d7b-f752-bd96-9c261da54104@kernel.org>
Date: Sun, 7 May 2017 12:37:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170506012828.22949-1-matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/17 02:28, Matt Ranostay wrote:
> MAX31856 is register equivalent to the MAX31855 but suppports J, N, R,
> S, T, E and B type thermocouples in addition to K-type.
> 
> Data conversion for the various types happens transparently to the driver
> via probe type detection, and a LUT on the sensor.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git and pushed out as testing
so other patches can be tested.

Thanks,

Jonathan
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 557214202eff..d70e2e53d6a7 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -267,6 +267,7 @@ static int maxim_thermocouple_remove(struct spi_device *spi)
>  static const struct spi_device_id maxim_thermocouple_id[] = {
>  	{"max6675", MAX6675},
>  	{"max31855", MAX31855},
> +	{"max31856", MAX31855},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> 

