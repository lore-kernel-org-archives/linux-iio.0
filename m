Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36727 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdEULIQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:08:16 -0400
Subject: Re: [PATCH v5 2/9] iio: light: rpr0521 poweroff for probe fails
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <43c73129-c953-6b59-7a64-bee8d5ce1bbc@kernel.org>
Date: Sun, 21 May 2017 12:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <1495109577-29596-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 13:12, Mikko Koivunen wrote:
> Set sensor measurement off after probe fail in pm_runtime_set_active() or
> iio_device_register(). Without this change sensor measurement stays on
> even though probe fails on these calls.
> 
> This is maybe rare case, but causes constant power drain without any
> benefits when it happens. Power drain is 20-500uA, typically 180uA.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.
Thanks,

Jonathan
> ---
> Sensor measurement is turned on rpr0521_init() so in probe it should be
> turned off in error cases after that. With CONFIG_PM it's probably
> unnecessary for iio_device_register()-fail, but without CONFIG_PM it is
> needed. Writing power off twice when CONFIG_PM enabled is ok.
> 
> Patch v4->v5 changes:
> errorpath (void) casting removed
> 
>   drivers/iio/light/rpr0521.c |   17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 03504f6..84d8d40 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -516,13 +516,26 @@ static int rpr0521_probe(struct i2c_client *client,
>   
>   	ret = pm_runtime_set_active(&client->dev);
>   	if (ret < 0)
> -		return ret;
> +		goto err_poweroff;
>   
>   	pm_runtime_enable(&client->dev);
>   	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
>   	pm_runtime_use_autosuspend(&client->dev);
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
> +	rpr0521_poweroff(data);
> +
> +	return ret;
>   }
>   
>   static int rpr0521_remove(struct i2c_client *client)
> 

