Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44041 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbcDLFV7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Apr 2016 01:21:59 -0400
Date: Tue, 12 Apr 2016 07:21:57 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <matt.ranostay@intel.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 3/3] iio: pressure: bmp280: add humidity support
In-Reply-To: <1460438494-16135-4-git-send-email-matt.ranostay@intel.com>
Message-ID: <alpine.DEB.2.20.12.1604120720230.31934@pmeerw.net>
References: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com> <1460438494-16135-4-git-send-email-matt.ranostay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Enable humidity support for the BME280 part

this also changes unrelated comments referring to datasheets

does this chip really use both, LE (in _compensate_humidity) and BE in 
(read_humidity)?
 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  drivers/iio/pressure/bmp280.c | 137 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 133 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index e80cbf3b21fc..9e3a9f00cd84 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -18,6 +18,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +#define BMP280_REG_HUMIDITY_LSB		0xFE
> +#define BMP280_REG_HUMIDITY_MSB		0xFD
>  #define BMP280_REG_TEMP_XLSB		0xFC
>  #define BMP280_REG_TEMP_LSB		0xFB
>  #define BMP280_REG_TEMP_MSB		0xFA
> @@ -26,11 +28,20 @@
>  #define BMP280_REG_PRESS_MSB		0xF7
>  
>  #define BMP280_REG_CONFIG		0xF5
> +#define BMP280_REG_CTRL_HUMIDITY	0xF2
>  #define BMP280_REG_CTRL_MEAS		0xF4
>  #define BMP280_REG_STATUS		0xF3
>  #define BMP280_REG_RESET		0xE0
>  #define BMP280_REG_ID			0xD0
>  
> +/* Due to non linear mapping, and data sizes we can't do a bulk read */
> +#define BMP280_REG_COMP_H1		0xA1
> +#define BMP280_REG_COMP_H2		0xE1
> +#define BMP280_REG_COMP_H3		0xE3
> +#define BMP280_REG_COMP_H4		0xE4
> +#define BMP280_REG_COMP_H5		0xE5
> +#define BMP280_REG_COMP_H6		0xE7
> +
>  #define BMP280_REG_COMP_TEMP_START	0x88
>  #define BMP280_COMP_TEMP_REG_COUNT	6
>  
> @@ -44,6 +55,14 @@
>  #define BMP280_FILTER_8X		(BIT(3) | BIT(2))
>  #define BMP280_FILTER_16X		BIT(4)
>  
> +#define BMP280_OSRS_HUMIDITY_MASK	(BIT(2) | BIT(1) | BIT(0))
> +#define BMP280_OSRS_HUMIDITY_SKIP	0
> +#define BMP280_OSRS_HUMIDITY_1X		BIT(0)
> +#define BMP280_OSRS_HUMIDITY_2X		BIT(1)
> +#define BMP280_OSRS_HUMIDITY_4X		(BIT(1) | BIT(0))
> +#define BMP280_OSRS_HUMIDITY_8X		BIT(2)
> +#define BMP280_OSRS_HUMIDITY_16X	(BIT(2) | BIT(0))
> +
>  #define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
>  #define BMP280_OSRS_TEMP_SKIP		0
>  #define BMP280_OSRS_TEMP_1X		BIT(5)
> @@ -93,6 +112,13 @@ struct bmp280_chip_info {
>  	int (*init)(struct bmp280_data *);
>  };
>  
> +static int bme280_chip_init(struct bmp280_data *data)
> +{
> +	return regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
> +				  BMP280_OSRS_HUMIDITY_MASK,
> +				  BMP280_OSRS_HUMIDITY_16X);
> +}
> +
>  static struct bmp280_chip_info bmp280_chip_info_table[] = {
>  	[bmp280] = {
>  		.id = BMP280_CHIP_ID,
> @@ -100,7 +126,8 @@ static struct bmp280_chip_info bmp280_chip_info_table[] = {
>  	},
>  	[bme280] = {
>  		.id = BME280_CHIP_ID,
> -		.num_channels = 2,
> +		.num_channels = 3,
> +		.init = bme280_chip_init,
>  	},
>  };
>  
> @@ -120,12 +147,17 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
>  };
>  
>  static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case BMP280_REG_CONFIG:
> +	case BMP280_REG_CTRL_HUMIDITY:
>  	case BMP280_REG_CTRL_MEAS:
>  	case BMP280_REG_RESET:
>  		return true;
> @@ -137,6 +169,8 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
>  static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case BMP280_REG_HUMIDITY_LSB:
> +	case BMP280_REG_HUMIDITY_MSB:
>  	case BMP280_REG_TEMP_XLSB:
>  	case BMP280_REG_TEMP_LSB:
>  	case BMP280_REG_TEMP_MSB:
> @@ -154,7 +188,7 @@ static const struct regmap_config bmp280_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  
> -	.max_register = BMP280_REG_TEMP_XLSB,
> +	.max_register = BMP280_REG_HUMIDITY_LSB,
>  	.cache_type = REGCACHE_RBTREE,
>  
>  	.writeable_reg = bmp280_is_writeable_reg,
> @@ -162,11 +196,74 @@ static const struct regmap_config bmp280_regmap_config = {
>  };
>  
>  /*
> + * Returns humidity in percent, resolution is 0.01 percent. Output value of
> + * "47445" represents 47445/1024 = 46.333 %RH.
> + *
> + * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
> + */
> +
> +static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> +				      s32 adc_humidity)
> +{
> +	struct device *dev = &data->client->dev;
> +	unsigned int H1, H3, tmp;
> +	int H2, H4, H5, H6, ret, var;
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &H1);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H1 comp value\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H2 comp value\n");
> +		return ret;
> +	}
> +	H2 = sign_extend32(le16_to_cpu(tmp), 15);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &H3);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H3 comp value\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H4 comp value\n");
> +		return ret;
> +	}
> +	H4 = sign_extend32(le16_to_cpu(tmp) >> 4 | (le16_to_cpu(tmp) & 0xf), 11);
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H5 comp value\n");
> +		return ret;
> +	}
> +	H5 = sign_extend32(le16_to_cpu(tmp) & 0xfff, 11);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read H6 comp value\n");
> +		return ret;
> +	}
> +	H6 = sign_extend32(tmp, 7);
> +
> +	var = ((s32)data->t_fine) - 76800;
> +	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
> +		* (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
> +		+ 2097152) * H2 + 8192) >> 14);
> +	var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
> +
> +	return var >> 12;
> +};
> +
> +/*
>   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
>   * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
>   * value.
>   *
> - * Taken from datasheet, Section 3.11.3, "Compensation formula".
> + * Taken from BMP280 datasheet, Section 3.11.3, "Compensation formula".
>   */
>  static s32 bmp280_compensate_temp(struct bmp280_data *data,
>  				  s32 adc_temp)
> @@ -206,7 +303,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>   * integer bits and 8 fractional bits).  Output value of "24674867"
>   * represents 24674867/256 = 96386.2 Pa = 963.862 hPa
>   *
> - * Taken from datasheet, Section 3.11.3, "Compensation formula".
> + * Taken from BMP280 datasheet, Section 3.11.3, "Compensation formula".
>   */
>  static u32 bmp280_compensate_press(struct bmp280_data *data,
>  				   s32 adc_press)
> @@ -301,6 +398,35 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	return IIO_VAL_FRACTIONAL;
>  }
>  
> +static int bmp280_read_humidity(struct bmp280_data *data,
> +				int *val, int *val2)
> +{
> +	int ret;
> +	__be16 tmp = 0;
> +	s32 adc_humidity;
> +	u32 comp_humidity;
> +
> +	/* Read and compensate temperature so we get a reading of t_fine. */
> +	ret = bmp280_read_temp(data, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> +			       (u8 *) &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read humidity\n");
> +		return ret;
> +	}
> +
> +	adc_humidity = be16_to_cpu(tmp);
> +	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> +
> +	*val = comp_humidity;
> +	*val2 = 1024;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
>  static int bmp280_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -313,6 +439,9 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			ret = bmp280_read_humidity(data, val, val2);
> +			break;
>  		case IIO_PRESSURE:
>  			ret = bmp280_read_press(data, val, val2);
>  			break;
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
