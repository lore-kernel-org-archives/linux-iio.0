Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36149 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbcBETcf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 14:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <20160205172457.GA16778@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
	<20160205172457.GA16778@deathstar>
Date: Fri, 5 Feb 2016 21:32:34 +0200
Message-ID: <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Michael Welling <mwelling@ieee.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 5, 2016 at 7:25 PM, Michael Welling <mwelling@ieee.org> wrote:
> On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
>> Datasheet can be found here:
>>       http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>> Changes since v3:
>>       * fixed type connectd -> connected
>>       * move mutex outside of switch in read_raw to be consistent
>>       with write_raw
>>
>> Changes since v2:
>>       * push locking out of the switch in write_raw
>>       * fix  buf allocation in triggered buffer's handler
>>
>> Changes since v1:
>>       * addressed concerns about replacing the ads1015 hwmon driver
>>               * For the moment the IIO driver is compatible with hwmon
>>                 driver (dt bindings) the only thing left is to also add
>>                 support for ads1115.
>>               * DT bindings are described in Documentation/devicetree/
>>                 bindings/hwmon/ads1015.txt. If needed will copy this file
>>                 in a later patch to the IIO corresponding location.
>>       * addressed comments from Jonathan
>>               * added proper locking
>>               * added timestamp channel
>>               * removed magic constants
>>               * added some new lines to increase readability
>>               * used regmap_get_device instead of keeping a copy of
>>               i2c_client pointer.
>>               * used non-devm function to correct the cleanup order
>>
>>  drivers/iio/adc/Kconfig      |  13 +
>>  drivers/iio/adc/Makefile     |   1 +
>>  drivers/iio/adc/ti-ads1015.c | 610 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 624 insertions(+)
>>  create mode 100644 drivers/iio/adc/ti-ads1015.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 60673b4..fad7e6a 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -370,6 +370,19 @@ config TI_ADC128S052
>>         This driver can also be built as a module. If so, the module will be
>>         called ti-adc128s052.
>>
>> +config TI_ADS1015
>> +     tristate "Texas Instruments ADS1015 ADC"
>> +     depends on I2C && !SENSORS_ADS1015
>> +     select REGMAP_I2C
>> +     select IIO_BUFFER
>> +     select IIO_TRIGGERED_BUFFER
>> +     help
>> +       If you say yes here you get support for Texas Instruments ADS1015
>> +       ADC chip.
>> +
>> +       This driver can also be built as a module. If so, the module will be
>> +       called ti-ads1015.
>> +
>>  config TI_ADS8688
>>       tristate "Texas Instruments ADS8688"
>>       depends on SPI && OF
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index fb57e12..2ff70a3 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>> +obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> new file mode 100644
>> index 0000000..596335f
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -0,0 +1,610 @@
>> +/*
>> + * ADS1015 - Texas Instruments Analog-to-Digital Converter
>> + *
>> + * Copyright (c) 2016, Intel Corporation.
>> + *
>> + * This file is subject to the terms and conditions of version 2 of
>> + * the GNU General Public License.  See the file COPYING in the main
>> + * directory of this archive for more details.
>> + *
>> + * IIO driver for ADS1015 ADC 7-bit I2C slave address:
>> + *   * 0x48 - ADDR connected to Ground
>> + *   * 0x49 - ADDR connected to Vdd
>> + *   * 0x4A - ADDR connected to SDA
>> + *   * 0x4B - ADDR connected to SCL
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +
>> +#include <linux/i2c/ads1015.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/types.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +
>> +#define ADS1015_DRV_NAME "ads1015"
>> +
>> +#define ADS1015_CONV_REG     0x00
>> +#define ADS1015_CFG_REG              0x01
>> +
>> +#define ADS1015_CFG_DR_SHIFT 5
>> +#define ADS1015_CFG_MOD_SHIFT        8
>> +#define ADS1015_CFG_PGA_SHIFT        9
>> +#define ADS1015_CFG_MUX_SHIFT        12
>> +
>> +#define ADS1015_CFG_DR_MASK  GENMASK(7, 5)
>> +#define ADS1015_CFG_MOD_MASK BIT(8)
>> +#define ADS1015_CFG_PGA_MASK GENMASK(11, 9)
>> +#define ADS1015_CFG_MUX_MASK GENMASK(14, 12)
>> +
>> +/* device operating modes */
>> +#define ADS1015_CONTINUOUS   0
>> +#define ADS1015_SINGLESHOT   1
>> +
>> +#define ADS1015_SLEEP_DELAY_MS               2000
>> +#define ADS1015_DEFAULT_PGA          2
>> +#define ADS1015_DEFAULT_DATA_RATE    4
>> +#define ADS1015_DEFAULT_CHAN         0
>> +
>> +enum ads1015_channels {
>> +     ADS1015_AIN0_AIN1 = 0,
>> +     ADS1015_AIN0_AIN3,
>> +     ADS1015_AIN1_AIN3,
>> +     ADS1015_AIN2_AIN3,
>> +     ADS1015_AIN0,
>> +     ADS1015_AIN1,
>> +     ADS1015_AIN2,
>> +     ADS1015_AIN3,
>> +     ADS1015_TIMESTAMP,
>> +};
>> +
>> +static const unsigned int ads1015_data_rate[] = {
>> +     128, 250, 490, 920, 1600, 2400, 3300, 3300
>> +};
>> +
>> +static const struct {
>> +     int scale;
>> +     int uscale;
>> +} ads1015_scale[] = {
>> +     {3, 0},
>> +     {2, 0},
>> +     {1, 0},
>> +     {0, 500000},
>> +     {0, 250000},
>> +     {0, 125000},
>> +     {0, 125000},
>> +     {0, 125000},
>> +};
>> +
>> +#define ADS1015_V_CHAN(_chan, _addr) {                               \
>> +     .type = IIO_VOLTAGE,                                    \
>> +     .indexed = 1,                                           \
>> +     .address = _addr,                                       \
>> +     .channel = _chan,                                       \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>> +                             BIT(IIO_CHAN_INFO_SCALE) |      \
>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>> +     .scan_index = _addr,                                    \
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 12,                                 \
>> +             .storagebits = 16,                              \
>> +             .shift = 4,                                     \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +}
>> +
>> +#define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {          \
>> +     .type = IIO_VOLTAGE,                                    \
>> +     .differential = 1,                                      \
>> +     .indexed = 1,                                           \
>> +     .address = _addr,                                       \
>> +     .channel = _chan,                                       \
>> +     .channel2 = _chan2,                                     \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>> +                             BIT(IIO_CHAN_INFO_SCALE) |      \
>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>> +     .scan_index = _addr,                                    \
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 12,                                 \
>> +             .storagebits = 16,                              \
>> +             .shift = 4,                                     \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +}
>> +
>> +struct ads1015_data {
>> +     struct regmap *regmap;
>> +     /*
>> +      * Protects ADC ops, e.g: concurrent sysfs/buffered
>> +      * data reads, configuration updates
>> +      */
>> +     struct mutex lock;
>> +     struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>> +};
>> +
>> +static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
>> +{
>> +     return (reg == ADS1015_CFG_REG);
>> +}
>> +
>> +static const struct regmap_config ads1015_regmap_config = {
>> +     .reg_bits = 8,
>> +     .val_bits = 16,
>> +     .max_register = ADS1015_CFG_REG,
>> +     .writeable_reg = ads1015_is_writeable_reg,
>> +};
>> +
>> +static const struct iio_chan_spec ads1015_channels[] = {
>> +     ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
>> +     ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
>> +     ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
>> +     ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
>> +     ADS1015_V_CHAN(0, ADS1015_AIN0),
>> +     ADS1015_V_CHAN(1, ADS1015_AIN1),
>> +     ADS1015_V_CHAN(2, ADS1015_AIN2),
>> +     ADS1015_V_CHAN(3, ADS1015_AIN3),
>> +     IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>> +};
>> +
>> +static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>> +{
>> +     int ret;
>> +     struct device *dev = regmap_get_device(data->regmap);
>> +
>> +     if (on) {
>> +             ret = pm_runtime_get_sync(dev);
>> +             if (ret < 0)
>> +                     pm_runtime_put_noidle(dev);
>> +     } else {
>> +             pm_runtime_mark_last_busy(dev);
>> +             ret = pm_runtime_put_autosuspend(dev);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static
>> +int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>> +{
>> +     int ret, pga, dr, conv_time;
>> +     bool change;
>> +
>> +     if (chan < 0 || chan >= ADS1015_CHANNELS)
>> +             return -EINVAL;
>> +
>> +     pga = data->channel_data[chan].pga;
>> +     dr = data->channel_data[chan].data_rate;
>> +
>> +     ret = regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
>> +                                    ADS1015_CFG_MUX_MASK |
>> +                                    ADS1015_CFG_PGA_MASK,
>> +                                    chan << ADS1015_CFG_MUX_SHIFT |
>> +                                    pga << ADS1015_CFG_PGA_SHIFT,
>> +                                    &change);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     if (change) {
>> +             conv_time = DIV_ROUND_UP(USEC_PER_SEC, ads1015_data_rate[dr]);
>> +             usleep_range(conv_time, conv_time + 1);
>> +     }
>> +
>> +     return regmap_read(data->regmap, ADS1015_CONV_REG, val);
>> +}
>> +
>> +static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct ads1015_data *data = iio_priv(indio_dev);
>> +     s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
>> +     int chan, ret, res;
>> +
>> +     memset(buf, 0, sizeof(buf));
>> +
>> +     mutex_lock(&data->lock);
>> +     chan = find_first_bit(indio_dev->active_scan_mask,
>> +                           indio_dev->masklength);
>> +     ret = ads1015_get_adc_result(data, chan, &res);
>> +     if (ret < 0) {
>> +             mutex_unlock(&data->lock);
>> +             goto err;
>> +     }
>> +
>> +     buf[0] = res;
>> +     mutex_unlock(&data->lock);
>> +
>> +     iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>> +
>> +err:
>> +     iio_trigger_notify_done(indio_dev->trig);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int ads1015_set_scale(struct ads1015_data *data, int chan,
>> +                          int scale, int uscale)
>> +{
>> +     int i, ret, rindex = -1;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++)
>> +             if (ads1015_scale[i].scale == scale &&
>> +                 ads1015_scale[i].uscale == uscale) {
>> +                     rindex = i;
>> +                     break;
>> +             }
>> +     if (rindex < 0)
>> +             return -EINVAL;
>> +
>> +     ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
>> +                              ADS1015_CFG_PGA_MASK,
>> +                              rindex << ADS1015_CFG_PGA_SHIFT);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     data->channel_data[chan].pga = rindex;
>> +
>> +     return 0;
>> +}
>> +
>> +static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
>> +{
>> +     int i, ret, rindex = -1;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
>> +             if (ads1015_data_rate[i] == rate) {
>> +                     rindex = i;
>> +                     break;
>> +             }
>> +     if (rindex < 0)
>> +             return -EINVAL;
>> +
>> +     ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
>> +                              ADS1015_CFG_DR_MASK,
>> +                              rindex << ADS1015_CFG_DR_SHIFT);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     data->channel_data[chan].data_rate = rindex;
>> +
>> +     return 0;
>> +}
>> +
>> +static int ads1015_read_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan, int *val,
>> +                         int *val2, long mask)
>> +{
>> +     int ret, idx;
>> +     struct ads1015_data *data = iio_priv(indio_dev);
>> +
>> +     mutex_lock(&data->lock);
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_RAW:
>> +             if (iio_buffer_enabled(indio_dev)) {
>> +                     ret = -EBUSY;
>> +                     break;
>> +             }
>> +
>> +             ret = ads1015_set_power_state(data, true);
>> +             if (ret < 0)
>> +                     break;
>
> Just tested the driver on a Dragonboard 410C with a robotics mezzanine that I
> designed.
>
> The above ads1015_set_power_state(data, true) is always returning -EINVAL.
>
> Any ideas why that would be happening?
> I think it may be the return from pm_runtime_get_sync?

Can you confirm that pm_runtime_get_sync fails? Using some printk?

Also adding printks in suspend/resume function would be helpful. Do
you have CONFIG_PM enabled?

>
> When I comment out the break the readings come back but are not updated continually.
> If I read in_voltage0-voltage1_raw then in_voltage0_raw the value is updated.

I guess this is normal if set_power_state fails.

thanks,
Daniel.
