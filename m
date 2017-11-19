Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdKSQEl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 11:04:41 -0500
Date: Sun, 19 Nov 2017 16:04:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 13/15] iio: imu: inv_mpu6050: Remove duplicate NULL
 check
Message-ID: <20171119160437.6c2742d9@archlinux>
In-Reply-To: <20171031142149.32512-13-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
        <20171031142149.32512-13-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Oct 2017 16:21:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git.  Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index dd6fc6d21f9d..d78a10403bac 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -196,8 +196,7 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
>  
> -	if (st->mux_client)
> -		i2c_unregister_device(st->mux_client);
> +	i2c_unregister_device(st->mux_client);
>  }
>  #else
>  

