Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbeCXNoP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:44:15 -0400
Date: Sat, 24 Mar 2018 13:44:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 10/11] staging: iio: tsl2x7x: put local variables in
 reverse Christmas tree order
Message-ID: <20180324134410.142b622e@archlinux>
In-Reply-To: <20180321102912.5130-11-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-11-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:11 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch ensures that all of the local variable declarations are in
> reverse Christmas tree order where possible to increase code
> readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied. As ever it's a minor improvement but I suppose worth doing
whilst we are there!

Thanks,

Jonathan.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 65b7fbca8c5d..5f78664d2b0e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -336,13 +336,12 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>   */
>  static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  {
> -	u32 lux; /* raw lux calculated from device data */
> -	u64 lux64;
> -	u32 ratio;
> -	u8 buf[4];
> -	struct tsl2x7x_lux *p;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2x7x_lux *p;
> +	u32 lux, ratio;
>  	int i, ret;
> +	u64 lux64;
> +	u8 buf[4];
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -589,13 +588,9 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  
>  static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  {
> -	int i;
> -	int ret = 0;
> -	u8 *dev_reg;
> -	int als_count;
> -	int als_time;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	u8 reg_val = 0;
> +	int ret, i, als_count, als_time;
> +	u8 *dev_reg, reg_val;
>  
>  	/* Non calculated parameters */
>  	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> @@ -1121,8 +1116,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			    int *val2,
>  			    long mask)
>  {
> -	int ret = -EINVAL;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -1583,9 +1578,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  static int tsl2x7x_probe(struct i2c_client *clientp,
>  			 const struct i2c_device_id *id)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev;
>  	struct tsl2X7X_chip *chip;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
>  	if (!indio_dev)

