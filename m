Return-Path: <oleksandr.kozaruk@globallogic.com>
MIME-Version: 1.0
In-Reply-To: <520BFFFF.7040904@kernel.org>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
	<1374758813-6539-3-git-send-email-oleksandr.kozaruk@ti.com>
	<520BFFFF.7040904@kernel.org>
Date: Thu, 15 Aug 2013 08:45:50 +0300
Message-ID: <CAPb7_mthhYXbp0tTKMvV=gwndfaHMxnrXPCgxUk3MSH1R+W9rQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
From: Oleksandr Kozaruk <oleksandr.kozaruk@globallogic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: tony@atomide.com, benoit.cousson@linaro.org, rnayak@ti.com,
	peter.ujfalusi@ti.com, kishon@ti.com, jic23@cam.ac.uk,
	Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>,
	Lars-Peter Clausen <lars@metafoo.de>, sameo@linux.intel.com,
	naveen krishna <ch.naveen@samsung.com>, poeschel@lemonage.de, milo.kim@ti.com,
	balajitk@ti.com, gg@slimlogic.co.uk, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b677c7e8a42ab04e3f5fc77
List-ID: <linux-iio@vger.kernel.org>

--047d7b677c7e8a42ab04e3f5fc77
Content-Type: text/plain; charset=ISO-8859-1

Hello Jonathan,

Thank you for the review and valuable comments.

Multiple authors are done by having multiple MODULE_AUTHOR lines rather as
> one long string.  See include/linux/module.h. I fixed that up and
> dealt with some trivial fuzz in the makefile/Kconfig.
>
>
> You might want to take advantage of devm_iio_allocate_device
> which has been introduced in the meantime and greatly simplifies error
> paths in IIO probe functions.
>

Should I make new version of the patch, or just prepare a new patch that
patches the patch?

Regards,
Sasha.



> Anyhow, applied to the togreg branch of iio.git
>
> Note I haven't taken the device tree patch. For that I would need and ack
> from the relevant maintainer(s). Personally I'd rather not touch device
> tree
> files unless i have to due to the high chance of merge conflicts occuring.
> I would expect the subarch maintainer to pick that one up (or to ask me
> to ;)
>
> Nice relatively clean driver for a somewhat 'interesting' bit of hardware.
>
> Thanks
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/Kconfig         |   14 +
> >  drivers/iio/adc/Makefile        |    1 +
> >  drivers/iio/adc/twl6030-gpadc.c | 1027
> +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1042 insertions(+)
> >  create mode 100644 drivers/iio/adc/twl6030-gpadc.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 93129ec..f8f9f18 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -160,6 +160,20 @@ config TI_AM335X_ADC
> >         Say yes here to build support for Texas Instruments ADC
> >         driver which is also a MFD client.
> >
> > +config TWL6030_GPADC
> > +     tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
> > +     depends on TWL4030_CORE
> > +     default n
> > +     help
> > +       Say yes here if you want support for the TWL6030/TWL6032 General
> > +       Purpose A/D Converter. This will add support for battery type
> > +       detection, battery voltage and temperature measurement, die
> > +       temperature measurement, system supply voltage, audio accessory,
> > +       USB ID detection.
> > +
> > +       This driver can also be built as a module. If so, the module
> will be
> > +       called twl6030-gpadc.
> > +
> >  config VIPERBOARD_ADC
> >       tristate "Viperboard ADC support"
> >       depends on MFD_VIPERBOARD && USB
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 8f475d3..db430bd 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -17,4 +17,5 @@ obj-$(CONFIG_MAX1363) += max1363.o
> >  obj-$(CONFIG_MCP320X) += mcp320x.o
> >  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
> >  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> > +obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> > diff --git a/drivers/iio/adc/twl6030-gpadc.c
> b/drivers/iio/adc/twl6030-gpadc.c
> > new file mode 100644
> > index 0000000..2b63083
> > --- /dev/null
> > +++ b/drivers/iio/adc/twl6030-gpadc.c
> > @@ -0,0 +1,1027 @@
> > +/*
> > + * TWL6030 GPADC module driver
> > + *
> > + * Copyright (C) 2009-2013 Texas Instruments Inc.
> > + * Nishant Kamat <nskamat@ti.com>
> > + * Balaji T K <balajitk@ti.com>
> > + * Graeme Gregory <gg@slimlogic.co.uk>
> > + * Girish S Ghongdemath <girishsg@ti.com>
> > + * Ambresh K <ambresh@ti.com>
> > + * Oleksandr Kozaruk <oleksandr.kozaruk@ti.com
> > + *
> > + * Based on twl4030-madc.c
> > + * Copyright (C) 2008 Nokia Corporation
> > + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> > + * 02110-1301 USA
> > + *
> > + */
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/i2c/twl.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define DRIVER_NAME          "twl6030_gpadc"
> > +
> > +/*
> > + * twl6030 per TRM has 17 channels, and twl6032 has 19 channels
> > + * 2 test network channels are not used,
> > + * 2 die temperature channels are not used either, as it is not
> > + * defined how to convert ADC value to temperature
> > + */
> > +#define TWL6030_GPADC_USED_CHANNELS          13
> > +#define TWL6030_GPADC_MAX_CHANNELS           15
> > +#define TWL6032_GPADC_USED_CHANNELS          15
> > +#define TWL6032_GPADC_MAX_CHANNELS           19
> > +#define TWL6030_GPADC_NUM_TRIM_REGS          16
> > +
> > +#define TWL6030_GPADC_CTRL_P1                        0x05
> > +
> > +#define TWL6032_GPADC_GPSELECT_ISB           0x07
> > +#define TWL6032_GPADC_CTRL_P1                        0x08
> > +
> > +#define TWL6032_GPADC_GPCH0_LSB                      0x0d
> > +#define TWL6032_GPADC_GPCH0_MSB                      0x0e
> > +
> > +#define TWL6030_GPADC_CTRL_P1_SP1            BIT(3)
> > +
> > +#define TWL6030_GPADC_GPCH0_LSB                      (0x29)
> > +
> > +#define TWL6030_GPADC_RT_SW1_EOC_MASK                BIT(5)
> > +
> > +#define TWL6030_GPADC_TRIM1                  0xCD
> > +
> > +#define TWL6030_REG_TOGGLE1                  0x90
> > +#define TWL6030_GPADCS                               BIT(1)
> > +#define TWL6030_GPADCR                               BIT(0)
> > +
> > +/**
> > + * struct twl6030_chnl_calib - channel calibration
> > + * @gain:            slope coefficient for ideal curve
> > + * @gain_error:              gain error
> > + * @offset_error:    offset of the real curve
> > + */
> > +struct twl6030_chnl_calib {
> > +     s32 gain;
> > +     s32 gain_error;
> > +     s32 offset_error;
> > +};
> > +
> > +/**
> > + * struct twl6030_ideal_code - GPADC calibration parameters
> > + * GPADC is calibrated in two points: close to the beginning and
> > + * to the and of the measurable input range
> > + *
> > + * @channel: channel number
> > + * @code1:   ideal code for the input at the beginning
> > + * @code2:   ideal code for at the end of the range
> > + * @volt1:   voltage input at the beginning(low voltage)
> > + * @volt2:   voltage input at the end(high voltage)
> > + */
> > +struct twl6030_ideal_code {
> > +     int channel;
> > +     u16 code1;
> > +     u16 code2;
> > +     u16 volt1;
> > +     u16 volt2;
> > +};
> > +
> > +struct twl6030_gpadc_data;
> > +
> > +/**
> > + * struct twl6030_gpadc_platform_data - platform specific data
> > + * @nchannels:               number of GPADC channels
> > + * @iio_channels:    iio channels
> > + * @twl6030_ideal:   pointer to calibration parameters
> > + * @start_conversion:        pointer to ADC start conversion function
> > + * @channel_to_reg   pointer to ADC function to convert channel to
> > + *                   register address for reading conversion result
> > + * @calibrate:               pointer to calibration function
> > + */
> > +struct twl6030_gpadc_platform_data {
> > +     const int nchannels;
> > +     const struct iio_chan_spec *iio_channels;
> > +     const struct twl6030_ideal_code *ideal;
> > +     int (*start_conversion)(int channel);
> > +     u8 (*channel_to_reg)(int channel);
> > +     int (*calibrate)(struct twl6030_gpadc_data *gpadc);
> > +};
> > +
> > +/**
> > + * struct twl6030_gpadc_data - GPADC data
> > + * @dev:             device pointer
> > + * @lock:            mutual exclusion lock for the structure
> > + * @irq_complete:    completion to signal end of conversion
> > + * @twl6030_cal_tbl: pointer to calibration data for each
> > + *                   channel with gain error and offset
> > + * @pdata:           pointer to device specific data
> > + */
> > +struct twl6030_gpadc_data {
> > +     struct device   *dev;
> > +     struct mutex    lock;
> > +     struct completion       irq_complete;
> > +     struct twl6030_chnl_calib       *twl6030_cal_tbl;
> > +     const struct twl6030_gpadc_platform_data *pdata;
> > +};
> > +
> > +/*
> > + * channels 11, 12, 13, 15 and 16 have no calibration data
> > + * calibration offset is same for channels 1, 3, 4, 5
> > + *
> > + * The data is taken from GPADC_TRIM registers description.
> > + * GPADC_TRIM registers keep difference between the code measured
> > + * at volt1 and volt2 input voltages and corresponding code1 and code2
> > + */
> > +static const struct twl6030_ideal_code
> > +     twl6030_ideal[TWL6030_GPADC_USED_CHANNELS] = {
> > +     [0] = { /* ch 0, external, battery type, resistor value */
> > +             .channel = 0,
> > +             .code1 = 116,
> > +             .code2 = 745,
> > +             .volt1 = 141,
> > +             .volt2 = 910,
> > +     },
> > +     [1] = { /* ch 1, external, battery temperature, NTC resistor value
> */
> > +             .channel = 1,
> > +             .code1 = 82,
> > +             .code2 = 900,
> > +             .volt1 = 100,
> > +             .volt2 = 1100,
> > +     },
> > +     [2] = { /* ch 2, external, audio accessory/general purpose */
> > +             .channel = 2,
> > +             .code1 = 55,
> > +             .code2 = 818,
> > +             .volt1 = 101,
> > +             .volt2 = 1499,
> > +     },
> > +     [3] = { /* ch 3, external, general purpose */
> > +             .channel = 3,
> > +             .code1 = 82,
> > +             .code2 = 900,
> > +             .volt1 = 100,
> > +             .volt2 = 1100,
> > +     },
> > +     [4] = { /* ch 4, external, temperature measurement/general purpose
> */
> > +             .channel = 4,
> > +             .code1 = 82,
> > +             .code2 = 900,
> > +             .volt1 = 100,
> > +             .volt2 = 1100,
> > +     },
> > +     [5] = { /* ch 5, external, general purpose */
> > +             .channel = 5,
> > +             .code1 = 82,
> > +             .code2 = 900,
> > +             .volt1 = 100,
> > +             .volt2 = 1100,
> > +     },
> > +     [6] = { /* ch 6, external, general purpose */
> > +             .channel = 6,
> > +             .code1 = 82,
> > +             .code2 = 900,
> > +             .volt1 = 100,
> > +             .volt2 = 1100,
> > +     },
> > +     [7] = { /* ch 7, internal, main battery */
> > +             .channel = 7,
> > +             .code1 = 614,
> > +             .code2 = 941,
> > +             .volt1 = 3001,
> > +             .volt2 = 4599,
> > +     },
> > +     [8] = { /* ch 8, internal, backup battery */
> > +             .channel = 8,
> > +             .code1 = 82,
> > +             .code2 = 688,
> > +             .volt1 = 501,
> > +             .volt2 = 4203,
> > +     },
> > +     [9] = { /* ch 9, internal, external charger input */
> > +             .channel = 9,
> > +             .code1 = 182,
> > +             .code2 = 818,
> > +             .volt1 = 2001,
> > +             .volt2 = 8996,
> > +     },
> > +     [10] = { /* ch 10, internal, VBUS */
> > +             .channel = 10,
> > +             .code1 = 149,
> > +             .code2 = 818,
> > +             .volt1 = 1001,
> > +             .volt2 = 5497,
> > +     },
> > +     [11] = { /* ch 11, internal, VBUS charging current */
> > +             .channel = 11,
> > +     },
> > +             /* ch 12, internal, Die temperature */
> > +             /* ch 13, internal, Die temperature */
> > +     [12] = { /* ch 14, internal, USB ID line */
> > +             .channel = 14,
> > +             .code1 = 48,
> > +             .code2 = 714,
> > +             .volt1 = 323,
> > +             .volt2 = 4800,
> > +     },
> > +};
> > +
> > +static const struct twl6030_ideal_code
> > +                     twl6032_ideal[TWL6032_GPADC_USED_CHANNELS] = {
> > +     [0] = { /* ch 0, external, battery type, resistor value */
> > +             .channel = 0,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [1] = { /* ch 1, external, battery temperature, NTC resistor value
> */
> > +             .channel = 1,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [2] = { /* ch 2, external, audio accessory/general purpose */
> > +             .channel = 2,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 660,
> > +             .volt2 = 1500,
> > +     },
> > +     [3] = { /* ch 3, external, temperature with external diode/general
> > +                                                             purpose */
> > +             .channel = 3,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [4] = { /* ch 4, external, temperature measurement/general purpose
> */
> > +             .channel = 4,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [5] = { /* ch 5, external, general purpose */
> > +             .channel = 5,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [6] = { /* ch 6, external, general purpose */
> > +             .channel = 6,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 440,
> > +             .volt2 = 1000,
> > +     },
> > +     [7] = { /* ch7, internal, system supply */
> > +             .channel = 7,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 2200,
> > +             .volt2 = 5000,
> > +     },
> > +     [8] = { /* ch8, internal, backup battery */
> > +             .channel = 8,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 2200,
> > +             .volt2 = 5000,
> > +     },
> > +     [9] = { /* ch 9, internal, external charger input */
> > +             .channel = 9,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 3960,
> > +             .volt2 = 9000,
> > +     },
> > +     [10] = { /* ch10, internal, VBUS */
> > +             .channel = 10,
> > +             .code1 = 150,
> > +             .code2 = 751,
> > +             .volt1 = 1000,
> > +             .volt2 = 5000,
> > +     },
> > +     [11] = { /* ch 11, internal, VBUS DC-DC output current */
> > +             .channel = 11,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 660,
> > +             .volt2 = 1500,
> > +     },
> > +             /* ch 12, internal, Die temperature */
> > +             /* ch 13, internal, Die temperature */
> > +     [12] = { /* ch 14, internal, USB ID line */
> > +             .channel = 14,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 2420,
> > +             .volt2 = 5500,
> > +     },
> > +             /* ch 15, internal, test network */
> > +             /* ch 16, internal, test network */
> > +     [13] = { /* ch 17, internal, battery charging current */
> > +             .channel = 17,
> > +     },
> > +     [14] = { /* ch 18, internal, battery voltage */
> > +             .channel = 18,
> > +             .code1 = 1441,
> > +             .code2 = 3276,
> > +             .volt1 = 2200,
> > +             .volt2 = 5000,
> > +     },
> > +};
> > +
> > +static inline int twl6030_gpadc_write(u8 reg, u8 val)
> > +{
> > +     return twl_i2c_write_u8(TWL6030_MODULE_GPADC, val, reg);
> > +}
> > +
> > +static inline int twl6030_gpadc_read(u8 reg, u8 *val)
> > +{
> > +
> > +     return twl_i2c_read(TWL6030_MODULE_GPADC, val, reg, 2);
> > +}
> > +
> > +static int twl6030_gpadc_enable_irq(u8 mask)
> > +{
> > +     int ret;
> > +
> > +     ret = twl6030_interrupt_unmask(mask, REG_INT_MSK_LINE_B);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = twl6030_interrupt_unmask(mask, REG_INT_MSK_STS_B);
> > +
> > +     return ret;
> > +}
> > +
> > +static void twl6030_gpadc_disable_irq(u8 mask)
> > +{
> > +     twl6030_interrupt_mask(mask, REG_INT_MSK_LINE_B);
> > +     twl6030_interrupt_mask(mask, REG_INT_MSK_STS_B);
> > +}
> > +
> > +static irqreturn_t twl6030_gpadc_irq_handler(int irq, void *indio_dev)
> > +{
> > +     struct twl6030_gpadc_data *gpadc = iio_priv(indio_dev);
> > +
> > +     complete(&gpadc->irq_complete);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int twl6030_start_conversion(int channel)
> > +{
> > +     return twl6030_gpadc_write(TWL6030_GPADC_CTRL_P1,
> > +                                     TWL6030_GPADC_CTRL_P1_SP1);
> > +}
> > +
> > +static int twl6032_start_conversion(int channel)
> > +{
> > +     int ret;
> > +
> > +     ret = twl6030_gpadc_write(TWL6032_GPADC_GPSELECT_ISB, channel);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return twl6030_gpadc_write(TWL6032_GPADC_CTRL_P1,
> > +                                             TWL6030_GPADC_CTRL_P1_SP1);
> > +}
> > +
> > +static u8 twl6030_channel_to_reg(int channel)
> > +{
> > +     return TWL6030_GPADC_GPCH0_LSB + 2 * channel;
> > +}
> > +
> > +static u8 twl6032_channel_to_reg(int channel)
> > +{
> > +     /*
> > +      * for any prior chosen channel, when the conversion is ready
> > +      * the result is avalable in GPCH0_LSB, GPCH0_MSB.
> > +      */
> > +
> > +     return TWL6032_GPADC_GPCH0_LSB;
> > +}
> > +
> > +static int twl6030_gpadc_lookup(const struct twl6030_ideal_code *ideal,
> > +             int channel, int size)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < size; i++)
> > +             if (ideal[i].channel == channel)
> > +                     break;
> > +
> > +     return i;
> > +}
> > +
> > +static int twl6030_channel_calibrated(const struct
> twl6030_gpadc_platform_data
> > +             *pdata, int channel)
> > +{
> > +     const struct twl6030_ideal_code *ideal = pdata->ideal;
> > +     int i;
> > +
> > +     i = twl6030_gpadc_lookup(ideal, channel, pdata->nchannels);
> > +     /* not calibrated channels have 0 in all structure members */
> > +     return pdata->ideal[i].code2;
> > +}
> > +
> > +static int twl6030_gpadc_make_correction(struct twl6030_gpadc_data
> *gpadc,
> > +             int channel, int raw_code)
> > +{
> > +     const struct twl6030_ideal_code *ideal = gpadc->pdata->ideal;
> > +     int corrected_code;
> > +     int i;
> > +
> > +     i = twl6030_gpadc_lookup(ideal, channel, gpadc->pdata->nchannels);
> > +     corrected_code = ((raw_code * 1000) -
> > +             gpadc->twl6030_cal_tbl[i].offset_error) /
> > +             gpadc->twl6030_cal_tbl[i].gain_error;
> > +
> > +     return corrected_code;
> > +}
> > +
> > +static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,
> > +             int channel, int *res)
> > +{
> > +     u8 reg = gpadc->pdata->channel_to_reg(channel);
> > +     __le16 val;
> > +     int raw_code;
> > +     int ret;
> > +
> > +     ret = twl6030_gpadc_read(reg, (u8 *)&val);
> > +     if (ret) {
> > +             dev_dbg(gpadc->dev, "unable to read register 0x%X\n", reg);
> > +             return ret;
> > +     }
> > +
> > +     raw_code = le16_to_cpu(val);
> > +     dev_dbg(gpadc->dev, "GPADC raw code: %d", raw_code);
> > +
> > +     if (twl6030_channel_calibrated(gpadc->pdata, channel))
> > +             *res = twl6030_gpadc_make_correction(gpadc, channel,
> raw_code);
> > +     else
> > +             *res = raw_code;
> > +
> > +     return ret;
> > +}
> > +
> > +static int twl6030_gpadc_get_processed(struct twl6030_gpadc_data *gpadc,
> > +             int channel, int *val)
> > +{
> > +     const struct twl6030_ideal_code *ideal = gpadc->pdata->ideal;
> > +     int corrected_code;
> > +     int channel_value;
> > +     int i;
> > +     int ret;
> > +
> > +     ret = twl6030_gpadc_get_raw(gpadc, channel, &corrected_code);
> > +     if (ret)
> > +             return ret;
> > +
> > +     i = twl6030_gpadc_lookup(ideal, channel, gpadc->pdata->nchannels);
> > +     channel_value = corrected_code *
> > +                     gpadc->twl6030_cal_tbl[i].gain;
> > +
> > +     /* Shift back into mV range */
> > +     channel_value /= 1000;
> > +
> > +     dev_dbg(gpadc->dev, "GPADC corrected code: %d", corrected_code);
> > +     dev_dbg(gpadc->dev, "GPADC value: %d", channel_value);
> > +
> > +     *val = channel_value;
> > +
> > +     return ret;
> > +}
> > +
> > +static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
> > +                          const struct iio_chan_spec *chan,
> > +                          int *val, int *val2, long mask)
> > +{
> > +     struct twl6030_gpadc_data *gpadc = iio_priv(indio_dev);
> > +     int ret;
> > +     long timeout;
> > +
> > +     mutex_lock(&gpadc->lock);
> > +
> > +     ret = gpadc->pdata->start_conversion(chan->channel);
> > +     if (ret) {
> > +             dev_err(gpadc->dev, "failed to start conversion\n");
> > +             goto err;
> > +     }
> > +     /* wait for conversion to complete */
> > +     timeout = wait_for_completion_interruptible_timeout(
> > +                             &gpadc->irq_complete,
> msecs_to_jiffies(5000));
> > +     if (timeout == 0) {
> > +             ret = -ETIMEDOUT;
> > +             goto err;
> > +     } else if (timeout < 0) {
> > +             goto err;
> > +             ret = -EINTR;
> > +     }
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = twl6030_gpadc_get_raw(gpadc, chan->channel, val);
> > +             ret = ret ? -EIO : IIO_VAL_INT;
> > +             break;
> > +
> > +     case IIO_CHAN_INFO_PROCESSED:
> > +             ret = twl6030_gpadc_get_processed(gpadc, chan->channel,
> val);
> > +             ret = ret ? -EIO : IIO_VAL_INT;
> > +             break;
> > +
> > +     default:
> > +             break;
> > +     }
> > +err:
> > +     mutex_unlock(&gpadc->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * The GPADC channels are calibrated using a two point calibration
> method.
> > + * The channels measured with two known values: volt1 and volt2, and
> > + * ideal corresponding output codes are known: code1, code2.
> > + * The difference(d1, d2) between ideal and measured codes stored in
> trim
> > + * registers.
> > + * The goal is to find offset and gain of the real curve for each
> calibrated
> > + * channel.
> > + * gain: k = 1 + ((d2 - d1) / (x2 - x1))
> > + * offset: b = d1 + (k - 1) * x1
> > + */
> > +static void twl6030_calibrate_channel(struct twl6030_gpadc_data *gpadc,
> > +             int channel, int d1, int d2)
> > +{
> > +     int b, k, gain, x1, x2, i;
> > +     const struct twl6030_ideal_code *ideal = gpadc->pdata->ideal;
> > +
> > +     i = twl6030_gpadc_lookup(ideal, channel, gpadc->pdata->nchannels);
> > +
> > +     /* Gain */
> > +     gain = ((ideal[i].volt2 - ideal[i].volt1) * 1000) /
> > +             (ideal[i].code2 - ideal[i].code1);
> > +
> > +     x1 = ideal[i].code1;
> > +     x2 = ideal[i].code2;
> > +
> > +     /* k - real curve gain */
> > +     k = 1000 + (((d2 - d1) * 1000) / (x2 - x1));
> > +
> > +     /* b - offset of the real curve gain */
> > +     b = (d1 * 1000) - (k - 1000) * x1;
> > +
> > +     gpadc->twl6030_cal_tbl[i].gain = gain;
> > +     gpadc->twl6030_cal_tbl[i].gain_error = k;
> > +     gpadc->twl6030_cal_tbl[i].offset_error = b;
> > +
> > +     dev_dbg(gpadc->dev, "GPADC d1   for Chn: %d = %d\n", channel, d1);
> > +     dev_dbg(gpadc->dev, "GPADC d2   for Chn: %d = %d\n", channel, d2);
> > +     dev_dbg(gpadc->dev, "GPADC x1   for Chn: %d = %d\n", channel, x1);
> > +     dev_dbg(gpadc->dev, "GPADC x2   for Chn: %d = %d\n", channel, x2);
> > +     dev_dbg(gpadc->dev, "GPADC Gain for Chn: %d = %d\n", channel,
> gain);
> > +     dev_dbg(gpadc->dev, "GPADC k    for Chn: %d = %d\n", channel, k);
> > +     dev_dbg(gpadc->dev, "GPADC b    for Chn: %d = %d\n", channel, b);
> > +}
> > +
> > +static inline int twl6030_gpadc_get_trim_offset(s8 d)
> > +{
> > +     /*
> > +      * XXX NOTE!
> > +      * bit 0 - sign, bit 7 - reserved, 6..1 - trim value
> > +      * though, the documentation states that trim value
> > +      * is absolute value, the correct conversion results are
> > +      * obtained if the value is interpreted as 2's complement.
> > +      */
> > +     __u32 temp = ((d & 0x7f) >> 1) | ((d & 1) << 6);
> > +
> > +     return sign_extend32(temp, 6);
> > +}
> > +
> > +static int twl6030_calibration(struct twl6030_gpadc_data *gpadc)
> > +{
> > +     int ret;
> > +     int chn;
> > +     u8 trim_regs[TWL6030_GPADC_NUM_TRIM_REGS];
> > +     s8 d1, d2;
> > +
> > +     /*
> > +      * for calibration two measurements have been performed at
> > +      * factory, for some channels, during the production test and
> > +      * have been stored in registers. This two stored values are
> > +      * used to correct the measurements. The values represent
> > +      * offsets for the given input from the output on ideal curve.
> > +      */
> > +     ret = twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,
> > +                     TWL6030_GPADC_TRIM1, TWL6030_GPADC_NUM_TRIM_REGS);
> > +     if (ret < 0) {
> > +             dev_err(gpadc->dev, "calibration failed\n");
> > +             return ret;
> > +     }
> > +
> > +     for (chn = 0; chn < TWL6030_GPADC_MAX_CHANNELS; chn++) {
> > +
> > +             switch (chn) {
> > +             case 0:
> > +                     d1 = trim_regs[0];
> > +                     d2 = trim_regs[1];
> > +                     break;
> > +             case 1:
> > +             case 3:
> > +             case 4:
> > +             case 5:
> > +             case 6:
> > +                     d1 = trim_regs[4];
> > +                     d2 = trim_regs[5];
> > +                     break;
> > +             case 2:
> > +                     d1 = trim_regs[12];
> > +                     d2 = trim_regs[13];
> > +                     break;
> > +             case 7:
> > +                     d1 = trim_regs[6];
> > +                     d2 = trim_regs[7];
> > +                     break;
> > +             case 8:
> > +                     d1 = trim_regs[2];
> > +                     d2 = trim_regs[3];
> > +                     break;
> > +             case 9:
> > +                     d1 = trim_regs[8];
> > +                     d2 = trim_regs[9];
> > +                     break;
> > +             case 10:
> > +                     d1 = trim_regs[10];
> > +                     d2 = trim_regs[11];
> > +                     break;
> > +             case 14:
> > +                     d1 = trim_regs[14];
> > +                     d2 = trim_regs[15];
> > +                     break;
> > +             default:
> > +                     continue;
> > +             }
> > +
> > +             d1 = twl6030_gpadc_get_trim_offset(d1);
> > +             d2 = twl6030_gpadc_get_trim_offset(d2);
> > +
> > +             twl6030_calibrate_channel(gpadc, chn, d1, d2);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int twl6032_get_trim_value(u8 *trim_regs, unsigned int reg0,
> > +             unsigned int reg1, unsigned int mask0, unsigned int mask1,
> > +             unsigned int shift0)
> > +{
> > +     int val;
> > +
> > +     val = (trim_regs[reg0] & mask0) << shift0;
> > +     val |= (trim_regs[reg1] & mask1) >> 1;
> > +     if (trim_regs[reg1] & 0x01)
> > +             val = -val;
> > +
> > +     return val;
> > +}
> > +
> > +static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)
> > +{
> > +     int chn, d1 = 0, d2 = 0, temp;
> > +     u8 trim_regs[TWL6030_GPADC_NUM_TRIM_REGS];
> > +     int ret;
> > +
> > +     ret = twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,
> > +                     TWL6030_GPADC_TRIM1, TWL6030_GPADC_NUM_TRIM_REGS);
> > +     if (ret < 0) {
> > +             dev_err(gpadc->dev, "calibration failed\n");
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Loop to calculate the value needed for returning voltages from
> > +      * GPADC not values.
> > +      *
> > +      * gain is calculated to 3 decimal places fixed point.
> > +      */
> > +     for (chn = 0; chn < TWL6032_GPADC_MAX_CHANNELS; chn++) {
> > +
> > +             switch (chn) {
> > +             case 0:
> > +             case 1:
> > +             case 2:
> > +             case 3:
> > +             case 4:
> > +             case 5:
> > +             case 6:
> > +             case 11:
> > +             case 14:
> > +                     d1 = twl6032_get_trim_value(trim_regs, 2, 0, 0x1f,
> > +                                                             0x06, 2);
> > +                     d2 = twl6032_get_trim_value(trim_regs, 3, 1, 0x3f,
> > +                                                             0x06, 2);
> > +                     break;
> > +             case 8:
> > +                     temp = twl6032_get_trim_value(trim_regs, 2, 0,
> 0x1f,
> > +                                                             0x06, 2);
> > +                     d1 = temp + twl6032_get_trim_value(trim_regs, 7, 6,
> > +                                                             0x18,
> 0x1E, 1);
> > +
> > +                     temp = twl6032_get_trim_value(trim_regs, 3, 1,
> 0x3F,
> > +                                                             0x06, 2);
> > +                     d2 = temp + twl6032_get_trim_value(trim_regs, 9, 7,
> > +                                                             0x1F,
> 0x06, 2);
> > +                     break;
> > +             case 9:
> > +                     temp = twl6032_get_trim_value(trim_regs, 2, 0,
> 0x1f,
> > +                                                             0x06, 2);
> > +                     d1 = temp + twl6032_get_trim_value(trim_regs, 13,
> 11,
> > +                                                             0x18,
> 0x1E, 1);
> > +
> > +                     temp = twl6032_get_trim_value(trim_regs, 3, 1,
> 0x3f,
> > +                                                             0x06, 2);
> > +                     d2 = temp + twl6032_get_trim_value(trim_regs, 15,
> 13,
> > +                                                             0x1F,
> 0x06, 1);
> > +                     break;
> > +             case 10:
> > +                     d1 = twl6032_get_trim_value(trim_regs, 10, 8, 0x0f,
> > +                                                             0x0E, 3);
> > +                     d2 = twl6032_get_trim_value(trim_regs, 14, 12,
> 0x0f,
> > +                                                             0x0E, 3);
> > +                     break;
> > +             case 7:
> > +             case 18:
> > +                     temp = twl6032_get_trim_value(trim_regs, 2, 0,
> 0x1f,
> > +                                                             0x06, 2);
> > +
> > +                     d1 = (trim_regs[4] & 0x7E) >> 1;
> > +                     if (trim_regs[4] & 0x01)
> > +                             d1 = -d1;
> > +                     d1 += temp;
> > +
> > +                     temp = twl6032_get_trim_value(trim_regs, 3, 1,
> 0x3f,
> > +                                                             0x06, 2);
> > +
> > +                     d2 = (trim_regs[5] & 0xFE) >> 1;
> > +                     if (trim_regs[5] & 0x01)
> > +                             d2 = -d2;
> > +
> > +                     d2 += temp;
> > +                     break;
> > +             default:
> > +                     /* No data for other channels */
> > +                     continue;
> > +             }
> > +
> > +             twl6030_calibrate_channel(gpadc, chn, d1, d2);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +#define TWL6030_GPADC_CHAN(chn, _type, chan_info) {  \
> > +     .type = _type,                                  \
> > +     .channel = chn,                                 \
> > +     .info_mask_separate = BIT(chan_info),           \
> > +     .indexed = 1,                                   \
> > +}
> > +
> > +static const struct iio_chan_spec twl6030_gpadc_iio_channels[] = {
> > +     TWL6030_GPADC_CHAN(0, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(1, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(2, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(3, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(4, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(5, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(6, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(7, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(8, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(9, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(10, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(11, IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(14, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +};
> > +
> > +static const struct iio_chan_spec twl6032_gpadc_iio_channels[] = {
> > +     TWL6030_GPADC_CHAN(0, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(1, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(2, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(3, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(4, IIO_TEMP, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(5, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(6, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(7, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(8, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(9, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(10, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(11, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(14, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +     TWL6030_GPADC_CHAN(17, IIO_VOLTAGE, IIO_CHAN_INFO_RAW),
> > +     TWL6030_GPADC_CHAN(18, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
> > +};
> > +
> > +static const struct iio_info twl6030_gpadc_iio_info = {
> > +     .read_raw = &twl6030_gpadc_read_raw,
> > +     .driver_module = THIS_MODULE,
> > +};
> > +
> > +static const struct twl6030_gpadc_platform_data twl6030_pdata = {
> > +     .iio_channels = twl6030_gpadc_iio_channels,
> > +     .nchannels = TWL6030_GPADC_USED_CHANNELS,
> > +     .ideal = twl6030_ideal,
> > +     .start_conversion = twl6030_start_conversion,
> > +     .channel_to_reg = twl6030_channel_to_reg,
> > +     .calibrate = twl6030_calibration,
> > +};
> > +
> > +static const struct twl6030_gpadc_platform_data twl6032_pdata = {
> > +     .iio_channels = twl6032_gpadc_iio_channels,
> > +     .nchannels = TWL6032_GPADC_USED_CHANNELS,
> > +     .ideal = twl6032_ideal,
> > +     .start_conversion = twl6032_start_conversion,
> > +     .channel_to_reg = twl6032_channel_to_reg,
> > +     .calibrate = twl6032_calibration,
> > +};
> > +
> > +static const struct of_device_id of_twl6030_match_tbl[] = {
> > +     {
> > +             .compatible = "ti,twl6030-gpadc",
> > +             .data = &twl6030_pdata,
> > +     },
> > +     {
> > +             .compatible = "ti,twl6032-gpadc",
> > +             .data = &twl6032_pdata,
> > +     },
> > +     { /* end */ }
> > +};
> > +
> > +static int twl6030_gpadc_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct twl6030_gpadc_data *gpadc;
> > +     const struct twl6030_gpadc_platform_data *pdata;
> > +     const struct of_device_id *match;
> > +     struct iio_dev *indio_dev;
> > +     int irq;
> > +     int ret;
> > +
> > +     match = of_match_device(of_match_ptr(of_twl6030_match_tbl), dev);
> > +     if (!match)
> > +             return -EINVAL;
> > +
> > +     pdata = match->data;
> > +
> > +     indio_dev = iio_device_alloc(sizeof(*gpadc));
> > +     if (!indio_dev) {
> > +             dev_err(dev, "failed allocating iio device\n");
> > +             ret = -ENOMEM;
> > +     }
> > +
> > +     gpadc = iio_priv(indio_dev);
> > +
> > +     gpadc->twl6030_cal_tbl = devm_kzalloc(dev,
> > +                                     sizeof(*gpadc->twl6030_cal_tbl) *
> > +                                     pdata->nchannels, GFP_KERNEL);
> > +     if (!gpadc->twl6030_cal_tbl)
> > +             goto err_free_device;
> > +
> > +     gpadc->dev = dev;
> > +     gpadc->pdata = pdata;
> > +
> > +     platform_set_drvdata(pdev, indio_dev);
> > +     mutex_init(&gpadc->lock);
> > +     init_completion(&gpadc->irq_complete);
> > +
> > +     ret = pdata->calibrate(gpadc);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "failed to read calibration
> registers\n");
> > +             goto err_free_device;
> > +     }
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "failed to get irq\n");
> > +             goto err_free_device;
> > +     }
> > +
> > +     ret = request_threaded_irq(irq, NULL, twl6030_gpadc_irq_handler,
> > +                             IRQF_ONESHOT, "twl6030_gpadc", indio_dev);
> > +     if (ret) {
> > +             dev_dbg(&pdev->dev, "could not request irq\n");
> > +             goto err_free_device;
> > +     }
> > +
> > +     ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
> > +             goto err_free_irq;
> > +     }
> > +
> > +     ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
> > +                                     TWL6030_REG_TOGGLE1);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "failed to enable GPADC module\n");
> > +             goto err_free_irq;
> > +     }
> > +
> > +     indio_dev->name = DRIVER_NAME;
> > +     indio_dev->dev.parent = dev;
> > +     indio_dev->info = &twl6030_gpadc_iio_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = pdata->iio_channels;
> > +     indio_dev->num_channels = pdata->nchannels;
> > +
> > +     ret = iio_device_register(indio_dev);
> > +     if (ret)
> > +             goto err_free_irq;
> > +
> > +     return ret;
> > +
> > +err_free_irq:
> > +     free_irq(irq, indio_dev);
> > +err_free_device:
> > +     iio_device_free(indio_dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int twl6030_gpadc_remove(struct platform_device *pdev)
> > +{
> > +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +     twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
> > +     free_irq(platform_get_irq(pdev, 0), indio_dev);
> > +     iio_device_unregister(indio_dev);
> > +     iio_device_free(indio_dev);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int twl6030_gpadc_suspend(struct device *pdev)
> > +{
> > +     int ret;
> > +
> > +     ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCR,
> > +                             TWL6030_REG_TOGGLE1);
> > +     if (ret)
> > +             dev_err(pdev, "error reseting GPADC (%d)!\n", ret);
> > +
> > +     return 0;
> > +};
> > +
> > +static int twl6030_gpadc_resume(struct device *pdev)
> > +{
> > +     int ret;
> > +
> > +     ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
> > +                             TWL6030_REG_TOGGLE1);
> > +     if (ret)
> > +             dev_err(pdev, "error setting GPADC (%d)!\n", ret);
> > +
> > +     return 0;
> > +};
> > +#endif
> > +
> > +static SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
> > +                                     twl6030_gpadc_resume);
> > +
> > +static struct platform_driver twl6030_gpadc_driver = {
> > +     .probe          = twl6030_gpadc_probe,
> > +     .remove         = twl6030_gpadc_remove,
> > +     .driver         = {
> > +             .name   = DRIVER_NAME,
> > +             .owner  = THIS_MODULE,
> > +             .pm     = &twl6030_gpadc_pm_ops,
> > +             .of_match_table = of_twl6030_match_tbl,
> > +     },
> > +};
> > +
> > +module_platform_driver(twl6030_gpadc_driver);
> > +
> > +MODULE_ALIAS("platform: " DRIVER_NAME);
> > +MODULE_AUTHOR("Balaji T K <balajitk@ti.com>, Graeme Gregory <
> gg@slimlogic.co.uk>, Oleksandr Kozaruk <oleksandr.kozaruk@ti.com");
> > +MODULE_DESCRIPTION("twl6030 ADC driver");
> > +MODULE_LICENSE("GPL");
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Regards,
Oleksandr Kozaruk | embedded developer
GlobalLogic
M +38.067.944.7905
www.globallogic.com
<http://www.globallogic.com/>
http://www.globallogic.com/email_disclaimer.txt

--047d7b677c7e8a42ab04e3f5fc77
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Jonathan,<div><br></div><div>Thank you for the revie=
w and valuable comments.<br><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
Multiple authors are done by having multiple MODULE_AUTHOR lines rather as<=
br>
one long string. =A0See include/linux/module.h. I fixed that up and<br>
dealt with some trivial fuzz in the makefile/Kconfig.<br>
<br>
<br>
You might want to take advantage of devm_iio_allocate_device<br>
which has been introduced in the meantime and greatly simplifies error<br>
paths in IIO probe functions.<br></blockquote><div><br></div><div>Should I =
make new version of the patch, or just prepare a new patch that patches the=
 patch?</div><div><br></div><div>Regards,</div><div>Sasha.</div><div>=A0</d=
iv>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<br>
Anyhow, applied to the togreg branch of iio.git<br>
<br>
Note I haven&#39;t taken the device tree patch. For that I would need and a=
ck<br>
from the relevant maintainer(s). Personally I&#39;d rather not touch device=
 tree<br>
files unless i have to due to the high chance of merge conflicts occuring.<=
br>
I would expect the subarch maintainer to pick that one up (or to ask me<br>
to ;)<br>
<br>
Nice relatively clean driver for a somewhat &#39;interesting&#39; bit of ha=
rdware.<br>
<br>
Thanks<br>
<br>
Jonathan<br>
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0drivers/iio/adc/Kconfig =A0 =A0 =A0 =A0 | =A0 14 +<br>
&gt; =A0drivers/iio/adc/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0drivers/iio/adc/twl6030-gpadc.c | 1027 ++++++++++++++++++++++++++++=
+++++++++++<br>
&gt; =A03 files changed, 1042 insertions(+)<br>
&gt; =A0create mode 100644 drivers/iio/adc/twl6030-gpadc.c<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig<br>
&gt; index 93129ec..f8f9f18 100644<br>
&gt; --- a/drivers/iio/adc/Kconfig<br>
&gt; +++ b/drivers/iio/adc/Kconfig<br>
&gt; @@ -160,6 +160,20 @@ config TI_AM335X_ADC<br>
&gt; =A0 =A0 =A0 =A0 Say yes here to build support for Texas Instruments AD=
C<br>
&gt; =A0 =A0 =A0 =A0 driver which is also a MFD client.<br>
&gt;<br>
&gt; +config TWL6030_GPADC<br>
&gt; + =A0 =A0 tristate &quot;TWL6030 GPADC (General Purpose A/D Converter)=
 Support&quot;<br>
&gt; + =A0 =A0 depends on TWL4030_CORE<br>
&gt; + =A0 =A0 default n<br>
&gt; + =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 Say yes here if you want support for the TWL6030/TWL6032=
 General<br>
&gt; + =A0 =A0 =A0 Purpose A/D Converter. This will add support for battery=
 type<br>
&gt; + =A0 =A0 =A0 detection, battery voltage and temperature measurement, =
die<br>
&gt; + =A0 =A0 =A0 temperature measurement, system supply voltage, audio ac=
cessory,<br>
&gt; + =A0 =A0 =A0 USB ID detection.<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 This driver can also be built as a module. If so, the mo=
dule will be<br>
&gt; + =A0 =A0 =A0 called twl6030-gpadc.<br>
&gt; +<br>
&gt; =A0config VIPERBOARD_ADC<br>
&gt; =A0 =A0 =A0 tristate &quot;Viperboard ADC support&quot;<br>
&gt; =A0 =A0 =A0 depends on MFD_VIPERBOARD &amp;&amp; USB<br>
&gt; diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile<br>
&gt; index 8f475d3..db430bd 100644<br>
&gt; --- a/drivers/iio/adc/Makefile<br>
&gt; +++ b/drivers/iio/adc/Makefile<br>
&gt; @@ -17,4 +17,5 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o<br>
&gt; =A0obj-$(CONFIG_MCP320X) +=3D mcp320x.o<br>
&gt; =A0obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o<br>
&gt; =A0obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o<br>
&gt; +obj-$(CONFIG_TWL6030_GPADC) +=3D twl6030-gpadc.o<br>
&gt; =A0obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o<br>
&gt; diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030=
-gpadc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..2b63083<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/adc/twl6030-gpadc.c<br>
&gt; @@ -0,0 +1,1027 @@<br>
&gt; +/*<br>
&gt; + * TWL6030 GPADC module driver<br>
&gt; + *<br>
&gt; + * Copyright (C) 2009-2013 Texas Instruments Inc.<br>
&gt; + * Nishant Kamat &lt;<a href=3D"mailto:nskamat@ti.com">nskamat@ti.com=
</a>&gt;<br>
&gt; + * Balaji T K &lt;<a href=3D"mailto:balajitk@ti.com">balajitk@ti.com<=
/a>&gt;<br>
&gt; + * Graeme Gregory &lt;<a href=3D"mailto:gg@slimlogic.co.uk">gg@slimlo=
gic.co.uk</a>&gt;<br>
&gt; + * Girish S Ghongdemath &lt;<a href=3D"mailto:girishsg@ti.com">girish=
sg@ti.com</a>&gt;<br>
&gt; + * Ambresh K &lt;<a href=3D"mailto:ambresh@ti.com">ambresh@ti.com</a>=
&gt;<br>
&gt; + * Oleksandr Kozaruk &lt;<a href=3D"mailto:oleksandr.kozaruk@ti.com">=
oleksandr.kozaruk@ti.com</a><br>
&gt; + *<br>
&gt; + * Based on twl4030-madc.c<br>
&gt; + * Copyright (C) 2008 Nokia Corporation<br>
&gt; + * Mikko Ylinen &lt;<a href=3D"mailto:mikko.k.ylinen@nokia.com">mikko=
.k.ylinen@nokia.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU General Public License<br>
&gt; + * version 2 as published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful, bu=
t<br>
&gt; + * WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GN=
U<br>
&gt; + * General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program; if not, write to the Free Software<br>
&gt; + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA<br>
&gt; + * 02110-1301 USA<br>
&gt; + *<br>
&gt; + */<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt; +#include &lt;linux/i2c/twl.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/iio/sysfs.h&gt;<br>
&gt; +<br>
&gt; +#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0&quot;twl6030_gpadc&quot;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * twl6030 per TRM has 17 channels, and twl6032 has 19 channels<br>
&gt; + * 2 test network channels are not used,<br>
&gt; + * 2 die temperature channels are not used either, as it is not<br>
&gt; + * defined how to convert ADC value to temperature<br>
&gt; + */<br>
&gt; +#define TWL6030_GPADC_USED_CHANNELS =A0 =A0 =A0 =A0 =A013<br>
&gt; +#define TWL6030_GPADC_MAX_CHANNELS =A0 =A0 =A0 =A0 =A0 15<br>
&gt; +#define TWL6032_GPADC_USED_CHANNELS =A0 =A0 =A0 =A0 =A015<br>
&gt; +#define TWL6032_GPADC_MAX_CHANNELS =A0 =A0 =A0 =A0 =A0 19<br>
&gt; +#define TWL6030_GPADC_NUM_TRIM_REGS =A0 =A0 =A0 =A0 =A016<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_CTRL_P1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x05<br>
&gt; +<br>
&gt; +#define TWL6032_GPADC_GPSELECT_ISB =A0 =A0 =A0 =A0 =A0 0x07<br>
&gt; +#define TWL6032_GPADC_CTRL_P1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x08<br>
&gt; +<br>
&gt; +#define TWL6032_GPADC_GPCH0_LSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x0d<br>
&gt; +#define TWL6032_GPADC_GPCH0_MSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x0e<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_CTRL_P1_SP1 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_GPCH0_LSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0x29)<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_RT_SW1_EOC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
BIT(5)<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_TRIM1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xCD<b=
r>
&gt; +<br>
&gt; +#define TWL6030_REG_TOGGLE1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x90<b=
r>
&gt; +#define TWL6030_GPADCS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 BIT(1)<br>
&gt; +#define TWL6030_GPADCR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 BIT(0)<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * struct twl6030_chnl_calib - channel calibration<br>
&gt; + * @gain: =A0 =A0 =A0 =A0 =A0 =A0slope coefficient for ideal curve<br=
>
&gt; + * @gain_error: =A0 =A0 =A0 =A0 =A0 =A0 =A0gain error<br>
&gt; + * @offset_error: =A0 =A0offset of the real curve<br>
&gt; + */<br>
&gt; +struct twl6030_chnl_calib {<br>
&gt; + =A0 =A0 s32 gain;<br>
&gt; + =A0 =A0 s32 gain_error;<br>
&gt; + =A0 =A0 s32 offset_error;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * struct twl6030_ideal_code - GPADC calibration parameters<br>
&gt; + * GPADC is calibrated in two points: close to the beginning and<br>
&gt; + * to the and of the measurable input range<br>
&gt; + *<br>
&gt; + * @channel: channel number<br>
&gt; + * @code1: =A0 ideal code for the input at the beginning<br>
&gt; + * @code2: =A0 ideal code for at the end of the range<br>
&gt; + * @volt1: =A0 voltage input at the beginning(low voltage)<br>
&gt; + * @volt2: =A0 voltage input at the end(high voltage)<br>
&gt; + */<br>
&gt; +struct twl6030_ideal_code {<br>
&gt; + =A0 =A0 int channel;<br>
&gt; + =A0 =A0 u16 code1;<br>
&gt; + =A0 =A0 u16 code2;<br>
&gt; + =A0 =A0 u16 volt1;<br>
&gt; + =A0 =A0 u16 volt2;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct twl6030_gpadc_data;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * struct twl6030_gpadc_platform_data - platform specific data<br>
&gt; + * @nchannels: =A0 =A0 =A0 =A0 =A0 =A0 =A0 number of GPADC channels<b=
r>
&gt; + * @iio_channels: =A0 =A0iio channels<br>
&gt; + * @twl6030_ideal: =A0 pointer to calibration parameters<br>
&gt; + * @start_conversion: =A0 =A0 =A0 =A0pointer to ADC start conversion =
function<br>
&gt; + * @channel_to_reg =A0 pointer to ADC function to convert channel to<=
br>
&gt; + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 register address for reading c=
onversion result<br>
&gt; + * @calibrate: =A0 =A0 =A0 =A0 =A0 =A0 =A0 pointer to calibration fun=
ction<br>
&gt; + */<br>
&gt; +struct twl6030_gpadc_platform_data {<br>
&gt; + =A0 =A0 const int nchannels;<br>
&gt; + =A0 =A0 const struct iio_chan_spec *iio_channels;<br>
&gt; + =A0 =A0 const struct twl6030_ideal_code *ideal;<br>
&gt; + =A0 =A0 int (*start_conversion)(int channel);<br>
&gt; + =A0 =A0 u8 (*channel_to_reg)(int channel);<br>
&gt; + =A0 =A0 int (*calibrate)(struct twl6030_gpadc_data *gpadc);<br>
&gt; +};<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * struct twl6030_gpadc_data - GPADC data<br>
&gt; + * @dev: =A0 =A0 =A0 =A0 =A0 =A0 device pointer<br>
&gt; + * @lock: =A0 =A0 =A0 =A0 =A0 =A0mutual exclusion lock for the struct=
ure<br>
&gt; + * @irq_complete: =A0 =A0completion to signal end of conversion<br>
&gt; + * @twl6030_cal_tbl: pointer to calibration data for each<br>
&gt; + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel with gain error and of=
fset<br>
&gt; + * @pdata: =A0 =A0 =A0 =A0 =A0 pointer to device specific data<br>
&gt; + */<br>
&gt; +struct twl6030_gpadc_data {<br>
&gt; + =A0 =A0 struct device =A0 *dev;<br>
&gt; + =A0 =A0 struct mutex =A0 =A0lock;<br>
&gt; + =A0 =A0 struct completion =A0 =A0 =A0 irq_complete;<br>
&gt; + =A0 =A0 struct twl6030_chnl_calib =A0 =A0 =A0 *twl6030_cal_tbl;<br>
&gt; + =A0 =A0 const struct twl6030_gpadc_platform_data *pdata;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * channels 11, 12, 13, 15 and 16 have no calibration data<br>
&gt; + * calibration offset is same for channels 1, 3, 4, 5<br>
&gt; + *<br>
&gt; + * The data is taken from GPADC_TRIM registers description.<br>
&gt; + * GPADC_TRIM registers keep difference between the code measured<br>
&gt; + * at volt1 and volt2 input voltages and corresponding code1 and code=
2<br>
&gt; + */<br>
&gt; +static const struct twl6030_ideal_code<br>
&gt; + =A0 =A0 twl6030_ideal[TWL6030_GPADC_USED_CHANNELS] =3D {<br>
&gt; + =A0 =A0 [0] =3D { /* ch 0, external, battery type, resistor value */=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 0,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 116,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 745,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 141,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 910,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [1] =3D { /* ch 1, external, battery temperature, NTC resist=
or value */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 900,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 100,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1100,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [2] =3D { /* ch 2, external, audio accessory/general purpose=
 */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 2,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 55,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 818,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 101,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1499,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [3] =3D { /* ch 3, external, general purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 3,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 900,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 100,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1100,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [4] =3D { /* ch 4, external, temperature measurement/general=
 purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 4,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 900,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 100,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1100,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [5] =3D { /* ch 5, external, general purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 5,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 900,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 100,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1100,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [6] =3D { /* ch 6, external, general purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 6,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 900,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 100,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1100,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [7] =3D { /* ch 7, internal, main battery */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 7,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 614,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 941,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 3001,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 4599,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [8] =3D { /* ch 8, internal, backup battery */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 8,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 82,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 688,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 501,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 4203,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [9] =3D { /* ch 9, internal, external charger input */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 9,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 182,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 818,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 2001,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 8996,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [10] =3D { /* ch 10, internal, VBUS */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 10,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 149,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 818,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 1001,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5497,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [11] =3D { /* ch 11, internal, VBUS charging current */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 11,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 12, internal, Die temperature */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 13, internal, Die temperature */<br>
&gt; + =A0 =A0 [12] =3D { /* ch 14, internal, USB ID line */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 14,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 48,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 714,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 323,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 4800,<br>
&gt; + =A0 =A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct twl6030_ideal_code<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl6032_ideal[TWL6032_GPADC_=
USED_CHANNELS] =3D {<br>
&gt; + =A0 =A0 [0] =3D { /* ch 0, external, battery type, resistor value */=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 0,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [1] =3D { /* ch 1, external, battery temperature, NTC resist=
or value */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [2] =3D { /* ch 2, external, audio accessory/general purpose=
 */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 2,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 660,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1500,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [3] =3D { /* ch 3, external, temperature with external diode=
/general<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 3,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [4] =3D { /* ch 4, external, temperature measurement/general=
 purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 4,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [5] =3D { /* ch 5, external, general purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 5,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [6] =3D { /* ch 6, external, general purpose */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 6,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 440,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [7] =3D { /* ch7, internal, system supply */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 7,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 2200,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [8] =3D { /* ch8, internal, backup battery */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 8,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 2200,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [9] =3D { /* ch 9, internal, external charger input */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 9,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 3960,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 9000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [10] =3D { /* ch10, internal, VBUS */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 10,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 150,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 751,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 1000,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5000,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [11] =3D { /* ch 11, internal, VBUS DC-DC output current */<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 11,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 660,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 1500,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 12, internal, Die temperature */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 13, internal, Die temperature */<br>
&gt; + =A0 =A0 [12] =3D { /* ch 14, internal, USB ID line */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 14,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 2420,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5500,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 15, internal, test network */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 /* ch 16, internal, test network */<br>
&gt; + =A0 =A0 [13] =3D { /* ch 17, internal, battery charging current */<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 17,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 [14] =3D { /* ch 18, internal, battery voltage */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .channel =3D 18,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code1 =3D 1441,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .code2 =3D 3276,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt1 =3D 2200,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .volt2 =3D 5000,<br>
&gt; + =A0 =A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static inline int twl6030_gpadc_write(u8 reg, u8 val)<br>
&gt; +{<br>
&gt; + =A0 =A0 return twl_i2c_write_u8(TWL6030_MODULE_GPADC, val, reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int twl6030_gpadc_read(u8 reg, u8 *val)<br>
&gt; +{<br>
&gt; +<br>
&gt; + =A0 =A0 return twl_i2c_read(TWL6030_MODULE_GPADC, val, reg, 2);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_enable_irq(u8 mask)<br>
&gt; +{<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_interrupt_unmask(mask, REG_INT_MSK_LINE_B);<=
br>
&gt; + =A0 =A0 if (ret &lt; 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_interrupt_unmask(mask, REG_INT_MSK_STS_B);<b=
r>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void twl6030_gpadc_disable_irq(u8 mask)<br>
&gt; +{<br>
&gt; + =A0 =A0 twl6030_interrupt_mask(mask, REG_INT_MSK_LINE_B);<br>
&gt; + =A0 =A0 twl6030_interrupt_mask(mask, REG_INT_MSK_STS_B);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static irqreturn_t twl6030_gpadc_irq_handler(int irq, void *indio_dev=
)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct twl6030_gpadc_data *gpadc =3D iio_priv(indio_dev);<br=
>
&gt; +<br>
&gt; + =A0 =A0 complete(&amp;gpadc-&gt;irq_complete);<br>
&gt; +<br>
&gt; + =A0 =A0 return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_start_conversion(int channel)<br>
&gt; +{<br>
&gt; + =A0 =A0 return twl6030_gpadc_write(TWL6030_GPADC_CTRL_P1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 TWL6030_GPADC_CTRL_P1_SP1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6032_start_conversion(int channel)<br>
&gt; +{<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_gpadc_write(TWL6032_GPADC_GPSELECT_ISB, chan=
nel);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; +<br>
&gt; + =A0 =A0 return twl6030_gpadc_write(TWL6032_GPADC_CTRL_P1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 TWL6030_GPADC_CTRL_P1_SP1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static u8 twl6030_channel_to_reg(int channel)<br>
&gt; +{<br>
&gt; + =A0 =A0 return TWL6030_GPADC_GPCH0_LSB + 2 * channel;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static u8 twl6032_channel_to_reg(int channel)<br>
&gt; +{<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* for any prior chosen channel, when the conversion is re=
ady<br>
&gt; + =A0 =A0 =A0* the result is avalable in GPCH0_LSB, GPCH0_MSB.<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; +<br>
&gt; + =A0 =A0 return TWL6032_GPADC_GPCH0_LSB;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_lookup(const struct twl6030_ideal_code *idea=
l,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int channel, int size)<br>
&gt; +{<br>
&gt; + =A0 =A0 int i;<br>
&gt; +<br>
&gt; + =A0 =A0 for (i =3D 0; i &lt; size; i++)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (ideal[i].channel =3D=3D channel)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; +<br>
&gt; + =A0 =A0 return i;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_channel_calibrated(const struct twl6030_gpadc_plat=
form_data<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 *pdata, int channel)<br>
&gt; +{<br>
&gt; + =A0 =A0 const struct twl6030_ideal_code *ideal =3D pdata-&gt;ideal;<=
br>
&gt; + =A0 =A0 int i;<br>
&gt; +<br>
&gt; + =A0 =A0 i =3D twl6030_gpadc_lookup(ideal, channel, pdata-&gt;nchanne=
ls);<br>
&gt; + =A0 =A0 /* not calibrated channels have 0 in all structure members *=
/<br>
&gt; + =A0 =A0 return pdata-&gt;ideal[i].code2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_make_correction(struct twl6030_gpadc_data *g=
padc,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int channel, int raw_code)<br>
&gt; +{<br>
&gt; + =A0 =A0 const struct twl6030_ideal_code *ideal =3D gpadc-&gt;pdata-&=
gt;ideal;<br>
&gt; + =A0 =A0 int corrected_code;<br>
&gt; + =A0 =A0 int i;<br>
&gt; +<br>
&gt; + =A0 =A0 i =3D twl6030_gpadc_lookup(ideal, channel, gpadc-&gt;pdata-&=
gt;nchannels);<br>
&gt; + =A0 =A0 corrected_code =3D ((raw_code * 1000) -<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i].offset_error) /=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i].gain_error;<br>
&gt; +<br>
&gt; + =A0 =A0 return corrected_code;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_get_raw(struct twl6030_gpadc_data *gpadc,<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int channel, int *res)<br>
&gt; +{<br>
&gt; + =A0 =A0 u8 reg =3D gpadc-&gt;pdata-&gt;channel_to_reg(channel);<br>
&gt; + =A0 =A0 __le16 val;<br>
&gt; + =A0 =A0 int raw_code;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_gpadc_read(reg, (u8 *)&amp;val);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;unable to read =
register 0x%X\n&quot;, reg);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 raw_code =3D le16_to_cpu(val);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC raw code: %d&quot;, raw_c=
ode);<br>
&gt; +<br>
&gt; + =A0 =A0 if (twl6030_channel_calibrated(gpadc-&gt;pdata, channel))<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 *res =3D twl6030_gpadc_make_correction(gpadc=
, channel, raw_code);<br>
&gt; + =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 *res =3D raw_code;<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_get_processed(struct twl6030_gpadc_data *gpa=
dc,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int channel, int *val)<br>
&gt; +{<br>
&gt; + =A0 =A0 const struct twl6030_ideal_code *ideal =3D gpadc-&gt;pdata-&=
gt;ideal;<br>
&gt; + =A0 =A0 int corrected_code;<br>
&gt; + =A0 =A0 int channel_value;<br>
&gt; + =A0 =A0 int i;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_gpadc_get_raw(gpadc, channel, &amp;corrected=
_code);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; +<br>
&gt; + =A0 =A0 i =3D twl6030_gpadc_lookup(ideal, channel, gpadc-&gt;pdata-&=
gt;nchannels);<br>
&gt; + =A0 =A0 channel_value =3D corrected_code *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i]=
.gain;<br>
&gt; +<br>
&gt; + =A0 =A0 /* Shift back into mV range */<br>
&gt; + =A0 =A0 channel_value /=3D 1000;<br>
&gt; +<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC corrected code: %d&quot;,=
 corrected_code);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC value: %d&quot;, channel_=
value);<br>
&gt; +<br>
&gt; + =A0 =A0 *val =3D channel_value;<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct iio_=
chan_spec *chan,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *val, int *va=
l2, long mask)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct twl6030_gpadc_data *gpadc =3D iio_priv(indio_dev);<br=
>
&gt; + =A0 =A0 int ret;<br>
&gt; + =A0 =A0 long timeout;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;gpadc-&gt;lock);<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D gpadc-&gt;pdata-&gt;start_conversion(chan-&gt;channe=
l);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(gpadc-&gt;dev, &quot;failed to start=
 conversion\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
&gt; + =A0 =A0 }<br>
&gt; + =A0 =A0 /* wait for conversion to complete */<br>
&gt; + =A0 =A0 timeout =3D wait_for_completion_interruptible_timeout(<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;gpadc-&=
gt;irq_complete, msecs_to_jiffies(5000));<br>
&gt; + =A0 =A0 if (timeout =3D=3D 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ETIMEDOUT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
&gt; + =A0 =A0 } else if (timeout &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINTR;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 switch (mask) {<br>
&gt; + =A0 =A0 case IIO_CHAN_INFO_RAW:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_gpadc_get_raw(gpadc, chan-&g=
t;channel, val);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ret ? -EIO : IIO_VAL_INT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; +<br>
&gt; + =A0 =A0 case IIO_CHAN_INFO_PROCESSED:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_gpadc_get_processed(gpadc, c=
han-&gt;channel, val);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ret ? -EIO : IIO_VAL_INT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; +<br>
&gt; + =A0 =A0 default:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 }<br>
&gt; +err:<br>
&gt; + =A0 =A0 mutex_unlock(&amp;gpadc-&gt;lock);<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The GPADC channels are calibrated using a two point calibration me=
thod.<br>
&gt; + * The channels measured with two known values: volt1 and volt2, and<=
br>
&gt; + * ideal corresponding output codes are known: code1, code2.<br>
&gt; + * The difference(d1, d2) between ideal and measured codes stored in =
trim<br>
&gt; + * registers.<br>
&gt; + * The goal is to find offset and gain of the real curve for each cal=
ibrated<br>
&gt; + * channel.<br>
&gt; + * gain: k =3D 1 + ((d2 - d1) / (x2 - x1))<br>
&gt; + * offset: b =3D d1 + (k - 1) * x1<br>
&gt; + */<br>
&gt; +static void twl6030_calibrate_channel(struct twl6030_gpadc_data *gpad=
c,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int channel, int d1, int d2)<br>
&gt; +{<br>
&gt; + =A0 =A0 int b, k, gain, x1, x2, i;<br>
&gt; + =A0 =A0 const struct twl6030_ideal_code *ideal =3D gpadc-&gt;pdata-&=
gt;ideal;<br>
&gt; +<br>
&gt; + =A0 =A0 i =3D twl6030_gpadc_lookup(ideal, channel, gpadc-&gt;pdata-&=
gt;nchannels);<br>
&gt; +<br>
&gt; + =A0 =A0 /* Gain */<br>
&gt; + =A0 =A0 gain =3D ((ideal[i].volt2 - ideal[i].volt1) * 1000) /<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 (ideal[i].code2 - ideal[i].code1);<br>
&gt; +<br>
&gt; + =A0 =A0 x1 =3D ideal[i].code1;<br>
&gt; + =A0 =A0 x2 =3D ideal[i].code2;<br>
&gt; +<br>
&gt; + =A0 =A0 /* k - real curve gain */<br>
&gt; + =A0 =A0 k =3D 1000 + (((d2 - d1) * 1000) / (x2 - x1));<br>
&gt; +<br>
&gt; + =A0 =A0 /* b - offset of the real curve gain */<br>
&gt; + =A0 =A0 b =3D (d1 * 1000) - (k - 1000) * x1;<br>
&gt; +<br>
&gt; + =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i].gain =3D gain;<br>
&gt; + =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i].gain_error =3D k;<br>
&gt; + =A0 =A0 gpadc-&gt;twl6030_cal_tbl[i].offset_error =3D b;<br>
&gt; +<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC d1 =A0 for Chn: %d =3D %d=
\n&quot;, channel, d1);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC d2 =A0 for Chn: %d =3D %d=
\n&quot;, channel, d2);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC x1 =A0 for Chn: %d =3D %d=
\n&quot;, channel, x1);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC x2 =A0 for Chn: %d =3D %d=
\n&quot;, channel, x2);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC Gain for Chn: %d =3D %d\n=
&quot;, channel, gain);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC k =A0 =A0for Chn: %d =3D =
%d\n&quot;, channel, k);<br>
&gt; + =A0 =A0 dev_dbg(gpadc-&gt;dev, &quot;GPADC b =A0 =A0for Chn: %d =3D =
%d\n&quot;, channel, b);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int twl6030_gpadc_get_trim_offset(s8 d)<br>
&gt; +{<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* XXX NOTE!<br>
&gt; + =A0 =A0 =A0* bit 0 - sign, bit 7 - reserved, 6..1 - trim value<br>
&gt; + =A0 =A0 =A0* though, the documentation states that trim value<br>
&gt; + =A0 =A0 =A0* is absolute value, the correct conversion results are<b=
r>
&gt; + =A0 =A0 =A0* obtained if the value is interpreted as 2&#39;s complem=
ent.<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 __u32 temp =3D ((d &amp; 0x7f) &gt;&gt; 1) | ((d &amp; 1) &l=
t;&lt; 6);<br>
&gt; +<br>
&gt; + =A0 =A0 return sign_extend32(temp, 6);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_calibration(struct twl6030_gpadc_data *gpadc)<br>
&gt; +{<br>
&gt; + =A0 =A0 int ret;<br>
&gt; + =A0 =A0 int chn;<br>
&gt; + =A0 =A0 u8 trim_regs[TWL6030_GPADC_NUM_TRIM_REGS];<br>
&gt; + =A0 =A0 s8 d1, d2;<br>
&gt; +<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* for calibration two measurements have been performed at=
<br>
&gt; + =A0 =A0 =A0* factory, for some channels, during the production test =
and<br>
&gt; + =A0 =A0 =A0* have been stored in registers. This two stored values a=
re<br>
&gt; + =A0 =A0 =A0* used to correct the measurements. The values represent<=
br>
&gt; + =A0 =A0 =A0* offsets for the given input from the output on ideal cu=
rve.<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_GPADC_TRIM1, TWL6030=
_GPADC_NUM_TRIM_REGS);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(gpadc-&gt;dev, &quot;calibration fai=
led\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 for (chn =3D 0; chn &lt; TWL6030_GPADC_MAX_CHANNELS; chn++) =
{<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 switch (chn) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 0:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[0];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[1];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 1:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 3:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 4:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 5:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 6:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[4];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[5];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 2:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[12];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[13];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 7:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[6];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[7];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 8:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[2];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[3];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 9:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[8];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[9];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 10:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[10];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[11];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 14:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D trim_regs[14];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D trim_regs[15];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 default:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D twl6030_gpadc_get_trim_offset(d1);<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D twl6030_gpadc_get_trim_offset(d2);<br=
>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_calibrate_channel(gpadc, chn, d1, d2=
);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6032_get_trim_value(u8 *trim_regs, unsigned int reg0,<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int reg1, unsigned int mask0, unsig=
ned int mask1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int shift0)<br>
&gt; +{<br>
&gt; + =A0 =A0 int val;<br>
&gt; +<br>
&gt; + =A0 =A0 val =3D (trim_regs[reg0] &amp; mask0) &lt;&lt; shift0;<br>
&gt; + =A0 =A0 val |=3D (trim_regs[reg1] &amp; mask1) &gt;&gt; 1;<br>
&gt; + =A0 =A0 if (trim_regs[reg1] &amp; 0x01)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 val =3D -val;<br>
&gt; +<br>
&gt; + =A0 =A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)<br>
&gt; +{<br>
&gt; + =A0 =A0 int chn, d1 =3D 0, d2 =3D 0, temp;<br>
&gt; + =A0 =A0 u8 trim_regs[TWL6030_GPADC_NUM_TRIM_REGS];<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl_i2c_read(TWL6030_MODULE_ID2, trim_regs,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_GPADC_TRIM1, TWL6030=
_GPADC_NUM_TRIM_REGS);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(gpadc-&gt;dev, &quot;calibration fai=
led\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0* Loop to calculate the value needed for returning voltag=
es from<br>
&gt; + =A0 =A0 =A0* GPADC not values.<br>
&gt; + =A0 =A0 =A0*<br>
&gt; + =A0 =A0 =A0* gain is calculated to 3 decimal places fixed point.<br>
&gt; + =A0 =A0 =A0*/<br>
&gt; + =A0 =A0 for (chn =3D 0; chn &lt; TWL6032_GPADC_MAX_CHANNELS; chn++) =
{<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 switch (chn) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 0:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 1:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 2:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 3:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 4:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 5:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 6:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 11:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 14:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D twl6032_get_trim_valu=
e(trim_regs, 2, 0, 0x1f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D twl6032_get_trim_valu=
e(trim_regs, 3, 1, 0x3f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 8:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 2, 0, 0x1f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D temp + twl6032_get_tr=
im_value(trim_regs, 7, 6,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x18, 0x1E, 1);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 3, 1, 0x3F,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D temp + twl6032_get_tr=
im_value(trim_regs, 9, 7,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1F, 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 9:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 2, 0, 0x1f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D temp + twl6032_get_tr=
im_value(trim_regs, 13, 11,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x18, 0x1E, 1);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 3, 1, 0x3f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D temp + twl6032_get_tr=
im_value(trim_regs, 15, 13,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1F, 0x06, 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 10:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D twl6032_get_trim_valu=
e(trim_regs, 10, 8, 0x0f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0E, 3);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D twl6032_get_trim_valu=
e(trim_regs, 14, 12, 0x0f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0E, 3);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 7:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 case 18:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 2, 0, 0x1f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D (trim_regs[4] &amp; 0=
x7E) &gt;&gt; 1;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trim_regs[4] &amp; 0x01)=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 =3D -d1;<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d1 +=3D temp;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D twl6032_get_trim_va=
lue(trim_regs, 3, 1, 0x3f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06, 2);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D (trim_regs[5] &amp; 0=
xFE) &gt;&gt; 1;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (trim_regs[5] &amp; 0x01)=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 =3D -d2;<=
br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d2 +=3D temp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 default:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No data for other channel=
s */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_calibrate_channel(gpadc, chn, d1, d2=
);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define TWL6030_GPADC_CHAN(chn, _type, chan_info) { =A0\<br>
&gt; + =A0 =A0 .type =3D _type, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; + =A0 =A0 .channel =3D chn, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; + =A0 =A0 .info_mask_separate =3D BIT(chan_info), =A0 =A0 =A0 =A0 =A0 =
\<br>
&gt; + =A0 =A0 .indexed =3D 1, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec twl6030_gpadc_iio_channels[] =3D {<=
br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(0, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(1, IIO_TEMP, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(2, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(3, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(4, IIO_TEMP, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(5, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(6, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(7, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(8, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(9, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(10, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(11, IIO_VOLTAGE, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(14, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec twl6032_gpadc_iio_channels[] =3D {<=
br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(0, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(1, IIO_TEMP, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(2, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(3, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(4, IIO_TEMP, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(5, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(6, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(7, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(8, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(9, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),=
<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(10, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(11, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(14, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(17, IIO_VOLTAGE, IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 TWL6030_GPADC_CHAN(18, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED)=
,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_info twl6030_gpadc_iio_info =3D {<br>
&gt; + =A0 =A0 .read_raw =3D &amp;twl6030_gpadc_read_raw,<br>
&gt; + =A0 =A0 .driver_module =3D THIS_MODULE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct twl6030_gpadc_platform_data twl6030_pdata =3D {<b=
r>
&gt; + =A0 =A0 .iio_channels =3D twl6030_gpadc_iio_channels,<br>
&gt; + =A0 =A0 .nchannels =3D TWL6030_GPADC_USED_CHANNELS,<br>
&gt; + =A0 =A0 .ideal =3D twl6030_ideal,<br>
&gt; + =A0 =A0 .start_conversion =3D twl6030_start_conversion,<br>
&gt; + =A0 =A0 .channel_to_reg =3D twl6030_channel_to_reg,<br>
&gt; + =A0 =A0 .calibrate =3D twl6030_calibration,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct twl6030_gpadc_platform_data twl6032_pdata =3D {<b=
r>
&gt; + =A0 =A0 .iio_channels =3D twl6032_gpadc_iio_channels,<br>
&gt; + =A0 =A0 .nchannels =3D TWL6032_GPADC_USED_CHANNELS,<br>
&gt; + =A0 =A0 .ideal =3D twl6032_ideal,<br>
&gt; + =A0 =A0 .start_conversion =3D twl6032_start_conversion,<br>
&gt; + =A0 =A0 .channel_to_reg =3D twl6032_channel_to_reg,<br>
&gt; + =A0 =A0 .calibrate =3D twl6032_calibration,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct of_device_id of_twl6030_match_tbl[] =3D {<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D &quot;ti,twl6030-gpadc&quot;=
,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .data =3D &amp;twl6030_pdata,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D &quot;ti,twl6032-gpadc&quot;=
,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .data =3D &amp;twl6032_pdata,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 { /* end */ }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct device *dev =3D &amp;pdev-&gt;dev;<br>
&gt; + =A0 =A0 struct twl6030_gpadc_data *gpadc;<br>
&gt; + =A0 =A0 const struct twl6030_gpadc_platform_data *pdata;<br>
&gt; + =A0 =A0 const struct of_device_id *match;<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev;<br>
&gt; + =A0 =A0 int irq;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 match =3D of_match_device(of_match_ptr(of_twl6030_match_tbl)=
, dev);<br>
&gt; + =A0 =A0 if (!match)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 pdata =3D match-&gt;data;<br>
&gt; +<br>
&gt; + =A0 =A0 indio_dev =3D iio_device_alloc(sizeof(*gpadc));<br>
&gt; + =A0 =A0 if (!indio_dev) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;failed allocating iio dev=
ice\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 gpadc =3D iio_priv(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 gpadc-&gt;twl6030_cal_tbl =3D devm_kzalloc(dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(*gpadc-&gt;twl6030_cal_tbl) *<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pdata-&gt;nchannels, GFP_KERNEL);<br>
&gt; + =A0 =A0 if (!gpadc-&gt;twl6030_cal_tbl)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_device;<br>
&gt; +<br>
&gt; + =A0 =A0 gpadc-&gt;dev =3D dev;<br>
&gt; + =A0 =A0 gpadc-&gt;pdata =3D pdata;<br>
&gt; +<br>
&gt; + =A0 =A0 platform_set_drvdata(pdev, indio_dev);<br>
&gt; + =A0 =A0 mutex_init(&amp;gpadc-&gt;lock);<br>
&gt; + =A0 =A0 init_completion(&amp;gpadc-&gt;irq_complete);<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D pdata-&gt;calibrate(gpadc);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to r=
ead calibration registers\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_device;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 irq =3D platform_get_irq(pdev, 0);<br>
&gt; + =A0 =A0 if (irq &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to g=
et irq\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_device;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D request_threaded_irq(irq, NULL, twl6030_gpadc_irq_ha=
ndler,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_ONESHOT=
, &quot;twl6030_gpadc&quot;, indio_dev);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&amp;pdev-&gt;dev, &quot;could not r=
equest irq\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_device;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MA=
SK);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to e=
nable GPADC interrupt\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 TWL6030_REG_TOGGLE1);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to e=
nable GPADC module\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 indio_dev-&gt;name =3D DRIVER_NAME;<br>
&gt; + =A0 =A0 indio_dev-&gt;dev.parent =3D dev;<br>
&gt; + =A0 =A0 indio_dev-&gt;info =3D &amp;twl6030_gpadc_iio_info;<br>
&gt; + =A0 =A0 indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt; + =A0 =A0 indio_dev-&gt;channels =3D pdata-&gt;iio_channels;<br>
&gt; + =A0 =A0 indio_dev-&gt;num_channels =3D pdata-&gt;nchannels;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D iio_device_register(indio_dev);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +<br>
&gt; +err_free_irq:<br>
&gt; + =A0 =A0 free_irq(irq, indio_dev);<br>
&gt; +err_free_device:<br>
&gt; + =A0 =A0 iio_device_free(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);<br=
>
&gt; +<br>
&gt; + =A0 =A0 twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);<br=
>
&gt; + =A0 =A0 free_irq(platform_get_irq(pdev, 0), indio_dev);<br>
&gt; + =A0 =A0 iio_device_unregister(indio_dev);<br>
&gt; + =A0 =A0 iio_device_free(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +#ifdef CONFIG_PM_SLEEP<br>
&gt; +static int twl6030_gpadc_suspend(struct device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCR,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_REG_=
TOGGLE1);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pdev, &quot;error reseting GPADC (%d=
)!\n&quot;, ret);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int twl6030_gpadc_resume(struct device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_REG_=
TOGGLE1);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pdev, &quot;error setting GPADC (%d)=
!\n&quot;, ret);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +};<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +static SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 twl6030_gpadc_resume);<br>
&gt; +<br>
&gt; +static struct platform_driver twl6030_gpadc_driver =3D {<br>
&gt; + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D twl6030_gpadc_probe,<br>
&gt; + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D twl6030_gpadc_remove,<br>
&gt; + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &amp;twl6030_gpadc_pm_ops,<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_twl6030_match_tbl,<br=
>
&gt; + =A0 =A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_platform_driver(twl6030_gpadc_driver);<br>
&gt; +<br>
&gt; +MODULE_ALIAS(&quot;platform: &quot; DRIVER_NAME);<br>
&gt; +MODULE_AUTHOR(&quot;Balaji T K &lt;<a href=3D"mailto:balajitk@ti.com"=
>balajitk@ti.com</a>&gt;, Graeme Gregory &lt;<a href=3D"mailto:gg@slimlogic=
.co.uk">gg@slimlogic.co.uk</a>&gt;, Oleksandr Kozaruk &lt;<a href=3D"mailto=
:oleksandr.kozaruk@ti.com">oleksandr.kozaruk@ti.com</a>&quot;);<br>

&gt; +MODULE_DESCRIPTION(&quot;twl6030 ADC driver&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt;<br>
--<br>
</div></div>To unsubscribe from this list: send the line &quot;unsubscribe =
linux-kernel&quot; in<br>
<div class=3D"im HOEnZb">the body of a message to <a href=3D"mailto:majordo=
mo@vger.kernel.org">majordomo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</div><div class=3D"HOEnZb"><div class=3D"h5">Please read the FAQ at =A0<a =
href=3D"http://www.tux.org/lkml/" target=3D"_blank">http://www.tux.org/lkml=
/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div>Regards,</div><font size=3D"-1"><span style=3D"vertical-align:baseline=
;font-variant:normal;font-style:normal;background-color:transparent;text-de=
coration:none">Oleksandr Kozaruk | embedded developer</span><br>
<span style=3D"vertical-align:baseline;font-variant:normal;font-style:norma=
l;font-size:12px;background-color:transparent;text-decoration:none;font-fam=
ily:Arial;font-weight:normal">GlobalLogic</span><br><span style=3D"vertical=
-align:baseline;font-variant:normal;font-style:normal;font-size:12px;backgr=
ound-color:transparent;text-decoration:none;font-family:Arial;font-weight:n=
ormal">M +38.067.944.7905</span><br>
<a href=3D"http://www.globallogic.com/" target=3D"_blank"><span style=3D"fo=
nt-size:12px;font-family:Arial;color:#1155cc;background-color:transparent;f=
ont-weight:normal;font-style:normal;font-variant:normal;text-decoration:und=
erline;vertical-align:baseline">www.globallogic.com</span></a><span style=
=3D"vertical-align:baseline;font-variant:normal;font-style:normal;font-size=
:12px;background-color:transparent;text-decoration:none;font-family:Arial;f=
ont-weight:normal"></span><br>
<a href=3D"http://www.globallogic.com/" target=3D"_blank"><span style=3D"fo=
nt-size:12px;font-family:Arial;color:#1155cc;background-color:transparent;f=
ont-weight:normal;font-style:normal;font-variant:normal;text-decoration:und=
erline;vertical-align:baseline"></span></a><br>
<a href=3D"http://www.globallogic.com/email_disclaimer.txt" target=3D"_blan=
k"><span style=3D"font-size:11px;font-family:Arial;color:#1155cc;background=
-color:transparent;font-weight:normal;font-style:normal;font-variant:normal=
;text-decoration:underline;vertical-align:baseline">http://www.globallogic.=
com/email_disclaimer.txt</span></a><span style=3D"vertical-align:baseline;f=
ont-variant:normal;font-style:normal;font-size:11px;background-color:transp=
arent;text-decoration:none;font-family:Arial;font-weight:normal"></span></f=
ont>
</div></div></div>

--047d7b677c7e8a42ab04e3f5fc77--
