Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170820120512.31c8e98a@archlinux>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
 <1500564267-8613-12-git-send-email-akinobu.mita@gmail.com>
 <20170723130143.474dbe6d@kernel.org> <20170820120512.31c8e98a@archlinux>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 22 Aug 2017 19:20:20 +0900
Message-ID: <CAC5umyjpakK1Lqac0i-fnO_CSU4vGu4UqDKjTRowSD+Fpyw9bw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] iio: adc: ti-ads1015: add threshold event support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-08-20 20:05 GMT+09:00 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
> On Sun, 23 Jul 2017 13:01:43 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Fri, 21 Jul 2017 00:24:27 +0900
>> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>>
>> > The ADS1015 device provides programmable comparator that can issue an
>> > interrupt on the ALERT pin.  This change adds the iio threshold event
>> > support for that feature.
>> >
>> > The ADS1015 device only have a single config register which contains an
>> > input multiplexer selection, comparator settings, and etc.  So only a
>> > single event channel can be enabled at a time.  Also enabling both buffer
>> > and event are prohibited for simplicity.
>> >
>> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> > Cc: Jonathan Cameron <jic23@kernel.org>
>> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> one really minor point inline.
>>
>> Otherwise I'm happy with this set.  Just waiting to see if
>> Daniel has time to take a look (or anyone else!)
>>
>
> I added a really trivial check on the error as mentioned inline and
> applied to the togreg branch of iio.git and pushed out as testing.
>
> If you could sanity check my change that would be great.

I have sent version 3 of this series on 2017-07-31 that included
a fix for the comparator polarity field setting in config register.

Should I send a incremental patch for the missing part to the togreg
branch?

> Thanks,
>
> Jonathan
>
>> Jonathan
>> > ---
>> >  drivers/iio/adc/ti-ads1015.c | 406 ++++++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 404 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> > index 5568be4..54547a2 100644
>> > --- a/drivers/iio/adc/ti-ads1015.c
>> > +++ b/drivers/iio/adc/ti-ads1015.c
>> > @@ -17,6 +17,7 @@
>> >  #include <linux/module.h>
>> >  #include <linux/of_device.h>
>> >  #include <linux/init.h>
>> > +#include <linux/irq.h>
>> >  #include <linux/i2c.h>
>> >  #include <linux/regmap.h>
>> >  #include <linux/pm_runtime.h>
>> > @@ -28,6 +29,7 @@
>> >  #include <linux/iio/iio.h>
>> >  #include <linux/iio/types.h>
>> >  #include <linux/iio/sysfs.h>
>> > +#include <linux/iio/events.h>
>> >  #include <linux/iio/buffer.h>
>> >  #include <linux/iio/triggered_buffer.h>
>> >  #include <linux/iio/trigger_consumer.h>
>> > @@ -36,17 +38,38 @@
>> >
>> >  #define ADS1015_CONV_REG   0x00
>> >  #define ADS1015_CFG_REG            0x01
>> > +#define ADS1015_LO_THRESH_REG      0x02
>> > +#define ADS1015_HI_THRESH_REG      0x03
>> >
>> > +#define ADS1015_CFG_COMP_QUE_SHIFT 0
>> > +#define ADS1015_CFG_COMP_LAT_SHIFT 2
>> > +#define ADS1015_CFG_COMP_POL_SHIFT 3
>> > +#define ADS1015_CFG_COMP_MODE_SHIFT        4
>> >  #define ADS1015_CFG_DR_SHIFT       5
>> >  #define ADS1015_CFG_MOD_SHIFT      8
>> >  #define ADS1015_CFG_PGA_SHIFT      9
>> >  #define ADS1015_CFG_MUX_SHIFT      12
>> >
>> > +#define ADS1015_CFG_COMP_QUE_MASK  GENMASK(1, 0)
>> > +#define ADS1015_CFG_COMP_LAT_MASK  BIT(2)
>> > +#define ADS1015_CFG_COMP_POL_MASK  BIT(2)
>> > +#define ADS1015_CFG_COMP_MODE_MASK BIT(4)
>> >  #define ADS1015_CFG_DR_MASK        GENMASK(7, 5)
>> >  #define ADS1015_CFG_MOD_MASK       BIT(8)
>> >  #define ADS1015_CFG_PGA_MASK       GENMASK(11, 9)
>> >  #define ADS1015_CFG_MUX_MASK       GENMASK(14, 12)
>> >
>> > +/* Comparator queue and disable field */
>> > +#define ADS1015_CFG_COMP_DISABLE   3
>> > +
>> > +/* Comparator polarity field */
>> > +#define ADS1015_CFG_COMP_POL_LOW   0
>> > +#define ADS1015_CFG_COMP_POL_HIGH  1
>> > +
>> > +/* Comparator mode field */
>> > +#define ADS1015_CFG_COMP_MODE_TRAD 0
>> > +#define ADS1015_CFG_COMP_MODE_WINDOW       1
>> > +
>> >  /* device operating modes */
>> >  #define ADS1015_CONTINUOUS 0
>> >  #define ADS1015_SINGLESHOT 1
>> > @@ -89,6 +112,30 @@ static int ads1015_fullscale_range[] = {
>> >     6144, 4096, 2048, 1024, 512, 256, 256, 256
>> >  };
>> >
>> > +/*
>> > + * Translation from COMP_QUE field value to the number of successive readings
>> > + * exceed the threshold values before an interrupt is generated
>> > + */
>> > +static const int ads1015_comp_queue[] = { 1, 2, 4 };
>> > +
>> > +static const struct iio_event_spec ads1015_events[] = {
>> > +   {
>> > +           .type = IIO_EV_TYPE_THRESH,
>> > +           .dir = IIO_EV_DIR_RISING,
>> > +           .mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> > +                           BIT(IIO_EV_INFO_ENABLE),
>> > +   }, {
>> > +           .type = IIO_EV_TYPE_THRESH,
>> > +           .dir = IIO_EV_DIR_FALLING,
>> > +           .mask_separate = BIT(IIO_EV_INFO_VALUE),
>> > +   }, {
>> > +           .type = IIO_EV_TYPE_THRESH,
>> > +           .dir = IIO_EV_DIR_EITHER,
>> > +           .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
>> > +                           BIT(IIO_EV_INFO_PERIOD),
>> > +   },
>> > +};
>> > +
>> >  #define ADS1015_V_CHAN(_chan, _addr) {                             \
>> >     .type = IIO_VOLTAGE,                                    \
>> >     .indexed = 1,                                           \
>> > @@ -105,6 +152,8 @@ static int ads1015_fullscale_range[] = {
>> >             .shift = 4,                                     \
>> >             .endianness = IIO_CPU,                          \
>> >     },                                                      \
>> > +   .event_spec = ads1015_events,                           \
>> > +   .num_event_specs = ARRAY_SIZE(ads1015_events),          \
>> >     .datasheet_name = "AIN"#_chan,                          \
>> >  }
>> >
>> > @@ -126,6 +175,8 @@ static int ads1015_fullscale_range[] = {
>> >             .shift = 4,                                     \
>> >             .endianness = IIO_CPU,                          \
>> >     },                                                      \
>> > +   .event_spec = ads1015_events,                           \
>> > +   .num_event_specs = ARRAY_SIZE(ads1015_events),          \
>> >     .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>> >  }
>> >
>> > @@ -144,6 +195,8 @@ static int ads1015_fullscale_range[] = {
>> >             .storagebits = 16,                              \
>> >             .endianness = IIO_CPU,                          \
>> >     },                                                      \
>> > +   .event_spec = ads1015_events,                           \
>> > +   .num_event_specs = ARRAY_SIZE(ads1015_events),          \
>> >     .datasheet_name = "AIN"#_chan,                          \
>> >  }
>> >
>> > @@ -164,9 +217,17 @@ static int ads1015_fullscale_range[] = {
>> >             .storagebits = 16,                              \
>> >             .endianness = IIO_CPU,                          \
>> >     },                                                      \
>> > +   .event_spec = ads1015_events,                           \
>> > +   .num_event_specs = ARRAY_SIZE(ads1015_events),          \
>> >     .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>> >  }
>> >
>> > +struct ads1015_thresh_data {
>> > +   unsigned int comp_queue;
>> > +   int high_thresh;
>> > +   int low_thresh;
>> > +};
>> > +
>> >  struct ads1015_data {
>> >     struct regmap *regmap;
>> >     /*
>> > @@ -176,6 +237,10 @@ struct ads1015_data {
>> >     struct mutex lock;
>> >     struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>> >
>> > +   unsigned int event_channel;
>> > +   unsigned int comp_mode;
>> > +   struct ads1015_thresh_data thresh_data[ADS1015_CHANNELS];
>> > +
>> >     unsigned int *data_rate;
>> >     /*
>> >      * Set to true when the ADC is switched to the continuous-conversion
>> > @@ -185,15 +250,41 @@ struct ads1015_data {
>> >     bool conv_invalid;
>> >  };
>> >
>> > +static bool ads1015_event_channel_enabled(struct ads1015_data *data)
>> > +{
>> > +   return (data->event_channel != ADS1015_CHANNELS);
>> > +}
>> > +
>> > +static void ads1015_event_channel_enable(struct ads1015_data *data, int chan,
>> > +                                    int comp_mode)
>> > +{
>> > +   WARN_ON(ads1015_event_channel_enabled(data));
>> > +
>> > +   data->event_channel = chan;
>> > +   data->comp_mode = comp_mode;
>> > +}
>> > +
>> > +static void ads1015_event_channel_disable(struct ads1015_data *data, int chan)
>> > +{
>> > +   data->event_channel = ADS1015_CHANNELS;
>> > +}
>> > +
>> >  static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
>> >  {
>> > -   return (reg == ADS1015_CFG_REG);
>> > +   switch (reg) {
>> > +   case ADS1015_CFG_REG:
>> > +   case ADS1015_LO_THRESH_REG:
>> > +   case ADS1015_HI_THRESH_REG:
>> > +           return true;
>> > +   default:
>> > +           return false;
>> > +   }
>> >  }
>> >
>> >  static const struct regmap_config ads1015_regmap_config = {
>> >     .reg_bits = 8,
>> >     .val_bits = 16,
>> > -   .max_register = ADS1015_CFG_REG,
>> > +   .max_register = ADS1015_HI_THRESH_REG,
>> >     .writeable_reg = ads1015_is_writeable_reg,
>> >  };
>> >
>> > @@ -258,6 +349,14 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>> >     cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
>> >             dr << ADS1015_CFG_DR_SHIFT;
>> >
>> > +   if (ads1015_event_channel_enabled(data)) {
>> > +           mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
>> > +           cfg |= data->thresh_data[chan].comp_queue <<
>> > +                           ADS1015_CFG_COMP_QUE_SHIFT |
>> > +                   data->comp_mode <<
>> > +                           ADS1015_CFG_COMP_MODE_SHIFT;
>> > +   }
>> > +
>> >     cfg = (old & ~mask) | (cfg & mask);
>> >
>> >     ret = regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
>> > @@ -356,6 +455,12 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>> >             if (ret)
>> >                     break;
>> >
>> > +           if (ads1015_event_channel_enabled(data) &&
>> > +                           data->event_channel != chan->address) {
>> > +                   ret = -EBUSY;
>> > +                   goto release_direct;
>> > +           }
>> > +
>> >             ret = ads1015_set_power_state(data, true);
>> >             if (ret < 0)
>> >                     goto release_direct;
>> > @@ -421,8 +526,251 @@ static int ads1015_write_raw(struct iio_dev *indio_dev,
>> >     return ret;
>> >  }
>> >
>> > +static int ads1015_read_event(struct iio_dev *indio_dev,
>> > +   const struct iio_chan_spec *chan, enum iio_event_type type,
>> > +   enum iio_event_direction dir, enum iio_event_info info, int *val,
>> > +   int *val2)
>> > +{
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +   int ret;
>> > +   unsigned int comp_queue;
>> > +   int period;
>> > +   int dr;
>> > +
>> > +   mutex_lock(&data->lock);
>> > +
>> > +   switch (info) {
>> > +   case IIO_EV_INFO_VALUE:
>> > +           *val = (dir == IIO_EV_DIR_RISING) ?
>> > +                   data->thresh_data[chan->address].high_thresh :
>> > +                   data->thresh_data[chan->address].low_thresh;
>> > +           ret = IIO_VAL_INT;
>> > +           break;
>> > +   case IIO_EV_INFO_PERIOD:
>> > +           dr = data->channel_data[chan->address].data_rate;
>> > +           comp_queue = data->thresh_data[chan->address].comp_queue;
>> > +           period = ads1015_comp_queue[comp_queue] *
>> > +                   USEC_PER_SEC / data->data_rate[dr];
>> > +
>> > +           *val = period / USEC_PER_SEC;
>> > +           *val2 = period % USEC_PER_SEC;
>> > +           ret = IIO_VAL_INT_PLUS_MICRO;
>> > +           break;
>> > +   default:
>> > +           ret = -EINVAL;
>> > +           break;
>> > +   }
>> > +
>> > +   mutex_unlock(&data->lock);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static int ads1015_write_event(struct iio_dev *indio_dev,
>> > +   const struct iio_chan_spec *chan, enum iio_event_type type,
>> > +   enum iio_event_direction dir, enum iio_event_info info, int val,
>> > +   int val2)
>> > +{
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +   int realbits = chan->scan_type.realbits;
>> > +   int ret = 0;
>> > +   long long period;
>> > +   int i;
>> > +   int dr;
>> > +
>> > +   mutex_lock(&data->lock);
>> > +
>> > +   switch (info) {
>> > +   case IIO_EV_INFO_VALUE:
>> > +           if (val >= 1 << (realbits - 1) || val < -1 << (realbits - 1)) {
>> > +                   ret = -EINVAL;
>> > +                   break;
>> > +           }
>> > +           if (dir == IIO_EV_DIR_RISING)
>> > +                   data->thresh_data[chan->address].high_thresh = val;
>> > +           else
>> > +                   data->thresh_data[chan->address].low_thresh = val;
>> > +           break;
>> > +   case IIO_EV_INFO_PERIOD:
>> > +           dr = data->channel_data[chan->address].data_rate;
>> > +           period = val * USEC_PER_SEC + val2;
>> > +
>> > +           for (i = 0; i < ARRAY_SIZE(ads1015_comp_queue) - 1; i++) {
>> > +                   if (period <= ads1015_comp_queue[i] *
>> > +                                   USEC_PER_SEC / data->data_rate[dr])
>> > +                           break;
>> > +           }
>> > +           data->thresh_data[chan->address].comp_queue = i;
>> > +           break;
>> > +   default:
>> > +           ret = -EINVAL;
>> > +           break;
>> > +   }
>> > +
>> > +   mutex_unlock(&data->lock);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static int ads1015_read_event_config(struct iio_dev *indio_dev,
>> > +   const struct iio_chan_spec *chan, enum iio_event_type type,
>> > +   enum iio_event_direction dir)
>> > +{
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +   int ret = 0;
>> > +
>> > +   mutex_lock(&data->lock);
>> > +   if (data->event_channel == chan->address) {
>> > +           switch (dir) {
>> > +           case IIO_EV_DIR_RISING:
>> > +                   ret = 1;
>> > +                   break;
>> > +           case IIO_EV_DIR_EITHER:
>> > +                   ret = (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
>> > +                   break;
>> > +           default:
>> > +                   ret = -EINVAL;
>> > +                   break;
>> > +           }
>> > +   }
>> > +   mutex_unlock(&data->lock);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static int ads1015_enable_event_config(struct ads1015_data *data,
>> > +   const struct iio_chan_spec *chan, int comp_mode)
>> > +{
>> > +   int low_thresh = data->thresh_data[chan->address].low_thresh;
>> > +   int high_thresh = data->thresh_data[chan->address].high_thresh;
>> > +   int ret;
>> > +   unsigned int val;
>> > +
>> > +   if (ads1015_event_channel_enabled(data)) {
>> > +           if (data->event_channel != chan->address ||
>> > +                   (data->comp_mode == ADS1015_CFG_COMP_MODE_TRAD &&
>> > +                           comp_mode == ADS1015_CFG_COMP_MODE_WINDOW))
>> > +                   return -EBUSY;
>> > +
>> > +           return 0;
>> > +   }
>> > +
>> > +   if (comp_mode == ADS1015_CFG_COMP_MODE_TRAD) {
>> > +           low_thresh = max(-1 << (chan->scan_type.realbits - 1),
>> > +                           high_thresh - 1);
>> > +   }
>> > +   ret = regmap_write(data->regmap, ADS1015_LO_THRESH_REG,
>> > +                   low_thresh << chan->scan_type.shift);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   ret = regmap_write(data->regmap, ADS1015_HI_THRESH_REG,
>> > +                   high_thresh << chan->scan_type.shift);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   ret = ads1015_set_power_state(data, true);
>> > +   if (ret < 0)
>> > +           return ret;
>> > +
>> > +   ads1015_event_channel_enable(data, chan->address, comp_mode);
>> > +
>> > +   ret = ads1015_get_adc_result(data, chan->address, &val);
>> > +   if (ret) {
>> > +           ads1015_event_channel_disable(data, chan->address);
>> > +           ads1015_set_power_state(data, false);
>> > +   }
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static int ads1015_disable_event_config(struct ads1015_data *data,
>> > +   const struct iio_chan_spec *chan, int comp_mode)
>> > +{
>> > +   int ret;
>> > +
>> > +   if (!ads1015_event_channel_enabled(data))
>> > +           return 0;
>> > +
>> > +   if (data->event_channel != chan->address)
>> > +           return 0;
>> > +
>> > +   if (data->comp_mode == ADS1015_CFG_COMP_MODE_TRAD &&
>> > +                   comp_mode == ADS1015_CFG_COMP_MODE_WINDOW)
>> > +           return 0;
>> > +
>> > +   ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
>> > +                           ADS1015_CFG_COMP_QUE_MASK,
>> > +                           ADS1015_CFG_COMP_DISABLE <<
>> > +                                   ADS1015_CFG_COMP_QUE_SHIFT);
>> > +   if (ret)
>> > +           return ret;
>> > +
>> > +   ads1015_event_channel_disable(data, chan->address);
>> > +
>> > +   return ads1015_set_power_state(data, false);
>> > +}
>> > +
>> > +static int ads1015_write_event_config(struct iio_dev *indio_dev,
>> > +   const struct iio_chan_spec *chan, enum iio_event_type type,
>> > +   enum iio_event_direction dir, int state)
>> > +{
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +   int ret;
>> > +   int comp_mode = (dir == IIO_EV_DIR_EITHER) ?
>> > +           ADS1015_CFG_COMP_MODE_WINDOW : ADS1015_CFG_COMP_MODE_TRAD;
>> > +
>> > +   mutex_lock(&data->lock);
>> > +
>> > +   /* Prevent from enabling both buffer and event at a time */
>> > +   ret = iio_device_claim_direct_mode(indio_dev);
>> > +   if (ret) {
>> > +           mutex_unlock(&data->lock);
>> > +           return ret;
>> > +   }
>> > +
>> > +   if (state)
>> > +           ret = ads1015_enable_event_config(data, chan, comp_mode);
>> > +   else
>> > +           ret = ads1015_disable_event_config(data, chan, comp_mode);
>> > +
>> > +   iio_device_release_direct_mode(indio_dev);
>> > +   mutex_unlock(&data->lock);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static irqreturn_t ads1015_event_handler(int irq, void *priv)
>> > +{
>> > +   struct iio_dev *indio_dev = priv;
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +   int val;
>> > +
>> > +   /* Clear the latched ALERT/RDY pin */
>> > +   regmap_read(data->regmap, ADS1015_CONV_REG, &val);
>> error checking?  Obviously you can't do anything much with
>> the error, but you don't want to muddle through the rest
>> with it.
>> > +
>> > +   if (ads1015_event_channel_enabled(data)) {
>> > +           enum iio_event_direction dir;
>> > +           u64 code;
>> > +
>> > +           dir = data->comp_mode == ADS1015_CFG_COMP_MODE_TRAD ?
>> > +                                   IIO_EV_DIR_RISING : IIO_EV_DIR_EITHER;
>> > +           code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, data->event_channel,
>> > +                                   IIO_EV_TYPE_THRESH, dir);
>> > +           iio_push_event(indio_dev, code, iio_get_time_ns(indio_dev));
>> > +   }
>> > +
>> > +   return IRQ_HANDLED;
>> > +}
>> > +
>> >  static int ads1015_buffer_preenable(struct iio_dev *indio_dev)
>> >  {
>> > +   struct ads1015_data *data = iio_priv(indio_dev);
>> > +
>> > +   /* Prevent from enabling both buffer and event at a time */
>> > +   if (ads1015_event_channel_enabled(data))
>> > +           return -EBUSY;
>> > +
>> >     return ads1015_set_power_state(iio_priv(indio_dev), true);
>> >  }
>> >
>> > @@ -473,6 +821,10 @@ static const struct iio_info ads1015_info = {
>> >     .driver_module  = THIS_MODULE,
>> >     .read_raw       = ads1015_read_raw,
>> >     .write_raw      = ads1015_write_raw,
>> > +   .read_event_value = ads1015_read_event,
>> > +   .write_event_value = ads1015_write_event,
>> > +   .read_event_config = ads1015_read_event_config,
>> > +   .write_event_config = ads1015_write_event_config,
>> >     .attrs          = &ads1015_attribute_group,
>> >  };
>> >
>> > @@ -480,6 +832,10 @@ static const struct iio_info ads1115_info = {
>> >     .driver_module  = THIS_MODULE,
>> >     .read_raw       = ads1015_read_raw,
>> >     .write_raw      = ads1015_write_raw,
>> > +   .read_event_value = ads1015_read_event,
>> > +   .write_event_value = ads1015_write_event,
>> > +   .read_event_config = ads1015_read_event_config,
>> > +   .write_event_config = ads1015_write_event_config,
>> >     .attrs          = &ads1115_attribute_group,
>> >  };
>> >
>> > @@ -583,6 +939,7 @@ static int ads1015_probe(struct i2c_client *client,
>> >     struct ads1015_data *data;
>> >     int ret;
>> >     enum chip_ids chip;
>> > +   int i;
>> >
>> >     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> >     if (!indio_dev)
>> > @@ -617,6 +974,18 @@ static int ads1015_probe(struct i2c_client *client,
>> >             break;
>> >     }
>> >
>> > +   data->event_channel = ADS1015_CHANNELS;
>> > +   /*
>> > +    * Set default lower and upper threshold to min and max value
>> > +    * respectively.
>> > +    */
>> > +   for (i = 0; i < ADS1015_CHANNELS; i++) {
>> > +           int realbits = indio_dev->channels[i].scan_type.realbits;
>> > +
>> > +           data->thresh_data[i].low_thresh = -1 << (realbits - 1);
>> > +           data->thresh_data[i].high_thresh = (1 << (realbits - 1)) - 1;
>> > +   }
>> > +
>> >     /* we need to keep this ABI the same as used by hwmon ADS1015 driver */
>> >     ads1015_get_channels_config(client);
>> >
>> > @@ -634,6 +1003,39 @@ static int ads1015_probe(struct i2c_client *client,
>> >             return ret;
>> >     }
>> >
>> > +   if (client->irq) {
>> > +           unsigned long irq_trig =
>> > +                   irqd_get_trigger_type(irq_get_irq_data(client->irq));
>> > +           unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
>> > +                   ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
>> > +           unsigned int cfg_comp =
>> > +                   ADS1015_CFG_COMP_DISABLE << ADS1015_CFG_COMP_QUE_SHIFT |
>> > +                   1 << ADS1015_CFG_COMP_LAT_SHIFT;
>> > +
>> > +           switch (irq_trig) {
>> > +           case IRQF_TRIGGER_LOW:
>> > +                   cfg_comp |= ADS1015_CFG_COMP_POL_LOW;
>> > +                   break;
>> > +           case IRQF_TRIGGER_HIGH:
>> > +                   cfg_comp |= ADS1015_CFG_COMP_POL_HIGH;
>> > +                   break;
>> > +           default:
>> > +                   return -EINVAL;
>> > +           }
>> > +
>> > +           ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
>> > +                                   cfg_comp_mask, cfg_comp);
>> > +           if (ret)
>> > +                   return ret;
>> > +
>> > +           ret = devm_request_threaded_irq(&client->dev, client->irq,
>> > +                                           NULL, ads1015_event_handler,
>> > +                                           irq_trig | IRQF_ONESHOT,
>> > +                                           client->name, indio_dev);
>> > +           if (ret)
>> > +                   return ret;
>> > +   }
>> > +
>> >     ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
>> >     if (ret)
>> >             return ret;
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
