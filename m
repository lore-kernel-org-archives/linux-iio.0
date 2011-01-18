Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60540 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1ARLsn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jan 2011 06:48:43 -0500
Message-ID: <4D357E19.9030207@cam.ac.uk>
Date: Tue, 18 Jan 2011 11:48:41 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: shubhrajyoti@ti.com
CC: linux-iio@vger.kernel.org, Shubhrajyoti D <a0393217@india.ti.com>
Subject: Re: [PATCH] hmc5843: Convert to dev pm ops
References: <1295350963-8667-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1295350963-8667-1-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/18/11 11:42, shubhrajyoti@ti.com wrote:
> From: Shubhrajyoti D <a0393217@india.ti.com>
> 
I'm not that familiar with the power management stuff, but
looks fine to me...
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 5168917..2650f21 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -583,20 +583,25 @@ static int hmc5843_remove(struct i2c_client *client)
>  	kfree(i2c_get_clientdata(client));
>  	return 0;
>  }
> -
> -static int hmc5843_suspend(struct i2c_client *client, pm_message_t mesg)
> +#ifdef CONFIG_PM
> +static int hmc5843_suspend(struct device *dev)
>  {
> +	struct i2c_client *client = to_i2c_client(dev);
>  	hmc5843_configure(client, MODE_SLEEP);
>  	return 0;
>  }
>  
> -static int hmc5843_resume(struct i2c_client *client)
> +static int hmc5843_resume(struct device *dev)
>  {
> +	struct i2c_client *client = to_i2c_client(dev);
>  	struct hmc5843_data *data = i2c_get_clientdata(client);
>  	hmc5843_configure(client, data->operating_mode);
>  	return 0;
>  }
>  
> +static SIMPLE_DEV_PM_OPS(hmc5843_pm, hmc5843_suspend, hmc5843_resume);
> +#endif
> +
>  static const struct i2c_device_id hmc5843_id[] = {
>  	{ "hmc5843", 0 },
>  	{ }
> @@ -605,14 +610,15 @@ static const struct i2c_device_id hmc5843_id[] = {
>  static struct i2c_driver hmc5843_driver = {
>  	.driver = {
>  		.name	= "hmc5843",
> +#ifdef CONFIG_PM
> +		.pm	= &hmc5843_pm,
> +#endif
>  	},
>  	.id_table	= hmc5843_id,
>  	.probe		= hmc5843_probe,
>  	.remove		= hmc5843_remove,
>  	.detect		= hmc5843_detect,
>  	.address_list	= normal_i2c,
> -	.suspend	= hmc5843_suspend,
> -	.resume		= hmc5843_resume,
>  };
>  
>  static int __init hmc5843_init(void)

