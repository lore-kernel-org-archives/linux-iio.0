Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbdFKKdt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 06:33:49 -0400
Date: Sun, 11 Jun 2017 11:33:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH v1] iio: proximity: sx9500: Use devm_gpiod_get()
Message-ID: <20170611113351.09b6c6b0@kernel.org>
In-Reply-To: <20170610190821.53499-1-andriy.shevchenko@linux.intel.com>
References: <20170610190821.53499-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 10 Jun 2017 22:08:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since index is always 0 replace devm_gpiod_get_index() by devm_gpiod_get().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy,

Good little tidy up. Looks like a classic use for a coccinelle patch
if you have time to take it further.  Sort of thing that will sneak in
within future drivers so good to tidy up all cases automatically ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/sx9500.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 9ea147f1a50d..f42b3a1c75ff 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -878,8 +878,7 @@ static void sx9500_gpio_probe(struct i2c_client *client,
>  
>  	dev = &client->dev;
>  
> -	data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
> -					       0, GPIOD_OUT_HIGH);
> +	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET, GPIOD_OUT_HIGH);
>  	if (IS_ERR(data->gpiod_rst)) {
>  		dev_warn(dev, "gpio get reset pin failed\n");
>  		data->gpiod_rst = NULL;

