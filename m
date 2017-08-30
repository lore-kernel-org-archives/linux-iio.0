Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33888 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdH3DB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2017 23:01:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAAGUq_ryozztz1B_-zuQ4SgR5Yh7Lznk=mrk7pd4YtDuScLyJw@mail.gmail.com>
References: <1503879782-11945-1-git-send-email-harinath922@gmail.com>
 <1699ec2db96b498478b95a3cbcfe73ca@posteo.de> <CAAGUq_ryozztz1B_-zuQ4SgR5Yh7Lznk=mrk7pd4YtDuScLyJw@mail.gmail.com>
From: harinath Nampally <harinath922@gmail.com>
Date: Tue, 29 Aug 2017 23:01:16 -0400
Message-ID: <CAAGUq_rMONY=upVapudHC+fpM2PQC-zUWnm9yJ4YCt4FQ_HjxQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: accel: mma8452: improvements to handle multiple events
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> We should never say "transient is for rising
> direction" or "ff_mt is for falling direction". any combination is fine.

Ok I agree that there is no hard and fast rule that "transient is for risin=
g
direction" or "ff_mt is for falling direction".
But in our case, datasheet for these chips define these events based on
acceleration magnitude rising or falling below a set threshold value.

For quick reference, below excerpts are from fxls8471 datasheet:
Motion Event: "When the acceleration exceeds a set threshold for a set
amount of time,
the motion interrupt is asserted."

Freefall event: "The detection of =E2=80=9CFreefall=E2=80=9D involves the m=
onitoring
of the X, Y, and Z axes
for the condition where the acceleration magnitude is below a
user-specified threshold
for a user-definable amount of time"

Transient event: "When the high-pass filter is bypassed, the
functionality becomes
similar to the motion-detection function; in this mode, acceleration
greater than
a programmable threshold is detected (along an axis)."

Therefore I think in this driver freefall event is defined as
'falling' event type and
motion event is defined as 'rising' event type and Transient is also define=
d as
'rising' event type.
 As you might already know that mma8562 and mma8563 doesn't have
transient event support
but they do have freefall and motion event support which are defined
as 'fall' and 'rise'
event types respectively. Please note in this driver, motion event is
enabled/configured only
for mma8652 and mma8653.
Therefore if I read/write sysfs node for 'rise' it should use the
FF_MT registers for mma8652 and mma853, but for all others like
mma8451, mma8452 and
mma8453 which has transient event support it picks the Transient
registers if enabled. Also please
note transient event is enabled(but not motion event) for mma8451,
mma8452 and mma8453.
The problem seems like we have two different events(motion and
transient) that are defined
as same event type 'rising' but in fact both motion and transient are
pretty much similar as they
both raise interrupt flag when the acceleration magnitude rises above
the threshold.
Only difference is transient event has its own event config registers
with High pass filter.
If HPF bypassed using config register transient event acts like motion
detection event.

That was my understanding but please correct me if I am wrong.

> Only freefall mode needs one fix: remembering to which set of registers t=
o fall back when
> disabling it.

I don't quite understand what you mean by 'to fall back when disabling
it'. Please elaborate. I would
appreciate if you could suggest your logic in the form of pseudo-code.
Thanks for your time

On Tue, Aug 29, 2017 at 10:55 PM, harinath Nampally
<harinath922@gmail.com> wrote:
>> We should never say "transient is for rising
>> direction" or "ff_mt is for falling direction". any combination is fine.
>
> Ok I agree that there is no hard and fast rule that "transient is for ris=
ing
> direction" or "ff_mt is for falling direction".
> But in our case, datasheet for these chips define these events based on
> acceleration magnitude rising or falling below a set threshold value.
>
> For quick reference, below excerpts are from fxls8471 datasheet:
> Motion Event: "When the acceleration exceeds a set threshold for a set
> amount of time,
> the motion interrupt is asserted."
>
> Freefall event: "The detection of =E2=80=9CFreefall=E2=80=9D involves the=
 monitoring of the
> X, Y, and Z axes
> for the condition where the acceleration magnitude is below a user-specif=
ied
> threshold
> for a user-definable amount of time"
>
> Transient event: "When the high-pass filter is bypassed, the functionalit=
y
> becomes
> similar to the motion-detection function; in this mode, acceleration grea=
ter
> than
> a programmable threshold is detected (along an axis)."
>
> Therefore I think in this driver freefall event is defined as 'falling'
> event type and
> motion event is defined as 'rising' event type and Transient is also defi=
ned
> as
> 'rising' event type.
>  As you might already know that mma8562 and mma8563 doesn't have transien=
t
> event support
> but they do have freefall and motion event support which are defined as
> 'fall' and 'rise'
> event types respectively. Please note in this driver, motion event is
> enabled/configured only
> for mma8652 and mma8653.
> Therefore if I read/write sysfs node for 'rise' it should use the
> FF_MT registers for mma8652 and mma853, but for all others like mma8451,
> mma8452 and
> mma8453 which has transient event support it picks the Transient register=
s
> if enabled. Also please
> note transient event is enabled(but not motion event) for mma8451, mma845=
2
> and mma8453.
> The problem seems like we have two different events(motion and transient)
> that are defined
> as same event type 'rising' but in fact both motion and transient are pre=
tty
> much similar as they
> both raise interrupt flag when the acceleration magnitude rises above the
> threshold.
> Only difference is transient event has its own event config registers wit=
h
> High pass filter.
> If HPF bypassed using config register transient event acts like motion
> detection event.
>
> That was my understanding but please correct me if I am wrong.
>
>> Only freefall mode needs one fix: remembering to which set of registers =
to
>> fall back when
>> disabling it.
>
> I don't quite understand what you mean by 'to fall back when disabling it=
'.
> Please elaborate. I would
> appreciate if you could suggest your logic in the form of pseudo-code.
> Thanks for your time
>
>
>
>
> On Mon, Aug 28, 2017 at 2:46 AM, Martin Kepplinger <martink@posteo.de>
> wrote:
>>
>> Am 28.08.2017 02:23 schrieb Harinath Nampally:
>>>
>>> This driver supports multiple devices like mma8653,
>>>     mma8652, mma8452, mma8453 and fxls8471. Almost all
>>>     these devices have more than one event.
>>>
>>>     Current driver design hardcodes the event specific
>>>     information, so only one event can be supported by this
>>>     driver at any given time.
>>>     Also current design doesn't have the flexibility to
>>>     add more events.
>>>
>>>     This patch improves by detaching the event related
>>>     information from chip_info struct,and based on channel
>>>     type and event direction the corresponding event
>>>     configuration registers are picked dynamically.
>>>     Hence both transient and freefall events can be
>>>     handled in read/write callbacks.
>>>
>>>     Changes are thoroughly tested on fxls8471 device on imx6UL
>>>     Eval board using iio_event_monitor user space program.
>>>
>>>     After this fix both Freefall and Transient events are
>>>     handled by the driver without any conflicts.
>>>
>>>     Changes since v4 -> v5
>>>     -Add supported_events and enabled_events
>>>      in chip_info structure so that devices(mma865x)
>>>      which has no support for transient event will
>>>      fallback to freefall event. Hence this patch changes
>>>      won't break for devices that can't support
>>>      transient events
>>>
>>>     Changes since v3 -> v4
>>>     -Add 'const struct ev_regs_accel_falling'
>>>     -Add 'const struct ev_regs_accel_rising'
>>>     -Refactor mma8452_get_event_regs function to
>>>      remove the fill in the struct and return above structs
>>>     -Condense the commit's subject message
>>>
>>>     Changes since v2 -> v3
>>>     -Fix typo in commit message
>>>     -Replace word 'Bugfix' with 'Improvements'
>>>     -Describe more accurate commit message
>>>     -Replace breaks with returns
>>>     -Initialise transient event threshold mask
>>>     -Remove unrelated change of IIO_ACCEL channel type
>>>      check in read/write event callbacks
>>>
>>>     Changes since v1 -> v2
>>>     -Fix indentations
>>>     -Remove unused fields in mma8452_event_regs struct
>>>     -Remove redundant return statement
>>>     -Remove unrelated changes like checkpatch.pl warning fixes
>>>
>>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>>> ---
>>>  drivers/iio/accel/mma8452.c | 349
>>> +++++++++++++++++++++++---------------------
>>>  1 file changed, 183 insertions(+), 166 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>>> index eb6e3dc..0a97e61b 100644
>>> --- a/drivers/iio/accel/mma8452.c
>>> +++ b/drivers/iio/accel/mma8452.c
>>> @@ -59,7 +59,9 @@
>>>  #define MMA8452_FF_MT_THS                      0x17
>>>  #define  MMA8452_FF_MT_THS_MASK                        0x7f
>>>  #define MMA8452_FF_MT_COUNT                    0x18
>>> +#define MMA8452_FF_MT_CHAN_SHIFT       3
>>>  #define MMA8452_TRANSIENT_CFG                  0x1d
>>> +#define  MMA8452_TRANSIENT_CFG_CHAN(chan)      BIT(chan + 1)
>>>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP         BIT(0)
>>>  #define  MMA8452_TRANSIENT_CFG_ELE             BIT(4)
>>>  #define MMA8452_TRANSIENT_SRC                  0x1e
>>> @@ -69,6 +71,7 @@
>>>  #define MMA8452_TRANSIENT_THS                  0x1f
>>>  #define  MMA8452_TRANSIENT_THS_MASK            GENMASK(6, 0)
>>>  #define MMA8452_TRANSIENT_COUNT                        0x20
>>> +#define MMA8452_TRANSIENT_CHAN_SHIFT 1
>>>  #define MMA8452_CTRL_REG1                      0x2a
>>>  #define  MMA8452_CTRL_ACTIVE                   BIT(0)
>>>  #define  MMA8452_CTRL_DR_MASK                  GENMASK(5, 3)
>>> @@ -107,6 +110,42 @@ struct mma8452_data {
>>>         const struct mma_chip_info *chip_info;
>>>  };
>>>
>>> + /**
>>> +  * struct mma8452_event_regs - chip specific data related to events
>>> +  * @ev_cfg:                   event config register address
>>> +  * @ev_src:                   event source register address
>>> +  * @ev_ths:                   event threshold register address
>>> +  * @ev_ths_mask:              mask for the threshold value
>>> +  * @ev_count:                 event count (period) register address
>>> +  *
>>> +  * Since not all chips supported by the driver support comparing high
>>> pass
>>> +  * filtered data for events (interrupts), different interrupt sources
>>> are
>>> +  * used for different chips and the relevant registers are included
>>> here.
>>> +  */
>>> +struct mma8452_event_regs {
>>> +               u8 ev_cfg;
>>> +               u8 ev_src;
>>> +               u8 ev_ths;
>>> +               u8 ev_ths_mask;
>>> +               u8 ev_count;
>>> +};
>>> +
>>> +static const struct mma8452_event_regs ev_regs_accel_falling =3D {
>>> +               .ev_cfg =3D MMA8452_FF_MT_CFG,
>>> +               .ev_src =3D MMA8452_FF_MT_SRC,
>>> +               .ev_ths =3D MMA8452_FF_MT_THS,
>>> +               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>>> +               .ev_count =3D MMA8452_FF_MT_COUNT
>>> +};
>>> +
>>> +static const struct mma8452_event_regs ev_regs_accel_rising =3D {
>>> +               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> +               .ev_src =3D MMA8452_TRANSIENT_SRC,
>>> +               .ev_ths =3D MMA8452_TRANSIENT_THS,
>>> +               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> +               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>>> +};
>>> +
>>>  /**
>>>   * struct mma_chip_info - chip specific data
>>>   * @chip_id:                   WHO_AM_I register's value
>>> @@ -116,40 +155,16 @@ struct mma8452_data {
>>>   * @mma_scales:                        scale factors for converting
>>> register values
>>>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 intege=
rs
>>>   *                             per mode: m/s^2 and micro m/s^2
>>> - * @ev_cfg:                    event config register address
>>> - * @ev_cfg_ele:                        latch bit in event config
>>> register
>>> - * @ev_cfg_chan_shift:         number of the bit to enable events in X
>>> - *                             direction; in event config register
>>> - * @ev_src:                    event source register address
>>> - * @ev_src_xe:                 bit in event source register that
>>> indicates
>>> - *                             an event in X direction
>>> - * @ev_src_ye:                 bit in event source register that
>>> indicates
>>> - *                             an event in Y direction
>>> - * @ev_src_ze:                 bit in event source register that
>>> indicates
>>> - *                             an event in Z direction
>>> - * @ev_ths:                    event threshold register address
>>> - * @ev_ths_mask:               mask for the threshold value
>>> - * @ev_count:                  event count (period) register address
>>> - *
>>> - * Since not all chips supported by the driver support comparing high
>>> pass
>>> - * filtered data for events (interrupts), different interrupt sources
>>> are
>>> - * used for different chips and the relevant registers are included
>>> here.
>>> + * @supported_events:          event flags supported by this chip
>>> + * @enabled_events:            event flags enabled and handled by this
>>> driver
>>>   */
>>>  struct mma_chip_info {
>>>         u8 chip_id;
>>>         const struct iio_chan_spec *channels;
>>>         int num_channels;
>>>         const int mma_scales[3][2];
>>> -       u8 ev_cfg;
>>> -       u8 ev_cfg_ele;
>>> -       u8 ev_cfg_chan_shift;
>>> -       u8 ev_src;
>>> -       u8 ev_src_xe;
>>> -       u8 ev_src_ye;
>>> -       u8 ev_src_ze;
>>> -       u8 ev_ths;
>>> -       u8 ev_ths_mask;
>>> -       u8 ev_count;
>>> +       int supported_events;
>>> +       int enabled_events;
>>>  };
>>>
>>>  enum {
>>> @@ -602,9 +617,8 @@ static int mma8452_set_power_mode(struct
>>> mma8452_data *data, u8 mode)
>>>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>>>  {
>>>         int val;
>>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>>
>>> -       val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +       val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CF=
G);
>>>         if (val < 0)
>>>                 return val;
>>>
>>> @@ -614,29 +628,28 @@ static int mma8452_freefall_mode_enabled(struct
>>> mma8452_data *data)
>>>  static int mma8452_set_freefall_mode(struct mma8452_data *data, bool
>>> state)
>>>  {
>>>         int val;
>>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>>
>>>         if ((state && mma8452_freefall_mode_enabled(data)) ||
>>>             (!state && !(mma8452_freefall_mode_enabled(data))))
>>>                 return 0;
>>>
>>> -       val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +       val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CF=
G);
>>>         if (val < 0)
>>>                 return val;
>>>
>>>         if (state) {
>>> -               val |=3D BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -               val |=3D BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -               val |=3D BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +               val |=3D BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +               val |=3D BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +               val |=3D BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>                 val &=3D ~MMA8452_FF_MT_CFG_OAE;
>>>         } else {
>>> -               val &=3D ~BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -               val &=3D ~BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -               val &=3D ~BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +               val &=3D ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +               val &=3D ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +               val &=3D ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>                 val |=3D MMA8452_FF_MT_CFG_OAE;
>>>         }
>>>
>>> -       return mma8452_change_config(data, chip->ev_cfg, val);
>>> +       return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
>>>  }
>>>
>>>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>>> @@ -740,6 +753,36 @@ static int mma8452_write_raw(struct iio_dev
>>> *indio_dev,
>>>         return ret;
>>>  }
>>>
>>> +static int mma8452_get_event_regs(struct mma8452_data *data,
>>> +               const struct iio_chan_spec *chan, enum
>>> iio_event_direction dir,
>>> +               const struct mma8452_event_regs **ev_reg)
>>> +{
>>> +       if (!chan)
>>> +               return -EINVAL;
>>> +
>>> +       switch (chan->type) {
>>> +       case IIO_ACCEL:
>>> +               switch (dir) {
>>> +               case IIO_EV_DIR_RISING:
>>> +                       if ((data->chip_info->supported_events
>>> +                                       & MMA8452_INT_TRANS) &&
>>> +                               (data->chip_info->enabled_events
>>> +                                       & MMA8452_INT_TRANS))
>>> +                               *ev_reg =3D &ev_regs_accel_rising;
>>> +                       else
>>> +                               *ev_reg =3D &ev_regs_accel_falling;
>>
>>
>> Not really intuitive. You see your semantic problem here. transient
>> registers
>> are just other kinds of events. We should never say "transient is for
>> rising
>> direction" or "ff_mt is for falling direction". any combination is fine.
>> Only freefall
>> mode needs one fix: remembering to which set of registers to fall back
>> when
>> disabling it.
>>
>>
>>> +                       return 0;
>>> +               case IIO_EV_DIR_FALLING:
>>> +                       *ev_reg =3D &ev_regs_accel_falling;
>>> +                       return 0;
>>> +               default:
>>> +                       return -EINVAL;
>>> +               }
>>> +       default:
>>> +               return -EINVAL;
>>> +       }
>>> +}
>>> +
>>>  static int mma8452_read_thresh(struct iio_dev *indio_dev,
>>>                                const struct iio_chan_spec *chan,
>>>                                enum iio_event_type type,
>>> @@ -749,21 +792,24 @@ static int mma8452_read_thresh(struct iio_dev
>>> *indio_dev,
>>>  {
>>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>>         int ret, us, power_mode;
>>> +       const struct mma8452_event_regs *ev_regs;
>>> +
>>> +       ret =3D mma8452_get_event_regs(data, chan, dir, &ev_regs);
>>> +       if (ret)
>>> +               return ret;
>>>
>>>         switch (info) {
>>>         case IIO_EV_INFO_VALUE:
>>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>>> -                                              data->chip_info->ev_ths)=
;
>>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>>> ev_regs->ev_ths);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> -               *val =3D ret & data->chip_info->ev_ths_mask;
>>> +               *val =3D ret & ev_regs->ev_ths_mask;
>>>
>>>                 return IIO_VAL_INT;
>>>
>>>         case IIO_EV_INFO_PERIOD:
>>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>>> -
>>> data->chip_info->ev_count);
>>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>>> ev_regs->ev_count);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> @@ -809,14 +855,18 @@ static int mma8452_write_thresh(struct iio_dev
>>> *indio_dev,
>>>  {
>>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>>         int ret, reg, steps;
>>> +       const struct mma8452_event_regs *ev_regs;
>>> +
>>> +       ret =3D mma8452_get_event_regs(data, chan, dir, &ev_regs);
>>> +       if (ret)
>>> +               return ret;
>>>
>>>         switch (info) {
>>>         case IIO_EV_INFO_VALUE:
>>> -               if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
>>> +               if (val < 0 || val > ev_regs->ev_ths_mask)
>>>                         return -EINVAL;
>>>
>>> -               return mma8452_change_config(data,
>>> data->chip_info->ev_ths,
>>> -                                            val);
>>> +               return mma8452_change_config(data, ev_regs->ev_ths, val=
);
>>>
>>>         case IIO_EV_INFO_PERIOD:
>>>                 ret =3D mma8452_get_power_mode(data);
>>> @@ -830,8 +880,7 @@ static int mma8452_write_thresh(struct iio_dev
>>> *indio_dev,
>>>                 if (steps < 0 || steps > 0xff)
>>>                         return -EINVAL;
>>>
>>> -               return mma8452_change_config(data,
>>> data->chip_info->ev_count,
>>> -                                            steps);
>>> +               return mma8452_change_config(data, ev_regs->ev_count,
>>> steps);
>>>
>>>         case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
>>>                 reg =3D i2c_smbus_read_byte_data(data->client,
>>> @@ -861,23 +910,18 @@ static int mma8452_read_event_config(struct
>>> iio_dev *indio_dev,
>>>                                      enum iio_event_direction dir)
>>>  {
>>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>>         int ret;
>>>
>>>         switch (dir) {
>>>         case IIO_EV_DIR_FALLING:
>>>                 return mma8452_freefall_mode_enabled(data);
>>>         case IIO_EV_DIR_RISING:
>>> -               if (mma8452_freefall_mode_enabled(data))
>>> -                       return 0;
>>> -
>>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>>> -                                              data->chip_info->ev_cfg)=
;
>>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>>> MMA8452_TRANSIENT_CFG);
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> -               return !!(ret & BIT(chan->scan_index +
>>> -                                   chip->ev_cfg_chan_shift));
>>> +               return !!(ret &
>>> MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index));
>>> +
>>>         default:
>>>                 return -EINVAL;
>>>         }
>>> @@ -890,7 +934,6 @@ static int mma8452_write_event_config(struct
>>> iio_dev *indio_dev,
>>>                                       int state)
>>>  {
>>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>>         int val, ret;
>>>
>>>         ret =3D mma8452_set_runtime_pm_state(data->client, state);
>>> @@ -901,28 +944,18 @@ static int mma8452_write_event_config(struct
>>> iio_dev *indio_dev,
>>>         case IIO_EV_DIR_FALLING:
>>>                 return mma8452_set_freefall_mode(data, state);
>>>         case IIO_EV_DIR_RISING:
>>> -               val =3D i2c_smbus_read_byte_data(data->client,
>>> chip->ev_cfg);
>>> +               val =3D i2c_smbus_read_byte_data(data->client,
>>> MMA8452_TRANSIENT_CFG);
>>>                 if (val < 0)
>>>                         return val;
>>>
>>> -               if (state) {
>>> -                       if (mma8452_freefall_mode_enabled(data)) {
>>> -                               val &=3D ~BIT(idx_x +
>>> chip->ev_cfg_chan_shift);
>>> -                               val &=3D ~BIT(idx_y +
>>> chip->ev_cfg_chan_shift);
>>> -                               val &=3D ~BIT(idx_z +
>>> chip->ev_cfg_chan_shift);
>>> -                               val |=3D MMA8452_FF_MT_CFG_OAE;
>>> -                       }
>>> -                       val |=3D BIT(chan->scan_index +
>>> chip->ev_cfg_chan_shift);
>>> -               } else {
>>> -                       if (mma8452_freefall_mode_enabled(data))
>>> -                               return 0;
>>> -
>>> -                       val &=3D ~BIT(chan->scan_index +
>>> chip->ev_cfg_chan_shift);
>>> -               }
>>> +               if (state)
>>> +                       val |=3D
>>> MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
>>> +               else
>>> +                       val &=3D
>>> ~MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
>>>
>>> -               val |=3D chip->ev_cfg_ele;
>>> +               val |=3D MMA8452_TRANSIENT_CFG_ELE;
>>>
>>> -               return mma8452_change_config(data, chip->ev_cfg, val);
>>> +               return mma8452_change_config(data, MMA8452_TRANSIENT_CF=
G,
>>> val);
>>>         default:
>>>                 return -EINVAL;
>>>         }
>>> @@ -934,35 +967,25 @@ static void mma8452_transient_interrupt(struct
>>> iio_dev *indio_dev)
>>>         s64 ts =3D iio_get_time_ns(indio_dev);
>>>         int src;
>>>
>>> -       src =3D i2c_smbus_read_byte_data(data->client,
>>> data->chip_info->ev_src);
>>> +       src =3D i2c_smbus_read_byte_data(data->client,
>>> MMA8452_TRANSIENT_SRC);
>>>         if (src < 0)
>>>                 return;
>>>
>>> -       if (mma8452_freefall_mode_enabled(data)) {
>>> -               iio_push_event(indio_dev,
>>> -                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> -                                                 IIO_MOD_X_AND_Y_AND_Z=
,
>>> -                                                 IIO_EV_TYPE_MAG,
>>> -                                                 IIO_EV_DIR_FALLING),
>>> -                              ts);
>>> -               return;
>>> -       }
>>> -
>>> -       if (src & data->chip_info->ev_src_xe)
>>> +       if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
>>>                 iio_push_event(indio_dev,
>>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> IIO_MOD_X,
>>>                                                   IIO_EV_TYPE_MAG,
>>>                                                   IIO_EV_DIR_RISING),
>>>                                ts);
>>>
>>> -       if (src & data->chip_info->ev_src_ye)
>>> +       if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
>>>                 iio_push_event(indio_dev,
>>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> IIO_MOD_Y,
>>>                                                   IIO_EV_TYPE_MAG,
>>>                                                   IIO_EV_DIR_RISING),
>>>                                ts);
>>>
>>> -       if (src & data->chip_info->ev_src_ze)
>>> +       if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
>>>                 iio_push_event(indio_dev,
>>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> IIO_MOD_Z,
>>>                                                   IIO_EV_TYPE_MAG,
>>> @@ -974,7 +997,6 @@ static irqreturn_t mma8452_interrupt(int irq, void
>>> *p)
>>>  {
>>>         struct iio_dev *indio_dev =3D p;
>>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>>         int ret =3D IRQ_NONE;
>>>         int src;
>>>
>>> @@ -982,15 +1004,29 @@ static irqreturn_t mma8452_interrupt(int irq, vo=
id
>>> *p)
>>>         if (src < 0)
>>>                 return IRQ_NONE;
>>>
>>> +       if (!(src & data->chip_info->enabled_events))
>>> +               return IRQ_NONE;
>>> +
>>>         if (src & MMA8452_INT_DRDY) {
>>>                 iio_trigger_poll_chained(indio_dev->trig);
>>>                 ret =3D IRQ_HANDLED;
>>>         }
>>>
>>> -       if ((src & MMA8452_INT_TRANS &&
>>> -            chip->ev_src =3D=3D MMA8452_TRANSIENT_SRC) ||
>>> -           (src & MMA8452_INT_FF_MT &&
>>> -            chip->ev_src =3D=3D MMA8452_FF_MT_SRC)) {
>>> +       if (src & MMA8452_INT_FF_MT) {
>>> +               if (mma8452_freefall_mode_enabled(data)) {
>>> +                       s64 ts =3D iio_get_time_ns(indio_dev);
>>> +
>>> +                       iio_push_event(indio_dev,
>>> +                                      IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> +
>>> IIO_MOD_X_AND_Y_AND_Z,
>>> +
>>> IIO_EV_TYPE_MAG,
>>> +
>>> IIO_EV_DIR_FALLING),
>>> +                                       ts);
>>> +               }
>>> +               ret =3D IRQ_HANDLED;
>>> +       }
>>> +
>>> +       if (src & MMA8452_INT_TRANS) {
>>>                 mma8452_transient_interrupt(indio_dev);
>>>                 ret =3D IRQ_HANDLED;
>>>         }
>>> @@ -1222,96 +1258,87 @@ static const struct mma_chip_info
>>> mma_chip_info_table[] =3D {
>>>                  *      g * N * 1000000 / 2048 for N =3D 2, 4, 8 and
>>> g=3D9.80665
>>>                  */
>>>                 .mma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 1,
>>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>>> +               /*
>>> +                * Although we enable the interrupt sources once and fo=
r
>>> +                * all here the event detection itself is not enabled
>>> until
>>> +                * userspace asks for it by mma8452_write_event_config(=
)
>>> +                */
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>>         },
>>>         [mma8452] =3D {
>>>                 .chip_id =3D MMA8452_DEVICE_ID,
>>>                 .channels =3D mma8452_channels,
>>>                 .num_channels =3D ARRAY_SIZE(mma8452_channels),
>>>                 .mma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 1,
>>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>>> +               /*
>>> +                * Although we enable the interrupt sources once and fo=
r
>>> +                * all here the event detection itself is not enabled
>>> until
>>> +                * userspace asks for it by mma8452_write_event_config(=
)
>>> +                */
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>>         },
>>>         [mma8453] =3D {
>>>                 .chip_id =3D MMA8453_DEVICE_ID,
>>>                 .channels =3D mma8453_channels,
>>>                 .num_channels =3D ARRAY_SIZE(mma8453_channels),
>>>                 .mma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} }=
,
>>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 1,
>>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>>> +               /*
>>> +                * Although we enable the interrupt sources once and fo=
r
>>> +                * all here the event detection itself is not enabled
>>> until
>>> +                * userspace asks for it by mma8452_write_event_config(=
)
>>> +                */
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>>         },
>>>         [mma8652] =3D {
>>>                 .chip_id =3D MMA8652_DEVICE_ID,
>>>                 .channels =3D mma8652_channels,
>>>                 .num_channels =3D ARRAY_SIZE(mma8652_channels),
>>>                 .mma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>>> -               .ev_cfg =3D MMA8452_FF_MT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 3,
>>> -               .ev_src =3D MMA8452_FF_MT_SRC,
>>> -               .ev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>>> -               .ev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>>> -               .ev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>>> -               .ev_ths =3D MMA8452_FF_MT_THS,
>>> -               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>>> -               .ev_count =3D MMA8452_FF_MT_COUNT,
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_FF_MT,
>>>         },
>>>         [mma8653] =3D {
>>>                 .chip_id =3D MMA8653_DEVICE_ID,
>>>                 .channels =3D mma8653_channels,
>>>                 .num_channels =3D ARRAY_SIZE(mma8653_channels),
>>>                 .mma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} }=
,
>>> -               .ev_cfg =3D MMA8452_FF_MT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 3,
>>> -               .ev_src =3D MMA8452_FF_MT_SRC,
>>> -               .ev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>>> -               .ev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>>> -               .ev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>>> -               .ev_ths =3D MMA8452_FF_MT_THS,
>>> -               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>>> -               .ev_count =3D MMA8452_FF_MT_COUNT,
>>> +               /*
>>> +                * Although we enable the interrupt sources once and fo=
r
>>> +                * all here the event detection itself is not enabled
>>> until
>>> +                * userspace asks for it by mma8452_write_event_config(=
)
>>> +                */
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_FF_MT,
>>>         },
>>>         [fxls8471] =3D {
>>>                 .chip_id =3D FXLS8471_DEVICE_ID,
>>>                 .channels =3D mma8451_channels,
>>>                 .num_channels =3D ARRAY_SIZE(mma8451_channels),
>>>                 .mma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -               .ev_cfg_chan_shift =3D 1,
>>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>>> +               /*
>>> +                * Although we enable the interrupt sources once and fo=
r
>>> +                * all here the event detection itself is not enabled
>>> until
>>> +                * userspace asks for it by mma8452_write_event_config(=
)
>>> +                */
>>> +               .supported_events =3D MMA8452_INT_DRDY |
>>> +                                       MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>> +               .enabled_events =3D MMA8452_INT_TRANS |
>>> +                                       MMA8452_INT_FF_MT,
>>>         },
>>>  };
>>>
>>> @@ -1509,16 +1536,6 @@ static int mma8452_probe(struct i2c_client
>>> *client,
>>>                 return ret;
>>>
>>>         if (client->irq) {
>>> -               /*
>>> -                * Although we enable the interrupt sources once and fo=
r
>>> -                * all here the event detection itself is not enabled
>>> until
>>> -                * userspace asks for it by mma8452_write_event_config(=
)
>>> -                */
>>> -               int supported_interrupts =3D MMA8452_INT_DRDY |
>>> -                                          MMA8452_INT_TRANS |
>>> -                                          MMA8452_INT_FF_MT;
>>> -               int enabled_interrupts =3D MMA8452_INT_TRANS |
>>> -                                        MMA8452_INT_FF_MT;
>>>                 int irq2;
>>>
>>>                 irq2 =3D of_irq_get_byname(client->dev.of_node, "INT2")=
;
>>> @@ -1528,7 +1545,7 @@ static int mma8452_probe(struct i2c_client *clien=
t,
>>>                 } else {
>>>                         ret =3D i2c_smbus_write_byte_data(client,
>>>
>>> MMA8452_CTRL_REG5,
>>> -
>>> supported_interrupts);
>>> +
>>> data->chip_info->supported_events);
>>>                         if (ret < 0)
>>>                                 return ret;
>>>
>>> @@ -1537,7 +1554,7 @@ static int mma8452_probe(struct i2c_client *clien=
t,
>>>
>>>                 ret =3D i2c_smbus_write_byte_data(client,
>>>                                                 MMA8452_CTRL_REG4,
>>> -                                               enabled_interrupts);
>>> +                                       data->chip_info->enabled_events=
);
>>>                 if (ret < 0)
>>>                         return ret;
>>
>>
>
