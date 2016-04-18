Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 18 Apr 2016 14:52:17 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Christoph Mair <christoph.mair@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 2/2] iio: pressure: bmp280: add ability to control
 oversampling rate
Message-ID: <20160418115216.GB20350@vdogaru>
References: <1460742827-6502-1-git-send-email-akinobu.mita@gmail.com>
 <1460742827-6502-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460742827-6502-3-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Akinobu,

On Sat, Apr 16, 2016 at 02:53:47AM +0900, Akinobu Mita wrote:
> This adds ability to control the oversampling ratio of the temperature
> and pressure measurement for both bmp180 and bmp280.
> (bmp280 is untested for now)

Code looks good, but I found a pretty big issue when testing with the
actual device.  Details inline.

> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: Christoph Mair <christoph.mair@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  drivers/iio/pressure/bmp280.c | 202 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 184 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 28daa74..fd931c7 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -50,19 +50,21 @@
>  
>  #define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
>  #define BMP280_OSRS_TEMP_SKIP		0
> -#define BMP280_OSRS_TEMP_1X		BIT(5)
> -#define BMP280_OSRS_TEMP_2X		BIT(6)
> -#define BMP280_OSRS_TEMP_4X		(BIT(6) | BIT(5))
> -#define BMP280_OSRS_TEMP_8X		BIT(7)
> -#define BMP280_OSRS_TEMP_16X		(BIT(7) | BIT(5))
> +#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
> +#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
> +#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
> +#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
> +#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
> +#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
>  
>  #define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
>  #define BMP280_OSRS_PRESS_SKIP		0
> -#define BMP280_OSRS_PRESS_1X		BIT(2)
> -#define BMP280_OSRS_PRESS_2X		BIT(3)
> -#define BMP280_OSRS_PRESS_4X		(BIT(3) | BIT(2))
> -#define BMP280_OSRS_PRESS_8X		BIT(4)
> -#define BMP280_OSRS_PRESS_16X		(BIT(4) | BIT(2))
> +#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
> +#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
> +#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
> +#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
> +#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
> +#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
>  
>  #define BMP280_MODE_MASK		(BIT(1) | BIT(0))
>  #define BMP280_MODE_SLEEP		0
> @@ -104,6 +106,9 @@ struct bmp280_data {
>  	struct regmap *regmap;
>  	const struct bmp280_chip_info *chip_info;
>  
> +	u8 oversampling_press;
> +	u8 oversampling_temp;
> +
>  	/*
>  	 * Carryover value from temperature conversion, used in pressure
>  	 * calculation.
> @@ -114,6 +119,12 @@ struct bmp280_data {
>  struct bmp280_chip_info {
>  	const struct regmap_config *regmap_config;
>  
> +	const int *oversampling_temp_avail;
> +	int num_oversampling_temp_avail;
> +
> +	const int *oversampling_press_avail;
> +	int num_oversampling_press_avail;
> +
>  	int (*chip_config)(struct bmp280_data *);
>  	int (*read_temp)(struct bmp280_data *, int *);
>  	int (*read_press)(struct bmp280_data *, int *, int *);
> @@ -129,11 +140,13 @@ enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  };
>  
> @@ -339,6 +352,21 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = 1 << data->oversampling_press;
> +			ret = IIO_VAL_INT;
> +			break;
> +		case IIO_TEMP:
> +			*val = 1 << data->oversampling_temp;
> +			ret = IIO_VAL_INT;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -349,22 +377,135 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
> +					       int val)
> +{
> +	int i;
> +	const int *avail = data->chip_info->oversampling_temp_avail;
> +	const int n = data->chip_info->num_oversampling_temp_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i] == val) {
> +			data->oversampling_temp = ilog2(val);

This is incorrect.  According to the datasheet, you should add 1 to the
return value of ilog2.  Thus, if val is 16, ilog2 is 4 and the
oversampling factor should be set to 5.  See Table 21 and Table 22 of
the BMP280 datasheet.

I wouldn't have noticed this but for the following bug: as the code
stands right now, setting an oversampling factor of 1 will result in
setting the bits in the register to 0, which corresponds to "skip
measurement" and a constant reading of 25.0C and ~77kPa.

> +
> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
> +					       int val)
> +{
> +	int i;
> +	const int *avail = data->chip_info->oversampling_press_avail;
> +	const int n = data->chip_info->num_oversampling_press_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i] == val) {
> +			data->oversampling_press = ilog2(val);

Same remark as above.

Thanks,
Vlad
