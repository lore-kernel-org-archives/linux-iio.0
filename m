Return-Path: <SRS0=kXWq=JW=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 6 Jul 2018 18:36:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>
Subject: Re: [PATCH v2] iio: light: introduce si1133
Message-ID: <20180706183635.00007c43@huawei.com>
In-Reply-To: <20180705134901.vrrfq7lqcyjah2wa@mbedesk.sonatest.net>
References: <20180626170109.13437-1-maxime.roussinbelanger@gmail.com>
	<20180630181854.1de97eec@archlinux>
	<20180705134901.vrrfq7lqcyjah2wa@mbedesk.sonatest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Thu, 5 Jul 2018 09:49:02 -0400
Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com> wrote:

> On Sat, Jun 30, 2018 at 06:18:54PM +0100, Jonathan Cameron wrote:
> > On Tue, 26 Jun 2018 13:01:09 -0400
> > Maxime Roussin-B=E9langer <maxime.roussinbelanger@gmail.com> wrote:
> >=20
> > Hi Maxime
> >=20
> > Coming together nicely though a few minor things inline to add to Peter=
's
> > review.
> >=20
> > It would make the device a lot more useful if we could provide a lux
> > measurement.  There is code out there to do this from the IR and ambien=
t  + IR
> > channels, but licensing is going to be a potential issue. See inline.
> >=20
> > Jonathan
> >  =20
> > > Signed-off-by: Maxime Roussin-B=E9langer <maxime.roussinbelanger@gmai=
l.com>
> > > Reviewed-by: Jean-Francois Dagenais <dagenaisj@sonatest.com>
> > > ---
> > > Changes in v2:
> > > 	- Add ABI documentation
> > > 	- Drop part abstraction
> > > 	- Clean up error handling style
> > >=20
> > >  .../ABI/testing/sysfs-bus-iio-light-si1133    |  57 ++
> > >  drivers/iio/light/Kconfig                     |  11 +
> > >  drivers/iio/light/Makefile                    |   1 +
> > >  drivers/iio/light/si1133.c                    | 809 ++++++++++++++++=
++
> > >  4 files changed, 878 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-si1=
133
> > >  create mode 100644 drivers/iio/light/si1133.c
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-si1133 b/D=
ocumentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > new file mode 100644
> > > index 000000000000..4533b5699c87
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-si1133
> > > @@ -0,0 +1,57 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity0_ir_small_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 1
> > > +		dark photodiode. "small" indicate the surface area capturing
> > > +		infrared.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity1_ir_med_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 2
> > > +		dark photodiode. "med" indicate the surface area capturing
> > > +		infrared.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity2_ir_large_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Unit-less infrared intensity. The intensity is measured from 4
> > > +		dark photodiode. "large" indicate the surface area capturing
> > > +		infrared. =20
> >=20
> > I'll admit I'm lost.  Why would we use the different numbers of photodi=
odes?
> > I get that the device supports them, but if there is a combination that=
 is=20
> > normally right, I'd like that one to be the one we don't use an extende=
d name
> > for (so generic code might look at it)
> >  =20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity11_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Get the current intensity of visible light which is influenced
> > > +		by Infrared light. If an accurate lux measurement is desired,
> > > +		the extra IR response of the visible-light photodiode must be
> > > +		compensated.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity13_large_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Get the current intensity of visible light with more diodes than
> > > +		the non-large version which is influenced by Infrared light. =20
> >=20
> > This sentence is confusing as the 'more diodes bit' is inserted in the =
middle
> > and it sounds a bit like that makes it influenced by IR.  I would make =
it two
> > sentences.
> >  =20
> > > +		If an accurate lux measurement is desired, the extra IR response
> > > +		of the visible-light photodiode must be compensated.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindex24_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		UV light intensity index measuring the human skin's response to
> > > +		different wavelength of sunlight weighted according to the
> > > +		standardised CIE Erythemal Action Spectrum. =20
> >=20
> > This should be a standard bit of ABI.  Please check if the generic docs
> > are good enough as it is best to avoid repetition.
> >  =20
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindex25_deep_raw
> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		UV light intensity index measuring the human skin's response to
> > > +		deep ultraviolet (DUV) wavelength of sunlight weighted according
> > > +		to the standardised CIE Erythemal Action Spectrum. =20
> >=20
> > I think we need a new modifier for this one.  Please propose something =
suitable.
> > I doubt it'll be the last time we see a sensor measuring this!
> >  =20
> > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > index c7ef8d1862d6..dfa3b1f956f8 100644
> > > --- a/drivers/iio/light/Kconfig
> > > +++ b/drivers/iio/light/Kconfig
> > > @@ -332,6 +332,17 @@ config SI1145
> > >  	  To compile this driver as a module, choose M here: the module wil=
l be
> > >  	  called si1145.
> > > =20
> > > +config SI1133
> > > +	tristate "SI1133 UV Index Sensor and Ambient Light Sensor"
> > > +	depends on I2C
> > > +	select REGMAP_I2C
> > > +	  help
> > > +	  Say Y here if you want to build a driver for the Silicon Labs SI1=
133
> > > +	  UV Index Sensor and Ambient Light Sensor chip.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module wil=
l be
> > > +	  called si1133.
> > > +
> > >  config STK3310
> > >  	tristate "STK3310 ALS and proximity sensor"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > > index 80943af5d627..dd9ffc38beeb 100644
> > > --- a/drivers/iio/light/Makefile
> > > +++ b/drivers/iio/light/Makefile
> > > @@ -33,6 +33,7 @@ obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
> > >  obj-$(CONFIG_RPR0521)		+=3D rpr0521.o
> > >  obj-$(CONFIG_SENSORS_TSL2563)	+=3D tsl2563.o
> > >  obj-$(CONFIG_SI1145)		+=3D si1145.o
> > > +obj-$(CONFIG_SI1133)		+=3D si1133.o
> > >  obj-$(CONFIG_STK3310)          +=3D stk3310.o
> > >  obj-$(CONFIG_ST_UVIS25)		+=3D st_uvis25_core.o
> > >  obj-$(CONFIG_ST_UVIS25_I2C)	+=3D st_uvis25_i2c.o
> > > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> > > new file mode 100644
> > > index 000000000000..6cb7fd8c35e4
> > > --- /dev/null
> > > +++ b/drivers/iio/light/si1133.c
> > > @@ -0,0 +1,809 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * si1133.c - Support for Silabs SI1133 combined ambient
> > > + * light and UV index sensors
> > > + *
> > > + * Copyright 2018 Maxime Roussin-Belanger <maxime.roussinbelanger@gm=
ail.com>
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +
> > > +#include <linux/util_macros.h>
> > > +
> > > +#define SI1133_REG_PART_ID		0x00
> > > +#define SI1133_REG_REV_ID		0x01
> > > +#define SI1133_REG_MFR_ID		0x02
> > > +#define SI1133_REG_INFO0		0x03
> > > +#define SI1133_REG_INFO1		0x04
> > > +
> > > +#define SI1133_PART_ID			0x33
> > > +
> > > +#define SI1133_REG_HOSTIN0		0x0A
> > > +#define SI1133_REG_COMMAND		0x0B
> > > +#define SI1133_REG_IRQ_ENABLE		0x0F
> > > +#define SI1133_REG_RESPONSE1		0x10
> > > +#define SI1133_REG_RESPONSE0		0x11
> > > +#define SI1133_REG_IRQ_STATUS		0x12
> > > +#define SI1133_REG_MEAS_RATE		0x1A
> > > +
> > > +#define SI1133_CMD_RESET_CTR		0x00
> > > +#define SI1133_CMD_RESET_SW		0x01
> > > +#define SI1133_CMD_FORCE		0x11
> > > +#define SI1133_CMD_START_AUTONOMOUS	0x13
> > > +#define SI1133_CMD_PARAM_SET		0x80
> > > +#define SI1133_CMD_PARAM_QUERY		0x40
> > > +#define SI1133_CMD_PARAM_MASK		0x3F
> > > +
> > > +#define SI1133_CMD_ERR_MASK		BIT(4)
> > > +#define SI1133_CMD_SEQ_MASK		0xF
> > > +
> > > +#define SI1133_PARAM_REG_CHAN_LIST	0x01
> > > +#define SI1133_PARAM_REG_ADCCONFIG(x)	(((x) * 4) + 2)
> > > +#define SI1133_PARAM_REG_ADCSENS(x)	(((x) * 4) + 3)
> > > +
> > > +#define SI1133_ADCMUX_MASK 0x1F
> > > +#define SI1133_ADCSENS_SCALE_MASK 0x70
> > > +#define SI1133_ADCSENS_SCALE_SHIFT 4
> > > +
> > > +#define SI1133_ADCSENS_HSIG_MASK 0x80
> > > +#define SI1133_ADCSENS_HSIG_SHIFT 7
> > > +
> > > +#define SI1133_ADCSENS_HW_GAIN_MASK 0xF
> > > +
> > > +#define SI1133_PARAM_ADCMUX_SMALL_IR	0x0
> > > +#define SI1133_PARAM_ADCMUX_MED_IR	0x1
> > > +#define SI1133_PARAM_ADCMUX_LARGE_IR	0x2
> > > +#define SI1133_PARAM_ADCMUX_WHITE	0xB
> > > +#define SI1133_PARAM_ADCMUX_LARGE_WHITE	0xD
> > > +#define SI1133_PARAM_ADCMUX_UV		0x18
> > > +#define SI1133_PARAM_ADCMUX_UV_DEEP	0x19
> > > +
> > > +#define SI1133_ERR_INVALID_CMD		0x0
> > > +#define SI1133_ERR_INVALID_LOCATION_CMD 0x1
> > > +#define SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION 0x2
> > > +#define SI1133_ERR_OUTPUT_BUFFER_OVERFLOW 0x3
> > > +
> > > +#define SI1133_CMD_MINSLEEP_US_LOW	5000
> > > +#define SI1133_CMD_MINSLEEP_US_HIGH	7500
> > > +#define SI1133_CMD_TIMEOUT_MS		25
> > > +#define SI1133_MAX_RETRIES 25
> > > +
> > > +#define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
> > > +
> > > +#define SI1133_MAX_CMD_CTR		0xF
> > > +
> > > +#define SI1133_MEASUREMENT_FREQUENCY 1250
> > > +
> > > +static const int si1133_scale_available[] =3D {
> > > +	1, 2, 4, 8, 16, 32, 64, 128};
> > > +
> > > +static IIO_CONST_ATTR(scale_available, "1 2 4 8 16 32 64 128");
> > > +
> > > +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.0244 0.0488 0.0975 0.195 0.3=
90 0.780 "
> > > +				     "1.560 3.120 6.24 12.48 25.0 50.0");
> > > +/* Integration time in milliseconds, nanoseconds */
> > > +static const int si1133_int_time_table[][2] =3D {
> > > +	{0, 24400},	{0, 48800},	{0, 97500},	{0, 195000},
> > > +	{0, 390000},	{0, 780000},	{1, 560000},	{3, 120000},
> > > +	{6, 240000},	{12, 480000},	{25, 000000},	{50, 000000},
> > > +};
> > > +
> > > +static const struct regmap_range si1133_reg_ranges[] =3D {
> > > +	regmap_reg_range(0x00, 0x02),
> > > +	regmap_reg_range(0x0A, 0x0B),
> > > +	regmap_reg_range(0x0F, 0x0F),
> > > +	regmap_reg_range(0x10, 0x12),
> > > +	regmap_reg_range(0x13, 0x2C),
> > > +};
> > > +
> > > +static const struct regmap_range si1133_reg_ro_ranges[] =3D {
> > > +	regmap_reg_range(0x00, 0x02),
> > > +	regmap_reg_range(0x10, 0x2C),
> > > +};
> > > +
> > > +static const struct regmap_range si1133_precious_ranges[] =3D {
> > > +	regmap_reg_range(0x12, 0x12),
> > > +};
> > > +
> > > +static const struct regmap_access_table si1133_write_ranges_table =
=3D {
> > > +	.yes_ranges	=3D si1133_reg_ranges,
> > > +	.n_yes_ranges	=3D ARRAY_SIZE(si1133_reg_ranges),
> > > +	.no_ranges	=3D si1133_reg_ro_ranges,
> > > +	.n_no_ranges	=3D ARRAY_SIZE(si1133_reg_ro_ranges),
> > > +};
> > > +
> > > +static const struct regmap_access_table si1133_read_ranges_table =3D=
 {
> > > +	.yes_ranges	=3D si1133_reg_ranges,
> > > +	.n_yes_ranges	=3D ARRAY_SIZE(si1133_reg_ranges),
> > > +};
> > > +
> > > +static const struct regmap_access_table si1133_precious_table =3D {
> > > +	.yes_ranges	=3D si1133_precious_ranges,
> > > +	.n_yes_ranges	=3D ARRAY_SIZE(si1133_precious_ranges),
> > > +};
> > > +
> > > +static const struct regmap_config si1133_regmap_config =3D {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +
> > > +	.max_register =3D 0x2C,
> > > +
> > > +	.wr_table =3D &si1133_write_ranges_table,
> > > +	.rd_table =3D &si1133_read_ranges_table,
> > > +
> > > +	.precious_table =3D &si1133_precious_table,
> > > +};
> > > +
> > > +struct si1133_data {
> > > +	struct regmap *regmap;
> > > +	struct i2c_client *client;
> > > +
> > > +	/* Lock protecting one command at a time can be processed */
> > > +	struct mutex mutex;
> > > +
> > > +	int rsp_seq;
> > > +	unsigned long scan_mask;
> > > +	unsigned int adc_sens;
> > > +	unsigned int adc_config;
> > > +	unsigned int meas_rate;
> > > +
> > > +	struct completion completion;
> > > +};
> > > +
> > > +/**
> > > + * si1133_cmd_reset_sw() - Reset the chip
> > > + *
> > > + * Wait till command reset completes or timeout
> > > + */
> > > +static int si1133_cmd_reset_sw(struct si1133_data *data)
> > > +{
> > > +	struct device *dev =3D &data->client->dev;
> > > +	unsigned int resp;
> > > +	unsigned long timeout;
> > > +	int err;
> > > +
> > > +	err =3D regmap_write(data->regmap, SI1133_REG_COMMAND,
> > > +			   SI1133_CMD_RESET_SW);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	timeout =3D jiffies + msecs_to_jiffies(SI1133_CMD_TIMEOUT_MS);
> > > +	while (true) {
> > > +		err =3D regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
> > > +		if (err =3D=3D -ENXIO) {
> > > +			usleep_range(SI1133_CMD_MINSLEEP_US_LOW,
> > > +				     SI1133_CMD_MINSLEEP_US_HIGH);
> > > +			continue;
> > > +		}
> > > +
> > > +		if ((resp & SI1133_MAX_CMD_CTR) =3D=3D SI1133_MAX_CMD_CTR)
> > > +			break;
> > > +
> > > +		if (time_after(jiffies, timeout)) {
> > > +			dev_warn(dev, "timeout on reset ctr resp: %d\n", resp);
> > > +			return -ETIMEDOUT;
> > > +		}
> > > +	}
> > > +
> > > +	if (!err)
> > > +		data->rsp_seq =3D SI1133_MAX_CMD_CTR;
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int si1133_parse_response_err(struct device *dev, unsigned in=
t resp,
> > > +				     u8 cmd)
> > > +{
> > > +	int ret =3D 0;
> > > +
> > > +	resp &=3D 0xF;
> > > +
> > > +	switch (resp) {
> > > +	case SI1133_ERR_OUTPUT_BUFFER_OVERFLOW:
> > > +		dev_warn(dev, "Output buffer overflow: %#02hhx\n", cmd);
> > > +		ret =3D -EOVERFLOW;
> > > +		break;
> > > +	case SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION:
> > > +		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: =
%#02hhx\n",
> > > +			 cmd);
> > > +		ret =3D -EOVERFLOW;
> > > +		break;
> > > +	case SI1133_ERR_INVALID_LOCATION_CMD:
> > > +		dev_warn(dev, "Parameter access to an invalid location: %#02hhx\n",
> > > +			 cmd);
> > > +		ret =3D -EINVAL;
> > > +		break;
> > > +	case SI1133_ERR_INVALID_CMD:
> > > +		dev_warn(dev, "Invalid command %#02hhx\n", cmd);
> > > +		ret =3D -EINVAL; =20
> > return -EINVAL... Lots of these above.
> >  =20
> > > +		break;
> > > +	default:
> > > +		dev_warn(dev, "Unknown error %#02hhx\n", cmd);
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int si1133_cmd_reset_counter(struct si1133_data *data)
> > > +{
> > > +	int err =3D regmap_write(data->regmap, SI1133_REG_COMMAND,
> > > +			       SI1133_CMD_RESET_CTR);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	data->rsp_seq =3D 0;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int si1133_command(struct si1133_data *data, u8 cmd)
> > > +{
> > > +	struct device *dev =3D &data->client->dev;
> > > +	unsigned int resp;
> > > +	int err;
> > > +	int expected_seq;
> > > +
> > > +	mutex_lock(&data->mutex);
> > > +
> > > +	expected_seq =3D (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
> > > +
> > > +	err =3D regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
> > > +	if (err) {
> > > +		dev_warn(dev, "failed to write command %#02hhx, ret=3D%d\n", cmd,
> > > +			 err);
> > > +		goto out;
> > > +	}
> > > +
> > > +	err =3D regmap_read_poll_timeout(data->regmap, SI1133_REG_RESPONSE0=
, resp,
> > > +				       (resp & SI1133_CMD_SEQ_MASK) =3D=3D
> > > +				       expected_seq ||
> > > +				       (resp & SI1133_CMD_ERR_MASK),
> > > +				       SI1133_CMD_MINSLEEP_US_LOW,
> > > +				       SI1133_CMD_TIMEOUT_MS * 1000);
> > > +
> > > +	if (resp & SI1133_CMD_ERR_MASK) {
> > > +		err =3D si1133_parse_response_err(dev, resp, cmd);
> > > +		si1133_cmd_reset_counter(data);
> > > +	} else {
> > > +		data->rsp_seq =3D resp & SI1133_CMD_SEQ_MASK;
> > > +	}
> > > +
> > > +out:
> > > +	mutex_unlock(&data->mutex);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int si1133_param_set(struct si1133_data *data, u8 param,
> > > +			    unsigned int value)
> > > +{
> > > +	int err =3D regmap_write(data->regmap, SI1133_REG_HOSTIN0, value);
> > > +
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return si1133_command(data, SI1133_CMD_PARAM_SET |
> > > +			      (param & SI1133_CMD_PARAM_MASK));
> > > +}
> > > +
> > > +static int si1133_param_query(struct si1133_data *data, u8 param,
> > > +			      unsigned int *result)
> > > +{
> > > +	int err =3D si1133_command(data, SI1133_CMD_PARAM_QUERY |
> > > +				 (param & SI1133_CMD_PARAM_MASK));
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return regmap_read(data->regmap, SI1133_REG_RESPONSE1, result);
> > > +}
> > > +
> > > +#define SI1133_CHANNEL(_si, _ch, _type) \
> > > +	.type =3D _type, \
> > > +	.indexed =3D 1, \
> > > +	.channel =3D _ch, \
> > > +	.scan_index =3D _si, \
> > > +	.scan_type =3D { \
> > > +		.sign =3D 'u', \
> > > +		.realbits =3D 16, \
> > > +		.storagebits =3D 16, \
> > > +		.endianness =3D IIO_LE, \
> > > +	}, \
> > > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > > +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > > +		BIT(IIO_CHAN_INFO_INT_TIME) | \
> > > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > > +		BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
> > > +
> > > +static const struct iio_chan_spec si1133_channels[] =3D {
> > > +	{
> > > +		SI1133_CHANNEL(0, SI1133_PARAM_ADCMUX_WHITE, IIO_INTENSITY)
> > > +		.channel2 =3D IIO_MOD_LIGHT_BOTH,
> > > +	},
> > > +	{
> > > +		SI1133_CHANNEL(1, SI1133_PARAM_ADCMUX_LARGE_WHITE,
> > > +			       IIO_INTENSITY)
> > > +		.channel2 =3D IIO_MOD_LIGHT_BOTH,
> > > +		.extend_name =3D "large",
> > > +	},
> > > +	{ =20
> >=20
> > Having in reply to the other review said that you need to maintain chan=
nel
> > indexes, note that they don't have to continue across channels with=20
> > different channel modifiers as those do uniquely describe events etc.
> >=20
> >  =20
> > > +		SI1133_CHANNEL(2, SI1133_PARAM_ADCMUX_SMALL_IR, IIO_INTENSITY)
> > > +		.extend_name =3D "small",
> > > +		.modified =3D 1,
> > > +		.channel2 =3D IIO_MOD_LIGHT_IR,
> > > +	},
> > > +	{
> > > +		SI1133_CHANNEL(3, SI1133_PARAM_ADCMUX_MED_IR, IIO_INTENSITY)
> > > +		.extend_name =3D "med",
> > > +		.modified =3D 1,
> > > +		.channel2 =3D IIO_MOD_LIGHT_IR,
> > > +	},
> > > +	{
> > > +		SI1133_CHANNEL(4, SI1133_PARAM_ADCMUX_LARGE_IR, IIO_INTENSITY)
> > > +		.extend_name =3D "large",
> > > +		.modified =3D 1,
> > > +		.channel2 =3D IIO_MOD_LIGHT_IR,
> > > +	},
> > > +	{
> > > +		SI1133_CHANNEL(5, SI1133_PARAM_ADCMUX_UV, IIO_UVINDEX) =20
> >=20
> > This is an entirely different channel type, index doesn't need to conti=
nue to
> > this from the other channel types.
> >=20
> > Whilst there is nothing in the ABI specifying that it 'should' be done,
> > mostly we restart counting for each channel type / modifier pair.
> > If you want a unique index to identify a channel use 'address'.
> >=20
> > This particular channel is the only one that will be recognised by
> > generic code as it's the only one with out and extended_name.
> >=20
> > It's really annoying that they don't even 'suggest' an algorithm
> > to calculate an ambient light value which is what people will typically
> > want to get from the other channels.  Normally we'd try to produce
> > that value from the driver as an other channel, but here we have no inf=
ormation
> > on how to do it!
> >=20
> > Actually there is example code at:
> > https://siliconlabs.github.io/Gecko_SDK_Doc/efm32g/html/si1133_8c_sourc=
e.html
> >=20
> > but - and it's a big but, the licence agreement is presumably=20
> >=20
> > https://github.com/hrshygoodness/EFM32-Library/blob/master/v2/an/an0820=
_efm32_smart_card/Silabs_License_Agreement.txt
> >=20
> > as that seems to be there standard license and it is a custom spun lice=
nse that
> > I doubt is GPL compatible..=20
> >=20
> > Worth asking if we can use it as it would make the driver of a great de=
al more
> > practical use?
> >  =20
>=20
> Like I said into my other reply I sent an email and asked if we could use=
 the
> algorithm inside the linux kernel based off a GPLv2 license and they repl=
ied this :
>=20
> "
> The LUX calculation code only works with Si1133.=20
> As long as the software is used with Silicon Lab's sensor product, I don'=
t see any problem.
> "
>=20
> Is that enough? If not, what kind of request can we ask from them? Ask th=
em to change
> the license so it's 100% GPLv2 compatible?
>=20
> It's the first time that I deal with some licensing problem, is there a s=
pecific kind of
> questions I should be asking for?=20
>=20
Hmm. Your question seems fine to me and the answer seems clear.  Quote thei=
r email in the
description for the patch so we have it recorded in the git archive.

So I think we are fine, but as ever I'm not a lawyer.  Perhaps send them an=
 advance
copy of the code and ask them confirm that they are happy for it to be incl=
uded in
the mainline kernel under GPL v2?

That should make it clear exactly what code is covered etc.

Jonathan
