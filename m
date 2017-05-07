Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57610 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbdEGWVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:21:01 -0400
Subject: Re: [PATCH v3 2/9] iio: light: rpr0521 poweroff for probe fails
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@intel.com>,
        linux-iio@vger.kernel.org
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d3b2f247-08f6-3ae5-e206-e77b1c574855@kernel.org>
Date: Sun, 7 May 2017 12:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <1493983193-8753-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 12:19, Mikko Koivunen wrote:
> Set sensor measurement off after probe fail in pm_runtime_set_active() or
> iio_device_register(). Without this change sensor measurement stays on
> even though probe fails on these calls.
> 
> This is maybe rare case, but causes constant power drain without any
> benefits when it happens. Power drain is 20-500uA, typically 180uA.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Looks good to me, but I will be looking for Acks from Daniel on this
set.  Daniel let me know if you want to pass on responsibility for the
driver (perhaps Mikko if willing?)

one tiny point inline.
> ---
> Sensor measurement is turned on rpr0521_init() so in probe it should be
> turned off in error cases after that. With CONFIG_PM it's probably
> unnecessary for iio_device_register()-fail, but without CONFIG_PM it is
> needed. Writing power off twice when CONFIG_PM enabled is ok.
> 
>  drivers/iio/light/rpr0521.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 03504f6..5d077f4 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -516,13 +516,26 @@ static int rpr0521_probe(struct i2c_client *client,
>  
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0)
> -		return ret;
> +		goto err_poweroff;
>  
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
>  
> -	return iio_device_register(indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_pm_disable;
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +err_poweroff:
> +	(void) rpr0521_poweroff(data);
shouldn't need the void cast.
> +
> +	return ret;
>  }
>  
>  static int rpr0521_remove(struct i2c_client *client)
> 

