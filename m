Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45566 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab2EBJDZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 May 2012 05:03:25 -0400
Message-ID: <4FA0F857.5020106@cam.ac.uk>
Date: Wed, 02 May 2012 10:03:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, marek.belisko@open-nandra.com,
	jic23@kernel.org
Subject: Re: [PATCH] iio: add support for HMC5883/HMC5883L to HMC5843 driver
References: <1335913035-27623-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335913035-27623-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/1/2012 11:57 PM, Peter Meerwald wrote:
> this patch aims at adding support for the HMC5883/HMC5883L magnetometer
> to the HMC5843 driver; the devices are pretty similar, so the existing driver
> is extended (see also http://www.spinics.net/lists/linux-iio/msg04778.html)
>
> the patch is big;
> * some of the changes are cleanup/preparation
> * there are bug fixes along the line of 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72
>    (i2c_get_clientdata(client) points to iio_dev, not hmc5843_data)
> * and finally the code to suppor the new devices
>
> I'd appreciate to get feedback on the general approach to extend the driver; if
> necessary I can try to split up the patch, starting with fixes
You got it in one ;) This needs splitting into fixes first, then 
cleanups then addition of new part.
>
> I only have a HMC5883L, so I cannot test if the HMC5843 code still works
>
> ---
>   drivers/staging/iio/magnetometer/Kconfig   |    8 +-
>   drivers/staging/iio/magnetometer/hmc5843.c |  543 ++++++++++++++++++----------
>   2 files changed, 353 insertions(+), 198 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
> index 722c4e1..b9d9325 100644
> --- a/drivers/staging/iio/magnetometer/Kconfig
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -15,13 +15,13 @@ config SENSORS_AK8975
>   	  will be called ak8975.
>
>   config SENSORS_HMC5843
> -	tristate "Honeywell HMC5843 3-Axis Magnetometer"
> +	tristate "Honeywell HMC5843/5883/5883L 3-Axis Magnetometer"
>   	depends on I2C
>   	help
> -	  Say Y here to add support for the Honeywell HMC 5843 3-Axis
> -	  Magnetometer (digital compass).
> +	  Say Y here to add support for the Honeywell HMC5843, HMC5883 and
> +	  HMC5883L 3-Axis Magnetometer (digital compass).
>
>   	  To compile this driver as a module, choose M here: the module
> -	  will be called hmc5843
> +	  will be called hmc5843.
>
>   endmenu
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index e7cc9e0..019c631 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -2,6 +2,8 @@
>       Author: Shubhrajyoti Datta<shubhrajyoti@ti.com>
>       Acknowledgement: Jonathan Cameron<jic23@cam.ac.uk>  for valuable inputs.
>
> +    Support for HMC5883 and HMC5883L by Peter Meerwald<pmeerw@pmeerw.net>.
> +
>       This program is free software; you can redistribute it and/or modify
>       it under the terms of the GNU General Public License as published by
>       the Free Software Foundation; either version 2 of the License, or
> @@ -22,83 +24,136 @@
>   #include<linux/i2c.h>
>   #include<linux/slab.h>
>   #include<linux/types.h>
> +
>   #include<linux/iio/iio.h>
>   #include<linux/iio/sysfs.h>
>
> -#define HMC5843_I2C_ADDRESS			0x1E
> -
> -#define HMC5843_CONFIG_REG_A			0x00
> -#define HMC5843_CONFIG_REG_B			0x01
> -#define HMC5843_MODE_REG			0x02
> -#define HMC5843_DATA_OUT_X_MSB_REG		0x03
> -#define HMC5843_DATA_OUT_X_LSB_REG		0x04
As a general rule, just stick to naming after the first part supported.
This just adds noise.  Obviously if registers only exist on one then you'll
want to have appropriate named defines.
> +#define HMC58X3_CONFIG_REG_A			0x00
> +#define HMC58X3_CONFIG_REG_B			0x01
> +#define HMC58X3_MODE_REG			0x02
> +#define HMC58X3_DATA_OUT_X_MSB_REG		0x03
> +#define HMC58X3_DATA_OUT_X_LSB_REG		0x04
>   #define HMC5843_DATA_OUT_Y_MSB_REG		0x05
>   #define HMC5843_DATA_OUT_Y_LSB_REG		0x06
>   #define HMC5843_DATA_OUT_Z_MSB_REG		0x07
>   #define HMC5843_DATA_OUT_Z_LSB_REG		0x08
> -#define HMC5843_STATUS_REG			0x09
> -#define HMC5843_ID_REG_A			0x0A
> -#define HMC5843_ID_REG_B			0x0B
> -#define HMC5843_ID_REG_C			0x0C
> +/* Beware: Y and Z are exchanged on HMC5883 */
Got to love hardware guys sometimes....
> +#define HMC5883_DATA_OUT_Z_MSB_REG		0x05
> +#define HMC58X3_DATA_OUT_Z_LSB_REG		0x06
> +#define HMC5883_DATA_OUT_Y_MSB_REG		0x07
> +#define HMC5883_DATA_OUT_Y_LSB_REG		0x08
> +#define HMC58X3_STATUS_REG			0x09
> +#define HMC58X3_ID_REG_A			0x0A
> +#define HMC58X3_ID_REG_B			0x0B
> +#define HMC58X3_ID_REG_C			0x0C
> +
> +enum hmc5843_ids {
> +	HMC5843_ID,
> +	HMC5883_ID,
> +	HMC5883L_ID,
> +};
>
> -#define HMC5843_ID_REG_LENGTH			0x03
> -#define HMC5843_ID_STRING			"H43"
> +/*
> + * Beware: identification of the HMC5883 is still "H43";
> + * I2C address is also unchanged
> + */
> +#define HMC58X3_ID_REG_LENGTH			0x03
> +#define HMC58X3_ID_STRING			"H43"
> +#define HMC58X3_I2C_ADDRESS			0x1E
>
>   /*
> - * Range settings in  (+-)Ga
> - * */
> -#define RANGE_GAIN_OFFSET			0x05
> -
> -#define	RANGE_0_7				0x00
> -#define	RANGE_1_0				0x01 /* default */
> -#define	RANGE_1_5				0x02
> -#define	RANGE_2_0				0x03
> -#define	RANGE_3_2				0x04
> -#define	RANGE_3_8				0x05
> -#define	RANGE_4_5				0x06
> -#define	RANGE_6_5				0x07 /* Not recommended */
> + * Range gain settings in (+-)Ga
> + * Beware: HMC5843 and HMC5883 have different recommended sensor field
> + * ranges; default corresponds to +-1.0 Ga and +-1.3 Ga, respectively
> + */
> +#define HMC58X3_RANGE_GAIN_OFFSET		0x05
> +#define HMC58X3_RANGE_GAIN_DEFAULT		0x01
> +#define HMC58X3_RANGE_GAIN_MAX			0x07
>
>   /*
>    * Device status
>    */
> -#define	DATA_READY				0x01
> -#define	DATA_OUTPUT_LOCK			0x02
> -#define	VOLTAGE_REGULATOR_ENABLED		0x04
> +#define	HMC58X3_DATA_READY			0x01
> +#define	HMC58X3_DATA_OUTPUT_LOCK		0x02
> +/* Does not exist on HMC5883, not used */
> +#define	HMC58X3_VOLTAGE_REGULATOR_ENABLED	0x04
>
>   /*
>    * Mode register configuration
>    */
> -#define	MODE_CONVERSION_CONTINUOUS		0x00
> -#define	MODE_CONVERSION_SINGLE			0x01
> -#define	MODE_IDLE				0x02
> -#define	MODE_SLEEP				0x03
> -
> -/* Minimum Data Output Rate in 1/10 Hz  */
> -#define RATE_OFFSET				0x02
> -#define RATE_BITMASK				0x1C
> -#define	RATE_5					0x00
> -#define	RATE_10					0x01
> -#define	RATE_20					0x02
> -#define	RATE_50					0x03
> -#define	RATE_100				0x04
> -#define	RATE_200				0x05
> -#define	RATE_500				0x06
> -#define	RATE_NOT_USED				0x07
> +#define	HMC58X3_MODE_CONVERSION_CONTINUOUS	0x00
> +#define	HMC58X3_MODE_CONVERSION_SINGLE		0x01
> +#define	HMC58X3_MODE_IDLE			0x02
> +#define	HMC58X3_MODE_SLEEP			0x03
> +#define HMC58X3_MODE_MASK			0x03
>
>   /*
> - * Device Configuration
> + * HMC5843: Minimum data output rate
> + * HMC5883: Typical data output rate
>    */
> -#define	CONF_NORMAL				0x00
> -#define	CONF_POSITIVE_BIAS			0x01
> -#define	CONF_NEGATIVE_BIAS			0x02
> -#define	CONF_NOT_USED				0x03
> -#define	MEAS_CONF_MASK				0x03
> +#define HMC58X3_RATE_OFFSET			0x02
> +#define HMC58X3_RATE_BITMASK			0x1C
> +#define	HMC58X3_RATE_NOT_USED			0x07
>
> -static int hmc5843_regval_to_nanoscale[] = {
> +/*
> + * Device measurement configuration
> + */
> +#define	HMC58X3_MEAS_CONF_NORMAL		0x00
> +#define	HMC58X3_MEAS_CONF_POSITIVE_BIAS		0x01
> +#define	HMC58X3_MEAS_CONF_NEGATIVE_BIAS		0x02
> +#define	HMC58X3_MEAS_CONF_NOT_USED		0x03
> +#define	HMC58X3_MEAS_CONF_MASK			0x03
> +
> +/*
> + * Scaling factors: 10000000/Gain
> + */
> +static const int hmc5843_regval_to_nanoscale[] = {
>   	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
>   };
>
> -static const int regval_to_input_field_mg[] = {
> +static const int hmc5883_regval_to_nanoscale[] = {
> +	7812, 9766, 13021, 16287, 24096, 27701, 32573, 45662
> +};
> +
> +static const int hmc5883l_regval_to_nanoscale[] = {
> +	7299, 9174, 12195, 15152, 22727, 25641, 30303, 43478
> +};
> +
> +/*
> + * From the HMC5843 datasheet:
> + * Value	| Sensor input field range (Ga)	| Gain (counts/milli-Gauss)
> + * 0		| (+-)0.7			| 1620
> + * 1		| (+-)1.0			| 1300
> + * 2		| (+-)1.5			| 970
> + * 3		| (+-)2.0			| 780
> + * 4		| (+-)3.2			| 530
> + * 5		| (+-)3.8			| 460
> + * 6		| (+-)4.5			| 390
> + * 7		| (+-)6.5			| 280
> + *
> + * From the HMC5883 datasheet:
> + * Value	| Recommended sensor field range (Ga)	| Gain (counts/Gauss)
> + * 0		| (+-)0.9				| 1280
> + * 1		| (+-)1.2				| 1024
> + * 2		| (+-)1.9				| 768
> + * 3		| (+-)2.5				| 614
> + * 4		| (+-)4.0				| 415
> + * 5		| (+-)4.6				| 361
> + * 6		| (+-)5.5				| 307
> + * 7		| (+-)7.9				| 219
> + *
> + * From the HMC5883L datasheet:
> + * Value	| Recommended sensor field range (Ga)	| Gain (LSB/Gauss)
> + * 0		| (+-)0.88				| 1370
> + * 1		| (+-)1.3				| 1090
> + * 2		| (+-)1.9				| 820
> + * 3		| (+-)2.5				| 660
> + * 4		| (+-)4.0				| 440
> + * 5		| (+-)4.7				| 390
> + * 6		| (+-)5.6				| 330
> + * 7		| (+-)8.1				| 230
> + */
> +static const int hmc5843_regval_to_input_field_mga[] = {
>   	700,
>   	1000,
>   	1500,
> @@ -108,7 +163,44 @@ static const int regval_to_input_field_mg[] = {
>   	4500,
>   	6500
>   };
> -static const char * const regval_to_samp_freq[] = {
> +
> +static const int hmc5883_regval_to_input_field_mga[] = {
> +	900,
> +	1200,
> +	1900,
> +	2500,
> +	4000,
> +	4600,
> +	5500,
> +	7900
> +};
> +
> +static const int hmc5883l_regval_to_input_field_mga[] = {
> +	880,
> +	1300,
> +	1900,
> +	2500,
> +	4000,
> +	4700,
> +	5600,
> +	8100
> +};
> +
> +
> +/*
> + * From the datasheet:
> + * Value	| HMC5843		| HMC5883/HMC5883L
> + *		| Data output rate (Hz)	| Data output rate (Hz)
> + * 0		| 0.5			| 0.75
> + * 1		| 1			| 1.5
> + * 2		| 2			| 3
> + * 3		| 5			| 7.5
> + * 4		| 10 (default)		| 15
> + * 5		| 20			| 30
> + * 6		| 50			| 75
> + * 7		| Not used		| Not used
> + */
> +static const char * const hmc5843_regval_to_samp_freq[] = {
>   	"0.5",
>   	"1",
>   	"2",
> @@ -118,28 +210,39 @@ static const char * const regval_to_samp_freq[] = {
>   	"50",
>   };
>
> +static const char * const hmc5883_regval_to_samp_freq[] = {
> +	"0.75",
> +	"1.5",
> +	"3",
> +	"7.5",
> +	"15",
> +	"30",
> +	"75",
> +};
> +
>   /* Addresses to scan: 0x1E */
> -static const unsigned short normal_i2c[] = { HMC5843_I2C_ADDRESS,
> -							I2C_CLIENT_END };
> +static const unsigned short normal_i2c[] = { HMC58X3_I2C_ADDRESS,
> +					     I2C_CLIENT_END };
>
>   /* Each client has this additional data */
>   struct hmc5843_data {
>   	struct mutex lock;
> -	u8		rate;
> -	u8		meas_conf;
> -	u8		operating_mode;
> -	u8		range;
> +	u8 rate;
> +	u8 meas_conf;
> +	u8 operating_mode;
> +	u8 range;
> +	const char * const *regval_to_sample_freq;
> +	const int *regval_to_input_field_mga;
> +	const int *regval_to_nanoscale;
>   };
>
> -static void hmc5843_init_client(struct i2c_client *client);
> -
> +/* The lower two bits contain the current conversion mode */
>   static s32 hmc5843_configure(struct i2c_client *client,
>   				       u8 operating_mode)
>   {
> -	/* The lower two bits contain the current conversion mode */
>   	return i2c_smbus_write_byte_data(client,
> -					HMC5843_MODE_REG,
> -					(operating_mode&  0x03));
> +					HMC58X3_MODE_REG,
> +					operating_mode&  HMC58X3_MODE_MASK);
>   }
>
>   /* Return the measurement value from the specified channel */
> @@ -152,32 +255,31 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
>   	s32 result;
>
>   	mutex_lock(&data->lock);
> -	result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> -	while (!(result&  DATA_READY))
> -		result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> +	result = i2c_smbus_read_byte_data(client, HMC58X3_STATUS_REG);
> +	while (!(result&  HMC58X3_DATA_READY))
> +		result = i2c_smbus_read_byte_data(client, HMC58X3_STATUS_REG);
>
>   	result = i2c_smbus_read_word_data(client, address);
>   	mutex_unlock(&data->lock);
>   	if (result<  0)
>   		return -EINVAL;
>
> -	*val	= (s16)swab16((u16)result);
> +	*val = (s16)swab16((u16)result);
>   	return IIO_VAL_INT;
>   }
>
> -
>   /*
> - * From the datasheet
> + * From the datasheet:
>    * 0 - Continuous-Conversion Mode: In continuous-conversion mode, the
> - * device continuously performs conversions and places the result in the
> - * data register.
> + *     device continuously performs conversions and places the result in
> + *     the data register.
>    *
> - * 1 - Single-Conversion Mode : device performs a single measurement,
> - *  sets RDY high and returned to sleep mode
> + * 1 - Single-Conversion Mode : Device performs a single measurement,
> + *     sets RDY high and returns to sleep mode.
>    *
> - * 2 - Idle Mode :  Device is placed in idle mode.
> + * 2 - Idle Mode : Device is placed in idle mode.
>    *
> - * 3 - Sleep Mode. Device is placed in sleep mode.
> + * 3 - Sleep Mode : Device is placed in sleep mode.
>    *
>    */
>   static ssize_t hmc5843_show_operating_mode(struct device *dev,
> @@ -201,14 +303,15 @@ static ssize_t hmc5843_set_operating_mode(struct device *dev,
>   	unsigned long operating_mode = 0;
>   	s32 status;
>   	int error;
> +
>   	mutex_lock(&data->lock);
> -	error = strict_strtoul(buf, 10,&operating_mode);
> +	error = kstrtoul(buf, 10,&operating_mode);
>   	if (error) {
>   		count = error;
>   		goto exit;
>   	}
> -	dev_dbg(dev, "set Conversion mode to %lu\n", operating_mode);
> -	if (operating_mode>  MODE_SLEEP) {
> +	dev_dbg(dev, "set conversion mode to %lu\n", operating_mode);
> +	if (operating_mode>  HMC58X3_MODE_SLEEP) {
>   		count = -EINVAL;
>   		goto exit;
>   	}
> @@ -225,35 +328,40 @@ exit:
>   	mutex_unlock(&data->lock);
>   	return count;
>   }
> +
>   static IIO_DEVICE_ATTR(operating_mode,
>   			S_IWUSR | S_IRUGO,
>   			hmc5843_show_operating_mode,
>   			hmc5843_set_operating_mode,
> -			HMC5843_MODE_REG);
> +			HMC58X3_MODE_REG);
>
>   /*
>    * API for setting the measurement configuration to
>    * Normal, Positive bias and Negative bias
> - * From the datasheet
>    *
> - * Normal measurement configuration (default): In normal measurement
> - * configuration the device follows normal measurement flow. Pins BP and BN
> - * are left floating and high impedance.
> + * From the datasheet:
> + * 0 - Normal measurement configuration (default): In normal measurement
> + *     configuration the device follows normal measurement flow. Pins BP
> + *     and BN are left floating and high impedance.
>    *
> - * Positive bias configuration: In positive bias configuration, a positive
> - * current is forced across the resistive load on pins BP and BN.
> + * 1 - Positive bias configuration: In positive bias configuration, a
> + *     positive current is forced across the resistive load on pins BP
> + *     and BN.
>    *
> - * Negative bias configuration. In negative bias configuration, a negative
> - * current is forced across the resistive load on pins BP and BN.
> + * 2 - Negative bias configuration. In negative bias configuration, a
> + *     negative current is forced across the resistive load on pins BP
> + *     and BN.
>    *
>    */
>   static s32 hmc5843_set_meas_conf(struct i2c_client *client,
>   				      u8 meas_conf)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
> -	reg_val = (meas_conf&  MEAS_CONF_MASK) |  (data->rate<<  RATE_OFFSET);
> -	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> +	reg_val = (meas_conf&  HMC58X3_MEAS_CONF_MASK) |
> +		(data->rate<<  HMC58X3_RATE_OFFSET);
> +	return i2c_smbus_write_byte_data(client, HMC58X3_CONFIG_REG_A, reg_val);
>   }
>
>   static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
> @@ -272,14 +380,18 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	unsigned long meas_conf = 0;
> -	int error = strict_strtoul(buf, 10,&meas_conf);
> +	int error;
> +
> +	error = kstrtoul(buf, 10,&meas_conf);
>   	if (error)
>   		return error;
> -	mutex_lock(&data->lock);
> +	if (meas_conf>= HMC58X3_MEAS_CONF_NOT_USED)
> +		return -EINVAL;
>
> -	dev_dbg(dev, "set mode to %lu\n", meas_conf);
> +	mutex_lock(&data->lock);
> +	dev_dbg(dev, "set measurement configuration to %lu\n", meas_conf);
>   	if (hmc5843_set_meas_conf(client, meas_conf)) {
>   		count = -EINVAL;
>   		goto exit;
> @@ -290,43 +402,65 @@ exit:
>   	mutex_unlock(&data->lock);
>   	return count;
>   }
> +
>   static IIO_DEVICE_ATTR(meas_conf,
>   			S_IWUSR | S_IRUGO,
>   			hmc5843_show_measurement_configuration,
>   			hmc5843_set_measurement_configuration,
>   			0);
>
> -/*
> - * From Datasheet
> - * The table shows the minimum data output
> - * Value	| Minimum data output rate(Hz)
> - * 0		| 0.5
> - * 1		| 1
> - * 2		| 2
> - * 3		| 5
> - * 4		| 10 (default)
> - * 5		| 20
> - * 6		| 50
> - * 7		| Not used
> - */
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
> +static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +
> +	char str[128] = "";
> +	int i;
> +
> +	for (i = 0; i<  HMC58X3_RATE_NOT_USED; i++) {
> +		strcat(str, data->regval_to_sample_freq[i]);
> +		strcat(str, " ");
> +	}
> +
> +	return sprintf(buf, "%s", str);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
>
>   static s32 hmc5843_set_rate(struct i2c_client *client,
>   				u8 rate)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	u8 reg_val;
>
> -	reg_val = (data->meas_conf) |  (rate<<  RATE_OFFSET);
> -	if (rate>= RATE_NOT_USED) {
> +	if (rate>= HMC58X3_RATE_NOT_USED) {
>   		dev_err(&client->dev,
> -			"This data output rate is not supported\n");
> +			"data output rate is not supported\n");
>   		return -EINVAL;
>   	}
> -	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> +	reg_val = data->meas_conf | (rate<<  HMC58X3_RATE_OFFSET);
> +	return i2c_smbus_write_byte_data(client, HMC58X3_CONFIG_REG_A, reg_val);
>   }
>
> -static ssize_t set_sampling_frequency(struct device *dev,
> +static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
> +						const char *buf)
> +{
> +	const char * const *samp_freq = data->regval_to_sample_freq;
> +	int i;
> +
> +	for (i = 0; i<  HMC58X3_RATE_NOT_USED; i++) {
> +		if (strncmp(buf, samp_freq[i],
> +			strlen(samp_freq[i])) == 0)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
>   					struct device_attribute *attr,
>   					const char *buf, size_t count)
>   {
> @@ -334,27 +468,17 @@ static ssize_t set_sampling_frequency(struct device *dev,
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
>   	struct hmc5843_data *data = iio_priv(indio_dev);
> -	unsigned long rate = 0;
> -
> -	if (strncmp(buf, "0.5" , 3) == 0)
> -		rate = RATE_5;
> -	else if (strncmp(buf, "1" , 1) == 0)
> -		rate = RATE_10;
> -	else if (strncmp(buf, "2", 1) == 0)
> -		rate = RATE_20;
> -	else if (strncmp(buf, "5", 1) == 0)
> -		rate = RATE_50;
> -	else if (strncmp(buf, "10", 2) == 0)
> -		rate = RATE_100;
> -	else if (strncmp(buf, "20" , 2) == 0)
> -		rate = RATE_200;
> -	else if (strncmp(buf, "50" , 2) == 0)
> -		rate = RATE_500;
> -	else
> -		return -EINVAL;
> +	int rate;
> +
> +	rate = hmc5843_check_sampling_frequency(data, buf);
> +	if (rate<  0) {
> +		dev_err(&client->dev,
> +			"sampling frequency is not supported\n");
> +		return rate;
> +	}
>
>   	mutex_lock(&data->lock);
> -	dev_dbg(dev, "set rate to %lu\n", rate);
> +	dev_dbg(dev, "set rate to %d\n", rate);
>   	if (hmc5843_set_rate(client, rate)) {
>   		count = -EINVAL;
>   		goto exit;
> @@ -366,40 +490,29 @@ exit:
>   	return count;
>   }
>
> -static ssize_t show_sampling_frequency(struct device *dev,
> +static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
>   			struct device_attribute *attr, char *buf)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>   	s32 rate;
>
> -	rate = i2c_smbus_read_byte_data(client,  this_attr->address);
> +	rate = i2c_smbus_read_byte_data(client, this_attr->address);
>   	if (rate<  0)
>   		return rate;
> -	rate = (rate&  RATE_BITMASK)>>  RATE_OFFSET;
> -	return sprintf(buf, "%s\n", regval_to_samp_freq[rate]);
> +	rate = (rate&  HMC58X3_RATE_BITMASK)>>  HMC58X3_RATE_OFFSET;
> +	return sprintf(buf, "%s\n", data->regval_to_sample_freq[rate]);
>   }
> +
>   static IIO_DEVICE_ATTR(sampling_frequency,
>   			S_IWUSR | S_IRUGO,
> -			show_sampling_frequency,
> -			set_sampling_frequency,
> -			HMC5843_CONFIG_REG_A);
> +			hmc5843_show_sampling_frequency,
> +			hmc5843_set_sampling_frequency,
> +			HMC58X3_CONFIG_REG_A);
>
> -/*
> - * From Datasheet
> - *	Nominal gain settings
> - * Value	| Sensor Input Field Range(Ga)	| Gain(counts/ milli-gauss)
> - *0		|(+-)0.7			|1620
> - *1		|(+-)1.0			|1300
> - *2		|(+-)1.5			|970
> - *3		|(+-)2.0			|780
> - *4		|(+-)3.2			|530
> - *5		|(+-)3.8			|460
> - *6		|(+-)4.5			|390
> - *7		|(+-)6.5			|280
> - */
> -static ssize_t show_range(struct device *dev,
> +static ssize_t hmc5843_show_range_gain(struct device *dev,
>   				struct device_attribute *attr,
>   				char *buf)
>   {
> @@ -408,10 +521,10 @@ static ssize_t show_range(struct device *dev,
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>
>   	range = data->range;
> -	return sprintf(buf, "%d\n", regval_to_input_field_mg[range]);
> +	return sprintf(buf, "%d\n", data->regval_to_input_field_mga[range]);
>   }
>
> -static ssize_t set_range(struct device *dev,
> +static ssize_t hmc5843_set_range_gain(struct device *dev,
>   			struct device_attribute *attr,
>   			const char *buf,
>   			size_t count)
> @@ -422,34 +535,35 @@ static ssize_t set_range(struct device *dev,
>   	struct hmc5843_data *data = iio_priv(indio_dev);
>   	unsigned long range = 0;
>   	int error;
> +
>   	mutex_lock(&data->lock);
> -	error = strict_strtoul(buf, 10,&range);
> +	error = kstrtoul(buf, 10,&range);
>   	if (error) {
>   		count = error;
>   		goto exit;
>   	}
>   	dev_dbg(dev, "set range to %lu\n", range);
>
> -	if (range>  RANGE_6_5) {
> +	if (range>  HMC58X3_RANGE_GAIN_MAX) {
>   		count = -EINVAL;
>   		goto exit;
>   	}
>
>   	data->range = range;
> -	range = range<<  RANGE_GAIN_OFFSET;
> +	range = range<<  HMC58X3_RANGE_GAIN_OFFSET;
>   	if (i2c_smbus_write_byte_data(client, this_attr->address, range))
>   		count = -EINVAL;
>
>   exit:
>   	mutex_unlock(&data->lock);
>   	return count;
> -
>   }
> +
>   static IIO_DEVICE_ATTR(in_magn_range,
>   			S_IWUSR | S_IRUGO,
> -			show_range,
> -			set_range,
> -			HMC5843_CONFIG_REG_B);
> +			hmc5843_show_range_gain,
> +			hmc5843_set_range_gain,
> +			HMC58X3_CONFIG_REG_B);
>
>   static int hmc5843_read_raw(struct iio_dev *indio_dev,
>   			    struct iio_chan_spec const *chan,
> @@ -465,7 +579,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>   						val);
>   	case IIO_CHAN_INFO_SCALE:
>   		*val = 0;
> -		*val2 = hmc5843_regval_to_nanoscale[data->range];
> +		*val2 = data->regval_to_nanoscale[data->range];
>   		return IIO_VAL_INT_PLUS_NANO;
>   	};
>   	return -EINVAL;
> @@ -482,17 +596,24 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>   	}
>
>   static const struct iio_chan_spec hmc5843_channels[] = {
> -	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
> +	HMC5843_CHANNEL(X, HMC58X3_DATA_OUT_X_MSB_REG),
>   	HMC5843_CHANNEL(Y, HMC5843_DATA_OUT_Y_MSB_REG),
>   	HMC5843_CHANNEL(Z, HMC5843_DATA_OUT_Z_MSB_REG),
>   };
>
> +static const struct iio_chan_spec hmc5883_channels[] = {
> +	HMC5843_CHANNEL(X, HMC58X3_DATA_OUT_X_MSB_REG),
> +	HMC5843_CHANNEL(Y, HMC5883_DATA_OUT_Y_MSB_REG),
> +	HMC5843_CHANNEL(Z, HMC5883_DATA_OUT_Z_MSB_REG),
> +};
> +
> +
>   static struct attribute *hmc5843_attributes[] = {
>   	&iio_dev_attr_meas_conf.dev_attr.attr,
>   	&iio_dev_attr_operating_mode.dev_attr.attr,
>   	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>   	&iio_dev_attr_in_magn_range.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>   	NULL
>   };
>
> @@ -503,32 +624,63 @@ static const struct attribute_group hmc5843_group = {
>   static int hmc5843_detect(struct i2c_client *client,
>   			  struct i2c_board_info *info)
>   {
> -	unsigned char id_str[HMC5843_ID_REG_LENGTH];
> +	unsigned char id_str[HMC58X3_ID_REG_LENGTH];
>
> -	if (client->addr != HMC5843_I2C_ADDRESS)
> +	if (client->addr != HMC58X3_I2C_ADDRESS)
>   		return -ENODEV;
>
> -	if (i2c_smbus_read_i2c_block_data(client, HMC5843_ID_REG_A,
> -				HMC5843_ID_REG_LENGTH, id_str)
> -			!= HMC5843_ID_REG_LENGTH)
> +	if (i2c_smbus_read_i2c_block_data(client, HMC58X3_ID_REG_A,
> +				HMC58X3_ID_REG_LENGTH, id_str)
> +			!= HMC58X3_ID_REG_LENGTH)
>   		return -ENODEV;
>
> -	if (0 != strncmp(id_str, HMC5843_ID_STRING, HMC5843_ID_REG_LENGTH))
> +	if (0 != strncmp(id_str, HMC58X3_ID_STRING, HMC58X3_ID_REG_LENGTH))
>   		return -ENODEV;
>
>   	return 0;
>   }
>
> -/* Called when we have found a new HMC5843. */
> -static void hmc5843_init_client(struct i2c_client *client)
> +/* Called when we have found a new HMC58X3 */
> +static void hmc5843_init_client(struct i2c_client *client,
> +				const struct i2c_device_id *id)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +
> +	switch (id->driver_data) {
> +	case HMC5843_ID:
> +		data->regval_to_sample_freq = hmc5843_regval_to_samp_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5843_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5843_regval_to_nanoscale;
> +		indio_dev->channels = hmc5843_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
> +		break;
> +	case HMC5883_ID:
> +		data->regval_to_sample_freq = hmc5883_regval_to_samp_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5883_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5883_regval_to_nanoscale;
> +		indio_dev->channels = hmc5883_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5883_channels);
> +		break;
> +	case HMC5883L_ID:
> +		data->regval_to_sample_freq = hmc5883_regval_to_samp_freq;
> +		data->regval_to_input_field_mga =
> +			hmc5883l_regval_to_input_field_mga;
> +		data->regval_to_nanoscale = hmc5883l_regval_to_nanoscale;
> +		indio_dev->channels = hmc5883_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(hmc5883_channels);
> +		break;
> +	}
> +
>   	hmc5843_set_meas_conf(client, data->meas_conf);
>   	hmc5843_set_rate(client, data->rate);
>   	hmc5843_configure(client, data->operating_mode);
> -	i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range);
> +	i2c_smbus_write_byte_data(client, HMC58X3_CONFIG_REG_B, data->range);
>   	mutex_init(&data->lock);
> -	pr_info("HMC5843 initialized\n");
> +
> +	pr_info("%s initialized\n", id->name);
>   }
>
>   static const struct iio_info hmc5843_info = {
> @@ -549,28 +701,27 @@ static int hmc5843_probe(struct i2c_client *client,
>   		err = -ENOMEM;
>   		goto exit;
>   	}
> -	data = iio_priv(indio_dev);
> -	/* default settings at probe */
>
> -	data->meas_conf = CONF_NORMAL;
> -	data->range = RANGE_1_0;
> -	data->operating_mode = MODE_CONVERSION_CONTINUOUS;
> +	/* default settings at probe */
> +	data = iio_priv(indio_dev);
> +	data->meas_conf = HMC58X3_MEAS_CONF_NORMAL;
> +	data->range = HMC58X3_RANGE_GAIN_DEFAULT;
> +	data->operating_mode = HMC58X3_MODE_CONVERSION_CONTINUOUS;
>
>   	i2c_set_clientdata(client, indio_dev);
> -
> -	/* Initialize the HMC5843 chip */
> -	hmc5843_init_client(client);
> +	hmc5843_init_client(client, id);
>
>   	indio_dev->info =&hmc5843_info;
>   	indio_dev->name = id->name;
> -	indio_dev->channels = hmc5843_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(hmc5843_channels);
>   	indio_dev->dev.parent =&client->dev;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
> +
>   	err = iio_device_register(indio_dev);
>   	if (err)
>   		goto exit_free2;
> +
>   	return 0;
> +
>   exit_free2:
>   	iio_device_free(indio_dev);
>   exit:
> @@ -583,7 +734,7 @@ static int hmc5843_remove(struct i2c_client *client)
>
>   	iio_device_unregister(indio_dev);
>   	 /*  sleep mode to save power */
> -	hmc5843_configure(client, MODE_SLEEP);
> +	hmc5843_configure(client, HMC58X3_MODE_SLEEP);
>   	iio_device_free(indio_dev);
>
>   	return 0;
> @@ -592,14 +743,16 @@ static int hmc5843_remove(struct i2c_client *client)
>   #ifdef CONFIG_PM_SLEEP
>   static int hmc5843_suspend(struct device *dev)
>   {
> -	hmc5843_configure(to_i2c_client(dev), MODE_SLEEP);
> +	hmc5843_configure(to_i2c_client(dev), HMC58X3_MODE_SLEEP);
>   	return 0;
>   }
>
>   static int hmc5843_resume(struct device *dev)
>   {
> -	struct hmc5843_data *data = i2c_get_clientdata(to_i2c_client(dev));
> -	hmc5843_configure(to_i2c_client(dev), data->operating_mode);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +	hmc5843_configure(client, data->operating_mode);
>   	return 0;
>   }
>
> @@ -610,7 +763,9 @@ static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_resume);
>   #endif
>
>   static const struct i2c_device_id hmc5843_id[] = {
> -	{ "hmc5843", 0 },
> +	{ "hmc5843", HMC5843_ID },
> +	{ "hmc5883", HMC5883_ID },
> +	{ "hmc5883l", HMC5883L_ID },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, hmc5843_id);
> @@ -629,5 +784,5 @@ static struct i2c_driver hmc5843_driver = {
>   module_i2c_driver(hmc5843_driver);
>
>   MODULE_AUTHOR("Shubhrajyoti Datta<shubhrajyoti@ti.com");
> -MODULE_DESCRIPTION("HMC5843 driver");
> +MODULE_DESCRIPTION("HMC5843/5883/5883L driver");
>   MODULE_LICENSE("GPL");

