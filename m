Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53715 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbbDIQaZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:30:25 -0400
Message-ID: <5526A920.6010502@kernel.org>
Date: Thu, 09 Apr 2015 17:30:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: sx9500: refactor GPIO interrupt code
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com> <1428065254-6444-5-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-5-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/15 13:47, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
This one is fine, though won't apply until we've sorted the earlier patch out.
> ---
>  drivers/iio/proximity/sx9500.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 13b174c..d1e886c 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -831,34 +831,25 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static int sx9500_gpio_probe(struct i2c_client *client,
> -			     struct sx9500_data *data)
> +static void sx9500_gpio_probe(struct i2c_client *client,
> +			      struct sx9500_data *data)
>  {
>  	struct device *dev;
>  	struct gpio_desc *gpio;
> -	int ret;
>  
>  	if (!client)
> -		return -EINVAL;
> +		return;
>  
>  	dev = &client->dev;
>  
> -	/* data ready gpio interrupt pin */
> -	gpio = devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0);
> -	if (IS_ERR(gpio)) {
> -		dev_err(dev, "acpi gpio get index failed\n");
> -		return PTR_ERR(gpio);
> +	if (client->irq <= 0) {
> +		gpio = devm_gpiod_get_index(dev, SX9500_GPIO_INT, 0, GPIOD_IN);
> +		if (IS_ERR(gpio))
> +			dev_err(dev, "gpio get irq failed\n");
> +		else
> +			client->irq = gpiod_to_irq(gpio);
>  	}
>  
> -	ret = gpiod_direction_input(gpio);
> -	if (ret)
> -		return ret;
> -
> -	ret = gpiod_to_irq(gpio);
> -
> -	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> -
> -	return ret;
>  }
>  
>  static int sx9500_probe(struct i2c_client *client,
> @@ -892,8 +883,7 @@ static int sx9500_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	if (client->irq <= 0)
> -		client->irq = sx9500_gpio_probe(client, data);
> +	sx9500_gpio_probe(client, data);
>  
>  	if (client->irq <= 0) {
>  		dev_err(&client->dev, "no valid irq found\n");
> 

