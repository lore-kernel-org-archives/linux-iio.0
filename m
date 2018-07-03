Return-Path: <SRS0=7N1r=JT=gmail.com=maxime.roussinbelanger@kernel.org>
Date: Tue, 3 Jul 2018 12:28:39 -0400
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	jeff.dagenais@gmail.com
Subject: Re: [PATCH v2] iio: light: introduce si1133
Message-ID: <20180703162838.5jquauqlkfohsod4@mbedesk.sonatest.net>
References: <20180626170109.13437-1-maxime.roussinbelanger@gmail.com>
 <alpine.DEB.2.21.1806272146300.5231@vps.pmeerw.net>
 <20180628143400.tvagraa7tbbh3mic@mbedesk.sonatest.net>
 <20180630173722.2c298b85@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180630173722.2c298b85@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 30, 2018 at 05:37:22PM +0100, Jonathan Cameron wrote:
> On Thu, 28 Jun 2018 10:34:05 -0400
> Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com> wrote:
> 
> > Asked a couple questions about IIO in general.
> > 
> > On Wed, Jun 27, 2018 at 10:02:59PM +0200, Peter Meerwald-Stadler wrote:
> > > 
> > > comments below
> > >   
> > > > Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
> > > > Reviewed-by: Jean-Francois Dagenais <dagenaisj@sonatest.com>
> > > > ---
> > > > Changes in v2:
> > > > 	- Add ABI documentation
> > > > 	- Drop part abstraction
> > > > 	- Clean up error handling style
> > > > 
> > > >  .../ABI/testing/sysfs-bus-iio-light-si1133    |  57 ++
> > > >  drivers/iio/light/Kconfig                     |  11 +
> > > >  drivers/iio/light/Makefile                    |   1 +
> > > >  drivers/iio/light/si1133.c                    | 809 ++++++++++++++++++
> > > >  4 files changed, 878 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > >  create mode 100644 drivers/iio/light/si1133.c
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-si1133 b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > > new file mode 100644
> > > > index 000000000000..4533b5699c87
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > > @@ -0,0 +1,57 @@
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity0_ir_small_raw  
> > > 
> > > do we need the 0?  
> > 
> > Hopefully not, comments below.
> 
> Given the several channels only distinguished by extended name, yes if you
> might potentially have events at some later date.
>

I'm a bit confused on what "events" are. I'm wondering if you are talking about the
autonomous mode or just the IRQ?
 
> > >   
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Unit-less infrared intensity. The intensity is measured from 1
> > > > +		dark photodiode. "small" indicate the surface area capturing
> > > > +		infrared.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity1_ir_med_raw
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Unit-less infrared intensity. The intensity is measured from 2
> > > > +		dark photodiode. "med" indicate the surface area capturing  
> > > 
> > > photodiodes
> > >   
> > > > +		infrared.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity2_ir_large_raw
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Unit-less infrared intensity. The intensity is measured from 4
> > > > +		dark photodiode. "large" indicate the surface area capturing  
> > > 
> > > photodiodes
> > >   
> > > > +		infrared.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity11_raw  
> > > 
> > > what does 11 mean?  
> > 
> > First time using iio subsystem... I think I can remove all the numbers, but the
> > number were used to differentiate the different channels with "large", "med"...
> > 
> > Now that I use the "extend_name" field, maybe I can get rid of it?
> 
> No.  Potentially causes all sorts of problems if there are events on this part
> or on some similar part in future.  Extend_name should not be used to make channels
> unique.
> 

I wasn't using the extend_name to make them unique, but trying to use the iio framework
to give a name to this property instead of a number that doesn't mean much. That's how I
interpreted the documentation for the "extend_name" field.

If it makes it unique, it's probably a coincidence.


> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Get the current intensity of visible light which is influenced
> > > > +		by Infrared light. If an accurate lux measurement is desired,
> > > > +		the extra IR response of the visible-light photodiode must be
> > > > +		compensated.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity13_large_raw
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Get the current intensity of visible light with more diodes than
> > > > +		the non-large version which is influenced by Infrared light.
> > > > +		If an accurate lux measurement is desired, the extra IR response
> > > > +		of the visible-light photodiode must be compensated.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindex24_raw
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		UV light intensity index measuring the human skin's response to
> > > > +		different wavelength of sunlight weighted according to the
> > > > +		standardised CIE Erythemal Action Spectrum.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindex25_deep_raw
> > > > +KernelVersion:	4.18
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		UV light intensity index measuring the human skin's response to
> > > > +		deep ultraviolet (DUV) wavelength of sunlight weighted according
> > > > +		to the standardised CIE Erythemal Action Spectrum.
> > > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > > index c7ef8d1862d6..dfa3b1f956f8 100644
> > > > --- a/drivers/iio/light/Kconfig
> > > > +++ b/drivers/iio/light/Kconfig
> > > > @@ -332,6 +332,17 @@ config SI1145
> > > >  	  To compile this driver as a module, choose M here: the module will be
> > > >  	  called si1145.
> > > >  
> > > > +config SI1133  
> > > 
> > > this should be before si1145 (alphabetic order)
> > >   
> > > > +	tristate "SI1133 UV Index Sensor and Ambient Light Sensor"
> > > > +	depends on I2C
> > > > +	select REGMAP_I2C
> > > > +	  help
> > > > +	  Say Y here if you want to build a driver for the Silicon Labs SI1133
> > > > +	  UV Index Sensor and Ambient Light Sensor chip.
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the module will be
> > > > +	  called si1133.
> > > > +
> > > >  config STK3310
> > > >  	tristate "STK3310 ALS and proximity sensor"
> > > >  	depends on I2C
> > > > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > > > index 80943af5d627..dd9ffc38beeb 100644
> > > > --- a/drivers/iio/light/Makefile
> > > > +++ b/drivers/iio/light/Makefile
> > > > @@ -33,6 +33,7 @@ obj-$(CONFIG_PA12203001)	+= pa12203001.o
> > > >  obj-$(CONFIG_RPR0521)		+= rpr0521.o
> > > >  obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
> > > >  obj-$(CONFIG_SI1145)		+= si1145.o
> > > > +obj-$(CONFIG_SI1133)		+= si1133.o
> > > >  obj-$(CONFIG_STK3310)          += stk3310.o
> > > >  obj-$(CONFIG_ST_UVIS25)		+= st_uvis25_core.o
> > > >  obj-$(CONFIG_ST_UVIS25_I2C)	+= st_uvis25_i2c.o
> > > > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> > > > new file mode 100644
> > > > index 000000000000..6cb7fd8c35e4
> > > > --- /dev/null
> > > > +++ b/drivers/iio/light/si1133.c
> > > > @@ -0,0 +1,809 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * si1133.c - Support for Silabs SI1133 combined ambient
> > > > + * light and UV index sensors
> > > > + *
> > > > + * Copyright 2018 Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/sysfs.h>
> > > > +
> > > > +#include <linux/util_macros.h>
> > > > +
> > > > +#define SI1133_REG_PART_ID		0x00
> > > > +#define SI1133_REG_REV_ID		0x01
> > > > +#define SI1133_REG_MFR_ID		0x02
> > > > +#define SI1133_REG_INFO0		0x03
> > > > +#define SI1133_REG_INFO1		0x04
> > > > +
> > > > +#define SI1133_PART_ID			0x33
> > > > +
> > > > +#define SI1133_REG_HOSTIN0		0x0A
> > > > +#define SI1133_REG_COMMAND		0x0B
> > > > +#define SI1133_REG_IRQ_ENABLE		0x0F
> > > > +#define SI1133_REG_RESPONSE1		0x10
> > > > +#define SI1133_REG_RESPONSE0		0x11
> > > > +#define SI1133_REG_IRQ_STATUS		0x12
> > > > +#define SI1133_REG_MEAS_RATE		0x1A
> > > > +
> > > > +#define SI1133_CMD_RESET_CTR		0x00
> > > > +#define SI1133_CMD_RESET_SW		0x01
> > > > +#define SI1133_CMD_FORCE		0x11
> > > > +#define SI1133_CMD_START_AUTONOMOUS	0x13
> > > > +#define SI1133_CMD_PARAM_SET		0x80
> > > > +#define SI1133_CMD_PARAM_QUERY		0x40
> > > > +#define SI1133_CMD_PARAM_MASK		0x3F
> > > > +
> > > > +#define SI1133_CMD_ERR_MASK		BIT(4)
> > > > +#define SI1133_CMD_SEQ_MASK		0xF
> > > > +
> > > > +#define SI1133_PARAM_REG_CHAN_LIST	0x01
> > > > +#define SI1133_PARAM_REG_ADCCONFIG(x)	(((x) * 4) + 2)
> > > > +#define SI1133_PARAM_REG_ADCSENS(x)	(((x) * 4) + 3)
> > > > +
> > > > +#define SI1133_ADCMUX_MASK 0x1F
> > > > +#define SI1133_ADCSENS_SCALE_MASK 0x70
> > > > +#define SI1133_ADCSENS_SCALE_SHIFT 4
> > > > +
> > > > +#define SI1133_ADCSENS_HSIG_MASK 0x80
> > > > +#define SI1133_ADCSENS_HSIG_SHIFT 7
> > > > +
> > > > +#define SI1133_ADCSENS_HW_GAIN_MASK 0xF
> > > > +
> > > > +#define SI1133_PARAM_ADCMUX_SMALL_IR	0x0
> > > > +#define SI1133_PARAM_ADCMUX_MED_IR	0x1
> > > > +#define SI1133_PARAM_ADCMUX_LARGE_IR	0x2
> > > > +#define SI1133_PARAM_ADCMUX_WHITE	0xB
> > > > +#define SI1133_PARAM_ADCMUX_LARGE_WHITE	0xD
> > > > +#define SI1133_PARAM_ADCMUX_UV		0x18
> > > > +#define SI1133_PARAM_ADCMUX_UV_DEEP	0x19
> > > > +
> > > > +#define SI1133_ERR_INVALID_CMD		0x0
> > > > +#define SI1133_ERR_INVALID_LOCATION_CMD 0x1
> > > > +#define SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION 0x2
> > > > +#define SI1133_ERR_OUTPUT_BUFFER_OVERFLOW 0x3
> > > > +
> > > > +#define SI1133_CMD_MINSLEEP_US_LOW	5000
> > > > +#define SI1133_CMD_MINSLEEP_US_HIGH	7500
> > > > +#define SI1133_CMD_TIMEOUT_MS		25
> > > > +#define SI1133_MAX_RETRIES 25
> > > > +
> > > > +#define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
> > > > +
> > > > +#define SI1133_MAX_CMD_CTR		0xF
> > > > +
> > > > +#define SI1133_MEASUREMENT_FREQUENCY 1250
> > > > +
> > > > +static const int si1133_scale_available[] = {
> > > > +	1, 2, 4, 8, 16, 32, 64, 128};
> > > > +
> > > > +static IIO_CONST_ATTR(scale_available, "1 2 4 8 16 32 64 128");
> > > > +
> > > > +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.0244 0.0488 0.0975 0.195 0.390 0.780 "
> > > > +				     "1.560 3.120 6.24 12.48 25.0 50.0");
> > > > +/* Integration time in milliseconds, nanoseconds */
> > > > +static const int si1133_int_time_table[][2] = {
> > > > +	{0, 24400},	{0, 48800},	{0, 97500},	{0, 195000},
> > > > +	{0, 390000},	{0, 780000},	{1, 560000},	{3, 120000},
> > > > +	{6, 240000},	{12, 480000},	{25, 000000},	{50, 000000},
> > > > +};
> > > > +
> > > > +static const struct regmap_range si1133_reg_ranges[] = {
> > > > +	regmap_reg_range(0x00, 0x02),
> > > > +	regmap_reg_range(0x0A, 0x0B),
> > > > +	regmap_reg_range(0x0F, 0x0F),
> > > > +	regmap_reg_range(0x10, 0x12),
> > > > +	regmap_reg_range(0x13, 0x2C),
> > > > +};
> > > > +
> > > > +static const struct regmap_range si1133_reg_ro_ranges[] = {
> > > > +	regmap_reg_range(0x00, 0x02),
> > > > +	regmap_reg_range(0x10, 0x2C),
> > > > +};
> > > > +
> > > > +static const struct regmap_range si1133_precious_ranges[] = {
> > > > +	regmap_reg_range(0x12, 0x12),
> > > > +};
> > > > +
> > > > +static const struct regmap_access_table si1133_write_ranges_table = {
> > > > +	.yes_ranges	= si1133_reg_ranges,
> > > > +	.n_yes_ranges	= ARRAY_SIZE(si1133_reg_ranges),
> > > > +	.no_ranges	= si1133_reg_ro_ranges,
> > > > +	.n_no_ranges	= ARRAY_SIZE(si1133_reg_ro_ranges),
> > > > +};
> > > > +
> > > > +static const struct regmap_access_table si1133_read_ranges_table = {
> > > > +	.yes_ranges	= si1133_reg_ranges,
> > > > +	.n_yes_ranges	= ARRAY_SIZE(si1133_reg_ranges),
> > > > +};
> > > > +
> > > > +static const struct regmap_access_table si1133_precious_table = {
> > > > +	.yes_ranges	= si1133_precious_ranges,
> > > > +	.n_yes_ranges	= ARRAY_SIZE(si1133_precious_ranges),
> > > > +};
> > > > +
> > > > +static const struct regmap_config si1133_regmap_config = {
> > > > +	.reg_bits = 8,
> > > > +	.val_bits = 8,
> > > > +
> > > > +	.max_register = 0x2C,
> > > > +
> > > > +	.wr_table = &si1133_write_ranges_table,
> > > > +	.rd_table = &si1133_read_ranges_table,
> > > > +
> > > > +	.precious_table = &si1133_precious_table,
> > > > +};
> > > > +
> > > > +struct si1133_data {
> > > > +	struct regmap *regmap;
> > > > +	struct i2c_client *client;
> > > > +
> > > > +	/* Lock protecting one command at a time can be processed */
> > > > +	struct mutex mutex;
> > > > +
> > > > +	int rsp_seq;
> > > > +	unsigned long scan_mask;
> > > > +	unsigned int adc_sens;
> > > > +	unsigned int adc_config;
> > > > +	unsigned int meas_rate;
> > > > +
> > > > +	struct completion completion;
> > > > +};
> > > > +
> > > > +/**
> > > > + * si1133_cmd_reset_sw() - Reset the chip
> > > > + *
> > > > + * Wait till command reset completes or timeout
> > > > + */
> > > > +static int si1133_cmd_reset_sw(struct si1133_data *data)
> > > > +{
> > > > +	struct device *dev = &data->client->dev;
> > > > +	unsigned int resp;
> > > > +	unsigned long timeout;
> > > > +	int err;
> > > > +
> > > > +	err = regmap_write(data->regmap, SI1133_REG_COMMAND,
> > > > +			   SI1133_CMD_RESET_SW);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	timeout = jiffies + msecs_to_jiffies(SI1133_CMD_TIMEOUT_MS);
> > > > +	while (true) {
> > > > +		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
> > > > +		if (err == -ENXIO) {
> > > > +			usleep_range(SI1133_CMD_MINSLEEP_US_LOW,
> > > > +				     SI1133_CMD_MINSLEEP_US_HIGH);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		if ((resp & SI1133_MAX_CMD_CTR) == SI1133_MAX_CMD_CTR)
> > > > +			break;
> > > > +
> > > > +		if (time_after(jiffies, timeout)) {
> > > > +			dev_warn(dev, "timeout on reset ctr resp: %d\n", resp);
> > > > +			return -ETIMEDOUT;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (!err)
> > > > +		data->rsp_seq = SI1133_MAX_CMD_CTR;
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static int si1133_parse_response_err(struct device *dev, unsigned int resp,
> > > > +				     u8 cmd)
> > > > +{
> > > > +	int ret = 0;
> > > > +
> > > > +	resp &= 0xF;
> > > > +
> > > > +	switch (resp) {
> > > > +	case SI1133_ERR_OUTPUT_BUFFER_OVERFLOW:
> > > > +		dev_warn(dev, "Output buffer overflow: %#02hhx\n", cmd);  
> > > 
> > > start messages with upper- or lowercase letter for consistency?  
> > 
> > I'll switch to upper everywhere or is there a preference for lowercase?
> > 
> > >   
> > > > +		ret = -EOVERFLOW;
> > > > +		break;
> > > > +	case SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION:
> > > > +		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02hhx\n",
> > > > +			 cmd);
> > > > +		ret = -EOVERFLOW;
> > > > +		break;
> > > > +	case SI1133_ERR_INVALID_LOCATION_CMD:
> > > > +		dev_warn(dev, "Parameter access to an invalid location: %#02hhx\n",
> > > > +			 cmd);
> > > > +		ret = -EINVAL;
> > > > +		break;
> > > > +	case SI1133_ERR_INVALID_CMD:
> > > > +		dev_warn(dev, "Invalid command %#02hhx\n", cmd);
> > > > +		ret = -EINVAL;
> > > > +		break;
> > > > +	default:
> > > > +		dev_warn(dev, "Unknown error %#02hhx\n", cmd);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int si1133_cmd_reset_counter(struct si1133_data *data)
> > > > +{
> > > > +	int err = regmap_write(data->regmap, SI1133_REG_COMMAND,
> > > > +			       SI1133_CMD_RESET_CTR);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	data->rsp_seq = 0;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int si1133_command(struct si1133_data *data, u8 cmd)
> > > > +{
> > > > +	struct device *dev = &data->client->dev;
> > > > +	unsigned int resp;
> > > > +	int err;
> > > > +	int expected_seq;
> > > > +
> > > > +	mutex_lock(&data->mutex);
> > > > +
> > > > +	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
> > > > +
> > > > +	err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
> > > > +	if (err) {
> > > > +		dev_warn(dev, "failed to write command %#02hhx, ret=%d\n", cmd,
> > > > +			 err);
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	err = regmap_read_poll_timeout(data->regmap, SI1133_REG_RESPONSE0, resp,
> > > > +				       (resp & SI1133_CMD_SEQ_MASK) ==
> > > > +				       expected_seq ||
> > > > +				       (resp & SI1133_CMD_ERR_MASK),
> > > > +				       SI1133_CMD_MINSLEEP_US_LOW,
> > > > +				       SI1133_CMD_TIMEOUT_MS * 1000);
> > > > +
> > > > +	if (resp & SI1133_CMD_ERR_MASK) {
> > > > +		err = si1133_parse_response_err(dev, resp, cmd);
> > > > +		si1133_cmd_reset_counter(data);
> > > > +	} else {
> > > > +		data->rsp_seq = resp & SI1133_CMD_SEQ_MASK;
> > > > +	}
> > > > +
> > > > +out:
> > > > +	mutex_unlock(&data->mutex);
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static int si1133_param_set(struct si1133_data *data, u8 param,
> > > > +			    unsigned int value)
> > > > +{
> > > > +	int err = regmap_write(data->regmap, SI1133_REG_HOSTIN0, value);
> > > > +
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	return si1133_command(data, SI1133_CMD_PARAM_SET |
> > > > +			      (param & SI1133_CMD_PARAM_MASK));
> > > > +}
> > > > +
> > > > +static int si1133_param_query(struct si1133_data *data, u8 param,
> > > > +			      unsigned int *result)
> > > > +{
> > > > +	int err = si1133_command(data, SI1133_CMD_PARAM_QUERY |
> > > > +				 (param & SI1133_CMD_PARAM_MASK));
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	return regmap_read(data->regmap, SI1133_REG_RESPONSE1, result);
> > > > +}
> > > > +
> > > > +#define SI1133_CHANNEL(_si, _ch, _type) \
> > > > +	.type = _type, \
> > > > +	.indexed = 1, \
> > > > +	.channel = _ch, \  
> > >   
> > > > +	.scan_index = _si, \  
> > > 
> > > buffered mode not supported, so .scan_type not needed  
> > 
> > Does it mean that I can remove scan_index too? From documentation,
> > it looks like it's used when reading from a buffer and it's not supported.
> 
> Yes you can remove it.
> 
> > 
> > > > +	.scan_type = { \
> > > > +		.sign = 'u', \
> > > > +		.realbits = 16, \
> > > > +		.storagebits = 16, \
> > > > +		.endianness = IIO_LE, \
> > > > +	}, \
> > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > > > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > > > +		BIT(IIO_CHAN_INFO_INT_TIME) | \
> > > > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > > > +		BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
> > > > +
> > > > +static const struct iio_chan_spec si1133_channels[] = {
> > > > +	{
> > > > +		SI1133_CHANNEL(0, SI1133_PARAM_ADCMUX_WHITE, IIO_INTENSITY)
> > > > +		.channel2 = IIO_MOD_LIGHT_BOTH,
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(1, SI1133_PARAM_ADCMUX_LARGE_WHITE,
> > > > +			       IIO_INTENSITY)
> > > > +		.channel2 = IIO_MOD_LIGHT_BOTH,
> > > > +		.extend_name = "large",
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(2, SI1133_PARAM_ADCMUX_SMALL_IR, IIO_INTENSITY)
> > > > +		.extend_name = "small",
> > > > +		.modified = 1,
> > > > +		.channel2 = IIO_MOD_LIGHT_IR,
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(3, SI1133_PARAM_ADCMUX_MED_IR, IIO_INTENSITY)
> > > > +		.extend_name = "med",
> > > > +		.modified = 1,
> > > > +		.channel2 = IIO_MOD_LIGHT_IR,
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(4, SI1133_PARAM_ADCMUX_LARGE_IR, IIO_INTENSITY)
> > > > +		.extend_name = "large",
> > > > +		.modified = 1,
> > > > +		.channel2 = IIO_MOD_LIGHT_IR,
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(5, SI1133_PARAM_ADCMUX_UV, IIO_UVINDEX)
> > > > +	},
> > > > +	{
> > > > +		SI1133_CHANNEL(6, SI1133_PARAM_ADCMUX_UV_DEEP, IIO_UVINDEX)
> > > > +		.extend_name = "deep",
> > > > +	}
> > > > +};
> > > > +
> > > > +static int si1133_read_samp_freq(struct si1133_data *data, int *val, int *val2)
> > > > +{
> > > > +	*val = SI1133_MEASUREMENT_FREQUENCY;
> > > > +	*val2 = data->meas_rate;
> > > > +	return IIO_VAL_FRACTIONAL;
> > > > +}
> > > > +
> > > > +/* Set the samp freq in driver private data */
> > > > +static int si1133_store_samp_freq(struct si1133_data *data, int val)
> > > > +{
> > > > +	unsigned int meas_rate;
> > > > +
> > > > +	if (val <= 0 || val > SI1133_MEASUREMENT_FREQUENCY)
> > > > +		return -ERANGE;
> > > > +	meas_rate = SI1133_MEASUREMENT_FREQUENCY / val;
> > > > +
> > > > +	data->meas_rate = meas_rate;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int si1133_get_int_time_index(int milliseconds, int nanoseconds)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(si1133_int_time_table); i++) {
> > > > +		if (milliseconds == si1133_int_time_table[i][0] &&
> > > > +		    nanoseconds == si1133_int_time_table[i][1])
> > > > +			return i;
> > > > +	}
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static int si1133_set_integration_time(struct si1133_data *data,
> > > > +				       int milliseconds, int nanoseconds)
> > > > +{
> > > > +	int index;
> > > > +
> > > > +	index = si1133_get_int_time_index(milliseconds, nanoseconds);
> > > > +	if (index < 0)
> > > > +		return index;
> > > > +
> > > > +	data->adc_sens &= 0xF0;
> > > > +	data->adc_sens |= index;
> > > > +
> > > > +	return si1133_param_set(data, SI1133_PARAM_REG_ADCSENS(0),
> > > > +				data->adc_sens);
> > > > +}
> > > > +
> > > > +static int si1133_set_chlist(struct iio_dev *indio_dev, unsigned long scan_mask)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	/* channel list already set, no need to reprogram */
> > > > +	if (data->scan_mask == scan_mask)
> > > > +		return 0;
> > > > +
> > > > +	data->scan_mask = scan_mask;
> > > > +
> > > > +	return si1133_param_set(data, SI1133_PARAM_REG_CHAN_LIST, scan_mask);
> > > > +}
> > > > +
> > > > +static int si1133_set_adcmux(struct si1133_data *data, unsigned int mux)
> > > > +{
> > > > +	if ((mux & data->adc_config) == mux)
> > > > +		return 0; /* mux already set to correct value */
> > > > +
> > > > +	data->adc_config &= ~SI1133_ADCMUX_MASK;
> > > > +	data->adc_config |= mux;
> > > > +
> > > > +	return si1133_param_set(data, SI1133_PARAM_REG_ADCCONFIG(0),
> > > > +				data->adc_config);
> > > > +}
> > > > +
> > > > +static int si1133_measure(struct iio_dev *indio_dev,
> > > > +			  struct iio_chan_spec const *chan,
> > > > +			  int *val)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +	int err;
> > > > +	int retries;
> > > > +
> > > > +	__be16 resp;
> > > > +
> > > > +	err = si1133_set_chlist(indio_dev, BIT(0));
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err = si1133_set_adcmux(data, chan->channel);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	retries = SI1133_MAX_RETRIES;
> > > > +
> > > > +	err = si1133_command(data, SI1133_CMD_FORCE);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	reinit_completion(&data->completion);
> > > > +
> > > > +	if (!wait_for_completion_timeout(&data->completion,
> > > > +				msecs_to_jiffies(SI1133_CMD_TIMEOUT_MS)))
> > > > +		return -ETIMEDOUT;
> > > > +
> > > > +	err = regmap_bulk_read(data->regmap, SI1133_REG_HOSTOUT(0), &resp,
> > > > +			       sizeof(resp));
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	*val = be16_to_cpu(resp);
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static irqreturn_t si1133_threaded_irq_handler(int irq, void *private)
> > > > +{
> > > > +	unsigned int irq_status;
> > > > +
> > > > +	struct iio_dev *indio_dev = private;
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +	int err;
> > > > +
> > > > +	err = regmap_read(data->regmap, SI1133_REG_IRQ_STATUS, &irq_status);
> > > > +	if (err) {
> > > > +		dev_err_ratelimited(&indio_dev->dev, "Error reading IRQ\n");
> > > > +		return IRQ_HANDLED;
> > > > +	}
> > > > +
> > > > +	if (irq_status & data->scan_mask) {
> > > > +		complete(&data->completion);
> > > > +		return IRQ_HANDLED;
> > > > +	}
> > > > +
> > > > +	return IRQ_NONE;
> > > > +}
> > > > +
> > > > +static int si1133_scale_to_swgain(int scale_integer, int scale_fractional)
> > > > +{
> > > > +	scale_integer = find_closest(scale_integer, si1133_scale_available,
> > > > +				     ARRAY_SIZE(si1133_scale_available));
> > > > +	if (scale_integer < 0 ||
> > > > +	    scale_integer > ARRAY_SIZE(si1133_scale_available) ||
> > > > +	    scale_fractional != 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return scale_integer;
> > > > +}
> > > > +
> > > > +static int si1133_read_raw(struct iio_dev *indio_dev,
> > > > +			   struct iio_chan_spec const *chan,
> > > > +			   int *val, int *val2, long mask)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +	unsigned int adc_sens = data->adc_sens;
> > > > +	int err;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			err = iio_device_claim_direct_mode(indio_dev);
> > > > +			if (err)
> > > > +				return err;
> > > > +			err = si1133_measure(indio_dev, chan, val);
> > > > +			iio_device_release_direct_mode(indio_dev);
> > > > +
> > > > +			if (err)
> > > > +				return err;
> > > > +
> > > > +			return IIO_VAL_INT;
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	case IIO_CHAN_INFO_INT_TIME:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			adc_sens &= SI1133_ADCSENS_HW_GAIN_MASK;
> > > > +
> > > > +			*val = si1133_int_time_table[adc_sens][0];
> > > > +			*val2 = si1133_int_time_table[adc_sens][1];
> > > > +			return IIO_VAL_INT_PLUS_MICRO;
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			adc_sens &= SI1133_ADCSENS_SCALE_MASK;
> > > > +			adc_sens >>= SI1133_ADCSENS_SCALE_SHIFT;
> > > > +
> > > > +			*val = BIT(adc_sens);
> > > > +
> > > > +			return IIO_VAL_INT;
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			adc_sens >>= SI1133_ADCSENS_HSIG_SHIFT;
> > > > +
> > > > +			*val = adc_sens;
> > > > +
> > > > +			return IIO_VAL_INT;
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > > +		return si1133_read_samp_freq(data, val, val2);
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int si1133_set_adcsens(struct iio_dev *indio_dev,
> > > > +			      unsigned int mask, unsigned int shift,
> > > > +			      unsigned int value)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +	unsigned int adc_sens;
> > > > +	int err;
> > > > +
> > > > +	err = si1133_param_query(data, SI1133_PARAM_REG_ADCSENS(0), &adc_sens);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	adc_sens &= ~mask;
> > > > +	adc_sens |= (value << shift);
> > > > +
> > > > +	err = si1133_param_set(data, SI1133_PARAM_REG_ADCSENS(0), adc_sens);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	data->adc_sens = adc_sens;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int si1133_write_raw(struct iio_dev *indio_dev,
> > > > +			    struct iio_chan_spec const *chan,
> > > > +			    int val, int val2, long mask)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_SCALE:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			val = si1133_scale_to_swgain(val, val2);
> > > > +			if (val < 0)
> > > > +				return val;
> > > > +
> > > > +			return si1133_set_adcsens(indio_dev,
> > > > +						  SI1133_ADCSENS_SCALE_MASK,
> > > > +						  SI1133_ADCSENS_SCALE_SHIFT,
> > > > +						  val);
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > > +		return si1133_store_samp_freq(data, val);
> > > > +	case IIO_CHAN_INFO_INT_TIME:
> > > > +		return si1133_set_integration_time(data, val, val2);
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > > +		switch (chan->type) {
> > > > +		case IIO_INTENSITY:
> > > > +		case IIO_UVINDEX:
> > > > +			if (val != 0 || val != 1)
> > > > +				return -EINVAL;
> > > > +
> > > > +			return si1133_set_adcsens(indio_dev,
> > > > +						  SI1133_ADCSENS_HSIG_MASK,
> > > > +						  SI1133_ADCSENS_HSIG_SHIFT,
> > > > +						  val);
> > > > +		default:
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static struct attribute *si1133_attributes[] = {
> > > > +	&iio_const_attr_integration_time_available.dev_attr.attr,
> > > > +	&iio_const_attr_scale_available.dev_attr.attr,
> > > > +	NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group si1133_attribute_group = {
> > > > +	.attrs = si1133_attributes,
> > > > +};
> > > > +
> > > > +static const struct iio_info si1133_info = {
> > > > +	.read_raw = si1133_read_raw,
> > > > +	.write_raw = si1133_write_raw,
> > > > +	.attrs = &si1133_attribute_group,
> > > > +};
> > > > +
> > > > +static int si1133_initialize(struct si1133_data *data)
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	data->scan_mask = 0x01;  
> > > 
> > > BIT(0)?
> > >   
> > > > +
> > > > +	err = si1133_cmd_reset_sw(data);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	/* Turn off autonomous mode */
> > > > +	err = si1133_param_set(data, SI1133_REG_MEAS_RATE, 0);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	/* Initialize sampling freq to 1 Hz */
> > > > +	err = si1133_store_samp_freq(data, 1);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	/* Activate first channel */
> > > > +	err = si1133_param_set(data, SI1133_PARAM_REG_CHAN_LIST,
> > > > +			       data->scan_mask);
> > > > +	if (err < 0)
> > > > +		return err;
> > > > +
> > > > +	return regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 1);
> > > > +}
> > > > +
> > > > +static int si1133_validate_ids(struct iio_dev *indio_dev)
> > > > +{
> > > > +	struct si1133_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	unsigned int part_id, rev_id, mfr_id;
> > > > +	int err;
> > > > +
> > > > +	err = regmap_read(data->regmap, SI1133_REG_PART_ID, &part_id);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err = regmap_read(data->regmap, SI1133_REG_REV_ID, &rev_id);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err = regmap_read(data->regmap, SI1133_REG_MFR_ID, &mfr_id);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	dev_info(&indio_dev->dev, "device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> > > > +		 part_id, rev_id, mfr_id);
> > > > +	if (part_id != SI1133_PART_ID) {
> > > > +		dev_err(&indio_dev->dev, "part ID mismatch got %#02hhx, expected %#02x\n",
> > > > +			part_id, SI1133_PART_ID);
> > > > +		return -ENODEV;
> > > > +	}  
> > > 
> > > add newline maybe
> > >   
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int si1133_probe(struct i2c_client *client,
> > > > +			const struct i2c_device_id *id)
> > > > +{
> > > > +	struct si1133_data *data;
> > > > +	struct iio_dev *indio_dev;
> > > > +  
> > > 
> > > delete newline maybe
> > >   
> > > > +	int err;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	data = iio_priv(indio_dev);
> > > > +
> > > > +	init_completion(&data->completion);
> > > > +
> > > > +	data->regmap = devm_regmap_init_i2c(client, &si1133_regmap_config);
> > > > +	if (IS_ERR(data->regmap)) {
> > > > +		err = PTR_ERR(data->regmap);
> > > > +		dev_err(&client->dev, "Failed to initialise regmap: %d\n", err);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	i2c_set_clientdata(client, indio_dev);
> > > > +	data->client = client;
> > > > +
> > > > +	indio_dev->dev.parent = &client->dev;
> > > > +	indio_dev->name = id->name;
> > > > +	indio_dev->channels = si1133_channels;
> > > > +	indio_dev->num_channels = ARRAY_SIZE(si1133_channels);
> > > > +	indio_dev->info = &si1133_info;
> > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > +
> > > > +	mutex_init(&data->mutex);
> > > > +
> > > > +	err = si1133_validate_ids(indio_dev);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	err = si1133_initialize(data);
> > > > +	if (err) {
> > > > +		dev_err(&client->dev, "Error when initializing chip : %d", err);  
> > > 
> > > no space before : maybe
> > > missing \n
> > >   
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	if (!client->irq) {
> > > > +		dev_err(&client->dev, "Required interrupt not provided, cannot proceed");  
> > > 
> > > missing \n
> > >   
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	err = devm_request_threaded_irq(&client->dev, client->irq,
> > > > +					NULL,
> > > > +					si1133_threaded_irq_handler,
> > > > +					IRQF_ONESHOT | IRQF_SHARED,
> > > > +					client->name, indio_dev);
> > > > +	if (err) {
> > > > +		dev_warn(&client->dev, "Unable to request irq: %d for use\n",  
> > > 
> > > the colon : doesn't make sense
> > >   
> > > > +			 client->irq);
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	err = devm_iio_device_register(&client->dev, indio_dev);
> > > > +	if (err)
> > > > +		dev_err(&client->dev, "iio registration fails with error %d\n",  
> > > 
> > > error message really needed?
> > >   
> > 
> > I like that error message if and only if the subsystem cannot provide me with
> > a worthy message. Is that the case?
> > 
> > > > +			err);
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id si1133_ids[] = {
> > > > +	{ "si1133", 0 },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, si1133_ids);
> > > > +
> > > > +static struct i2c_driver si1133_driver = {
> > > > +	.driver = {
> > > > +	    .name   = "si1133",
> > > > +	},
> > > > +	.probe  = si1133_probe,
> > > > +	.id_table = si1133_ids,
> > > > +};
> > > > +
> > > > +module_i2c_driver(si1133_driver);
> > > > +
> > > > +MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
> > > > +MODULE_DESCRIPTION("Silabs SI1133, UV index sensor and ambient light sensor driver");
> > > > +MODULE_LICENSE("GPL");
> > > >   
> > > 
> > > -- 
> > > 
> > > Peter Meerwald-Stadler
> > > Mobile: +43 664 24 44 418  
> > 
> > Maxime Roussin-Belanger
> 
