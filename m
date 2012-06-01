Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55782 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568Ab2FAIBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jun 2012 04:01:50 -0400
Message-ID: <4FC876EB.7090701@kernel.org>
Date: Fri, 01 Jun 2012 09:01:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Leed Aguilar <leed.aguilar@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio:magnetometer:ak8975: use gpio_request_one
 api
References: <1338470231-19272-1-git-send-email-leed.aguilar@ti.com>
In-Reply-To: <1338470231-19272-1-git-send-email-leed.aguilar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/31/2012 2:17 PM, Leed Aguilar wrote:
> Use gpio_request_one api, it looks cleaner.
But adds a dependency on GPIOLIB.   I'm not that bothered by
that but it needs to be explicit in the Kconfig.
>
> Signed-off-by: Leed Aguilar<leed.aguilar@ti.com>
> Cc: Jonathan Cameron<jic23@kernel.org>
> ---
>   drivers/staging/iio/magnetometer/ak8975.c |   10 +---------
>   1 files changed, 1 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
> index ebc2d08..52833cd 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -487,21 +487,13 @@ static int ak8975_probe(struct i2c_client *client,
>   	/* We may not have a GPIO based IRQ to scan, that is fine, we will
>   	   poll if so */
>   	if (gpio_is_valid(eoc_gpio)) {
> -		err = gpio_request(eoc_gpio, "ak_8975");
> +		err = gpio_request_one(eoc_gpio, GPIOF_IN, "ak_8975");
>   		if (err<  0) {
>   			dev_err(&client->dev,
>   				"failed to request GPIO %d, error %d\n",
>   							eoc_gpio, err);
>   			goto exit;
>   		}
> -
> -		err = gpio_direction_input(eoc_gpio);
> -		if (err<  0) {
> -			dev_err(&client->dev,
> -				"Failed to configure input direction for GPIO %d, error %d\n",
> -						eoc_gpio, err);
> -			goto exit_gpio;
> -		}
>   	}
>
>   	/* Register with IIO */

