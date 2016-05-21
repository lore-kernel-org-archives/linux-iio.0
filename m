Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46599 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbcEUQui (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 12:50:38 -0400
Subject: Re: [PATCH v3] iio: adc: ti-ads1015: add support for ADS1115 part
To: Crt Mori <cmo@melexis.com>, Daniel Baluta <daniel.baluta@intel.com>
References: <1463375926-2146-1-git-send-email-matt.ranostay@intel.com>
 <CAEnQRZB20puqrkcAj6OLNQh6Okt9uwSWkoZqB2KT_yUjEScsLA@mail.gmail.com>
 <CAKv63utmuXjQHXWRj=Ufz5AsYQjSefvDNd27poQvEH7SG=EMdA@mail.gmail.com>
Cc: Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55281326-b77c-60bb-5c53-5ba0d48e4932@kernel.org>
Date: Sat, 21 May 2016 17:50:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv63utmuXjQHXWRj=Ufz5AsYQjSefvDNd27poQvEH7SG=EMdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/16 08:07, Crt Mori wrote:
> Acked-by: Crt Mori <cmo@melexis.com>
> 
> On 16 May 2016 at 14:15, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>
>> On Mon, May 16, 2016 at 8:18 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>>> TI ADS1115 is a 16-bit resolution ADC that is register map
>>> compatible with the ADS1015 device.
>>>
>>> Cc: daniel.baluta@intel.com
>>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>>
>> Looks good to me.
>>
>> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
>>
>>> ---
>>>  Changes from v2:
>>>  * Add missing ads1115 data rate values
>>>  * Allow support defining data rates per chip
>>>
>>>  drivers/iio/adc/ti-ads1015.c | 124 +++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 109 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>>> index 73cbf0b..a835423 100644
>>> --- a/drivers/iio/adc/ti-ads1015.c
>>> +++ b/drivers/iio/adc/ti-ads1015.c
>>> @@ -55,6 +55,11 @@
>>>  #define ADS1015_DEFAULT_DATA_RATE      4
>>>  #define ADS1015_DEFAULT_CHAN           0
>>>
>>> +enum {
>>> +       ADS1015,
>>> +       ADS1115,
>>> +};
>>> +
>>>  enum ads1015_channels {
>>>         ADS1015_AIN0_AIN1 = 0,
>>>         ADS1015_AIN0_AIN3,
>>> @@ -71,6 +76,10 @@ static const unsigned int ads1015_data_rate[] = {
>>>         128, 250, 490, 920, 1600, 2400, 3300, 3300
>>>  };
>>>
>>> +static const unsigned int ads1115_data_rate[] = {
>>> +       8, 16, 32, 64, 128, 250, 475, 860
>>> +};
>>> +
>>>  static const struct {
>>>         int scale;
>>>         int uscale;
>>> @@ -123,6 +132,42 @@ static const struct {
>>>         },                                                      \
>>>  }
>>>
>>> +#define ADS1115_V_CHAN(_chan, _addr) {                         \
>>> +       .type = IIO_VOLTAGE,                                    \
>>> +       .indexed = 1,                                           \
>>> +       .address = _addr,                                       \
>>> +       .channel = _chan,                                       \
>>> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>>> +                               BIT(IIO_CHAN_INFO_SCALE) |      \
>>> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>>> +       .scan_index = _addr,                                    \
>>> +       .scan_type = {                                          \
>>> +               .sign = 's',                                    \
>>> +               .realbits = 16,                                 \
>>> +               .storagebits = 16,                              \
>>> +               .endianness = IIO_CPU,                          \
>>> +       },                                                      \
>>> +}
>>> +
>>> +#define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
>>> +       .type = IIO_VOLTAGE,                                    \
>>> +       .differential = 1,                                      \
>>> +       .indexed = 1,                                           \
>>> +       .address = _addr,                                       \
>>> +       .channel = _chan,                                       \
>>> +       .channel2 = _chan2,                                     \
>>> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>>> +                               BIT(IIO_CHAN_INFO_SCALE) |      \
>>> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>>> +       .scan_index = _addr,                                    \
>>> +       .scan_type = {                                          \
>>> +               .sign = 's',                                    \
>>> +               .realbits = 16,                                 \
>>> +               .storagebits = 16,                              \
>>> +               .endianness = IIO_CPU,                          \
>>> +       },                                                      \
>>> +}
>>> +
>>>  struct ads1015_data {
>>>         struct regmap *regmap;
>>>         /*
>>> @@ -131,6 +176,8 @@ struct ads1015_data {
>>>          */
>>>         struct mutex lock;
>>>         struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
>>> +
>>> +       unsigned int *data_rate;
>>>  };
>>>
>>>  static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
>>> @@ -157,6 +204,18 @@ static const struct iio_chan_spec ads1015_channels[] = {
>>>         IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>>>  };
>>>
>>> +static const struct iio_chan_spec ads1115_channels[] = {
>>> +       ADS1115_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
>>> +       ADS1115_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3),
>>> +       ADS1115_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3),
>>> +       ADS1115_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3),
>>> +       ADS1115_V_CHAN(0, ADS1015_AIN0),
>>> +       ADS1115_V_CHAN(1, ADS1015_AIN1),
>>> +       ADS1115_V_CHAN(2, ADS1015_AIN2),
>>> +       ADS1115_V_CHAN(3, ADS1015_AIN3),
>>> +       IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
>>> +};
>>> +
>>>  static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>>>  {
>>>         int ret;
>>> @@ -196,7 +255,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>>>                 return ret;
>>>
>>>         if (change) {
>>> -               conv_time = DIV_ROUND_UP(USEC_PER_SEC, ads1015_data_rate[dr]);
>>> +               conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
>>>                 usleep_range(conv_time, conv_time + 1);
>>>         }
>>>
>>> @@ -263,7 +322,7 @@ static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
>>>         int i, ret, rindex = -1;
>>>
>>>         for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
>>> -               if (ads1015_data_rate[i] == rate) {
>>> +               if (data->data_rate[i] == rate) {
>>>                         rindex = i;
>>>                         break;
>>>                 }
>>> @@ -291,7 +350,9 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>>>         mutex_lock(&indio_dev->mlock);
>>>         mutex_lock(&data->lock);
>>>         switch (mask) {
>>> -       case IIO_CHAN_INFO_RAW:
>>> +       case IIO_CHAN_INFO_RAW: {
>>> +               int shift = chan->scan_type.shift;
>>> +
>>>                 if (iio_buffer_enabled(indio_dev)) {
>>>                         ret = -EBUSY;
>>>                         break;
>>> @@ -307,8 +368,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>>>                         break;
>>>                 }
>>>
>>> -               /* 12 bit res, D0 is bit 4 in conversion register */
>>> -               *val = sign_extend32(*val >> 4, 11);
>>> +               *val = sign_extend32(*val >> shift, 15 - shift);
>>>
>>>                 ret = ads1015_set_power_state(data, false);
>>>                 if (ret < 0)
>>> @@ -316,6 +376,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>>>
>>>                 ret = IIO_VAL_INT;
>>>                 break;
>>> +       }
>>>         case IIO_CHAN_INFO_SCALE:
>>>                 idx = data->channel_data[chan->address].pga;
>>>                 *val = ads1015_scale[idx].scale;
>>> @@ -324,7 +385,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>>>                 break;
>>>         case IIO_CHAN_INFO_SAMP_FREQ:
>>>                 idx = data->channel_data[chan->address].data_rate;
>>> -               *val = ads1015_data_rate[idx];
>>> +               *val = data->data_rate[idx];
>>>                 ret = IIO_VAL_INT;
>>>                 break;
>>>         default:
>>> @@ -380,12 +441,15 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
>>>  };
>>>
>>>  static IIO_CONST_ATTR(scale_available, "3 2 1 0.5 0.25 0.125");
>>> -static IIO_CONST_ATTR(sampling_frequency_available,
>>> -                     "128 250 490 920 1600 2400 3300");
>>> +
>>> +static IIO_CONST_ATTR_NAMED(ads1015_sampling_frequency_available,
>>> +       sampling_frequency_available, "128 250 490 920 1600 2400 3300");
>>> +static IIO_CONST_ATTR_NAMED(ads1115_sampling_frequency_available,
>>> +       sampling_frequency_available, "8 16 32 64 128 250 475 860");
>>>
>>>  static struct attribute *ads1015_attributes[] = {
>>>         &iio_const_attr_scale_available.dev_attr.attr,
>>> -       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> +       &iio_const_attr_ads1015_sampling_frequency_available.dev_attr.attr,
>>>         NULL,
>>>  };
>>>
>>> @@ -393,11 +457,28 @@ static const struct attribute_group ads1015_attribute_group = {
>>>         .attrs = ads1015_attributes,
>>>  };
>>>
>>> -static const struct iio_info ads1015_info = {
>>> +static struct attribute *ads1115_attributes[] = {
>>> +       &iio_const_attr_scale_available.dev_attr.attr,
>>> +       &iio_const_attr_ads1115_sampling_frequency_available.dev_attr.attr,
>>> +       NULL,
>>> +};
>>> +
>>> +static const struct attribute_group ads1115_attribute_group = {
>>> +       .attrs = ads1115_attributes,
>>> +};
>>> +
>>> +static struct iio_info ads1015_info = {
>>> +       .driver_module  = THIS_MODULE,
>>> +       .read_raw       = ads1015_read_raw,
>>> +       .write_raw      = ads1015_write_raw,
>>> +       .attrs          = &ads1015_attribute_group,
>>> +};
>>> +
>>> +static struct iio_info ads1115_info = {
>>>         .driver_module  = THIS_MODULE,
>>>         .read_raw       = ads1015_read_raw,
>>>         .write_raw      = ads1015_write_raw,
>>> -       .attrs          = &ads1015_attribute_group,
>>> +       .attrs          = &ads1115_attribute_group,
>>>  };
>>>
>>>  #ifdef CONFIG_OF
>>> @@ -500,12 +581,24 @@ static int ads1015_probe(struct i2c_client *client,
>>>         mutex_init(&data->lock);
>>>
>>>         indio_dev->dev.parent = &client->dev;
>>> -       indio_dev->info = &ads1015_info;
>>>         indio_dev->name = ADS1015_DRV_NAME;
>>> -       indio_dev->channels = ads1015_channels;
>>> -       indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
>>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>>
>>> +       switch (id->driver_data) {
>>> +       case ADS1015:
>>> +               indio_dev->channels = ads1015_channels;
>>> +               indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
>>> +               indio_dev->info = &ads1015_info;
>>> +               data->data_rate = (unsigned int *) &ads1015_data_rate;
>>> +               break;
>>> +       case ADS1115:
>>> +               indio_dev->channels = ads1115_channels;
>>> +               indio_dev->num_channels = ARRAY_SIZE(ads1115_channels);
>>> +               indio_dev->info = &ads1115_info;
>>> +               data->data_rate = (unsigned int *) &ads1115_data_rate;
>>> +               break;
>>> +       }
>>> +
>>>         /* we need to keep this ABI the same as used by hwmon ADS1015 driver */
>>>         ads1015_get_channels_config(client);
>>>
>>> @@ -590,7 +683,8 @@ static const struct dev_pm_ops ads1015_pm_ops = {
>>>  };
>>>
>>>  static const struct i2c_device_id ads1015_id[] = {
>>> -       {"ads1015", 0},
>>> +       {"ads1015", ADS1015},
>>> +       {"ads1115", ADS1115},
>>>         {}
>>>  };
>>>  MODULE_DEVICE_TABLE(i2c, ads1015_id);
>>> --
>>> 2.7.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

