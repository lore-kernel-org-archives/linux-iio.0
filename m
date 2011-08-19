Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37030 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab1HSNaP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2011 09:30:15 -0400
Message-ID: <4E4E674F.1060201@cam.ac.uk>
Date: Fri, 19 Aug 2011 14:38:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 3/3] iio: capfun: AD7150: Add support for the second interrupt
 strobe.
References: <1313757716-20557-1-git-send-email-michael.hennerich@analog.com> <1313757716-20557-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1313757716-20557-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/11 13:41, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD7150 features two outputs that can be used as interrupt strobes
> to the host processor. In order to receive all events independently,
> both need to utilized.
> 
> Update copyright notice.

Looks sane. I'll pull it into capfun for now.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7150.c |   33 +++++++++++++++++++++------------
>  1 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
> index 4bc5b20..711e8b1 100644
> --- a/drivers/staging/iio/adc/ad7150.c
> +++ b/drivers/staging/iio/adc/ad7150.c
> @@ -1,7 +1,7 @@
>  /*
>   * AD7150 capacitive sensor driver supporting AD7150/1/6
>   *
> - * Copyright 2010 Analog Devices Inc.
> + * Copyright 2010-2011 Analog Devices Inc.
>   *
>   * Licensed under the GPL-2 or later.
>   */
> @@ -45,14 +45,6 @@
>  #define AD7150_SN0                 22
>  #define AD7150_ID                  23
>  
> -#define AD7150_MAX_CONV_MODE       4
> -
> -/**
> - * Todo list:
> - * - Review whether old_state usage makes sense.
> - * - get rid of explicit control of conversion mode
> - */
> -
>  /**
>   * struct ad7150_chip_info - instance specific chip data
>   * @client: i2c client for this device
> @@ -596,17 +588,30 @@ static int __devinit ad7150_probe(struct i2c_client *client,
>  					   &ad7150_event_handler,
>  					   IRQF_TRIGGER_RISING |
>  					   IRQF_TRIGGER_FALLING,
> -					   "ad7150",
> +					   "ad7150_irq1",
>  					   indio_dev);
>  		if (ret)
>  			goto error_free_dev;
>  	}
>  
> +	if (client->dev.platform_data) {
> +		ret = request_threaded_irq(client->dev.platform_data,
> +					   NULL,
> +					   &ad7150_event_handler,
> +					   IRQF_TRIGGER_RISING |
> +					   IRQF_TRIGGER_FALLING,
> +					   "ad7150_irq2",
> +					   indio_dev);
> +		if (ret)
> +			goto error_free_irq;
> +	}
> +
>  	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
>  		 id->name, client->irq);
>  
>  	return 0;
> -
> +error_free_irq:
> +	free_irq(client->irq, indio_dev);
>  error_free_dev:
>  	if (regdone)
>  		iio_device_unregister(indio_dev);
> @@ -622,6 +627,10 @@ static int __devexit ad7150_remove(struct i2c_client *client)
>  
>  	if (client->irq)
>  		free_irq(client->irq, indio_dev);
> +
> +	if (client->dev.platform_data)
> +		free_irq(client->dev.platform_data, indio_dev);
> +
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;
> @@ -656,7 +665,7 @@ static __exit void ad7150_exit(void)
>  }
>  
>  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ad7150/1/6 capacitive sensor driver");
> +MODULE_DESCRIPTION("Analog Devices AD7150/1/6 capacitive sensor driver");
>  MODULE_LICENSE("GPL v2");
>  
>  module_init(ad7150_init);

