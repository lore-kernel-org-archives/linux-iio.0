Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59771 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbdCEL3o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 06:29:44 -0500
Subject: Re: [PATCH] iio: magnetometer: ak8974: remove incorrect __exit
 markups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20170301233757.GA10606@dtor-ws>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4b941e94-2ecf-81d1-272a-f8224bf84c80@kernel.org>
Date: Sun, 5 Mar 2017 11:29:41 +0000
MIME-Version: 1.0
In-Reply-To: <20170301233757.GA10606@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/17 23:37, Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Thanks,

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> ---
>  drivers/iio/magnetometer/ak8974.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index ce09d771c1fb..75f83424903b 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -767,7 +767,7 @@ static int ak8974_probe(struct i2c_client *i2c,
>  	return ret;
>  }
>  
> -static int __exit ak8974_remove(struct i2c_client *i2c)
> +static int ak8974_remove(struct i2c_client *i2c)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
>  	struct ak8974 *ak8974 = iio_priv(indio_dev);
> @@ -849,7 +849,7 @@ static struct i2c_driver ak8974_driver = {
>  		.of_match_table = of_match_ptr(ak8974_of_match),
>  	},
>  	.probe	  = ak8974_probe,
> -	.remove	  = __exit_p(ak8974_remove),
> +	.remove	  = ak8974_remove,
>  	.id_table = ak8974_id,
>  };
>  module_i2c_driver(ak8974_driver);
> 

