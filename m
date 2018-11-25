Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWnG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 17:43:06 -0500
Date: Sun, 25 Nov 2018 11:52:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] Staging: iio: adt7316: Change the name from
 irq_flags to irq_type
Message-ID: <20181125115205.2a402509@archlinux>
In-Reply-To: <20181120165836.7335-1-shreeya.patel23498@gmail.com>
References: <20181120165836.7335-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Nov 2018 22:28:36 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Most of the drivers in IIO uses irq_type as the name for
> storing the interrupt type and hence change the name from
> irq_flags to irq_type for maintaining the consistency.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index dfae22619287..9c72538baf9e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2102,7 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int irq_flags = IRQF_TRIGGER_LOW;
> +	int irq_type = IRQF_TRIGGER_LOW;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2147,18 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  
>  	if (chip->bus.irq > 0) {
>  		if (adt7316_platform_data[0])
> -			irq_flags = adt7316_platform_data[0];
> +			irq_type = adt7316_platform_data[0];
>  
>  		ret = devm_request_threaded_irq(dev, chip->bus.irq,
>  						NULL,
>  						adt7316_event_handler,
> -						irq_flags | IRQF_ONESHOT,
> +						irq_type | IRQF_ONESHOT,
>  						indio_dev->name,
>  						indio_dev);
>  		if (ret)
>  			return ret;
>  
> -		if (irq_flags & IRQF_TRIGGER_HIGH)
> +		if (irq_type & IRQF_TRIGGER_HIGH)
>  			chip->config1 |= ADT7316_INT_POLARITY;
>  	}
>  
