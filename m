Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CB28DC4;
	Sun, 19 Apr 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620368; cv=none; b=aPXFj79mpmFrDZtAB71zElR4lWzuJtGwmk3k3rnHlUqGu0QtwrBMqvdHA/PdeXJw12NKCvxXMg42Sf5ng59W9+3HfpnG87U4mgyOba+RwG4IdpQhSn0Duqos2bOyhhNtgu1iG7zACvrKtUAkqebUJRU10g3DZDIV0zwFEvsneiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620368; c=relaxed/simple;
	bh=cpG+I3oWWNUTrOkoPFvRT+owRe5XR2S1NLz5g0bf59o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEmbd+kWRS1ux0ZVUjWdd2JLE+CBabgtoBu8tShLQegTmPli3U+wGuVxQsINyOdocq/jHl1f1z8DWDlrYnr3fpJpesFBuN+CPadOhNuw/dJvv6UBXOS2FaN4kK75/aO/Y1R/WfO8bMP0J/lPGhklSpySmPs4HnqTUNgKmpeD6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCdEbziJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCdEbziJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9D9C2BCAF;
	Sun, 19 Apr 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776620368;
	bh=cpG+I3oWWNUTrOkoPFvRT+owRe5XR2S1NLz5g0bf59o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cCdEbziJFfRFUyVPrpN5B5pszdaVtVQnhGfB9Xyn5Ij6or3MGXyzWXHlcCwtc5yeH
	 pAMbDg0nNKe/Oy4EDK7L9QMYuD28bZNeWY4nzJk9g1xhLtZ/SDDjK3UuSZ5BVGhoSi
	 mhFGGXU/g96P/p/MeSLcBPUFfSQNYVK/eneQyo5EYYTyMZLn2U/nWUb/07Zu3ONOo5
	 dpidkOjDNEgolrBa85SjWePxmQH6YsXljq2CLvLv/tKrGuzGd+X5i66fXLWgFVVXyh
	 rCTmo80LV4KW1rLqPSmsHsGNPBRdwy848B5vvOo4eNu6u2XZ779lACt7z5aoK59MdA
	 n6dbWI6A+E1kQ==
Date: Sun, 19 Apr 2026 18:39:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] iio: ssp_sensors: convert probe and teardown to
 devm-managed resources
Message-ID: <20260419183918.23a22e12@jic23-huawei>
In-Reply-To: <20260415050749.3858046-6-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
	<20260415050749.3858046-6-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 10:37:47 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Convert SSP driver resource management to use devm-managed helpers
> and devm actions, tying the lifetime of all resources to the device.
> 
> Mutex initialization, IRQ registration, work items, timers, and MFD
> resource are now managed using devm APIs. Cleanup logic previously
> handled explicitly in probe error paths and the remove callback is
> replaced with devm_add_action_or_reset(), ensuring correct teardown
> ordering and consistent behaviour on probe failure and device unbind.
> 
> This simplifies the probe path by removing goto-based error handling,
> eliminates the remove callback entirely.
> 
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Hi Sanjay.

Devm conversions often get complex and end up raising questions
that weren't as obvious when doing an explicit remove() callback.

One of those inline.

Thanks

Jonathan

> ---
> Changes in v6:
> - Drop remove path completely using devm_action with review comment from David
> - Convert MFD device to manage resource along with mutex and IRQ
> - Link to v5: https://lore.kernel.org/all/20260406080852.2727453-1-sanjayembedded@gmail.com/
> ---
> 
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 88 ++++++++++--------------
>  1 file changed, 38 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index cb4c26a6b76c..94ecc794f926 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -194,6 +194,16 @@ static void ssp_disable_wdt_timer(struct ssp_data *data)
>  	cancel_work_sync(&data->work_wdt);
>  }
>  
> +static void ssp_shutdown_action(struct ssp_data *data)
> +{
> +	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
> +		dev_err(&data->spi->dev,
> +			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
> +
> +	ssp_enable_mcu(data, false);
> +	ssp_clean_pending_list(data);
Where this is called below, it's not obvious to me what particular
actions it is undoing.  So I think you need comments on that somewhere.

General alarm bell was that it was undoing multiple things.

> +}
> +
>  /**
>   * ssp_get_sensor_delay() - gets sensor data acquisition period
>   * @data:	sensorhub structure
> @@ -491,9 +501,9 @@ static int ssp_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
> -			      sensorhub_sensor_devs,
> -			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
> +	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
> +				   sensorhub_sensor_devs,
> +				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "mfd add devices fail\n");
>  		return ret;
> @@ -503,14 +513,16 @@ static int ssp_probe(struct spi_device *spi)
>  	ret = spi_setup(spi);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "Failed to setup spi\n");
> -		goto err_setup_spi;
> +		return ret;
>  	}
>  
>  	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
>  	data->spi = spi;
>  	spi_set_drvdata(spi, data);
>  
> -	mutex_init(&data->comm_lock);
> +	ret = devm_mutex_init(&spi->dev, &data->comm_lock);
> +	if (ret < 0)
> +		return ret;
>  
>  	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
>  		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
> @@ -523,7 +535,9 @@ static int ssp_probe(struct spi_device *spi)
>  
>  	data->time_syncing = true;
>  
> -	mutex_init(&data->pending_lock);
> +	ret = devm_mutex_init(&spi->dev, &data->pending_lock);
> +	if (ret < 0)
> +		return ret;
>  	INIT_LIST_HEAD(&data->pending_list);
>  
>  	atomic_set(&data->enable_refcount, 0);
> @@ -533,14 +547,17 @@ static int ssp_probe(struct spi_device *spi)
>  
>  	timer_setup(&data->wdt_timer, ssp_wdt_timer_func, 0);
>  
> -	ret = request_threaded_irq(data->spi->irq, NULL,
> -				   ssp_irq_thread_fn,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				   "SSP_Int", data);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "Irq request fail\n");
> -		goto err_setup_irq;
> -	}
> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ssp_disable_wdt_timer, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(&spi->dev, data->spi->irq, NULL,
> +					ssp_irq_thread_fn,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"SSP_Int", data);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Let's start with enabled one so irq balance could be ok */
>  	data->shut_down = false;
> @@ -548,53 +565,24 @@ static int ssp_probe(struct spi_device *spi)
>  	/* just to avoid unbalanced irq set wake up */
>  	enable_irq_wake(data->spi->irq);
>  
> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ssp_shutdown_action, data);

See above. At minimum this needs some explanatory comments on why
the stuff in there needs to be called from this point onwards.
Before this patch it wasn't called if there was an error in the next
few lines.


> +	if (ret)
> +		return ret;
> +
>  	data->fw_dl_state = ssp_check_fwbl(data);
>  	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
>  		ret = ssp_initialize_mcu(data);
>  		if (ret < 0) {
>  			dev_err(&spi->dev, "Initialize_mcu failed\n");
> -			goto err_read_reg;
> +			return ret;
>  		}
>  	} else {
>  		dev_err(&spi->dev, "Firmware version not supported\n");
> -		ret = -EPERM;
> -		goto err_read_reg;
> +		return -EPERM;
>  	}
>  
>  	return 0;
> -
> -err_read_reg:
> -	free_irq(data->spi->irq, data);
> -err_setup_irq:
> -	mutex_destroy(&data->pending_lock);
> -	mutex_destroy(&data->comm_lock);
> -err_setup_spi:
> -	mfd_remove_devices(&spi->dev);
> -
> -	dev_err(&spi->dev, "Probe failed!\n");
> -
> -	return ret;
> -}
> -
> -static void ssp_remove(struct spi_device *spi)
> -{
> -	struct ssp_data *data = spi_get_drvdata(spi);
> -
> -	if (ssp_command(data, SSP_MSG2SSP_AP_STATUS_SHUTDOWN, 0) < 0)
> -		dev_err(&data->spi->dev,
> -			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
> -
> -	ssp_enable_mcu(data, false);
> -	ssp_clean_pending_list(data);
> -
> -	free_irq(data->spi->irq, data);
> -
> -	ssp_disable_wdt_timer(data);
> -
> -	mutex_destroy(&data->comm_lock);
> -	mutex_destroy(&data->pending_lock);
> -
> -	mfd_remove_devices(&spi->dev);
>  }
>  
>  static int ssp_suspend(struct device *dev)

