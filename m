Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdLJQXG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 11:23:06 -0500
Date: Sun, 10 Dec 2017 16:23:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: light: make a couple of config structures
 static
Message-ID: <20171210162302.13236b42@archlinux>
In-Reply-To: <20171204120406.4364-1-colin.king@canonical.com>
References: <20171204120406.4364-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  4 Dec 2017 12:04:06 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Structures st_uvis25_i2c_regmap_config and st_uvis25_spi_regmap_config are
> local to the source and do not need to be in global scope, so make them
> both static.
> 
> Cleans up sparse warnings:
> warning: symbol 'st_uvis25_i2c_regmap_config' was not declared. Should
> it be static?
> warning: symbol 'st_uvis25_spi_regmap_config' was not declared. Should
> it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks Colin,

Not sure why I missed these when running build tests and they got past
0-day.  Ah well..  Applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with them.

Thanks,

Jonathan

> ---
>  drivers/iio/light/st_uvis25_i2c.c | 2 +-
>  drivers/iio/light/st_uvis25_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
> index c939c0b0ff10..afd6eb01a202 100644
> --- a/drivers/iio/light/st_uvis25_i2c.c
> +++ b/drivers/iio/light/st_uvis25_i2c.c
> @@ -19,7 +19,7 @@
>  
>  #define UVIS25_I2C_AUTO_INCREMENT	BIT(7)
>  
> -const struct regmap_config st_uvis25_i2c_regmap_config = {
> +static const struct regmap_config st_uvis25_i2c_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  	.write_flag_mask = UVIS25_I2C_AUTO_INCREMENT,
> diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
> index e697e14e7952..cdfee5e84d5e 100644
> --- a/drivers/iio/light/st_uvis25_spi.c
> +++ b/drivers/iio/light/st_uvis25_spi.c
> @@ -19,7 +19,7 @@
>  #define UVIS25_SENSORS_SPI_READ		BIT(7)
>  #define UVIS25_SPI_AUTO_INCREMENT	BIT(6)
>  
> -const struct regmap_config st_uvis25_spi_regmap_config = {
> +static const struct regmap_config st_uvis25_spi_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  	.read_flag_mask = UVIS25_SENSORS_SPI_READ | UVIS25_SPI_AUTO_INCREMENT,

