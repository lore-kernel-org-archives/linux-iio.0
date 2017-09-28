Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36952 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbdI1NZ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Sep 2017 09:25:58 -0400
Subject: Re: [PATCH 2/4] hwmon: (ina2xx) Make max expected current
 configurable
To: Maciej Purski <m.purski@samsung.com>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
 <CGME20170928125057eucas1p2e8a2db5db29e7d7886c3906c7fffd390@eucas1p2.samsung.com>
 <1506603015-27202-3-git-send-email-m.purski@samsung.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c2de1bb-1396-6d1c-efb0-3411c40f638c@roeck-us.net>
Date: Thu, 28 Sep 2017 06:25:54 -0700
MIME-Version: 1.0
In-Reply-To: <1506603015-27202-3-git-send-email-m.purski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/2017 05:50 AM, Maciej Purski wrote:
> Max expected current is used for calculating calibration register value,
> Current LSB and Power LSB according to equations found in ina datasheet.
> Max expected current is now implicitly set to default value,
> which is 2^15, thanks to which Current LSB is equal to 1 mA and
> Power LSB is equal to 20000 uW or 25000 uW depending on ina model.
> 
> Make max expected current configurable, just like it's already done
> with shunt resistance: from device tree, platform_data or later
> from sysfs. On each max_expected_current change, calculate new values
> for Current LSB and Power LSB. According to datasheet Current LSB should
> be calculated by dividing max expected current by 2^15, as values read
> from device registers are in this case 16-bit integers. Power LSB
> is calculated by multiplying Current LSB by a factor, which is defined
> in ina documentation.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>   drivers/hwmon/ina2xx.c | 105 +++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 93 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 62e38fa..d956013 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -80,6 +80,8 @@
>   /* common attrs, ina226 attrs and NULL */
>   #define INA2XX_MAX_ATTRIBUTE_GROUPS	3
>   
> +#define INA2XX_MAX_EXPECTED_A_DEFAULT  (1 << 15)       /* current_lsb = 1 mA */
> +
>   /*
>    * Both bus voltage and shunt voltage conversion times for ina226 are set
>    * to 0b0100 on POR, which translates to 2200 microseconds in total.
> @@ -100,13 +102,16 @@ struct ina2xx_config {
>   	int shunt_div;
>   	int bus_voltage_shift;
>   	int bus_voltage_lsb;	/* uV */
> -	int power_lsb;		/* uW */
> +	int power_lsb_factor;
>   };
>   
>   struct ina2xx_data {
>   	const struct ina2xx_config *config;
>   
> -	long rshunt;
> +	long rshunt;				/* uOhms */
> +	unsigned int max_expected_current;	/* mA */
> +	int current_lsb;			/* uA */
> +	int power_lsb;				/* uW */
>   	struct mutex config_lock;
>   	struct regmap *regmap;
>   
> @@ -121,7 +126,7 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.shunt_div = 100,
>   		.bus_voltage_shift = 3,
>   		.bus_voltage_lsb = 4000,
> -		.power_lsb = 20000,
> +		.power_lsb_factor = 20,
>   	},
>   	[ina226] = {
>   		.config_default = INA226_CONFIG_DEFAULT,
> @@ -130,7 +135,7 @@ static const struct ina2xx_config ina2xx_config[] = {
>   		.shunt_div = 400,
>   		.bus_voltage_shift = 0,
>   		.bus_voltage_lsb = 1250,
> -		.power_lsb = 25000,
> +		.power_lsb_factor = 25,
>   	},
>   };
>   
> @@ -169,10 +174,17 @@ static u16 ina226_interval_to_reg(int interval)
>   	return INA226_SHIFT_AVG(avg_bits);
>   }
>   
> +/*
> + * Calculate calibration value according to equation 1 in ina226 datasheet
> + * http://www.ti.com/lit/ds/symlink/ina226.pdf.
> + * Current LSB is in uA and RShunt is in uOhms, so in order to keep
> + * calibration value scaled RShunt must be converted to mOhms.
> + */
>   static int ina2xx_calibrate(struct ina2xx_data *data)
>   {
> +	int r_shunt = DIV_ROUND_CLOSEST(data->rshunt, 1000);
>   	u16 val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
> -				    data->rshunt);
> +				    data->current_lsb * r_shunt);
>   
>   	return regmap_write(data->regmap, INA2XX_CALIBRATION, val);
>   }
> @@ -187,13 +199,28 @@ static int ina2xx_init(struct ina2xx_data *data)
>   	if (ret < 0)
>   		return ret;
>   
> -	/*
> -	 * Set current LSB to 1mA, shunt is in uOhms
> -	 * (equation 13 in datasheet).
> -	 */
>   	return ina2xx_calibrate(data);
>   }
>   
> +/*
> + * Set max_expected_current (mA) and calculate current_lsb (uA),
> + * according to equation 2 in ina226 datasheet. Power LSB is calculated
> + * by multiplying Current LSB by a given factor, which may vary depending
> + * on ina version.
> + */
> +static int set_max_expected_current(struct ina2xx_data *data, unsigned int val)
> +{
> +	if (val <= 0 || val > data->config->calibration_factor)
> +		return -EINVAL;
> +
> +	data->max_expected_current = val;
> +	data->current_lsb = DIV_ROUND_CLOSEST(data->max_expected_current * 1000,
> +					      1 << 15);
> +	data->power_lsb = data->current_lsb * data->config->power_lsb_factor;
> +
> +	return 0;
> +}
> +
>   static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
>   {
>   	struct ina2xx_data *data = dev_get_drvdata(dev);
> @@ -268,11 +295,11 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
>   		val = DIV_ROUND_CLOSEST(val, 1000);
>   		break;
>   	case INA2XX_POWER:
> -		val = regval * data->config->power_lsb;
> +		val = regval * data->power_lsb;
>   		break;
>   	case INA2XX_CURRENT:
> -		/* signed register, LSB=1mA (selected), in mA */
> -		val = (s16)regval;
> +		val = (s16)regval * data->current_lsb;
> +		val = DIV_ROUND_CLOSEST(val, 1000);
>   		break;
>   	case INA2XX_CALIBRATION:
>   		val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
> @@ -369,6 +396,39 @@ static ssize_t ina226_show_interval(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d\n", ina226_reg_to_interval(regval));
>   }
>   
> +static ssize_t ina2xx_max_expected_current_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", data->max_expected_current);
> +}
> +
> +static ssize_t ina2xx_max_expected_current_set(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t len)
> +{
> +	struct ina2xx_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul((const char *) buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = set_max_expected_current(data, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Update the Calibration register */
> +	ret = ina2xx_calibrate(data);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
>   /* shunt voltage */
>   static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
>   			  INA2XX_SHUNT_VOLTAGE);
> @@ -390,6 +450,11 @@ static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
>   			  ina2xx_show_value, ina2xx_set_shunt,
>   			  INA2XX_CALIBRATION);
>   
> +/* max expected current */
> +static SENSOR_DEVICE_ATTR(max_expected_current, S_IRUGO | S_IWUSR,
> +			  ina2xx_max_expected_current_show,
> +			  ina2xx_max_expected_current_set, 0);
> +
>   /* update interval (ina226 only) */
>   static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
>   			  ina226_show_interval, ina226_set_interval, 0);
> @@ -401,6 +466,7 @@ static struct attribute *ina2xx_attrs[] = {
>   	&sensor_dev_attr_curr1_input.dev_attr.attr,
>   	&sensor_dev_attr_power1_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt_resistor.dev_attr.attr,
> +	&sensor_dev_attr_max_expected_current.dev_attr.attr,

We do have standard attributes (presumably currX_max or possibly currX_crit).
Please use them, or explain in detail why you don't.

Guenter

>   	NULL,
>   };
>   
> @@ -453,6 +519,21 @@ static int ina2xx_probe(struct i2c_client *client,
>   
>   	data->rshunt = val;
>   
> +	if (of_property_read_u32(dev->of_node, "max-expected-current",
> +				 &val) < 0) {
> +		struct ina2xx_platform_data *pdata =
> +		    dev_get_platdata(&client->dev);
> +
> +		if (pdata && pdata->max_mA != 0)
> +			val = pdata->max_mA;
> +		else
> +			val = INA2XX_MAX_EXPECTED_A_DEFAULT;
> +	}
> +
> +	ret = set_max_expected_current(data, val);
> +	if (ret < 0)
> +		return ret;
> +
>   	ina2xx_regmap_config.max_register = data->config->registers;
>   
>   	data->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
> 

