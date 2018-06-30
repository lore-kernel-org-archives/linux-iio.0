Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeF3R0i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:26:38 -0400
Date: Sat, 30 Jun 2018 18:26:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: accel: adxl345: convert address field usage
 in iio_chan_spec
Message-ID: <20180630182633.24fdd73e@archlinux>
In-Reply-To: <1529940163-5149-3-git-send-email-akinobu.mita@gmail.com>
References: <1529940163-5149-1-git-send-email-akinobu.mita@gmail.com>
        <1529940163-5149-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Jun 2018 00:22:41 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Currently the address field in iio_chan_spec is filled with an accel
> data register address for the corresponding axis.
> 
> In preparation for adding calibration offset support, this sets the
> address field to the index of accel data registers instead of the actual
> register address.
> 
> This change makes it easier to access both accel registers and
> calibration offset registers with fewer lines of code as these are
> located in X-axis, Y-axis, Z-axis order.
> 
> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Arguably the change of name of variable down the bottom should have
been a separate patch, but meh - it's trivial.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> * v4
> - Stop abusing scan_index and keep using address field in iio_chan_spec
> 
>  drivers/iio/accel/adxl345_core.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8e0d56b..7a25840 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -23,6 +23,8 @@
>  #define ADXL345_REG_DATAX0		0x32
>  #define ADXL345_REG_DATAY0		0x34
>  #define ADXL345_REG_DATAZ0		0x36
> +#define ADXL345_REG_DATA_AXIS(index)	\
> +	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
>  
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
> @@ -49,19 +51,19 @@ struct adxl345_data {
>  	u8 data_range;
>  };
>  
> -#define ADXL345_CHANNEL(reg, axis) {					\
> +#define ADXL345_CHANNEL(index, axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
> -	.address = reg,							\
> +	.address = index,						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
>  }
>  
>  static const struct iio_chan_spec adxl345_channels[] = {
> -	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
> -	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
> -	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> +	ADXL345_CHANNEL(0, X),
> +	ADXL345_CHANNEL(1, Y),
> +	ADXL345_CHANNEL(2, Z),
>  };
>  
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
> @@ -69,7 +71,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
> -	__le16 regval;
> +	__le16 accel;
>  	int ret;
>  
>  	switch (mask) {
> @@ -79,12 +81,13 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
>  		 */
> -		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> -				       sizeof(regval));
> +		ret = regmap_bulk_read(data->regmap,
> +				       ADXL345_REG_DATA_AXIS(chan->address),
> +				       &accel, sizeof(accel));
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(le16_to_cpu(regval), 12);
> +		*val = sign_extend32(le16_to_cpu(accel), 12);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;

