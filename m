Return-Path: <SRS0=vJyU=D6=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1514967127-127457-1-git-send-email-weiyongjun1@huawei.com>
References: <1514967127-127457-1-git-send-email-weiyongjun1@huawei.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Wed, 3 Jan 2018 11:44:53 +0100
Message-ID: <CAA2SeNJpZsjWAxLg2eGFHsXDDCctAUyNsLk1cydh1TYArDDUug@mail.gmail.com>
Subject: Re: [PATCH -next] iio: light: st_uvis25: make local symbols static
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> Fixes the following sparse warning:
>
> drivers/iio/light/st_uvis25_i2c.c:22:28: warning:
>  symbol 'st_uvis25_i2c_regmap_config' was not declared. Should it be static?
> drivers/iio/light/st_uvis25_spi.c:22:28: warning:
>  symbol 'st_uvis25_spi_regmap_config' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iio/light/st_uvis25_i2c.c | 2 +-
>  drivers/iio/light/st_uvis25_spi.c | 2 +-
>  2 file changed, 2 insertion(+), 2 deletion(-)
>
> diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
> index c939c0b..afd6eb0 100644
> --- a/drivers/iio/light/st_uvis25_i2c.c
> +++ b/drivers/iio/light/st_uvis25_i2c.c
> @@ -19,7 +19,7 @@
>
>  #define UVIS25_I2C_AUTO_INCREMENT      BIT(7)
>
> -const struct regmap_config st_uvis25_i2c_regmap_config = {
> +static const struct regmap_config st_uvis25_i2c_regmap_config = {
>         .reg_bits = 8,
>         .val_bits = 8,
>         .write_flag_mask = UVIS25_I2C_AUTO_INCREMENT,
> diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
> index e697e14..cdfee5e 100644
> --- a/drivers/iio/light/st_uvis25_spi.c
> +++ b/drivers/iio/light/st_uvis25_spi.c
> @@ -19,7 +19,7 @@
>  #define UVIS25_SENSORS_SPI_READ                BIT(7)
>  #define UVIS25_SPI_AUTO_INCREMENT      BIT(6)
>
> -const struct regmap_config st_uvis25_spi_regmap_config = {
> +static const struct regmap_config st_uvis25_spi_regmap_config = {
>         .reg_bits = 8,
>         .val_bits = 8,
>         .read_flag_mask = UVIS25_SENSORS_SPI_READ | UVIS25_SPI_AUTO_INCREMENT,
>

I guess it is already fixed in commit 75d06abbf30e3569035cfa0e7cf46797548bb829

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
