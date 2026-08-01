Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAD1A5B9D;
	Sat,  1 Aug 2026 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609159; cv=none; b=QURdqXYV5qcaQd8Ayqf+n5+d47+4K2vofzzH2eNLxjkIEvPBfNeitLzYIIj7AjsV2iCTbRwJos9D4Lhcp5K2snAQeegBoM4+JEBJ2PrP302GCkIfRd2sfxiOlzA7gWHfyAr5LRI1ScCYpQuaL9OBoLXw5MKb12OrcFWqiZ9rwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609159; c=relaxed/simple;
	bh=GhKYehAxSIzsnQfG1N6ngNX1GZQ3HXF9pec7MPlKvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMG+/mNE+wKSdFRza/dv7yZZwNlL4zhCEMzomB1RXAZcmcc7zUHGcWHLXsAIjqk0LaIT5TEMlIhZPGDUVVO8NlB/UWwv+WztoZ9ytaQ/monoM7cpiAT0j5ZfloNwNkZb8UrSB9VCreR3VwLdjKEgowd0CXuTE5bSyLXhxRhJsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/OaOz1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/OaOz1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CD1F00AC4;
	Sat,  1 Aug 2026 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785609158;
	bh=ozqz1uFRDAK/9brUdJKAmZbb6k9kYfIkc1JZvt64ZO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i/OaOz1rg6YbjT6FWwvk0JbhRNvyol9SQvu99wc6rLWHSl+o9zfoL87jIPiaoTdei
	 xCu8xkLf9K3f7/daJxDSPqjm11ojo2s4uHDQ6Tk5iFkTdJtmOOGFza+MhcMjOhYMAa
	 eiQMjbkSGUqj+xtxvhd7GfNHnOZOXR6Q7wTCT/a46dX9RGzkaNCEBzk9UenNRvW7ey
	 pKppRrOMUn8JRrq2IEbt1HjvJKCAcPmqdQ8YwxUZ92MDzzhHAQ95XAiGRQxk9YzZtj
	 uj1FiTqc1gze84xM+Idk59A1TNDo7MudS6L5zXlKlFABPvS+2uUAsEnG2wQCFasii0
	 ZR1CZw71gswwA==
Date: Sat, 1 Aug 2026 19:32:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: adc: ti-ads1015: use local device pointer
 in probe
Message-ID: <20260801193233.69de4f35@jic23-huawei>
In-Reply-To: <20260727192102.37968-5-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
	<20260727192102.37968-5-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 00:51:00 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Introduce a local device pointer 'dev' in ads1015_probe to
> avoid accessing &client->dev repeatedly.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
Hi Archit,

To avoid churn in the series this should be done slightly different.
See below but in short it is a case of not updating everything in
this patch given you are going to touch the same code in the next
one.

> ---
>  drivers/iio/adc/ti-ads1015.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 293fdd49381f..59ce2f89daeb 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -933,6 +933,7 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
>  static int ads1015_probe(struct i2c_client *client)
>  {
>  	const struct ads1015_chip_data *chip;
> +	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct ads1015_data *data;
>  	int ret;
> @@ -940,9 +941,9 @@ static int ads1015_probe(struct i2c_client *client)
>  
>  	chip = i2c_get_match_data(client);
>  	if (!chip)
> -		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
> +		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -978,15 +979,15 @@ static int ads1015_probe(struct i2c_client *client)
>  					    &ads1015_regmap_config :
>  					    &tla2024_regmap_config);
>  	if (IS_ERR(data->regmap)) {
> -		dev_err(&client->dev, "Failed to allocate register map\n");
> +		dev_err(dev, "Failed to allocate register map\n");
>  		return PTR_ERR(data->regmap);

Leave updating this one for next patch (and ignore sashiko if it complains ;)

>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      ads1015_trigger_handler,
>  					      &ads1015_buffer_setup_ops);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		dev_err(dev, "iio triggered buffer setup failed\n");
Likewise, do this as part of der_err_probe()
>  		return ret;
>  	}
>  
> @@ -1018,7 +1019,7 @@ static int ads1015_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, client->irq,
>  						NULL, ads1015_event_handler,
>  						irq_trig | IRQF_ONESHOT,
>  						client->name, indio_dev);
> @@ -1032,18 +1033,18 @@ static int ads1015_probe(struct i2c_client *client)
>  
>  	data->conv_invalid = true;
>  
> -	ret = pm_runtime_set_active(&client->dev);
> +	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		return ret;
> -	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
> -	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
> -		pm_runtime_disable(&client->dev);
> -		pm_runtime_set_suspended(&client->dev);
> +		dev_err(dev, "Failed to register IIO device\n");

Leave this one for dev_err_probe() patch.  Just this line not the ones around it.

> +		pm_runtime_disable(dev);
> +		pm_runtime_set_suspended(dev);
>  		return ret;
>  	}
>  

