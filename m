Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52769 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbaF2LB4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 07:01:56 -0400
Message-ID: <53AFF2A0.7090102@kernel.org>
Date: Sun, 29 Jun 2014 12:04:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
CC: myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com
Subject: Re: [PATCH v2] iio: magnetometer: ak8975: Use devm_* APIs
References: <1403526846-28299-1-git-send-email-beomho.seo@samsung.com>
In-Reply-To: <1403526846-28299-1-git-send-email-beomho.seo@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/14 13:34, Beomho Seo wrote:
> This patch use devm_* APIs make driver simpler.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
> Changes in v2:
> - Return -ENOMEM and -ENPOSYS directly.
> - Withdraw some patch set because ordering issue.
> ---
>   drivers/iio/magnetometer/ak8975.c |   58 +++++++++----------------------------
>   1 file changed, 14 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 09ea5c4..a29592c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -165,7 +165,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>   	else
>   		irq = gpio_to_irq(data->eoc_gpio);
>
> -	rc = request_irq(irq, ak8975_irq_handler,
> +	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
>   			 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>   			 dev_name(&client->dev), data);
>   	if (rc < 0) {
> @@ -520,21 +520,21 @@ static int ak8975_probe(struct i2c_client *client,
>   	/* We may not have a GPIO based IRQ to scan, that is fine, we will
>   	   poll if so */
>   	if (gpio_is_valid(eoc_gpio)) {
> -		err = gpio_request_one(eoc_gpio, GPIOF_IN, "ak_8975");
> +		err = devm_gpio_request_one(&client->dev, eoc_gpio,
> +							GPIOF_IN, "ak_8975");
>   		if (err < 0) {
>   			dev_err(&client->dev,
>   				"failed to request GPIO %d, error %d\n",
>   							eoc_gpio, err);
> -			goto exit;
> +			return err;
>   		}
>   	}
>
>   	/* Register with IIO */
> -	indio_dev = iio_device_alloc(sizeof(*data));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto exit_gpio;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
>   	data = iio_priv(indio_dev);
>   	i2c_set_clientdata(client, indio_dev);
>
> @@ -549,17 +549,16 @@ static int ak8975_probe(struct i2c_client *client,
>   		name = (char *) id->name;
>   	} else if (ACPI_HANDLE(&client->dev))
>   		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
> -	else {
> -		err = -ENOSYS;
> -		goto exit_free_iio;
> -	}
> +	else
> +		return -ENOSYS;
> +
>   	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>
>   	/* Perform some basic start-of-day setup of the device. */
>   	err = ak8975_setup(client);
>   	if (err < 0) {
>   		dev_err(&client->dev, "AK8975 initialization fails\n");
> -		goto exit_free_iio;
> +		return err;
>   	}
>
>   	data->client = client;
> @@ -571,37 +570,9 @@ static int ak8975_probe(struct i2c_client *client,
>   	indio_dev->info = &ak8975_info;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->name = name;
> -	err = iio_device_register(indio_dev);
> +	err = devm_iio_device_register(&client->dev, indio_dev);
>   	if (err < 0)
> -		goto exit_free_iio;
> -
> -	return 0;
> -
> -exit_free_iio:
> -	iio_device_free(indio_dev);
> -	if (data->eoc_irq)
> -		free_irq(data->eoc_irq, data);
> -exit_gpio:
> -	if (gpio_is_valid(eoc_gpio))
> -		gpio_free(eoc_gpio);
> -exit:
> -	return err;
> -}
> -
> -static int ak8975_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ak8975_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	if (data->eoc_irq)
> -		free_irq(data->eoc_irq, data);
> -
> -	if (gpio_is_valid(data->eoc_gpio))
> -		gpio_free(data->eoc_gpio);
> -
> -	iio_device_free(indio_dev);
> +		return err;
>
>   	return 0;
>   }
> @@ -628,7 +599,6 @@ static struct i2c_driver ak8975_driver = {
>   		.acpi_match_table = ACPI_PTR(ak_acpi_match),
>   	},
>   	.probe		= ak8975_probe,
> -	.remove		= ak8975_remove,
>   	.id_table	= ak8975_id,
>   };
>   module_i2c_driver(ak8975_driver);
>

