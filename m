Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbeFXNhu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:37:50 -0400
Date: Sun, 24 Jun 2018 14:37:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345: use scan_index for
 accessing accel registers
Message-ID: <20180624143745.4881e8fa@archlinux>
In-Reply-To: <1529337552-23726-3-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
        <1529337552-23726-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Jun 2018 00:59:10 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Currently the address field in iio_chan_spec is filled with an accel
> data register address for the corresponding axis.
> 
> In preparation for adding calibration offset support, this makes use of
> scan_index field to access accel data registers instead of using address
> field.  This change makes it easier to access both accel registers and
> calibration offset registers with fewer lines of code as these are
> located in X-axis, Y-axis, Z-axis order.
> 
Hmm. My issue here is that scan_index exists for a very specific purpose
and that purpose is only relevant once we have buffered support (where
it describes the ordering in the binary data from the chrdev).

I'd rather we stuck to using the addr field, just changed it to an
index like you are doing here.

It's possible a later adding of buffered support would not work with these
particular scan_index values.

Jonathan

> Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - No changes from v1
> 
>  drivers/iio/accel/adxl345_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8e0d56b..6b62f82 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -49,19 +49,19 @@ struct adxl345_data {
>  	u8 data_range;
>  };
>  
> -#define ADXL345_CHANNEL(reg, axis) {					\
> +#define ADXL345_CHANNEL(si, axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
> -	.address = reg,							\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = si,						\
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
> @@ -79,8 +79,9 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
>  		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
>  		 */
> -		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> -				       sizeof(regval));
> +		ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0 +
> +				       sizeof(regval) * chan->scan_index,
> +				       &regval, sizeof(regval));
>  		if (ret < 0)
>  			return ret;
>  

