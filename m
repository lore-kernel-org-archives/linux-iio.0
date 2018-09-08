Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:40440 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeIHW7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2018 18:59:11 -0400
Date: Sat, 8 Sep 2018 19:12:31 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: simplify setting PM ops
Message-ID: <20180908191231.78c01b47@archlinux>
In-Reply-To: <20180902132923.13513-1-tduszyns@gmail.com>
References: <20180902132923.13513-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  2 Sep 2018 15:29:23 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Relying on CONFIG_PM_SLEEP to set PM ops is not necessary
> since core will handle everything internally. One have to only make sure
> that functions that can go unused are marked with __maybe_unused.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/bh1750.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 493ca7420602..c3a481452b67 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -278,8 +278,7 @@ static int bh1750_remove(struct i2c_client *client)
>  	return 0;
>  }
> 
> -#ifdef CONFIG_PM_SLEEP
> -static int bh1750_suspend(struct device *dev)
> +static int __maybe_unused bh1750_suspend(struct device *dev)
>  {
>  	int ret;
>  	struct bh1750_data *data =
> @@ -297,10 +296,6 @@ static int bh1750_suspend(struct device *dev)
>  }
> 
>  static SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
> -#define BH1750_PM_OPS (&bh1750_pm_ops)
> -#else
> -#define BH1750_PM_OPS NULL
> -#endif
> 
>  static const struct i2c_device_id bh1750_id[] = {
>  	{ "bh1710", BH1710 },
> @@ -315,7 +310,7 @@ MODULE_DEVICE_TABLE(i2c, bh1750_id);
>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> -		.pm = BH1750_PM_OPS,
> +		.pm = &bh1750_pm_ops,
>  	},
>  	.probe = bh1750_probe,
>  	.remove = bh1750_remove,
> --
> 2.18.0
> 
