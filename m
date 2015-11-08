Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43776 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbKHPfO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 10:35:14 -0500
Subject: Re: [PATCH] iio: light: pa12203001: Poweroff chip if register fails
To: Adriana Reus <adriana.reus@intel.com>
References: <1446801037-11453-1-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F6BB0.1030505@kernel.org>
Date: Sun, 8 Nov 2015 15:35:12 +0000
MIME-Version: 1.0
In-Reply-To: <1446801037-11453-1-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/15 09:10, Adriana Reus wrote:
> Make sure we poweroff the chip if for any reason iio_register
> returns an error.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Good spot.

Applied to the togreg branch of iio.git - initially pushed out as
testing etc etc.

Jonathan
> ---
>  drivers/iio/light/pa12203001.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index 45f7bde..76a9e12 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -381,17 +381,23 @@ static int pa12203001_probe(struct i2c_client *client,
>  		return ret;
>  
>  	ret = pm_runtime_set_active(&client->dev);
> -	if (ret < 0) {
> -		pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto out_err;
>  
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev,
>  					 PA12203001_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> -	return iio_device_register(indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto out_err;
> +
> +	return 0;
> +
> +out_err:
> +	pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
> +	return ret;
>  }
>  
>  static int pa12203001_remove(struct i2c_client *client)
> 

