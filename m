Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37148 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbbHQT2o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Aug 2015 15:28:44 -0400
Date: Mon, 17 Aug 2015 21:28:41 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Teodora Baluta <teodora.baluta@intel.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: magnetometer: add mmc34160 magnetometer driver
In-Reply-To: <1439826269-14849-1-git-send-email-teodora.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1508172124490.5283@pmeerw.net>
References: <1439826269-14849-1-git-send-email-teodora.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Aug 2015, Teodora Baluta wrote:

> This patch adds support for the MMC34160 3-axis magnetometer driver. The
> MMC31460 magnetometer driver uses the same register map as MMC35240 with
> different specifications for sensitivity.
> 
> According to Memsic specification, for the MMC31460 sensor, there is no
> need to apply compensation to the read values. Also, the MMC34160 sensor
> does not use the same formula as MMC35240 for transforming raw data into
> mgauss, and the current formula is based on the input driver (mmc3416x)
> provided by Memsic.

comments below
 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
> ---
> Changes since v3:
> - rebased to apply correctly
> - include bits that went missing from v2 to v3
> - remove return variable from mmc34160_raw_to_mgauss function
> 
>  drivers/iio/magnetometer/Kconfig    |   4 +-
>  drivers/iio/magnetometer/mmc35240.c | 205 ++++++++++++++++++++++++++++--------
>  2 files changed, 162 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 868abad..df3f4cc 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -70,8 +70,8 @@ config MMC35240
>  	select REGMAP_I2C
>  	depends on I2C
>  	help
> -	  Say yes here to build support for the MEMSIC MMC35240 3-axis
> -	  magnetic sensor.
> +	  Say yes here to build support for the MEMSIC MMC35240 and MMC34160
> +	  3-axis magnetic sensors.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mmc35240.
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 176e14a..e4fc5e4 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -83,6 +83,20 @@
>  
>  #define MMC35240_OTP_START_ADDR		0x1B
>  
> +#define MMC35240_CHIP_ID	0x08
> +#define MMC34160_CHIP_ID	0x06
> +
> +enum mmc35240_chipset {
> +	MMC35240,
> +	MMC34160,
> +	MMC_MAX_CHIPS
> +};
> +
> +static u8 chip_ids[MMC_MAX_CHIPS] = {

mmc35240_ prefix missing

> +	MMC35240_CHIP_ID,
> +	MMC34160_CHIP_ID,
> +};
> +
>  enum mmc35240_resolution {
>  	MMC35240_16_BITS_SLOW = 0, /* 7.92 ms */
>  	MMC35240_16_BITS_FAST,     /* 4.08 ms */
> @@ -99,27 +113,53 @@ enum mmc35240_axis {
>  static const struct {
>  	int sens[3]; /* sensitivity per X, Y, Z axis */
>  	int nfo; /* null field output */
> -} mmc35240_props_table[] = {
> -	/* 16 bits, 125Hz ODR */
> -	{
> -		{1024, 1024, 1024},
> -		32768,
> -	},
> -	/* 16 bits, 250Hz ODR */
> -	{
> -		{1024, 1024, 770},
> -		32768,
> -	},
> -	/* 14 bits, 450Hz ODR */
> +} mmc35240_props_table[MMC_MAX_CHIPS][4] = {
> +	/* MMC35240 */
>  	{
> -		{256, 256, 193},
> -		8192,
> +		/* 16 bits, 125Hz ODR */
> +		{
> +			{1024, 1024, 1024},
> +			32768,
> +		},
> +		/* 16 bits, 250Hz ODR */
> +		{
> +			{1024, 1024, 770},
> +			32768,
> +		},
> +		/* 14 bits, 450Hz ODR */
> +		{
> +			{256, 256, 193},
> +			8192,
> +		},
> +		/* 12 bits, 800Hz ODR */
> +		{
> +			{64, 64, 48},
> +			2048,
> +		},
>  	},
> -	/* 12 bits, 800Hz ODR */
> +	/* MMC34160 */
>  	{
> -		{64, 64, 48},
> -		2048,
> -	},
> +		/* 16 bits, 125Hz ODR */
> +		{
> +			{2048, 2048, 2048},
> +			32768,
> +		},
> +		/* 16 bits, 250Hz ODR */
> +		{
> +			{2048, 2048, 2048},
> +			32768,
> +		},
> +		/* 14 bits, 450Hz ODR */
> +		{
> +			{512, 512, 512},
> +			8192,
> +		},
> +		/* 12 bits, 800Hz ODR */
> +		{
> +			{128, 128, 128},
> +			2048,
> +		},
> +	}
>  };
>  
>  struct mmc35240_data {
> @@ -131,6 +171,7 @@ struct mmc35240_data {
>  	/* OTP compensation */
>  	int axis_coef[3];
>  	int axis_scale[3];
> +	enum mmc35240_chipset chipset;
>  };
>  
>  static const struct {
> @@ -206,6 +247,16 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
>  
>  }
>  
> +static inline bool mmc35240_needs_compensation(enum mmc35240_chipset chipset)

maybe drop inline and let the compiler figure out

> +{
> +	switch (chipset) {
> +	case MMC35240:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int mmc35240_init(struct mmc35240_data *data)
>  {
>  	int ret, y_convert, z_convert;
> @@ -220,6 +271,11 @@ static int mmc35240_init(struct mmc35240_data *data)
>  
>  	dev_dbg(&data->client->dev, "MMC35240 chip id %x\n", reg_id);
>  
> +	if (reg_id != chip_ids[data->chipset]) {
> +		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
> +		return -ENODEV;
> +	}
> +
>  	/*
>  	 * make sure we restore sensor characteristics, by doing
>  	 * a SET/RESET sequence, the axis polarity being naturally
> @@ -241,6 +297,9 @@ static int mmc35240_init(struct mmc35240_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!mmc35240_needs_compensation(data->chipset))
> +		return 0;
> +
>  	ret = regmap_bulk_read(data->regmap, MMC35240_OTP_START_ADDR,
>  			       (u8 *)otp_data, sizeof(otp_data));
>  	if (ret < 0)
> @@ -302,9 +361,37 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
>  				3 * sizeof(__le16));
>  }
>  
> +static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo,
> +				  int index, int *val)
> +{
> +	return (raw[index] - nfo) * 1000 / sens[index];
> +}
> +
> +static int mmc35240_raw_to_mgauss(int raw[3], int sens[3], int nfo,
> +				  int index, int *val)
> +{
> +	switch (index) {
> +	case AXIS_X:
> +		*val = (raw[AXIS_X] - nfo) * 1000 / sens[AXIS_X];
> +		break;
> +	case AXIS_Y:
> +		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] -
> +			(raw[AXIS_Z] - nfo)  * 1000 / sens[AXIS_Z];
> +		break;
> +	case AXIS_Z:
> +		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] +
> +			(raw[AXIS_Z] - nfo) * 1000 / sens[AXIS_Z];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
> - * mmc35240_raw_to_mgauss - convert raw readings to milli gauss. Also apply
> -			    compensation for output value.
> + * memsic_raw_to_mgauss - convert raw readings to milli gauss. Also apply
> +			  compensation for output value.

why the name change?

>   *
>   * @data: device private data
>   * @index: axis index for which we want the conversion
> @@ -313,40 +400,42 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
>   *
>   * Returns: 0 in case of success, -EINVAL when @index is not valid
>   */
> -static int mmc35240_raw_to_mgauss(struct mmc35240_data *data, int index,
> -				  __le16 buf[], int *val)
> +static int memsic_raw_to_mgauss(struct mmc35240_data *data, int index,
> +				__le16 buf[], int *val)
>  {
>  	int raw[3];
>  	int sens[3];
>  	int nfo;
> +	int ret;
> +	int id = data->chipset;
>  
>  	raw[AXIS_X] = le16_to_cpu(buf[AXIS_X]);
>  	raw[AXIS_Y] = le16_to_cpu(buf[AXIS_Y]);
>  	raw[AXIS_Z] = le16_to_cpu(buf[AXIS_Z]);
>  
> -	sens[AXIS_X] = mmc35240_props_table[data->res].sens[AXIS_X];
> -	sens[AXIS_Y] = mmc35240_props_table[data->res].sens[AXIS_Y];
> -	sens[AXIS_Z] = mmc35240_props_table[data->res].sens[AXIS_Z];
> +	sens[AXIS_X] = mmc35240_props_table[id][data->res].sens[AXIS_X];
> +	sens[AXIS_Y] = mmc35240_props_table[id][data->res].sens[AXIS_Y];
> +	sens[AXIS_Z] = mmc35240_props_table[id][data->res].sens[AXIS_Z];
>  
> -	nfo = mmc35240_props_table[data->res].nfo;
>  
> -	switch (index) {
> -	case AXIS_X:
> -		*val = (raw[AXIS_X] - nfo) * 1000 / sens[AXIS_X];
> -		break;
> -	case AXIS_Y:
> -		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] -
> -			(raw[AXIS_Z] - nfo)  * 1000 / sens[AXIS_Z];
> -		break;
> -	case AXIS_Z:
> -		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y] +
> -			(raw[AXIS_Z] - nfo) * 1000 / sens[AXIS_Z];
> -		break;
> +	nfo = mmc35240_props_table[id][data->res].nfo;
> +
> +	switch (id) {
> +	case MMC35240:
> +		ret = mmc35240_raw_to_mgauss(raw, sens, nfo, index, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* apply OTP compensation */
> +		*val = (*val) * data->axis_coef[index] /
> +			data->axis_scale[index];
> +
> +		return 0;
> +	case MMC34160:
> +		return mmc34160_raw_to_mgauss(raw, sens, nfo, index, val);
>  	default:
>  		return -EINVAL;
>  	}
> -	/* apply OTP compensation */
> -	*val = (*val) * data->axis_coef[index] / data->axis_scale[index];
>  
>  	return 0;
>  }
> @@ -367,7 +456,7 @@ static int mmc35240_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->mutex);
>  		if (ret < 0)
>  			return ret;
> -		ret = mmc35240_raw_to_mgauss(data, chan->address, buf, val);
> +		ret = memsic_raw_to_mgauss(data, chan->address, buf, val);
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT;
> @@ -485,12 +574,27 @@ static const struct regmap_config mmc35240_regmap_config = {
>  	.num_reg_defaults = ARRAY_SIZE(mmc35240_reg_defaults),
>  };
>  
> +static const char *mmc35240_match_acpi_device(struct device *dev,
> +					      enum mmc35240_chipset *chipset)
> +{
> +	const struct acpi_device_id *id;
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return NULL;
> +
> +	*chipset = (enum mmc35240_chipset)id->driver_data;
> +
> +	return dev_name(dev);
> +}
> +
>  static int mmc35240_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct mmc35240_data *data;
>  	struct iio_dev *indio_dev;
>  	struct regmap *regmap;
> +	const char *name;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -509,11 +613,20 @@ static int mmc35240_probe(struct i2c_client *client,
>  	data->regmap = regmap;
>  	data->res = MMC35240_16_BITS_SLOW;
>  
> +	if (id) {
> +		data->chipset = (enum mmc35240_chipset)(id->driver_data);
> +		name = id->name;
> +	} else if (ACPI_HANDLE(&client->dev)) {
> +		name = mmc35240_match_acpi_device(&client->dev,
> +						  &data->chipset);
> +	} else
> +		return -ENODEV;
> +
>  	mutex_init(&data->mutex);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &mmc35240_info;
> -	indio_dev->name = MMC35240_DRV_NAME;
> +	indio_dev->name = name;
>  	indio_dev->channels = mmc35240_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(mmc35240_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -566,14 +679,16 @@ static const struct of_device_id mmc35240_of_match[] = {
>  MODULE_DEVICE_TABLE(of, mmc35240_of_match);
>  
>  static const struct acpi_device_id mmc35240_acpi_match[] = {
> -	{"MMC35240", 0},
> +	{"MMC35240", MMC35240},
> +	{"MMC34160", MMC34160},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
>  
>  static const struct i2c_device_id mmc35240_id[] = {
> -	{"mmc35240", 0},
> -	{}
> +	{"mmc35240", MMC35240},
> +	{"mmc34160", MMC34160},
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mmc35240_id);
>  
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
