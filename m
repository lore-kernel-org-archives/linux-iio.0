Return-Path: <mario.goulart@gmail.com>
Sender: Mario Domenech Goulart <mario.goulart@gmail.com>
From: Mario Domenech Goulart <mario@ossystems.com.br>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, otavio@ossystems.com.br
Subject: Re: RFC: driver for TI ADS124x ADC series
References: <877ggd2fkl.fsf@parenteses.org> <51F97CBD.2090103@kernel.org>
Date: Thu, 08 Aug 2013 13:53:03 +0000
In-Reply-To: <51F97CBD.2090103@kernel.org> (Jonathan Cameron's message of
	"Wed, 31 Jul 2013 22:08:13 +0100")
Message-ID: <878v0cthkw.fsf@parenteses.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan, Lars and folks,

Thanks a lot for your review and comments.  Really appreciated.  Further
comments and questions below.

Lars: thanks for your comments in the other message.  The issues you
point will be addressed.

On Wed, 31 Jul 2013 22:08:13 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On 07/26/13 22:10, Mario Domenech Goulart wrote:
>>
>> We are working on a driver for TI ADS124x ADC series (ADS1246,
>> ADS1247 and ADS1248.  Datasheet: http://www.ti.com/litv/pdf/sbas426g)
>>
>> The attached patch is what we have so far.  It is by no means
>> finished.  We are actually submitting it in the hope you can
>> review it and provide feedback.
>>
>> Some observations and questions in advance:
>>
>> * we've set the chip to only convert on-demand.  I.e., it is not
>>   constantly converting.  Conversions are only performed when
>>   requested via sysfs.  We are not sure about the best approach
>>   with regard to that behavior.  Should it be constantly
>>   converting?
> Depends on how long it takes to bring the chip up to take a sample.
> If you ever provide a buffered interface (probably doesn't make sense
> with a reasonably slow chip like this) then continuous mode would be
> what you would use for that.

The sampling rate for those chips go from 5 up to 2000 samples/second.
Are higher sampling rates like 2000 samples/second feasible when
operating with interruptions?

>> * we've set the device as IIO_TEMP, although what is currently
>>   exposed in sysfs is voltage. The chip is targeted to
>>   temperature sensors, but the actual output of the ADC is
>>   voltage, so we don't know exactly what to use as type.
> Voltage in that case.  If it is feasible to provide the
> stuff to do the temperature calculation via the device tree
> then perhaps temperature would be better.

Ok.  For simplicity, we'll assume voltage from now.

>> * we are aware of some ugly hacks like wait_for_drdy. :-) What's
>>   the best approach to wait for the data ready signal?
> Interrupt if at all possible.  If you have to poll there isn't
> really a better way than what you have, hideous though it is!

Ok.  If the sampling rate is not a problem, we will try to make it
interrupt-driven.

>> * in fact we've been mostly working with ADS1247 and haven't
>>   concentrated on supporting ADS1246 and ADS1248 for now, but we
>>   intend to do so.
>
> A few general comments.  Why do you want to do the explicit channel
> configuration (i.e. only provide specific channels from those supported
> by the chip)?  Normally we'd provide all channels.  The only common
> exception is SoC integrated parts.  There has been some discussion of
> generic configuration of this sort of thing but it hasn't yet come to
> any conclusion (e.g. move this into core code if we are going to allow
> it).  I guess this might be justfiable here as the chip is very much directed
> at differential signals for temperature measurement.
>
> Please document the device tree stuff so we can discuss that without
> digging through the code.

Here's what we currently have for the ADC:

adc_pins_a: adc@0 {
        reg = <0>;
        fsl,pinmux-ids = <
                0x0073 /* MX23_PAD_GPMI_D07__GPIO_0_7 */
                0x00e3 /* MX23_PAD_GPMI_D14__GPIO_0_14 */
                0x00f3 /* MX23_PAD_GPMI_D15__GPIO_0_15 */
        >;
        fsl,drive-strength = <1>;
        fsl,voltage = <1>;
        fsl,pull-up = <1>;
};


ssp1: ssp@80034000 {
        #address-cells = <1>;
        #size-cells = <0>;
        compatible = "fsl,imx23-spi";
        pinctrl-names = "default";
        pinctrl-0 = <&spi2_pins_a>;
        status = "okay";

        adc: ads1247@0 {
                compatible = "ti,ads1247";
                pinctrl-names = "default";
                pinctrl-0 = <&adc_pins_a>;
                drdy-gpio = <&gpio0 7 0>;
                start-gpio = <&gpio0 14 0>;
                reset-gpio = <&gpio0 15 0>;
                spi-max-frequency = <2000000>;
                vref-mv = <2670>;
                #channels = <2>;
                channels = <0 1 2 3>;
                reg = <0>;
        };
};

Those are the parts specific to the ADC.  Please, let me know if you
need more context.

We were thinking about using `#channels' to specify the number of
channels and `channels' to specify the channels configuration as pairs
of inputs.  So, in the case of the above dt, we'd have two channels:

Channel 1:
   Positive input 0
   Negative input 1

Channel 2:
  Positive input 2
  Negative input 3

> Otherwise, some bits and bobs in line.  Mostly the code is fine, but
> could do with a bit of tidying up.

Thanks for reviewing it.  Further comments below.

>> 0001-Initial-and-incomplete-support-for-TI-ADS124x-ADC-se.patch
>>
>>
>> From a31b12f59cc51d414a1e56404707c1d5d227e2f2 Mon Sep 17 00:00:00 2001
>> From: Mario Domenech Goulart <mario@ossystems.com.br>
>> Date: Fri, 26 Jul 2013 16:27:08 -0300
>> Subject: [PATCH] Initial (and incomplete) support for TI ADS124x ADC series
>>  (WIP)
>>
>> Signed-off-by: Mario Domenech Goulart <mario@ossystems.com.br>
>> ---
>>  drivers/staging/iio/adc/Kconfig      |   10 +
>>  drivers/staging/iio/adc/Makefile     |    1 +
>>  drivers/staging/iio/adc/ti-ads124x.c |  495 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 506 insertions(+)
>>  create mode 100644 drivers/staging/iio/adc/ti-ads124x.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index cabc7a3..fec2966 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -130,4 +130,14 @@ config SPEAR_ADC
>>  	  Say yes here to build support for the integrated ADC inside the
>>  	  ST SPEAr SoC. Provides direct access via sysfs.
>>
>> +config TI_ADS124X
>> +	tristate "Texas Instruments ADS1246/7/8 temperature sensor and ADC driver"
>> +	depends on SPI
>> +	help
>> +	  Say yes here to build support for Texas Instruments ADS1246/7/8 temperature
>> +	  sensor and ADC driver.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called ti-ads124x
>> +
>>  endmenu
>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
>> index 3e9fb14..3badf8c 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_AD7280) += ad7280a.o
>>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
>>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>> +obj-$(CONFIG_TI_ADS124X) += ti-ads124x.o
>> diff --git a/drivers/staging/iio/adc/ti-ads124x.c b/drivers/staging/iio/adc/ti-ads124x.c
>> new file mode 100644
>> index 0000000..13467ca
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ti-ads124x.c
>> @@ -0,0 +1,495 @@
>> +/*
>> + * Texas Instruments ADS1246/7/8 ADC driver
>> + *
>> + * Copyright (c) 2013 O.S. Systems Software LTDA.
>> + * Copyright (c) 2013 Otavio Salvador <otavio@ossystems.com.br>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/delay.h>
>> +
>> +/* Register addresses for ADS1247 and ADS1248 */
> Pick a part and name everything after that rather
> than using a wild card. For example there is are
> ads1240, ads1241 and ads1243 that aren't supported
> by this driver.  Even if there were not this
> is bad practice as who is to say that just because
> you have ads1240-ads1249 covered by your driver
> no one will release and ads124a and be confused.

Good point.  Is there a convention for naming in situations like that
(assuming we intend to support ads1246, ads1247 and ads1248)?

>> +#define ADS124X_REG_MUX0      0x00
>> +#define ADS124X_REG_VBIAS     0x01
>> +#define ADS124X_REG_MUX1      0x02
>> +#define ADS124X_REG_SYS0      0x03
>> +#define ADS124X_REG_OFC0      0x04
>> +#define ADS124X_REG_OFC1      0x05
>> +#define ADS124X_REG_OFC2      0x06
>> +#define ADS124X_REG_FSC0      0x07
>> +#define ADS124X_REG_FSC1      0x08
>> +#define ADS124X_REG_FSC2      0x09
>> +#define ADS124X_REG_IDAC0     0x0a
>> +#define ADS124X_REG_IDAC1     0x0b
>> +#define ADS124X_REG_GPIOCFG   0x0c
>> +#define ADS124X_REG_GPIODIR   0x0d
>> +#define ADS124X_REG_GPIODAT   0x0e
>> +
>> +/* SPI Commands */
>> +#define ADS124X_SPI_WAKEUP    0x00
>> +#define ADS124X_SPI_SLEEP     0x02
>> +#define ADS124X_SPI_SYNC1     0x04
>> +#define ADS124X_SPI_SYNC2     0x04
>> +#define ADS124X_SPI_RESET     0x06
>> +#define ADS124X_SPI_NOP       0xff
>> +#define ADS124X_SPI_RDATA     0x12
>> +#define ADS124X_SPI_RDATAC    0x14
>> +#define ADS124X_SPI_SDATAC    0x16
>> +#define ADS124X_SPI_RREG      0x20
>> +#define ADS124X_SPI_WREG      0x40
>> +#define ADS124X_SPI_SYSOCAL   0x60
>> +#define ADS124X_SPI_SYSGCAL   0x61
>> +#define ADS124X_SPI_SELFOCAL  0x62
>> +
>> +#define ADS124X_SINGLE_REG    0x00
>> +
>> +static const u16 ads124x_sample_freq_avail[] = { 5, 10, 20, 40, 80, 160,
>> +						 320, 640, 1000, 2000
>> +};
>> +
>> +static const u8 ads124x_sample_gain_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("5 10 20 40 80 160 320 640 1000 2000");
>> +
>> +static IIO_CONST_ATTR(sampling_gain_available, "1 2 4 8 16 32 64 128");
>> +
>> +static struct attribute *ads124x_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_sampling_gain_available.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group ads124x_attribute_group = {
>> +	.attrs = ads124x_attributes,
>> +};
>> +
>> +struct ads124x_state {
>> +	struct spi_device *spi;
>> +	int drdy_gpio;
>> +	int start_gpio;
>> +	int reset_gpio;
>> +	u32 vref_mv;
>> +	int sample_rate;
>> +
>> +	struct mutex lock;
>> +};
>> +
>> +static const struct of_device_id ads124x_ids[] = {
>> +	{.compatible = "ti,ads1247"},
>> +	{}
>> +};
>> +
> I wouldn't bother with a blank line here.

Ok.

>> +MODULE_DEVICE_TABLE(of, ads124x_ids);
>> +
>> +static int ads124x_stop_reading_continuously(struct ads124x_state *st)
>> +{
>> +	u8 cmd[1];
>> +	int ret;
>> +	cmd[0] = ADS124X_SPI_SDATAC;
>> +
>> +	ret = spi_write(st->spi, cmd, 1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads124x_read_reg(struct ads124x_state *st, u8 reg, u8 *buf)
>> +{
>> +	u8 read_cmd[2];
>> +	int ret;
>> +
>> +	read_cmd[0] = ADS124X_SPI_RREG | reg;
>> +	read_cmd[1] = ADS124X_SINGLE_REG;
>> +	spi_write(st->spi, read_cmd, 2);
>> +
>> +	ret = spi_read(st->spi, buf, 1);
>> +
>> +	return ret;
> return spi_read(...).
>
> Same in other similar cases.

Ok.  Those are leftovers from debugging sessions that printed the return
value.  They are not necessary anymore, indeed.

>> +}
>> +
>> +static int ads124x_write_reg(struct ads124x_state *st,
>> +			     u8 reg, u8 *buf, size_t len)
>> +{
>> +	u8 write_cmd[3];
>> +	int ret;
>> +
>> +	write_cmd[0] = ADS124X_SPI_WREG | reg;
>> +	write_cmd[1] = ADS124X_SINGLE_REG;
>> +	write_cmd[2] = *buf;
>> +
>> +	ret = spi_write(st->spi, write_cmd, 3);
>> +
>> +	return ret;
>> +}
>> +
>> +static u32 ads124x_sample_to_32bit(u8 *sample)
>> +{
>> +	int sample32 = 0;
>> +	sample32 = sample[0] << 16;
>> +	sample32 |= sample[1] << 8;
>> +	sample32 |= sample[2];
> I'd specify the above as one line and for clarity perhaps mask the unused bits
> even if always 0.

Ok.

>> +	return sign_extend32(sample32, 23);
>> +}
>> +
>> +static void wait_for_drdy(int drdy_gpio)
>> +{
>> +	u8 drdy;
>> +
>> +	for (;;) {
>> +		drdy = gpio_get_value(drdy_gpio);
>> +		if (!drdy)
>> +			return;
>> +		usleep_range(1000, 2000);
>> +	}
> Would normally expect this to be interrupt driven with a
> completion used to signal to the waiting code that it was
> done. See the ad_sigma_delta.c code that does something similar
> iirc.

Thanks for the pointer.

>> +}
>> +
>> +static int ads124x_convert(struct ads124x_state *st)
>> +{
>> +	u8 cmd[1], res[3];
>> +	u32 res32;
>> +	int ret;
>> +	cmd[0] = ADS124X_SPI_RDATA;
>> +
>> +	ret = spi_write(st->spi, cmd, 1);
>> +
> Make sure to handle all possible errors.

Ok.

>> +	/* Wait for conversion results */
>> +	wait_for_drdy(st->drdy_gpio);
>> +
>> +	ret = spi_read(st->spi, res, 3);
>> +
>> +	res32 = ads124x_sample_to_32bit(res);
>> +
>> +	return res32;
>> +}
>> +
>> +static void ads124x_start(struct ads124x_state *st)
>> +{
>> +	gpio_set_value(st->start_gpio, 1);
>> +	/* FIXME: the sleep time is not accurate: see the datasheet, */
>> +	/* table 15 at page 33. */
>> +	msleep(200);
>> +	return;
>> +}
>> +
>> +static void ads124x_reset(struct ads124x_state *st)
>> +{
>> +	u8 cmd[1];
>> +	int ret;
>> +
>> +	gpio_set_value(st->reset_gpio, 0);
>> +	gpio_set_value(st->reset_gpio, 1);
>> +
>> +	cmd[0] = ADS124X_SPI_RESET;
>> +	ret = spi_write(st->spi, cmd, 1);
>> +
>> +	msleep(200);		/* FIXME: that's arbitrary. */
> Fix it then ;)

Fair enough. :-)

>> +
>> +	return;
>> +}
>> +
>> +static int ads124x_select_input(struct ads124x_state *st,
>> +				struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan)
>> +{
>> +	u8 mux0;
>> +	int ret;
>> +
>> +	mutex_lock(&st->lock);
>> +
>> +	ret = ads124x_read_reg(st, ADS124X_REG_MUX0, &mux0);
>> +
> No blank line here or in similar locations.

Ok.

>> +	if (ret < 0)
>> +		goto release_lock_and_return;
>> +
>> +	/* Preserve the two most significant bits */
>> +	mux0 &= 0xc0;
>> +
>> +	/* Select positive and negative inputs */
>> +	mux0 |= (chan->channel << 3) | chan->channel2;
>> +
>> +	ret = ads124x_write_reg(st, ADS124X_REG_MUX0, &mux0, 1);
>> +
>> +release_lock_and_return:
>> +	mutex_unlock(&st->lock);
>> +	return ret;
>> +}
>> +
>> +static int ads124x_set_pga_gain(struct ads124x_state *st, u8 gain)
>> +{
>> +	int ret;
>> +	u8 sys0;
>> +
>> +	mutex_lock(&st->lock);
>> +
>> +	ret = ads124x_read_reg(st, ADS124X_REG_SYS0, &sys0);
>> +
>> +	if (ret < 0)
>> +		goto release_lock_and_return;
>> +
>> +	sys0 = (sys0 & 0x8f) | (gain << 4);
>> +
>> +	ret = ads124x_write_reg(st, ADS124X_REG_SYS0, &sys0, 1);
>> +
>> +release_lock_and_return:
>> +	mutex_unlock(&st->lock);
> Normally a blank line before a return statement.

Ok.

>> +	return ret;
>> +}
>> +
>> +static int ads124x_set_sample_rate(struct ads124x_state *st)
>> +{
>> +	u8 sys0;
>> +	int ret;
> Blank line here for conventional formatting.

Ok.

>> +	ret = ads124x_read_reg(st, ADS124X_REG_SYS0, &sys0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	sys0 |= 0x0f & st->sample_rate;
>> +
>> +	ret = ads124x_write_reg(st, ADS124X_REG_SYS0, &sys0, 1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads124x_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val,
>> +			    int *val2,
>> +			    long mask)
>> +{
>> +	struct ads124x_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ads124x_select_input(st, indio_dev, chan);
>> +		wait_for_drdy(st->drdy_gpio);
>> +		ret = ads124x_convert(st);
>> +		*val = ret;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = st->vref_mv;
>> +		*val2 = (1 << 23) - 1;
>> +		return IIO_VAL_FRACTIONAL;
>> +
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val = ads124x_sample_freq_avail[st->sample_rate];
>> +		*val2 = 0;
>> +		return IIO_VAL_INT;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ads124x_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ads124x_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +	u8 i;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		for (i = 0; i < 8; i++)	/* 8 possible values for PGA gain */
>> +			if (val == ads124x_sample_gain_avail[i])
>> +				return ads124x_set_pga_gain(st, i);
>> +		break;
>> +
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		for (i = 0; i < ARRAY_SIZE(ads124x_sample_freq_avail); i++)
>> +			if (val == ads124x_sample_freq_avail[i]) {
>> +				mutex_lock(&st->lock);
>> +				st->sample_rate = i;
>> +				ret = ads124x_set_sample_rate(st);
>> +				mutex_unlock(&st->lock);
>> +				return ret;
>> +			}
>> +		break;
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info ads124x_iio_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw = &ads124x_read_raw,
>> +	.write_raw = &ads124x_write_raw,
>> +	.attrs = &ads124x_attribute_group,
>> +};
>> +
>> +static int ads124x_init_chan_array(struct iio_dev *indio_dev,
>> +				   struct device_node *np)
>> +{
>> +	struct iio_chan_spec *chan_array;
>> +	int num_inputs = indio_dev->num_channels * 2;
>> +	int *channels_config;
>> +	int i, ret;
>> +
>> +	channels_config = kcalloc(num_inputs, sizeof(u32), GFP_KERNEL);
>> +
>> +	ret = of_property_read_u32_array(np, "channels",
>> +					 channels_config, num_inputs);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	chan_array = kcalloc(indio_dev->num_channels,
>> +			     sizeof(struct iio_chan_spec), GFP_KERNEL);
>> +
>> +	if (chan_array == NULL)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_inputs; i += 2) {
>> +		struct iio_chan_spec *chan = chan_array + (i / 2);
>> +		chan->type = IIO_TEMP;
>> +		chan->indexed = 1;
>> +		chan->channel = channels_config[i];
>> +		chan->channel2 = channels_config[i + 1];
> So the any pair of inputs is a valid differential pair?

It actually assumes the dt contains channels configuration that make
sense.  Should it validate the configuration?

>> +		chan->differential = 1;
>> +		chan->scan_index = i;
>> +		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>> +		    BIT(IIO_CHAN_INFO_SAMP_FREQ);
>> +	}
>> +
>> +	indio_dev->channels = chan_array;
>> +
> Why return a variable that is effectively passed in?

Thanks for pointing that out.  It's pointless, indeed.

>> +	return indio_dev->num_channels;
>> +}
>> +
>> +static int ads124x_probe(struct spi_device *spi)
>> +{
>> +	struct device_node *np = spi->dev.of_node;
>> +	struct iio_dev *indio_dev;
>> +	struct ads124x_state *st;
>> +	int ret;
>> +
>> +	indio_dev = iio_device_alloc(sizeof(*st));
>> +	if (indio_dev == NULL)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	/* Initialize GPIO pins */
>> +	st->drdy_gpio = of_get_named_gpio(np, "drdy-gpio", 0);
>> +	st->start_gpio = of_get_named_gpio(np, "start-gpio", 0);
>> +	st->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>> +
>> +	ret = devm_gpio_request_one(&indio_dev->dev, st->drdy_gpio,
>> +				    GPIOF_IN, "adc-drdy");
>> +	if (ret) {
>> +		dev_err(&indio_dev->dev, "failed to get adc-drdy-gpios: %d\n",
>> +			ret);
>> +		goto error;
>> +	}
>> +
>> +	ret = devm_gpio_request_one(&indio_dev->dev, st->start_gpio,
>> +				    GPIOF_OUT_INIT_LOW, "adc-start");
>> +	if (ret) {
>> +		dev_err(&indio_dev->dev, "failed to get adc-start-gpios: %d\n",
>> +			ret);
>> +		goto error;
>> +	}
>> +
>> +	ret = devm_gpio_request_one(&indio_dev->dev, st->reset_gpio,
>> +				    GPIOF_OUT_INIT_LOW, "adc-reset");
> Cleaner to do this with the spi->dev if you use devm_iio_device_alloc
> that was recently introduced.

Ok.  I'll look into that.

>> +	if (ret) {
>> +		dev_err(&indio_dev->dev, "failed to get adc-reset-gpios: %d\n",
>> +			ret);
>> +		goto error;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "vref-mv", &st->vref_mv);
>> +	if (ret < 0)
>> +		goto error;
> Why not use the regulator framework to supply this.

Ok.

>> +
>> +	/* Initialize SPI */
>> +	spi_set_drvdata(spi, indio_dev);
>> +	st->spi = spi;
>> +	st->spi->mode = SPI_MODE_1;
>> +	st->spi->bits_per_word = 8;
>> +	ret = spi_setup(spi);
>> +
>> +	indio_dev->dev.parent = &spi->dev;
>> +	indio_dev->name = np->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &ads124x_iio_info;
>> +
>> +	/* Setup the ADC channels available on the board */
>> +	ret = of_property_read_u32(np, "#channels", &indio_dev->num_channels);
>> +	if (ret < 0)
>> +		goto error;
> I wouldn't normally expect to see this for a non integrated.
> We'd normally expect to see all channels as one tends not to put an N channel
> device on a board without wiring it to something.
>
> Is this actually a way of handling the different parts?

Yeah, we didn't assume non integrated systems.  We assumed a device tree
with proper channel configuration.  Maybe that's not feasible for the
general case.

> If so don't do that, just have separate static channel arrays dependent
> on what parts are present.

Ok.

>> +
>> +	ret = ads124x_init_chan_array(indio_dev, np);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error;
>> +
> These next 3 lines certainly need explanation.  I'd also suggest
> they want to go before the iio_device_register as that brings
> up the userspace interfaces.

Ok.  I'm taking a closer look at the datashet and I'm not totally sure
they are necessary here.  I'll need to investigate it further.

>> +	ads124x_reset(st);
>> +	ads124x_start(st);
>> +	ads124x_stop_reading_continuously(st);
>> +
> This definitely wants to go before the iio_device_register.

Ok.

>> +	mutex_init(&st->lock);
>> +
>> +	return 0;
>> +
>> +error:
>> +	iio_device_free(indio_dev);
>> +	dev_err(&spi->dev, "ADS124x: Error while probing.\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads124x_remove(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +	struct ads124x_state *st;
>> +
>> +	iio_device_unregister(indio_dev);
>> +	iio_device_free(indio_dev);
>> +
> The above frees the iio_dev structure and associated
> private region so the next two lines are accessing memory
> already freed.

Thanks for pointing that out.  Will fix it.

> The recent addition of devm_iio_allocate_device()
> simplifies this sort of handling by providing a managed interface.

Ok.

>> +	st = iio_priv(indio_dev);
>> +	mutex_destroy(&st->lock);
>
>> +
>> +	return 0;
>> +}
>> +
>> +static struct spi_driver ads124x_driver = {
>> +	.driver = {
>> +		   .name = "ti-ads124x",
>> +		   .owner = THIS_MODULE,
>> +		   .of_match_table = of_match_ptr(ads124x_ids),
>> +		   },
>> +	.probe = ads124x_probe,
>> +	.remove = ads124x_remove,
>> +};
>> +
>> +module_spi_driver(ads124x_driver);
>> +
>> +MODULE_AUTHOR("Otavio Salvador <otavio@ossystems.com.br>");
>> +MODULE_DESCRIPTION("Texas Instruments ADS1246/7/8 driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 1.7.10.4

Best wishes.
Mario
-- 
http://www.ossystems.com.br
