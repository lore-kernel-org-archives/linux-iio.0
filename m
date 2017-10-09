Return-Path: <SRS0=hCD8=BI=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 9 Oct 2017 14:35:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Maciej Purski <m.purski@samsung.com>
CC: Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>, Jean Delvare
	<jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King
	<linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Bartlomiej
 Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/4] iio: adc: ina2xx: Make max expected current
 configurable
Message-ID: <20171009143539.00002222@huawei.com>
In-Reply-To: <662441b9-1b04-3e8b-baac-5852ba873ca5@samsung.com>
References: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
	<CGME20170928125053eucas1p19e757ac5c3774f54c7cd0ee4525decbe@eucas1p1.samsung.com>
	<1506603015-27202-2-git-send-email-m.purski@samsung.com>
	<20171001112934.360c840b@archlinux>
	<f04fb517-9866-39fe-310d-b65a915375ca@samsung.com>
	<20171008104756.6eaa62c5@archlinux>
	<662441b9-1b04-3e8b-baac-5852ba873ca5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 9 Oct 2017 10:08:42 +0200
Maciej Purski <m.purski@samsung.com> wrote:

> On 10/08/2017 11:47 AM, Jonathan Cameron wrote:
> > On Wed, 04 Oct 2017 09:11:31 +0200
> > Maciej Purski <m.purski@samsung.com> wrote:
> >   
> >> On 10/01/2017 12:29 PM, Jonathan Cameron wrote:  
> >>> On Thu, 28 Sep 2017 14:50:12 +0200
> >>> Maciej Purski <m.purski@samsung.com> wrote:
> >>>      
> >>>> Max expected current is used for calculating calibration register value,
> >>>> Current LSB and Power LSB according to equations found in ina datasheet.
> >>>> Max expected current is now implicitly set to default value,
> >>>> which is 2^15, thanks to which Current LSB is equal to 1 mA and
> >>>> Power LSB is equal to 20000 uW or 25000 uW depending on ina model.
> >>>>
> >>>> Make max expected current configurable, just like it's already done
> >>>> with shunt resistance: from device tree, platform_data or later
> >>>> from sysfs. On each max_expected_current change, calculate new values
> >>>> for Current LSB and Power LSB. According to datasheet Current LSB should
> >>>> be calculated by dividing max expected current by 2^15, as values read
> >>>> from device registers are in this case 16-bit integers. Power LSB
> >>>> is calculated by multiplying Current LSB by a factor, which is defined
> >>>> in ina documentation.  
> >>>
> >>> One odd bit of casting inline.  Also this is new userspace ABI.
> >>> It needs documenting in
> >>>
> >>> Documentation/ABI/testing/sysfs-bus-iio* as appropriate.
> >>> I'm also unclear on one element about this - is it a value used only
> >>> for calibration or are we talking about the actual 'range' of the device?
> >>>      
> >>
> >> This is used for calibration. The device measures directly only voltage.
> >> However, it has also current and power registers. Their values are
> >> calculated by the device using the calibration register which is calculated
> >> using max expected current. So I guess that it's not what you mean
> >> by the actual 'range' of the device.
> >>  
> >>> The interpretation of this value isn't clear against the more general
> >>> ABI.
> >>>
> >>> In particular it is it in raw units (adc counts) or mA?  Docs say
> >>> that but the naming of the attribute doesn't make this clear.
> >>>      
> >>
> >> It's in mA. I can make it clear in the attribute name.
> >>  
> >>> Also I'm unconvinced this isn't better represented using the
> >>> range specifications available for any IIO attribute on the raw
> >>> value in combination with adjusting the scale value.
> >>> Note not many drivers yet provide ranges on their raw outputs
> >>> but we do have core support for it.  I've been meaning to start
> >>> pushing this out into drivers, but been busy since we introduced
> >>> the core support.  The dpot-dac driver does use it for examplel
> >>>     
> >>
> >>
> >> I'm not sure if what I'm about to add is similar to what is done
> >> in the mentioned dpot-dac driver. It seems that the callback read_avail
> >> returns information on raw values which can be obtained from the device.
> >> What I need is an adjustable value, which is then used by the device internally
> >> in order to calculate current with the requested precision. Max expected current
> >> is also used for calculating the scale value.
> >> Tell me if I'm wrong. Maybe I misunderstood the 'range' concept in IIO and
> >> your solution fits in here.
> >>  
> > 
> > I think I answered this in the other branch of the thread.
> > _calibscale is what you want here as it's internal to the device.
> > 
> > It's not one often used for ADCs but quite a few other types of
> > device provide some front end analog adjustment (whilst it is digital
> > here, it is applied within the device - so we don't need to care).
> > 
> > Jonathan  
> 
> Thank you for your explanation. Calibscale seems suitable for me in this case,
> but what do you think I should do then with SCALE attribute? Should I get rid of 
> it for current and use only calibscale? Or should I use both calibscale and 
> scale attributes and for current they will be the same value?

You'll have to leave it as it is existing ABI.  It won't have the same value
as calibscale.  Calibscale is for internal changes that don't effect the raw
value.  scale is to be applied by userspace to the raw value. As I understand it
here the calibscale value should have no effect on scale.
> 
> I should mention that currenst_lsb value is also used for calculating power_lsb
> as they have a fixed ratio (20 or 25) given in the documentation.

Then expose it for power as well (appropriately adjusted).
In IIO ABI it is fine to have two elements addressing the same underlying hardware
value - rule is you change something, you check everything else hasn't changed.

Jonathan 
> 
> Thanks,
> 
> Maciej
> 
> >   
> >> Best regards,
> >>
> >> 	Maciej  
> >>> This moves the burden of calculating the 1lsb value to userspace,
> >>> but importantly it would give us a consistent ABI where this fits
> >>> in with existing elements (largely buy not introducing any new
> >>> ones :).
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan  
> >>>>
> >>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> >>>> ---
> >>>>    drivers/iio/adc/ina2xx-adc.c         | 110 ++++++++++++++++++++++++++++++-----
> >>>>    include/linux/platform_data/ina2xx.h |   2 +
> >>>>    2 files changed, 98 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> >>>> index f387b97..883fede 100644
> >>>> --- a/drivers/iio/adc/ina2xx-adc.c
> >>>> +++ b/drivers/iio/adc/ina2xx-adc.c
> >>>> @@ -56,6 +56,7 @@
> >>>>    #define INA226_DEFAULT_IT		1110
> >>>>    
> >>>>    #define INA2XX_RSHUNT_DEFAULT           10000
> >>>> +#define INA2XX_MAX_EXPECTED_A_DEFAULT	(1 << 15)	/* current_lsb = 1 mA */
> >>>>    
> >>>>    /*
> >>>>     * bit masks for reading the settings in the configuration register
> >>>> @@ -114,7 +115,7 @@ struct ina2xx_config {
> >>>>    	int shunt_div;
> >>>>    	int bus_voltage_shift;
> >>>>    	int bus_voltage_lsb;	/* uV */
> >>>> -	int power_lsb;		/* uW */
> >>>> +	int power_lsb_factor;
> >>>>    	enum ina2xx_ids chip_id;
> >>>>    };
> >>>>    
> >>>> @@ -123,7 +124,10 @@ struct ina2xx_chip_info {
> >>>>    	struct task_struct *task;
> >>>>    	const struct ina2xx_config *config;
> >>>>    	struct mutex state_lock;
> >>>> -	unsigned int shunt_resistor;
> >>>> +	unsigned int shunt_resistor;		/* uOhms */
> >>>> +	unsigned int max_expected_current;	/* mA */
> >>>> +	int current_lsb;			/* uA */
> >>>> +	int power_lsb;				/* uW */
> >>>>    	int avg;
> >>>>    	int int_time_vbus; /* Bus voltage integration time uS */
> >>>>    	int int_time_vshunt; /* Shunt voltage integration time uS */
> >>>> @@ -137,7 +141,7 @@ static const struct ina2xx_config ina2xx_config[] = {
> >>>>    		.shunt_div = 100,
> >>>>    		.bus_voltage_shift = 3,
> >>>>    		.bus_voltage_lsb = 4000,
> >>>> -		.power_lsb = 20000,
> >>>> +		.power_lsb_factor = 20,
> >>>>    		.chip_id = ina219,
> >>>>    	},
> >>>>    	[ina226] = {
> >>>> @@ -146,7 +150,7 @@ static const struct ina2xx_config ina2xx_config[] = {
> >>>>    		.shunt_div = 400,
> >>>>    		.bus_voltage_shift = 0,
> >>>>    		.bus_voltage_lsb = 1250,
> >>>> -		.power_lsb = 25000,
> >>>> +		.power_lsb_factor = 25,
> >>>>    		.chip_id = ina226,
> >>>>    	},
> >>>>    };
> >>>> @@ -210,14 +214,15 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
> >>>>    
> >>>>    		case INA2XX_POWER:
> >>>>    			/* processed (mW) = raw*lsb (uW) / 1000 */
> >>>> -			*val = chip->config->power_lsb;
> >>>> +			*val = chip->power_lsb;
> >>>>    			*val2 = 1000;
> >>>>    			return IIO_VAL_FRACTIONAL;
> >>>>    
> >>>>    		case INA2XX_CURRENT:
> >>>> -			/* processed (mA) = raw (mA) */
> >>>> -			*val = 1;
> >>>> -			return IIO_VAL_INT;
> >>>> +			/* processed (mA) = raw*lsb (uA) / 1000 */
> >>>> +			*val = chip->current_lsb;
> >>>> +			*val2 = 1000;
> >>>> +			return IIO_VAL_FRACTIONAL;
> >>>>    		}
> >>>>    	}
> >>>>    
> >>>> @@ -434,24 +439,47 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
> >>>>    }
> >>>>    
> >>>>    /*
> >>>> - * Set current LSB to 1mA, shunt is in uOhms
> >>>> - * (equation 13 in datasheet). We hardcode a Current_LSB
> >>>> - * of 1.0 x10-6. The only remaining parameter is RShunt.
> >>>> + * Calculate calibration value according to equation 1 in ina226 datasheet
> >>>> + * http://www.ti.com/lit/ds/symlink/ina226.pdf.
> >>>> + * Current LSB is in uA and RShunt is in uOhms, so RShunt should be
> >>>> + * converted to mOhms in order to keep the scale.
> >>>>     * There is no need to expose the CALIBRATION register
> >>>>     * to the user for now. But we need to reset this register
> >>>> - * if the user updates RShunt after driver init, e.g upon
> >>>> - * reading an EEPROM/Probe-type value.
> >>>> + * if the user updates RShunt or max expected current after driver
> >>>> + * init, e.g upon reading an EEPROM/Probe-type value.
> >>>>     */
> >>>>    static int ina2xx_set_calibration(struct ina2xx_chip_info *chip)
> >>>>    {
> >>>> +	unsigned int rshunt = DIV_ROUND_CLOSEST(chip->shunt_resistor, 1000);
> >>>>    	u16 regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> >>>> -				   chip->shunt_resistor);
> >>>> +				     chip->current_lsb * rshunt);
> >>>>    
> >>>>    	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
> >>>>    }
> >>>>    
> >>>> +/*
> >>>> + * Set max_expected_current (mA) and calculate current_lsb (uA),
> >>>> + * according to equation 2 in ina226 datasheet. Power LSB is calculated
> >>>> + * by multiplying Current LSB by a given factor, which may vary depending
> >>>> + * on ina version.
> >>>> + */
> >>>> +static int set_max_expected_current(struct ina2xx_chip_info *chip,
> >>>> +				    unsigned int val)
> >>>> +{
> >>>> +	if (val <= 0 || val > chip->config->calibration_factor)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	chip->max_expected_current = val;
> >>>> +	chip->current_lsb = DIV_ROUND_CLOSEST(chip->max_expected_current * 1000,
> >>>> +					      1 << 15);
> >>>> +	chip->power_lsb = chip->current_lsb * chip->config->power_lsb_factor;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>>    static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
> >>>>    {
> >>>> +
> >>>>    	if (val <= 0 || val > chip->config->calibration_factor)
> >>>>    		return -EINVAL;
> >>>>    
> >>>> @@ -493,6 +521,39 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
> >>>>    	return len;
> >>>>    }
> >>>>    
> >>>> +static ssize_t ina2xx_max_expected_current_show(struct device *dev,
> >>>> +					  struct device_attribute *attr,
> >>>> +					  char *buf)
> >>>> +{
> >>>> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> >>>> +
> >>>> +	return sprintf(buf, "%d\n", chip->max_expected_current);
> >>>> +}
> >>>> +
> >>>> +static ssize_t ina2xx_max_expected_current_store(struct device *dev,
> >>>> +					   struct device_attribute *attr,
> >>>> +					   const char *buf, size_t len)
> >>>> +{
> >>>> +	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
> >>>> +	unsigned long val;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = kstrtoul((const char *) buf, 10, &val);  
> >>>
> >>> Odd bit of casting given that's what it already is...
> >>>      
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	ret = set_max_expected_current(chip, val);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	/* Update the Calibration register */
> >>>> +	ret = ina2xx_set_calibration(chip);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	return len;
> >>>> +}
> >>>> +
> >>>>    #define INA219_CHAN(_type, _index, _address) { \
> >>>>    	.type = (_type), \
> >>>>    	.address = (_address), \
> >>>> @@ -755,10 +816,15 @@ static IIO_DEVICE_ATTR(in_shunt_resistor, S_IRUGO | S_IWUSR,
> >>>>    		       ina2xx_shunt_resistor_show,
> >>>>    		       ina2xx_shunt_resistor_store, 0);
> >>>>    
> >>>> +static IIO_DEVICE_ATTR(in_max_expected_current, S_IRUGO | S_IWUSR,
> >>>> +		       ina2xx_max_expected_current_show,
> >>>> +		       ina2xx_max_expected_current_store, 0);
> >>>> +
> >>>>    static struct attribute *ina219_attributes[] = {
> >>>>    	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
> >>>>    	&iio_const_attr_ina219_integration_time_available.dev_attr.attr,
> >>>>    	&iio_dev_attr_in_shunt_resistor.dev_attr.attr,
> >>>> +	&iio_dev_attr_in_max_expected_current.dev_attr.attr,
> >>>>    	NULL,
> >>>>    };
> >>>>    
> >>>> @@ -766,6 +832,7 @@ static struct attribute *ina226_attributes[] = {
> >>>>    	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
> >>>>    	&iio_const_attr_ina226_integration_time_available.dev_attr.attr,
> >>>>    	&iio_dev_attr_in_shunt_resistor.dev_attr.attr,
> >>>> +	&iio_dev_attr_in_max_expected_current.dev_attr.attr,
> >>>>    	NULL,
> >>>>    };
> >>>>    
> >>>> @@ -851,6 +918,21 @@ static int ina2xx_probe(struct i2c_client *client,
> >>>>    	if (ret)
> >>>>    		return ret;
> >>>>    
> >>>> +	if (of_property_read_u32(client->dev.of_node,
> >>>> +				  "max-expected-current", &val) < 0) {
> >>>> +		struct ina2xx_platform_data *pdata =
> >>>> +		    dev_get_platdata(&client->dev);
> >>>> +
> >>>> +		if (pdata && pdata->max_mA != 0)
> >>>> +			val = pdata->max_mA;
> >>>> +		else
> >>>> +			val = INA2XX_MAX_EXPECTED_A_DEFAULT;
> >>>> +	}
> >>>> +
> >>>> +	ret = set_max_expected_current(chip, val);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>>    	/* Patch the current config register with default. */
> >>>>    	val = chip->config->config_default;
> >>>>    
> >>>> diff --git a/include/linux/platform_data/ina2xx.h b/include/linux/platform_data/ina2xx.h
> >>>> index 9abc0ca..f02b1d8 100644
> >>>> --- a/include/linux/platform_data/ina2xx.h
> >>>> +++ b/include/linux/platform_data/ina2xx.h
> >>>> @@ -13,7 +13,9 @@
> >>>>    /**
> >>>>     * struct ina2xx_platform_data - ina2xx info
> >>>>     * @shunt_uohms		shunt resistance in microohms
> >>>> + * @max_mA		max expected current in mA
> >>>>     */
> >>>>    struct ina2xx_platform_data {
> >>>>    	long shunt_uohms;
> >>>> +	int max_mA;
> >>>>    };  
> >>>
> >>>
> >>>
> >>>      
> > 
> > 
> > 
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
