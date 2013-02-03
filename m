Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52953 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3BCMKi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 07:10:38 -0500
Message-ID: <510E53B8.40803@kernel.org>
Date: Sun, 03 Feb 2013 12:10:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 1/4] iio: max1363: Use devm_ functions whereever possible
 to allocate resources
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net> <1359853180-5664-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359853180-5664-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/2013 12:59 AM, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of iio.git.

Note I'll probably rebase the togreg branch if / when Greg has pulled
last pull request (sent a few mins ago) so as to get a directly
applied fix for this driver.

> ---
>  drivers/iio/adc/max1363.c |   29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index ef868c9..1353fda 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1410,8 +1410,9 @@ static int max1363_alloc_scan_masks(struct iio_dev *indio_dev)
>  	unsigned long *masks;
>  	int i;
>  
> -	masks = kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
> -			  (st->chip_info->num_modes + 1), GFP_KERNEL);
> +	masks = devm_kzalloc(&indio_dev->dev,
> +			BITS_TO_LONGS(MAX1363_MAX_CHANNELS) * sizeof(long) *
> +			(st->chip_info->num_modes + 1), GFP_KERNEL);
>  	if (!masks)
>  		return -ENOMEM;
>  
> @@ -1546,7 +1547,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = regulator_get(&client->dev, "vcc");
> +	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);
>  		goto error_unregister_map;
> @@ -1554,7 +1555,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	ret = regulator_enable(st->reg);
>  	if (ret)
> -		goto error_put_reg;
> +		goto error_unregister_map;
>  
>  	/* this is only used for device removal purposes */
>  	i2c_set_clientdata(client, indio_dev);
> @@ -1575,15 +1576,15 @@ static int max1363_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	ret = max1363_initial_setup(st);
>  	if (ret < 0)
> -		goto error_free_available_scan_masks;
> +		goto error_disable_reg;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  		&max1363_trigger_handler, &max1363_buffered_setup_ops);
>  	if (ret)
> -		goto error_free_available_scan_masks;
> +		goto error_disable_reg;
>  
>  	if (client->irq) {
> -		ret = request_threaded_irq(st->client->irq,
> +		ret = devm_request_threaded_irq(&client->dev, st->client->irq,
>  					   NULL,
>  					   &max1363_event_handler,
>  					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -1596,20 +1597,14 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto error_free_irq;
> +		goto error_uninit_buffer;
>  
>  	return 0;
> -error_free_irq:
> -	if (client->irq)
> -		free_irq(st->client->irq, indio_dev);
> +
>  error_uninit_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
> -error_free_available_scan_masks:
> -	kfree(indio_dev->available_scan_masks);
>  error_disable_reg:
>  	regulator_disable(st->reg);
> -error_put_reg:
> -	regulator_put(st->reg);
>  error_unregister_map:
>  	iio_map_array_unregister(indio_dev);
>  error_free_device:
> @@ -1624,12 +1619,8 @@ static int max1363_remove(struct i2c_client *client)
>  	struct max1363_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (client->irq)
> -		free_irq(st->client->irq, indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
> -	kfree(indio_dev->available_scan_masks);
>  	regulator_disable(st->reg);
> -	regulator_put(st->reg);
>  	iio_map_array_unregister(indio_dev);
>  	iio_device_free(indio_dev);
>  
> 
