Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbeFPSsk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jun 2018 14:48:40 -0400
Date: Sat, 16 Jun 2018 19:48:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: adxl345: add calibration offset support
Message-ID: <20180616194835.46e75a99@archlinux>
In-Reply-To: <1529161484-28781-4-git-send-email-akinobu.mita@gmail.com>
References: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
        <1529161484-28781-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Jun 2018 00:04:42 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The ADXL345 provides the offset adjustment registers for each axis.
> This adds the iio channel information for the calibraion offsets with
> that feature.
> 
> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Hi,

The use of calibscale surprised me.  Calibbias is often effectively in
'unknown units' as there is non linear stuff in the way but roughly speaking
the assumption is that it is in the same units as the _raw measurement if it
can be (hence calibscale = 1).

adc reading = ((actualval + calibbias)*calibscale)
processed reading = (adc reading + offset)*scale

Looks like it would be easy enough to do that here and rely on default for
calibscale of 1.  That gives us one less userspace interface which is one
less thing for people to use wrong :)

> ---
>  drivers/iio/accel/adxl345_core.c | 52 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6b62f82..a392f9e 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -18,6 +18,9 @@
>  #include "adxl345.h"
>  
>  #define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_OFSX		0x1e
> +#define ADXL345_REG_OFSY		0x1f
> +#define ADXL345_REG_OFSZ		0x20
>  #define ADXL345_REG_POWER_CTL		0x2D
>  #define ADXL345_REG_DATA_FORMAT		0x31
>  #define ADXL345_REG_DATAX0		0x32
> @@ -53,8 +56,10 @@ struct adxl345_data {
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
>  	.scan_index = si,						\
>  }
>  
> @@ -69,7 +74,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
> -	__le16 regval;
> +	__le16 accel;
> +	unsigned int regval;
>  	int ret;
>  
>  	switch (mask) {
> @@ -80,18 +86,51 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
>  		 */
>  		ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
> -				       sizeof(regval) * chan->scan_index,
> -				       &regval, sizeof(regval));
> +				       sizeof(accel) * chan->scan_index, &accel,
> +				       sizeof(accel));
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(le16_to_cpu(regval), 12);
> +		*val = sign_extend32(le16_to_cpu(accel), 12);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		*val2 = adxl345_uscale;
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_read(data->regmap,
> +				  ADXL345_REG_OFSX + chan->scan_index, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val = sign_extend32(regval, 7);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		/*
> +		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
> +		 * factor
> +		 */
> +		*val = 0;
> +		*val2 = adxl345_uscale * 4;

This surprises me.  Why am I seeing a read only calibration scale parameter?
The ABI doesn't say that this is the scale of the bias if that's what you are thinking...

calibbias is kind of unit less as often it's before a non linear transform of some
type.  However, if we were going to assume it was simple, we'd assume it had the
same scale as _raw.  Hence I would just adjust the value in the read and write for
the calibbias itself.

> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int adxl345_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_write(data->regmap,
> +				   ADXL345_REG_OFSX + chan->scan_index, val);
> +		return ret;
>  	}
>  
>  	return -EINVAL;
> @@ -99,6 +138,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info adxl345_info = {
>  	.read_raw	= adxl345_read_raw,
> +	.write_raw	= adxl345_write_raw,
>  };
>  
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,

