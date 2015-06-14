Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44261 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbFNOCp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 10:02:45 -0400
Message-ID: <557D8981.8080007@kernel.org>
Date: Sun, 14 Jun 2015 15:02:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: light: Add support for ROHM RPR0521 sensor
References: <1433946113-8985-1-git-send-email-daniel.baluta@intel.com>	<557D5CAC.1090406@kernel.org> <CAEnQRZD43z77oiaw2WSc1kytiPULu32CGsktkT3vN0R4upONww@mail.gmail.com>
In-Reply-To: <CAEnQRZD43z77oiaw2WSc1kytiPULu32CGsktkT3vN0R4upONww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/06/15 12:28, Daniel Baluta wrote:
> On Sun, Jun 14, 2015 at 1:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 10/06/15 15:21, Daniel Baluta wrote:
>>> This patch adds support for ROHM RPR0521 ambient light and proximity
>>> sensor. It offers raw readings for intensity and proximity.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> Looks good to me.  A few comments inline.  Only one I'd really
>> bother making a change for is to be consistent using genmask
>> for all the masks rather than just some of them.
> 
> Agree. I will fix this.
> 
>>
>> Another thought is whether the regmap field stuff would give some
>> gains in this driver.  What do you think?
>>
> 
> Lately, I've seen that there is a strong preference for using regmap.
> Personally, I like
> it because I don't have to deal with deal with bit operations.
> 
> Here, the only advantage seems to be for caching gain values. Also, one future
> possible benefit of regmap would be easier porting for SPI bus (if added).
> 
> So, if you don't mind I prefer leaving it like this.
That's fine.  Using the field stuff mostly only gives a small gain in clarity
and that only once you have looked up how it works :)

Jonathan
> 
>> Anyhow, if this would make the merge window I'd have taken it now
>> but seeing as we just missed anyway, lets tidy up these loose ends
>> and give others a little more time to comment.
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>> Changes since v2: (after Peter's review)
>>>       * replaced calibscale with scale
>>>       * several style fixes (new lines, spellings, etc)
>>>       * fixed proximity interpretation. Now we have the
>>>       following relation: high proximity <-> low distance
>>>       * will send a follow up patch to clarify the ABI description
>>>       and to fix all other drivers that misinterpret this.
>>>
>>>  drivers/iio/light/Kconfig   |  11 +
>>>  drivers/iio/light/Makefile  |   1 +
>>>  drivers/iio/light/rpr0521.c | 622 ++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 634 insertions(+)
>>>  create mode 100644 drivers/iio/light/rpr0521.c
>>>
>>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>>> index e6198b7..cbc4677 100644
>>> --- a/drivers/iio/light/Kconfig
>>> +++ b/drivers/iio/light/Kconfig
>>> @@ -168,6 +168,17 @@ config JSA1212
>>>        To compile this driver as a module, choose M here:
>>>        the module will be called jsa1212.
>>>
>>> +config RPR0521
>>> +     tristate "ROHM RPR0521 ALS and proximity sensor driver"
>>> +     depends on I2C
>>> +     select REGMAP_I2C
>>> +     help
>>> +      Say Y here if you want to build support for ROHM's RPR0521
>>> +      ambient light and proximity sensor device.
>>> +
>>> +      To compile this driver as a module, choose M here:
>>> +      the module will be called rpr0521.
>>> +
>>>  config SENSORS_LM3533
>>>       tristate "LM3533 ambient light sensor"
>>>       depends on MFD_LM3533
>>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>>> index e2d50fd..adf9723 100644
>>> --- a/drivers/iio/light/Makefile
>>> +++ b/drivers/iio/light/Makefile
>>> @@ -19,6 +19,7 @@ obj-$(CONFIG_ISL29125)              += isl29125.o
>>>  obj-$(CONFIG_JSA1212)                += jsa1212.o
>>>  obj-$(CONFIG_SENSORS_LM3533) += lm3533-als.o
>>>  obj-$(CONFIG_LTR501)         += ltr501.o
>>> +obj-$(CONFIG_RPR0521)                += rpr0521.o
>>>  obj-$(CONFIG_SENSORS_TSL2563)        += tsl2563.o
>>>  obj-$(CONFIG_STK3310)          += stk3310.o
>>>  obj-$(CONFIG_TCS3414)                += tcs3414.o
>>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>>> new file mode 100644
>>> index 0000000..a75032ea
>>> --- /dev/null
>>> +++ b/drivers/iio/light/rpr0521.c
>>> @@ -0,0 +1,622 @@
>>> +/*
>>> + * RPR-0521 ROHM Ambient Light and Proximity Sensor
>>> + *
>>> + * Copyright (c) 2015, Intel Corporation.
>>> + *
>>> + * This file is subject to the terms and conditions of version 2 of
>>> + * the GNU General Public License.  See the file COPYING in the main
>>> + * directory of this archive for more details.
>>> + *
>>> + * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
>>> + *
>>> + * TODO: illuminance channel, PM support, buffer
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/acpi.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/pm_runtime.h>
>>> +
>>> +#define RPR0521_REG_SYSTEM_CTRL              0x40
>>> +#define RPR0521_REG_MODE_CTRL                0x41
>>> +#define RPR0521_REG_ALS_CTRL         0x42
>>> +#define RPR0521_REG_PXS_CTRL         0x43
>>> +#define RPR0521_REG_PXS_DATA         0x44 /* 16-bit, little endian */
>>> +#define RPR0521_REG_ALS_DATA0                0x46 /* 16-bit, little endian */
>>> +#define RPR0521_REG_ALS_DATA1                0x48 /* 16-bit, little endian */
>>> +#define RPR0521_REG_ID                       0x92
>>> +
>>> +#define RPR0521_MODE_ALS_MASK                BIT(7)
>>> +#define RPR0521_MODE_PXS_MASK                BIT(6)
>>> +#define RPR0521_MODE_MEAS_TIME_MASK  GENMASK(3, 0)
>>> +#define RPR0521_ALS_DATA0_GAIN_MASK  (BIT(4) | BIT(5))
>> Ideal would probably be genmask for these other masks as well.
> 
> Ok.
> 
>>> +#define RPR0521_ALS_DATA0_GAIN_SHIFT 4
>>> +#define RPR0521_ALS_DATA1_GAIN_MASK  (BIT(2) | BIT(3))
>>> +#define RPR0521_ALS_DATA1_GAIN_SHIFT 2
>>> +#define RPR0521_PXS_GAIN_MASK                (BIT(4) | BIT(5))
>>> +#define RPR0521_PXS_GAIN_SHIFT               4
>>> +
>>> +#define RPR0521_MODE_ALS_ENABLE              BIT(7)
>>> +#define RPR0521_MODE_ALS_DISABLE     0x00
>>> +#define RPR0521_MODE_PXS_ENABLE              BIT(6)
>>> +#define RPR0521_MODE_PXS_DISABLE     0x00
>>> +
>>> +#define RPR0521_PXS_MAX_VAL          (BIT(13) - 1)
>>> +#define RPR0521_MANUFACT_ID          0xE0
>>> +#define RPR0521_DEFAULT_MEAS_TIME    0x06 /* ALS - 100ms, PXS - 100ms */
>>> +
>>> +#define RPR0521_DRV_NAME             "RPR0521"
>>> +#define RPR0521_REGMAP_NAME          "rpr0521_regmap"
>>> +
>>> +#define RPR0521_SLEEP_DELAY_MS       2000
>>> +
>>> +#define RPR0521_ALS_SCALE_AVAIL "0.007812 0.015625 0.5 1"
>>> +#define RPR0521_PXS_SCALE_AVAIL "0.125 0.5 1"
>>> +
>>> +struct rpr0521_gain {
>>> +     int scale;
>>> +     int uscale;
>>> +};
>>> +
>>> +static const struct rpr0521_gain rpr0521_als_gain[4] = {
>>> +     {1, 0},         /* x1 */
>>> +     {0, 500000},    /* x2 */
>>> +     {0, 15625},     /* x64 */
>>> +     {0, 7812},      /* x128 */
>>> +};
>>> +
>>> +static const struct rpr0521_gain rpr0521_pxs_gain[3] = {
>>> +     {1, 0},         /* x1 */
>>> +     {0, 500000},    /* x2 */
>>> +     {0, 125000},    /* x4 */
>>> +};
>>> +
>>> +enum rpr0521_channel {
>>> +     RPR0521_CHAN_ALS_DATA0,
>>> +     RPR0521_CHAN_ALS_DATA1,
>>> +     RPR0521_CHAN_PXS,
>>> +};
>>> +
>>> +struct rpr0521_reg_desc {
>>> +     u8 address;
>>> +     u8 device_mask;
>>> +};
>>> +
>>> +static const struct rpr0521_reg_desc rpr0521_data_reg[] = {
>>> +     [RPR0521_CHAN_ALS_DATA0] = {
>>> +             .address        = RPR0521_REG_ALS_DATA0,
>>> +             .device_mask    = RPR0521_MODE_ALS_MASK,
>>> +     },
>>> +     [RPR0521_CHAN_ALS_DATA1] = {
>>> +             .address        = RPR0521_REG_ALS_DATA1,
>>> +             .device_mask    = RPR0521_MODE_ALS_MASK,
>>> +     },
>>> +     [RPR0521_CHAN_PXS]      = {
>>> +             .address        = RPR0521_REG_PXS_DATA,
>>> +             .device_mask    = RPR0521_MODE_PXS_MASK,
>>> +     },
>>> +};
>>> +
>> I'd have been tempted to roll the above reg_desc and this
>> gain_info structures together and just have a chan_info
>> structure containing them both.  Still more a matter of
>> taste than anything else so I'm fine with what you have here
>> as well!
> 
> I will have a closer look when sending v4.
> 
>>> +static const struct rpr0521_gain_info {
>>> +     u8 reg;
>>> +     u8 mask;
>>> +     u8 shift;
>>> +     const struct rpr0521_gain *gain;
>>> +     int size;
>>> +} rpr0521_gain[] = {
>>> +     [RPR0521_CHAN_ALS_DATA0] = {
>>> +             .reg    = RPR0521_REG_ALS_CTRL,
>>> +             .mask   = RPR0521_ALS_DATA0_GAIN_MASK,
>>> +             .shift  = RPR0521_ALS_DATA0_GAIN_SHIFT,
>>> +             .gain   = rpr0521_als_gain,
>>> +             .size   = ARRAY_SIZE(rpr0521_als_gain),
>>> +     },
>>> +     [RPR0521_CHAN_ALS_DATA1] = {
>>> +             .reg    = RPR0521_REG_ALS_CTRL,
>>> +             .mask   = RPR0521_ALS_DATA1_GAIN_MASK,
>>> +             .shift  = RPR0521_ALS_DATA1_GAIN_SHIFT,
>>> +             .gain   = rpr0521_als_gain,
>>> +             .size   = ARRAY_SIZE(rpr0521_als_gain),
>>> +     },
>>> +     [RPR0521_CHAN_PXS] = {
>>> +             .reg    = RPR0521_REG_PXS_CTRL,
>>> +             .mask   = RPR0521_PXS_GAIN_MASK,
>>> +             .shift  = RPR0521_PXS_GAIN_SHIFT,
>>> +             .gain   = rpr0521_pxs_gain,
>>> +             .size   = ARRAY_SIZE(rpr0521_pxs_gain),
>>> +     },
>>> +};
>>> +
>>> +struct rpr0521_data {
>>> +     struct i2c_client *client;
>>> +
>>> +     /* protect device params updates (e.g state, gain) */
>>> +     struct mutex lock;
>>> +
>>> +     /* device active status */
>>> +     bool als_dev_en;
>>> +     bool pxs_dev_en;
>>> +
>>> +     /* optimize runtime pm ops - enable device only if needed */
>>> +     bool als_ps_need_en;
>>> +     bool pxs_ps_need_en;
>>> +
>>> +     struct regmap *regmap;
>>> +};
>>> +
>>> +static IIO_CONST_ATTR(in_intensity_scale_available, RPR0521_ALS_SCALE_AVAIL);
>>> +static IIO_CONST_ATTR(in_proximity_scale_available, RPR0521_PXS_SCALE_AVAIL);
>>> +
>>> +static struct attribute *rpr0521_attributes[] = {
>>> +     &iio_const_attr_in_intensity_scale_available.dev_attr.attr,
>>> +     &iio_const_attr_in_proximity_scale_available.dev_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +static const struct attribute_group rpr0521_attribute_group = {
>>> +     .attrs = rpr0521_attributes,
>>> +};
>>> +
>>> +static const struct iio_chan_spec rpr0521_channels[] = {
>>> +     {
>>> +             .type = IIO_INTENSITY,
>>> +             .modified = 1,
>>> +             .address = RPR0521_CHAN_ALS_DATA0,
>>> +             .channel2 = IIO_MOD_LIGHT_BOTH,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                     BIT(IIO_CHAN_INFO_SCALE),
>>> +     },
>>> +     {
>>> +             .type = IIO_INTENSITY,
>>> +             .modified = 1,
>>> +             .address = RPR0521_CHAN_ALS_DATA1,
>>> +             .channel2 = IIO_MOD_LIGHT_IR,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                     BIT(IIO_CHAN_INFO_SCALE),
>>> +     },
>>> +     {
>>> +             .type = IIO_PROXIMITY,
>>> +             .address = RPR0521_CHAN_PXS,
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                     BIT(IIO_CHAN_INFO_SCALE),
>>> +     }
>>> +};
>>> +
>>> +static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
>>> +                              RPR0521_MODE_ALS_MASK,
>>> +                              status);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     data->als_dev_en = true;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
>>> +                              RPR0521_MODE_PXS_MASK,
>>> +                              status);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     data->pxs_dev_en = true;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * rpr0521_set_power_state - handles runtime PM state and sensors enabled status
>>> + *
>>> + * @data: rpr0521 device private data
>>> + * @on: state to be set for devices in @device_mask
>>> + * @device_mask: bitmask specifying for which device we need to update @on state
>>> + *
>>> + * We rely on rpr0521_runtime_resume to enable our @device_mask devices, but
>>> + * if (for example) PXS was enabled (pxs_dev_en = true) by a previous call to
>>> + * rpr0521_runtime_resume and we want to enable ALS we MUST set ALS enable
>>> + * bit of RPR0521_REG_MODE_CTRL here because rpr0521_runtime_resume will not
>>> + * be called twice.
>>> + */
>>> +static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>>> +                                u8 device_mask)
>>> +{
>>> +#ifdef CONFIG_PM
>>> +     int ret;
>>> +     u8 update_mask = 0;
>>> +
>>> +     if (device_mask & RPR0521_MODE_ALS_MASK) {
>>> +             if (on && !data->als_ps_need_en && data->pxs_dev_en)
>>> +                     update_mask |= RPR0521_MODE_ALS_MASK;
>>> +             else
>>> +                     data->als_ps_need_en = on;
>>> +     }
>>> +
>>> +     if (device_mask & RPR0521_MODE_PXS_MASK) {
>>> +             if (on && !data->pxs_ps_need_en && data->als_dev_en)
>>> +                     update_mask |= RPR0521_MODE_PXS_MASK;
>>> +             else
>>> +                     data->pxs_ps_need_en = on;
>>> +     }
>>> +
>>> +     if (update_mask) {
>>> +             ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
>>> +                                      update_mask, update_mask);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     if (on) {
>>> +             ret = pm_runtime_get_sync(&data->client->dev);
>>> +     } else {
>>> +             pm_runtime_mark_last_busy(&data->client->dev);
>>> +             ret = pm_runtime_put_autosuspend(&data->client->dev);
>>> +     }
>>> +     if (ret < 0) {
>>> +             dev_err(&data->client->dev,
>>> +                     "Failed: rpr0521_set_power_state for %d, ret %d\n",
>>> +                     on, ret);
>>> +             if (on)
>>> +                     pm_runtime_put_noidle(&data->client->dev);
>>> +
>>> +             return ret;
>>> +     }
>>> +#endif
>>> +     return 0;
>>> +}
>>> +
>>> +static int rpr0521_get_gain_index(const struct rpr0521_gain *gainv, int size,
>>> +                               int val, int val2)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = 0; i < size; i++)
>>> +             if (val == gainv[i].scale && val2 == gainv[i].uscale)
>>> +                     return i;
>>> +
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static int rpr0521_get_gain(struct rpr0521_data *data, int chan,
>>> +                         int *val, int *val2)
>>> +{
>>> +     int ret, reg, idx;
>>> +
>>> +     ret = regmap_read(data->regmap, rpr0521_gain[chan].reg, &reg);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     idx = (rpr0521_gain[chan].mask & reg) >> rpr0521_gain[chan].shift;
>>> +     *val = rpr0521_gain[chan].gain[idx].scale;
>>> +     *val2 = rpr0521_gain[chan].gain[idx].uscale;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int rpr0521_set_gain(struct rpr0521_data *data, int chan,
>>> +                         int val, int val2)
>>> +{
>>> +     int idx;
>>> +
>>> +     idx = rpr0521_get_gain_index(rpr0521_gain[chan].gain,
>>> +                                  rpr0521_gain[chan].size, val, val2);
>> Marginal benefit in having the separate get_gain_index function as
>> only used here and very simple at that.  Maybe, just worth while..
> 
> Agree with this.
> 
>>> +     if (idx < 0)
>>> +             return idx;
>>> +
>>> +     return regmap_update_bits(data->regmap, rpr0521_gain[chan].reg,
>>> +                               rpr0521_gain[chan].mask,
>>> +                               idx << rpr0521_gain[chan].shift);
>>> +}
>>> +
>>> +static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>> +                         struct iio_chan_spec const *chan, int *val,
>>> +                         int *val2, long mask)
>>> +{
>>> +     struct rpr0521_data *data = iio_priv(indio_dev);
>>> +     int ret;
>>> +     u8 device_mask;
>>> +     __le16 raw_data;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW:
>>> +             if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
>>> +                     return -EINVAL;
>>> +
>>> +             device_mask = rpr0521_data_reg[chan->address].device_mask;
>>> +
>>> +             mutex_lock(&data->lock);
>>> +             ret = rpr0521_set_power_state(data, true, device_mask);
>>> +             if (ret < 0) {
>> Fine as is, but perhaps you would have been better pulling this section
>> out to a separate function then using the traditional goto type error
>> handling to undo the relevant elements as you go rather than having repeats
>> of this mutex unlock for example.  Not quite a complex enough case for
>> me to insist on it here though :)
>>> +                     mutex_unlock(&data->lock);
>>> +                     return ret;
> 
> I see, it seems ok as it is. I'll try to see if using goto makes code easier
> to read.
> 
> thanks,
> Daniel.
> 

