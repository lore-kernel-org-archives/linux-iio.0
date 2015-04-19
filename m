Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:52100 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbbDSK4u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 19 Apr 2015 06:56:50 -0400
Message-ID: <553389EB.7070109@gmx.de>
Date: Sun, 19 Apr 2015 12:56:43 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>, Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	GTA04 owners <gta04-owner@goldelico.com>,
	Doug Anderson <dianders@chromium.org>,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Christian Strobel <christian.strobel@iis.fraunhofer.de>
Subject: Re: [PATCH v2] iio: gyro: itg3200: add suspend/resume support.
References: <20150224132441.2cb8ae6d@notabene.brown>
In-Reply-To: <20150224132441.2cb8ae6d@notabene.brown>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

NeilBrown schrieb am 24.02.2015 um 03:24:
> 
> Unless we put the device to sleep when not it use, it wastes
> 6mA.
> 
> If the device is asleep on probe, the 'id' register
> sometimes mis-reads - so reset first.  If the device responds
> at all a command sent to the address, it is almost certainly
> the correct device already.
> 
> Acked-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>

I don't recall acking on this. Anyway, no objection on the patch content.

Hartmut

> Signed-off-by: NeilBrown <neil@brown.name>
> 
> ---
> v1 of this was sent in November.  I got some useful feedback, but then got distracted
> by something.  Sorry for the long gap.
> NeilBrown
> 
> 
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 6a8020d48140..f0fd94055d88 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -223,6 +223,10 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
>  	int ret;
>  	u8 val;
>  
> +	ret = itg3200_reset(indio_dev);
> +	if (ret)
> +		goto err_ret;
> +
>  	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
>  	if (ret)
>  		goto err_ret;
> @@ -233,10 +237,6 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
>  		goto err_ret;
>  	}
>  
> -	ret = itg3200_reset(indio_dev);
> -	if (ret)
> -		goto err_ret;
> -
>  	ret = itg3200_enable_full_scale(indio_dev);
>  err_ret:
>  	return ret;
> @@ -351,6 +351,26 @@ static int itg3200_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int __maybe_unused itg3200_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct itg3200 *st = iio_priv(indio_dev);
> +
> +	dev_dbg(&st->i2c->dev, "suspend device");
> +
> +	return itg3200_write_reg_8(indio_dev, ITG3200_REG_POWER_MANAGEMENT,
> +				   ITG3200_SLEEP);
> +}
> +
> +static int __maybe_unused itg3200_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return itg3200_initial_setup(indio_dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend, itg3200_resume);
> +
>  static const struct i2c_device_id itg3200_id[] = {
>  	{ "itg3200", 0 },
>  	{ }
> @@ -361,6 +381,7 @@ static struct i2c_driver itg3200_driver = {
>  	.driver = {
>  		.owner  = THIS_MODULE,
>  		.name	= "itg3200",
> +		.pm	= &itg3200_pm_ops,
>  	},
>  	.id_table	= itg3200_id,
>  	.probe		= itg3200_probe,
> 

