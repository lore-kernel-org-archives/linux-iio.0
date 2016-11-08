Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41884 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbcKHU2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 15:28:00 -0500
Subject: Re: [PATCH] staging: iio: tsl2583: fix unused function warning
To: Arnd Bergmann <arnd@arndb.de>
References: <20161108140213.2270755-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <da722ffc-2245-987e-47e3-43da324fcb9a@kernel.org>
Date: Tue, 8 Nov 2016 20:27:56 +0000
MIME-Version: 1.0
In-Reply-To: <20161108140213.2270755-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 14:01, Arnd Bergmann wrote:
> Removing a call to the taos_chip_off() makes it unused when CONFIG_PM
> is disabled:
> 
> drivers/staging/iio/light/tsl2583.c:438:12: error: ‘taos_chip_off’ defined but not used [-Werror=unused-function]
> 
> This removes all the #ifdef in this file, and marks the PM functions as
> __maybe_unused instead, which is more reliable and gives us better
> compile time coverage.
> 
> Fixes: 0561155f6fc5 ("staging: iio: tsl2583: don't shutdown chip when updating the lux table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks. Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 7eab17f4557e..d74e33bacbf9 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -816,8 +816,7 @@ static int taos_probe(struct i2c_client *clientp,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int taos_suspend(struct device *dev)
> +static int __maybe_unused taos_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> @@ -834,7 +833,7 @@ static int taos_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int taos_resume(struct device *dev)
> +static int __maybe_unused taos_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> @@ -850,10 +849,6 @@ static int taos_resume(struct device *dev)
>  }
>  
>  static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
> -#define TAOS_PM_OPS (&taos_pm_ops)
> -#else
> -#define TAOS_PM_OPS NULL
> -#endif
>  
>  static struct i2c_device_id taos_idtable[] = {
>  	{ "tsl2580", 0 },
> @@ -863,7 +858,6 @@ static struct i2c_device_id taos_idtable[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, taos_idtable);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id taos2583_of_match[] = {
>  	{ .compatible = "amstaos,tsl2580", },
>  	{ .compatible = "amstaos,tsl2581", },
> @@ -871,15 +865,12 @@ static const struct of_device_id taos2583_of_match[] = {
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, taos2583_of_match);
> -#else
> -#define taos2583_of_match NULL
> -#endif
>  
>  /* Driver definition */
>  static struct i2c_driver taos_driver = {
>  	.driver = {
>  		.name = "tsl2583",
> -		.pm = TAOS_PM_OPS,
> +		.pm = &taos_pm_ops,
>  		.of_match_table = taos2583_of_match,
>  	},
>  	.id_table = taos_idtable,
> 

