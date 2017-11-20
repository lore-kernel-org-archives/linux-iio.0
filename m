Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46286 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdKTBtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Nov 2017 20:49:04 -0500
MIME-Version: 1.0
In-Reply-To: <20171119144709.38b52103@archlinux>
References: <1510197177-9434-1-git-send-email-harinath922@gmail.com> <20171119144709.38b52103@archlinux>
From: harinath Nampally <harinath922@gmail.com>
Date: Sun, 19 Nov 2017 20:48:21 -0500
Message-ID: <CAAGUq_pvq3SGotMMNwiA_K0A7TT2NRcrXdNWOsOctH0nbf-qXg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: mma8452: Add single pulse/tap event detection
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alison Schofield <amsfield22@gmail.com>,
        Martin Kepplinger <martink@posteo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > This patch adds following related changes:
> > - defines pulse event related registers
> > - enables and handles single pulse interrupt for fxls8471
> > - handles IIO_EV_DIR_EITHER in read/write callbacks (because
> >   event direction for pulse is either rising or falling)
> > - configures read/write event value for pulse latency register
> >   using IIO_EV_INFO_HYSTERESIS
> > - adds multiple events like pulse and tranient event spec
> >   as elements of event_spec array named 'mma8452_accel_events'
> >
> > Except mma8653 chip all other chips like mma845x and
> > fxls8471 have single tap detection feature.
> > Tested thoroughly using iio_event_monitor application on
> > imx6ul-evk board which has fxls8471.
> >
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>
> The use of an either direction magnitude event is misleading.
> Tap detection requires a timed sequence of events - a rapid
> increase in acceleration followed by a rapid decrease.
Yes I agree.

> So.. I'd propose (and I want as much feedback on this as possible)
>
> IIO_EV_TYPE_TAP
>
> Then abuse iio_event_direction to specify single or double (the concept
> of direction doesn't really apply to these in that sense so we'd always
> have them set to none).
Sure, I think this would be very useful as there are lot of modern
accelerometers
with tap event support.

Thanks,
Harinath

On Sun, Nov 19, 2017 at 9:47 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed,  8 Nov 2017 22:12:57 -0500
> Harinath Nampally <harinath922@gmail.com> wrote:
>
>> This patch adds following related changes:
>> - defines pulse event related registers
>> - enables and handles single pulse interrupt for fxls8471
>> - handles IIO_EV_DIR_EITHER in read/write callbacks (because
>>   event direction for pulse is either rising or falling)
>> - configures read/write event value for pulse latency register
>>   using IIO_EV_INFO_HYSTERESIS
>> - adds multiple events like pulse and tranient event spec
>>   as elements of event_spec array named 'mma8452_accel_events'
>>
>> Except mma8653 chip all other chips like mma845x and
>> fxls8471 have single tap detection feature.
>> Tested thoroughly using iio_event_monitor application on
>> imx6ul-evk board which has fxls8471.
>>
>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>
> The use of an either direction magnitude event is misleading.
> Tap detection requires a timed sequence of events - a rapid
> increase in acceleration followed by a rapid decrease.
>
> I don't think we can fit tap detection into the existing
> event types (which is annoying but there we are).
>
> So.. I'd propose (and I want as much feedback on this as possible)
>
> IIO_EV_TYPE_TAP
>
> Then abuse iio_event_direction to specify single or double (the concept
> of direction doesn't really apply to these in that sense so we'd always
> have them set to none).
>
> The alternative would be to full out for an abstract representation of
> these events (like step detection) and define a channel type
> IIO_TAP then detect a change in the number of taps (IIO_DIR_NONE), but
> given we have directional taps we would need the modifier for that.
> Hence no means of describing whether it is a single or double tap
> short of burning channel taps.  I'm also not sure we want to
> remove the association with a particular sensor channel.
>
> Hence I think I prefer option 1 but would like other's input on this...
>
> Jonathan
>
>> ---
>>  drivers/iio/accel/mma8452.c | 156 ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 151 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 43c3a6b..36f1b56 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -72,6 +72,19 @@
>>  #define  MMA8452_TRANSIENT_THS_MASK          GENMASK(6, 0)
>>  #define MMA8452_TRANSIENT_COUNT                      0x20
>>  #define MMA8452_TRANSIENT_CHAN_SHIFT 1
>> +#define MMA8452_PULSE_CFG                    0x21
>> +#define MMA8452_PULSE_CFG_CHAN(chan)         BIT(chan * 2)
>> +#define MMA8452_PULSE_CFG_ELE                        BIT(6)
>> +#define MMA8452_PULSE_SRC                    0x22
>> +#define MMA8452_PULSE_SRC_XPULSE             BIT(4)
>> +#define MMA8452_PULSE_SRC_YPULSE             BIT(5)
>> +#define MMA8452_PULSE_SRC_ZPULSE             BIT(6)
>> +#define MMA8452_PULSE_THS                    0x23
>> +#define MMA8452_PULSE_THS_MASK                       GENMASK(6, 0)
>> +#define MMA8452_PULSE_COUNT                  0x26
>> +#define MMA8452_PULSE_CHAN_SHIFT             2
>> +#define MMA8452_PULSE_LTCY                   0x27
>> +
>>  #define MMA8452_CTRL_REG1                    0x2a
>>  #define  MMA8452_CTRL_ACTIVE                 BIT(0)
>>  #define  MMA8452_CTRL_DR_MASK                        GENMASK(5, 3)
>> @@ -91,6 +104,7 @@
>>
>>  #define  MMA8452_INT_DRDY                    BIT(0)
>>  #define  MMA8452_INT_FF_MT                   BIT(2)
>> +#define  MMA8452_INT_PULSE                   BIT(3)
>>  #define  MMA8452_INT_TRANS                   BIT(5)
>>
>>  #define MMA8451_DEVICE_ID                    0x1a
>> @@ -155,6 +169,16 @@ static const struct mma8452_event_regs trans_ev_regs = {
>>               .ev_count = MMA8452_TRANSIENT_COUNT,
>>  };
>>
>> +static const struct mma8452_event_regs pulse_ev_regs = {
>> +             .ev_cfg = MMA8452_PULSE_CFG,
>> +             .ev_cfg_ele = MMA8452_PULSE_CFG_ELE,
>> +             .ev_cfg_chan_shift = MMA8452_PULSE_CHAN_SHIFT,
>> +             .ev_src = MMA8452_PULSE_SRC,
>> +             .ev_ths = MMA8452_PULSE_THS,
>> +             .ev_ths_mask = MMA8452_PULSE_THS_MASK,
>> +             .ev_count = MMA8452_PULSE_COUNT,
>> +};
>> +
>>  /**
>>   * struct mma_chip_info - chip specific data
>>   * @chip_id:                 WHO_AM_I register's value
>> @@ -784,6 +808,14 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
>>               case IIO_EV_DIR_FALLING:
>>                       *ev_reg = &ff_mt_ev_regs;
>>                       return 0;
>> +             case IIO_EV_DIR_EITHER:
>> +                     if (!(data->chip_info->all_events
>> +                                     & MMA8452_INT_PULSE) ||
>> +                             !(data->chip_info->enabled_events
>> +                                     & MMA8452_INT_PULSE))
>> +                             return -EINVAL;
>> +                     *ev_reg = &pulse_ev_regs;
>> +                     return 0;
>>               default:
>>                       return -EINVAL;
>>               }
>> @@ -848,6 +880,25 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>>                               return ret;
>>               }
>>
>> +     case IIO_EV_INFO_HYSTERESIS:
>> +             if (!(data->chip_info->all_events & MMA8452_INT_PULSE) ||
>> +                     !(data->chip_info->enabled_events & MMA8452_INT_PULSE))
>> +                     return -EINVAL;
>> +
>> +             ret = i2c_smbus_read_byte_data(data->client,
>> +                                             MMA8452_PULSE_LTCY);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             power_mode = mma8452_get_power_mode(data);
>> +             if (power_mode < 0)
>> +                     return power_mode;
>> +
>> +             us = ret * mma8452_time_step_us[power_mode][
>> +                             mma8452_get_odr_index(data)];
>> +             *val = us / USEC_PER_SEC;
>> +             *val2 = us % USEC_PER_SEC;
>> +
>>               return IIO_VAL_INT_PLUS_MICRO;
>>
>>       default:
>> @@ -908,6 +959,24 @@ static int mma8452_write_event_value(struct iio_dev *indio_dev,
>>
>>               return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, reg);
>>
>> +     case IIO_EV_INFO_HYSTERESIS:
>> +             if (!(data->chip_info->all_events & MMA8452_INT_PULSE) ||
>> +                     !(data->chip_info->enabled_events & MMA8452_INT_PULSE))
>> +                     return -EINVAL;
>> +
>> +             ret = mma8452_get_power_mode(data);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             steps = (val * USEC_PER_SEC + val2) /
>> +                             mma8452_time_step_us[ret][
>> +                                     mma8452_get_odr_index(data)];
>> +
>> +             if (steps < 0 || steps > 0xff)
>> +                     return -EINVAL;
>> +
>> +             return mma8452_change_config(data, MMA8452_PULSE_LTCY, steps);
>> +
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -937,6 +1006,14 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>>
>>               return !!(ret & BIT(chan->scan_index +
>>                               ev_regs->ev_cfg_chan_shift));
>> +     case IIO_EV_DIR_EITHER:
>> +             ret = i2c_smbus_read_byte_data(data->client,
>> +                             ev_regs->ev_cfg);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             return !!(ret & BIT(chan->scan_index *
>> +                             ev_regs->ev_cfg_chan_shift));
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -988,6 +1065,25 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>>               val |= ev_regs->ev_cfg_ele;
>>
>>               return mma8452_change_config(data, ev_regs->ev_cfg, val);
>> +
>> +     case IIO_EV_DIR_EITHER:
>> +             val = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
>> +             if (val < 0)
>> +                     return val;
>> +
>> +             if (state) {
>> +                     val &= ~BIT(chan->scan_index *
>> +                                     ev_regs->ev_cfg_chan_shift);
>> +                     val |= BIT(chan->scan_index *
>> +                                     ev_regs->ev_cfg_chan_shift);
>> +             } else {
>> +                     val &= ~BIT(chan->scan_index *
>> +                                     ev_regs->ev_cfg_chan_shift);
>> +             }
>> +
>> +             val |= ev_regs->ev_cfg_ele;
>> +
>> +             return mma8452_change_config(data, ev_regs->ev_cfg, val);
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -1025,6 +1121,38 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>>                              ts);
>>  }
>>
>> +static void mma8452_pulse_interrupt(struct iio_dev *indio_dev)
>> +{
>> +     struct mma8452_data *data = iio_priv(indio_dev);
>> +     s64 ts = iio_get_time_ns(indio_dev);
>> +     int src;
>> +
>> +     src = i2c_smbus_read_byte_data(data->client, MMA8452_PULSE_SRC);
>> +     if (src < 0)
>> +             return;
>> +
>> +     if (src & MMA8452_PULSE_SRC_XPULSE)
>> +             iio_push_event(indio_dev,
>> +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>> +                                               IIO_EV_TYPE_MAG,
>> +                                               IIO_EV_DIR_EITHER),
>> +                            ts);
>> +
>> +     if (src & MMA8452_PULSE_SRC_YPULSE)
>> +             iio_push_event(indio_dev,
>> +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>> +                                               IIO_EV_TYPE_MAG,
>> +                                               IIO_EV_DIR_EITHER),
>> +                            ts);
>> +
>> +     if (src & MMA8452_PULSE_SRC_ZPULSE)
>> +             iio_push_event(indio_dev,
>> +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>> +                                               IIO_EV_TYPE_MAG,
>> +                                               IIO_EV_DIR_EITHER),
>> +                            ts);
>> +}
>> +
>>  static irqreturn_t mma8452_interrupt(int irq, void *p)
>>  {
>>       struct iio_dev *indio_dev = p;
>> @@ -1063,6 +1191,11 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>>               ret = IRQ_HANDLED;
>>       }
>>
>> +     if (src & MMA8452_INT_PULSE) {
>> +             mma8452_pulse_interrupt(indio_dev);
>> +             ret = IRQ_HANDLED;
>> +     }
>> +
>>       return ret;
>>  }
>>
>> @@ -1130,8 +1263,10 @@ static const struct iio_event_spec mma8652_freefall_event[] = {
>>       },
>>  };
>>
>> -static const struct iio_event_spec mma8452_transient_event[] = {
>> +
>> +static const struct iio_event_spec mma8452_accel_events[] = {
>>       {
>> +             //trasient event
>>               .type = IIO_EV_TYPE_MAG,
>>               .dir = IIO_EV_DIR_RISING,
>>               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> @@ -1139,6 +1274,15 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>>                                       BIT(IIO_EV_INFO_PERIOD) |
>>                                       BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB)
>>       },
>> +     {
>> +             //pulse event
>> +             .type = IIO_EV_TYPE_MAG,
>> +             .dir = IIO_EV_DIR_EITHER,
>> +             .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>> +                                     BIT(IIO_EV_INFO_PERIOD) |
>> +                                     BIT(IIO_EV_INFO_HYSTERESIS)
>> +     },
>>  };
>>
>>  static const struct iio_event_spec mma8452_motion_event[] = {
>> @@ -1202,8 +1346,8 @@ static struct attribute_group mma8452_event_attribute_group = {
>>               .shift = 16 - (bits), \
>>               .endianness = IIO_BE, \
>>       }, \
>> -     .event_spec = mma8452_transient_event, \
>> -     .num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>> +     .event_spec = mma8452_accel_events, \
>> +     .num_event_specs = ARRAY_SIZE(mma8452_accel_events), \
>>  }
>>
>>  #define MMA8652_CHANNEL(axis, idx, bits) { \
>> @@ -1368,9 +1512,11 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>>                */
>>               .all_events = MMA8452_INT_DRDY |
>>                                       MMA8452_INT_TRANS |
>> -                                     MMA8452_INT_FF_MT,
>> +                                     MMA8452_INT_FF_MT |
>> +                                     MMA8452_INT_PULSE,
>>               .enabled_events = MMA8452_INT_TRANS |
>> -                                     MMA8452_INT_FF_MT,
>> +                                     MMA8452_INT_FF_MT |
>> +                                     MMA8452_INT_PULSE,
>>       },
>>  };
>>
>
