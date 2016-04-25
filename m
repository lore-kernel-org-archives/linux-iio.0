Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 25 Apr 2016 13:18:19 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Christoph Mair <christoph.mair@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/2] iio: pressure: bmp280: add ability to control
 oversampling rate
Message-ID: <20160425101818.GB13732@vdogaru>
References: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com>
 <1461505931-21884-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461505931-21884-3-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 24, 2016 at 10:52:11PM +0900, Akinobu Mita wrote:
> This adds ability to control the oversampling ratio of the temperature
> and pressure measurement for both bmp180 and bmp280.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: Christoph Mair <christoph.mair@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Vlad Dogaru <vlad.dogaru@intel.com>

> ---
> * v3
> - fix oversampling register setting for bmp280, spotted by Vlad Dogaru
> 
>  drivers/iio/pressure/bmp280.c | 203 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 185 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index dcf3b0a..2f1498e 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -48,19 +48,21 @@
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
> @@ -98,6 +100,10 @@ struct bmp280_data {
>  	struct regmap *regmap;
>  	const struct bmp280_chip_info *chip_info;
>  
> +	/* log of base 2 of oversampling rate */
> +	u8 oversampling_press;
> +	u8 oversampling_temp;
> +
>  	/*
>  	 * Carryover value from temperature conversion, used in pressure
>  	 * calculation.
> @@ -108,6 +114,12 @@ struct bmp280_data {
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
> @@ -123,11 +135,13 @@ enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
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
> @@ -333,6 +347,21 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
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
> @@ -343,22 +372,135 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
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
> +
> +			return data->chip_info->chip_config(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int bmp280_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret = 0;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		mutex_lock(&data->lock);
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			ret = bmp280_write_oversampling_ratio_press(data, val);
> +			break;
> +		case IIO_TEMP:
> +			ret = bmp280_write_oversampling_ratio_temp(data, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t bmp280_show_avail(char *buf, const int *vals, const int n)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < n; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", vals[i]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bmp280_show_avail(buf, data->chip_info->oversampling_temp_avail,
> +				 data->chip_info->num_oversampling_temp_avail);
> +}
> +
> +static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bmp280_show_avail(buf, data->chip_info->oversampling_press_avail,
> +				 data->chip_info->num_oversampling_press_avail);
> +}
> +
> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available,
> +	S_IRUGO, bmp280_show_temp_oversampling_avail, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_pressure_oversampling_ratio_available,
> +	S_IRUGO, bmp280_show_press_oversampling_avail, NULL, 0);
> +
> +static struct attribute *bmp280_attributes[] = {
> +	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
> +	&iio_dev_attr_in_pressure_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmp280_attrs_group = {
> +	.attrs = bmp280_attributes,
> +};
> +
>  static const struct iio_info bmp280_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &bmp280_read_raw,
> +	.write_raw = &bmp280_write_raw,
> +	.attrs = &bmp280_attrs_group,
>  };
>  
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	int ret;
> +	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
> +		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				 BMP280_OSRS_TEMP_MASK |
>  				 BMP280_OSRS_PRESS_MASK |
>  				 BMP280_MODE_MASK,
> -				 BMP280_OSRS_TEMP_2X |
> -				 BMP280_OSRS_PRESS_16X |
> -				 BMP280_MODE_NORMAL);
> +				 osrs | BMP280_MODE_NORMAL);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"failed to write ctrl_meas register\n");
> @@ -377,8 +519,17 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  	return ret;
>  }
>  
> +static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
>  static const struct bmp280_chip_info bmp280_chip_info = {
>  	.regmap_config = &bmp280_regmap_config,
> +
> +	.oversampling_temp_avail = bmp280_oversampling_avail,
> +	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +
> +	.oversampling_press_avail = bmp280_oversampling_avail,
> +	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> +
>  	.chip_config = bmp280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> @@ -433,7 +584,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  	if (ctrl_meas == BMP180_MEAS_TEMP)
>  		delay_us = 4500;
>  	else
> -		delay_us = conversion_time_max[ilog2(8)];
> +		delay_us = conversion_time_max[data->oversampling_press];
>  
>  	usleep_range(delay_us, delay_us + 1000);
>  
> @@ -573,7 +724,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  {
>  	int ret;
>  	__be32 tmp = 0;
> -	u8 oss = ilog2(8);
> +	u8 oss = data->oversampling_press;
>  
>  	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
>  	if (ret)
> @@ -599,7 +750,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
>  	s32 x1, x2, x3, p;
>  	s32 b3, b6;
>  	u32 b4, b7;
> -	s32 oss = ilog2(8);
> +	s32 oss = data->oversampling_press;
>  	struct bmp180_calib calib;
>  
>  	ret = bmp180_read_calib(data, &calib);
> @@ -660,8 +811,20 @@ static int bmp180_chip_config(struct bmp280_data *data)
>  	return 0;
>  }
>  
> +static const int bmp180_oversampling_temp_avail[] = { 1 };
> +static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
> +
>  static const struct bmp280_chip_info bmp180_chip_info = {
>  	.regmap_config = &bmp180_regmap_config,
> +
> +	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
> +	.num_oversampling_temp_avail =
> +		ARRAY_SIZE(bmp180_oversampling_temp_avail),
> +
> +	.oversampling_press_avail = bmp180_oversampling_press_avail,
> +	.num_oversampling_press_avail =
> +		ARRAY_SIZE(bmp180_oversampling_press_avail),
> +
>  	.chip_config = bmp180_chip_config,
>  	.read_temp = bmp180_read_temp,
>  	.read_press = bmp180_read_press,
> @@ -693,9 +856,13 @@ static int bmp280_probe(struct i2c_client *client,
>  	switch (id->driver_data) {
>  	case BMP180_CHIP_ID:
>  		data->chip_info = &bmp180_chip_info;
> +		data->oversampling_press = ilog2(8);
> +		data->oversampling_temp = ilog2(1);
>  		break;
>  	case BMP280_CHIP_ID:
>  		data->chip_info = &bmp280_chip_info;
> +		data->oversampling_press = ilog2(16);
> +		data->oversampling_temp = ilog2(2);
>  		break;
>  	default:
>  		return -EINVAL;
> -- 
> 2.5.0
> 
