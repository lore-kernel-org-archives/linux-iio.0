Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeKRD0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 22:26:20 -0500
Date: Sat, 17 Nov 2018 17:08:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Staging: iio: adt7316: Use device tree data to
 assign irq_type
Message-ID: <20181117170856.5637f708@archlinux>
In-Reply-To: <20181116230455.25073-1-shreeya.patel23498@gmail.com>
References: <20181116230455.25073-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 04:34:55 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> ADT7316 driver no more uses platform data and hence use device tree
> data instead of platform data for assigning irq_type field.
> Switch case figures out the type of irq and if it's the default case
> then assign the default value to the irq_type i.e.
> irq_type = IRQF_TRIGGER_LOW
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I think this set of 3 patches around irq type are fine.  If no
one else finds any issues, I'll pick up in v2.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9c72538baf9e..c647875a64f5 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int irq_type = IRQF_TRIGGER_LOW;
> +	int irq_type;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (chip->bus.irq > 0) {
> -		if (adt7316_platform_data[0])
> -			irq_type = adt7316_platform_data[0];
> +		irq_type =
> +			irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +
> +		switch (irq_type) {
> +		case IRQF_TRIGGER_HIGH:
> +		case IRQF_TRIGGER_RISING:
> +			break;
> +		case IRQF_TRIGGER_LOW:
> +		case IRQF_TRIGGER_FALLING:
> +			break;
> +		default:
> +			dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
> +				 irq_type);
> +			irq_type = IRQF_TRIGGER_LOW;
> +			break;
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, chip->bus.irq,
>  						NULL,
