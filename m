Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:52077 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbbE1Nex (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 May 2015 09:34:53 -0400
Date: Thu, 28 May 2015 15:34:51 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: light: Add support for ROHM RPR0521 sensor
In-Reply-To: <CAEnQRZDioRjc0nLLncYitkjW7QyC4z+Ha6VE82h2RUScyXFx-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1505281507511.30008@pmeerw.net>
References: <1432810354-24745-1-git-send-email-daniel.baluta@intel.com> <alpine.DEB.2.02.1505281300180.30008@pmeerw.net> <CAEnQRZDioRjc0nLLncYitkjW7QyC4z+Ha6VE82h2RUScyXFx-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> +static const struct rpr0521_gain_info {
> >> +     u8 reg;
> >> +     u8 mask;
> >> +     u8 shift;
> >> +     int *gain;
> >
> > why not const int *?
> 
> Correct. Will fix.
> 
> >
> >> +     int size;
> >> +} rpr0521_gain[] = {
> >> +     [RPR0521_CHAN_ALS_DATA0] = {
> >> +             .reg    = RPR0521_REG_ALS_CTRL,
> >> +             .mask   = RPR0521_ALS_DATA0_GAIN_MASK,
> >> +             .shift  = RPR0521_ALS_DATA0_GAIN_SHIFT,
> >> +             .gain   = (int *)rpr0521_als_gain,

const int* would take care of the cast here as well

> >> +             .size   = ARRAY_SIZE(rpr0521_als_gain),
> >> +     },
> >> +     [RPR0521_CHAN_ALS_DATA1] = {
> >> +             .reg    = RPR0521_REG_ALS_CTRL,
> >> +             .mask   = RPR0521_ALS_DATA1_GAIN_MASK,
> >> +             .shift  = RPR0521_ALS_DATA1_GAIN_SHIFT,
> >> +             .gain   = (int *)rpr0521_als_gain,
> >> +             .size   = ARRAY_SIZE(rpr0521_als_gain),
> >> +     },
> >> +     [RPR0521_CHAN_PXS] = {
> >> +             .reg    = RPR0521_REG_PXS_CTRL,
> >> +             .mask   = RPR0521_PXS_GAIN_MASK,
> >> +             .shift  = RPR0521_PXS_GAIN_SHIFT,
> >> +             .gain   = (int *)rpr0521_pxs_gain,
> >> +             .size   = ARRAY_SIZE(rpr0521_pxs_gain),
> >> +     },
> >> +};
> >> +
> >> +struct rpr0521_data {
> >> +     struct i2c_client *client;
> >> +
> >> +     /* protect device params updates (e.g state, gain) */
> >> +     struct mutex lock;
> >> +
> >> +     /* device active status */
> >> +     bool als_dev_en;
> >> +     bool pxs_dev_en;
> >> +
> >> +     /* optimize runtime pm ops - enable device only if needed */
> >> +     bool als_ps_need_en;
> >> +     bool pxs_ps_need_en;
> >> +
> >> +     struct regmap *regmap;
> >> +};
> >> +
> >> +static const struct iio_chan_spec rpr0521_channels[] = {
> >> +     {
> >> +             .type = IIO_INTENSITY,
> >> +             .modified = 1,
> >> +             .address = RPR0521_CHAN_ALS_DATA0,
> >> +             .channel2 = IIO_MOD_LIGHT_BOTH,
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +                     BIT(IIO_CHAN_INFO_CALIBSCALE),
> >
> > why CALIBSCALE and not SCALE?
> 
> Because this is used to set/get gain, which is used by the hardware
> to do proper scaling.
> 
> AFAIK this should be calibscale.

in sysfs-bus-iiof on CALIBSCALE: Hardware applied calibration scale factor 
(assumed to fix production inaccuracies).

this doesn't seem applicable here, it is a gain factor controlling 
measurement resolution

> >
> >> +     },
> >> +     {
> >> +             .type = IIO_INTENSITY,
> >> +             .modified = 1,
> >> +             .address = RPR0521_CHAN_ALS_DATA1,
> >> +             .channel2 = IIO_MOD_LIGHT_IR,
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +                     BIT(IIO_CHAN_INFO_CALIBSCALE),
> >> +     },
> >> +     {
> >> +             .type = IIO_PROXIMITY,
> >> +             .address = RPR0521_CHAN_PXS,
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +                     BIT(IIO_CHAN_INFO_CALIBSCALE),
> >> +     }
> >> +};
> >> +
> >> +static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
> >> +{
> >> +     int ret;
> >> +
> >> +     ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
> >> +                              RPR0521_MODE_ALS_MASK,
> >> +                              status);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     data->als_dev_en = true;
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
> >> +{
> >> +     int ret;
> >> +
> >> +     ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
> >> +                              RPR0521_MODE_PXS_MASK,
> >> +                              status);
> >
> > status would fit on the line above?
> 
> Yes it looks so :). The same for als_enable.
> 
> >
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     data->pxs_dev_en = true;
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +/**
> >> + * rpr0521_set_power_state - handles runtime PM state and sensors enabled status
> >> + *
> >> + * @data: rpr0521 device private data
> >> + * @on: state to be set for devices in @device_mask
> >> + * @device_mask: bitmask specifying for which device we need to update @on state
> >> + *
> >> + * We rely on rpr0521_runtime_resume to enable our @device_mask devices, but
> >> + * if (for example) PXS was enabled (pxs_dev_en = true) by a previous call to
> >> + * rpr0521_runtime_resume and we want to enable ALS we MUST set ALS enable
> >> + * bit of RPR0521_REG_MODE_CTRL here because rpr0521_runtime_resume will not
> >> + * be called twice.
> >> + */
> >> +static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> >> +                                u8 device_mask)
> >> +{
> >> +#ifdef CONFIG_PM
> >> +     int ret;
> >> +     u8 update_mask = 0;
> >> +
> >> +     if (device_mask & RPR0521_MODE_ALS_MASK) {
> >> +             if (on && !data->als_ps_need_en && data->pxs_dev_en)
> >> +                     update_mask |= RPR0521_MODE_ALS_MASK;
> >> +             else
> >> +                     data->als_ps_need_en = on;
> >> +     }
> >> +
> >> +     if (device_mask & RPR0521_MODE_PXS_MASK) {
> >> +             if (on && !data->pxs_ps_need_en && data->als_dev_en)
> >> +                     update_mask |= RPR0521_MODE_PXS_MASK;
> >> +             else
> >> +                     data->pxs_ps_need_en = on;
> >> +     }
> >> +
> >> +     if (update_mask) {
> >> +             ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
> >> +                                      update_mask, update_mask);
> >> +             if (ret < 0)
> >> +                     return ret;
> >> +     }
> >> +
> >> +     if (on) {
> >> +             ret = pm_runtime_get_sync(&data->client->dev);
> >> +     } else {
> >> +             pm_runtime_mark_last_busy(&data->client->dev);
> >> +             ret = pm_runtime_put_autosuspend(&data->client->dev);
> >> +     }
> >> +     if (ret < 0) {
> >> +             dev_err(&data->client->dev,
> >> +                     "Failed: rpr0521_set_power_state for %d, ret %d\n",
> >> +                     on, ret);
> >> +             if (on)
> >> +                     pm_runtime_put_noidle(&data->client->dev);
> >> +
> >> +             return ret;
> >> +     }
> >> +#endif
> >> +     return 0;
> >> +}
> >> +
> >> +static int rpr0521_get_gain_index(int *gainv, int size, int gain)
> >> +{
> >> +     int i;
> >> +
> >> +     for (i = 0; i < size; i++)
> >> +             if (gain == gainv[i])
> >> +                     return i;
> >> +
> >> +     return -EINVAL;
> >> +}
> >> +
> >> +static int rpr0521_get_gain(struct rpr0521_data *data, int chan, int *val)
> >> +{
> >> +     int ret, reg, idx;
> >> +
> >> +     ret = regmap_read(data->regmap, rpr0521_gain[chan].reg, &reg);
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >> +     idx = (rpr0521_gain[chan].mask & reg) >> rpr0521_gain[chan].shift;
> >> +     *val = rpr0521_gain[chan].gain[idx];
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int rpr0521_set_gain(struct rpr0521_data *data, int chan, int val)
> >> +{
> >> +     int idx;
> >> +
> >> +     idx = rpr0521_get_gain_index(rpr0521_gain[chan].gain,
> >> +                                  rpr0521_gain[chan].size, val);
> >> +     if (idx < 0)
> >> +             return idx;
> >> +
> >> +     return regmap_update_bits(data->regmap, rpr0521_gain[chan].reg,
> >> +                               rpr0521_gain[chan].mask,
> >> +                               idx << rpr0521_gain[chan].shift);
> >> +}
> >> +
> >> +static int rpr0521_read_raw(struct iio_dev *indio_dev,
> >> +                         struct iio_chan_spec const *chan, int *val,
> >> +                         int *val2, long mask)
> >> +{
> >> +     struct rpr0521_data *data = iio_priv(indio_dev);
> >> +     int ret;
> >> +     u8 device_mask;
> >> +     __le16 raw_data;
> >> +
> >> +     switch (mask) {
> >> +     case IIO_CHAN_INFO_RAW:
> >> +             switch (chan->type) {
> >
> > could put the mask into _data_reg to avoid the switch
> Looks good. Then, here we'll only check for a valid chan->type?
> 
> if (chan->type != IIO_INTENSITY && chan->type != IIO_PROXIMITY)
>          return -EINVAL.
> 
> Or we can consider that the chan->type is always valid?

I'd think so; you also assume that chan->address is valid

I suggest to use chan->address to point to a table containing the
address and the mask

> 
> >
> >> +             case IIO_INTENSITY:
> >> +                     device_mask = RPR0521_MODE_ALS_MASK;
> >> +                     break;
> >> +             case IIO_PROXIMITY:
> >> +                     device_mask = RPR0521_MODE_PXS_MASK;
> >> +                     break;
> >> +             default:
> >> +                     return -EINVAL;
> >> +             }
> >> +             mutex_lock(&data->lock);
> >> +             ret = rpr0521_set_power_state(data, true, device_mask);
> >> +             if (ret < 0) {
> >> +                     mutex_unlock(&data->lock);
> >> +                     return ret;
> >> +             }
> >> +
> >> +             ret = regmap_bulk_read(data->regmap,
> >> +                                    rpr0521_data_reg[chan->address],
> >> +                                    &raw_data, 2);
> >> +             if (ret < 0) {
> >> +                     rpr0521_set_power_state(data, false, device_mask);
> >> +                     mutex_unlock(&data->lock);
> >> +                     return ret;
> >> +             }
> >> +
> >> +             ret = rpr0521_set_power_state(data, false, device_mask);
> >> +             mutex_unlock(&data->lock);
> >> +             if (ret < 0)
> >> +                     return ret;
> >> +
> >> +             *val = le16_to_cpu(raw_data);
> >> +             /*
> >> +              * proximity uses 12 bits, with bits 7:4 of PXS MSB DATA
> >> +              * being always zero. Also, proximity MUST be exposed as
> >> +              * a distance with lower values for closer objects.
> >
> > this matter hasn't been settled, all other proximity sensor drivers do it
> > the other way around
> 
> Which sensors? It means they do not agree with the ABI:
> 
> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L1131

that 'clarification' was added recently, 
614e8842ddf5502f0e781f91695bfbc1e1e1d9b6 (with 3.18)
"Proximity measurement .. by observing reflectivity"

high proximity <-> high reflectivity -- this is the reality of what most 
sensors output (including yours)

proximity and distance are opposite concepts;
high proximity <-> low distance, and vice versa

the distance part doesn't make sense in the ABI description

> >
> >> +              */
> >> +             if (chan->type == IIO_PROXIMITY)
> >> +                     *val = RPR0521_PXS_MAX_VAL - *val;
> >
> > really this should be _PROCESSED, not _RAW?
> 
> I understand and it makes sense. Anyhow, looking at
> drivers/iio/proximity/sx9500.c
> it seems to be using _RAW.
> 
> > how to handle it for buffered reads?
> 
> Not sure I understand this. Care to add more details :)?
 
> I would expect that for buffer mode we create an item with 12 realbits and
> 16 storage bits, and to copy the data from register to buffer.

in buffered mode we want to avoid manipulating the data (i.e. MAX_DATA - 
measurement_value)

since MAX_DATA is not exposed, user mode cannot do this computation and 
_RAW differs from the buffered output

(I assume that we want to have buffered output correspond to _RAW values)

> >> +     pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
> >> +     pm_runtime_use_autosuspend(&client->dev);
> >> +
> >> +     return 0;
> >
> > maybe some whitespace here
> >
> do you mean remove the new line? :)

add a newline if I predict Jonathan's perference correctly :)
 
-- 

Peter Meerwald
+43-664-2444418 (mobile)
