Return-Path: <SRS0=9k/+=AA=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1699ec2db96b498478b95a3cbcfe73ca@posteo.de>
References: <1503879782-11945-1-git-send-email-harinath922@gmail.com> <1699ec2db96b498478b95a3cbcfe73ca@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Tue, 29 Aug 2017 22:55:50 -0400
Message-ID: <CAAGUq_ryozztz1B_-zuQ4SgR5Yh7Lznk=mrk7pd4YtDuScLyJw@mail.gmail.com>
Subject: Re: [PATCH v5] iio: accel: mma8452: improvements to handle multiple events
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: multipart/alternative; boundary="089e082384e8c404790557efac7f"
List-ID: <linux-iio@vger.kernel.org>

--089e082384e8c404790557efac7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
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
onitoring of the
X, Y, and Z axes
for the condition where the acceleration magnitude is below a
user-specified threshold
for a user-definable amount of time"

Transient event: "When the high-pass filter is bypassed, the functionality
becomes
similar to the motion-detection function; in this mode, acceleration
greater than
a programmable threshold is detected (along an axis)."

Therefore I think in this driver freefall event is defined as 'falling'
event type and
motion event is defined as 'rising' event type and Transient is also
defined as
'rising' event type.
 As you might already know that mma8562 and mma8563 doesn't have transient
event support
but they do have freefall and motion event support which are defined as
'fall' and 'rise'
event types respectively. Please note in this driver, motion event is
enabled/configured only
for mma8652 and mma8653.
Therefore if I read/write sysfs node for 'rise' it should use the
FF_MT registers for mma8652 and mma853, but for all others like mma8451,
mma8452 and
mma8453 which has transient event support it picks the Transient registers
if enabled. Also please
note transient event is enabled(but not motion event) for mma8451, mma8452
and mma8453.
The problem seems like we have two different events(motion and transient)
that are defined
as same event type 'rising' but in fact both motion and transient are
pretty much similar as they
both raise interrupt flag when the acceleration magnitude rises above the
threshold.
Only difference is transient event has its own event config registers with
High pass filter.
If HPF bypassed using config register transient event acts like motion
detection event.

That was my understanding but please correct me if I am wrong.

Only freefall mode needs one fix: remembering to which set of registers to
> fall back when
> disabling it.

I don't quite understand what you mean by 'to fall back when disabling it'.
Please elaborate. I would
appreciate if you could suggest your logic in the form of pseudo-code.
Thanks for your time




On Mon, Aug 28, 2017 at 2:46 AM, Martin Kepplinger <martink@posteo.de>
wrote:

> Am 28.08.2017 02:23 schrieb Harinath Nampally:
>
>> This driver supports multiple devices like mma8653,
>>     mma8652, mma8452, mma8453 and fxls8471. Almost all
>>     these devices have more than one event.
>>
>>     Current driver design hardcodes the event specific
>>     information, so only one event can be supported by this
>>     driver at any given time.
>>     Also current design doesn't have the flexibility to
>>     add more events.
>>
>>     This patch improves by detaching the event related
>>     information from chip_info struct,and based on channel
>>     type and event direction the corresponding event
>>     configuration registers are picked dynamically.
>>     Hence both transient and freefall events can be
>>     handled in read/write callbacks.
>>
>>     Changes are thoroughly tested on fxls8471 device on imx6UL
>>     Eval board using iio_event_monitor user space program.
>>
>>     After this fix both Freefall and Transient events are
>>     handled by the driver without any conflicts.
>>
>>     Changes since v4 -> v5
>>     -Add supported_events and enabled_events
>>      in chip_info structure so that devices(mma865x)
>>      which has no support for transient event will
>>      fallback to freefall event. Hence this patch changes
>>      won't break for devices that can't support
>>      transient events
>>
>>     Changes since v3 -> v4
>>     -Add 'const struct ev_regs_accel_falling'
>>     -Add 'const struct ev_regs_accel_rising'
>>     -Refactor mma8452_get_event_regs function to
>>      remove the fill in the struct and return above structs
>>     -Condense the commit's subject message
>>
>>     Changes since v2 -> v3
>>     -Fix typo in commit message
>>     -Replace word 'Bugfix' with 'Improvements'
>>     -Describe more accurate commit message
>>     -Replace breaks with returns
>>     -Initialise transient event threshold mask
>>     -Remove unrelated change of IIO_ACCEL channel type
>>      check in read/write event callbacks
>>
>>     Changes since v1 -> v2
>>     -Fix indentations
>>     -Remove unused fields in mma8452_event_regs struct
>>     -Remove redundant return statement
>>     -Remove unrelated changes like checkpatch.pl warning fixes
>>
>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>> ---
>>  drivers/iio/accel/mma8452.c | 349 +++++++++++++++++++++++-------
>> --------------
>>  1 file changed, 183 insertions(+), 166 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index eb6e3dc..0a97e61b 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -59,7 +59,9 @@
>>  #define MMA8452_FF_MT_THS                      0x17
>>  #define  MMA8452_FF_MT_THS_MASK                        0x7f
>>  #define MMA8452_FF_MT_COUNT                    0x18
>> +#define MMA8452_FF_MT_CHAN_SHIFT       3
>>  #define MMA8452_TRANSIENT_CFG                  0x1d
>> +#define  MMA8452_TRANSIENT_CFG_CHAN(chan)      BIT(chan + 1)
>>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP         BIT(0)
>>  #define  MMA8452_TRANSIENT_CFG_ELE             BIT(4)
>>  #define MMA8452_TRANSIENT_SRC                  0x1e
>> @@ -69,6 +71,7 @@
>>  #define MMA8452_TRANSIENT_THS                  0x1f
>>  #define  MMA8452_TRANSIENT_THS_MASK            GENMASK(6, 0)
>>  #define MMA8452_TRANSIENT_COUNT                        0x20
>> +#define MMA8452_TRANSIENT_CHAN_SHIFT 1
>>  #define MMA8452_CTRL_REG1                      0x2a
>>  #define  MMA8452_CTRL_ACTIVE                   BIT(0)
>>  #define  MMA8452_CTRL_DR_MASK                  GENMASK(5, 3)
>> @@ -107,6 +110,42 @@ struct mma8452_data {
>>         const struct mma_chip_info *chip_info;
>>  };
>>
>> + /**
>> +  * struct mma8452_event_regs - chip specific data related to events
>> +  * @ev_cfg:                   event config register address
>> +  * @ev_src:                   event source register address
>> +  * @ev_ths:                   event threshold register address
>> +  * @ev_ths_mask:              mask for the threshold value
>> +  * @ev_count:                 event count (period) register address
>> +  *
>> +  * Since not all chips supported by the driver support comparing high
>> pass
>> +  * filtered data for events (interrupts), different interrupt sources
>> are
>> +  * used for different chips and the relevant registers are included
>> here.
>> +  */
>> +struct mma8452_event_regs {
>> +               u8 ev_cfg;
>> +               u8 ev_src;
>> +               u8 ev_ths;
>> +               u8 ev_ths_mask;
>> +               u8 ev_count;
>> +};
>> +
>> +static const struct mma8452_event_regs ev_regs_accel_falling =3D {
>> +               .ev_cfg =3D MMA8452_FF_MT_CFG,
>> +               .ev_src =3D MMA8452_FF_MT_SRC,
>> +               .ev_ths =3D MMA8452_FF_MT_THS,
>> +               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>> +               .ev_count =3D MMA8452_FF_MT_COUNT
>> +};
>> +
>> +static const struct mma8452_event_regs ev_regs_accel_rising =3D {
>> +               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>> +               .ev_src =3D MMA8452_TRANSIENT_SRC,
>> +               .ev_ths =3D MMA8452_TRANSIENT_THS,
>> +               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>> +               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>> +};
>> +
>>  /**
>>   * struct mma_chip_info - chip specific data
>>   * @chip_id:                   WHO_AM_I register's value
>> @@ -116,40 +155,16 @@ struct mma8452_data {
>>   * @mma_scales:                        scale factors for converting
>> register values
>>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integer=
s
>>   *                             per mode: m/s^2 and micro m/s^2
>> - * @ev_cfg:                    event config register address
>> - * @ev_cfg_ele:                        latch bit in event config regist=
er
>> - * @ev_cfg_chan_shift:         number of the bit to enable events in X
>> - *                             direction; in event config register
>> - * @ev_src:                    event source register address
>> - * @ev_src_xe:                 bit in event source register that
>> indicates
>> - *                             an event in X direction
>> - * @ev_src_ye:                 bit in event source register that
>> indicates
>> - *                             an event in Y direction
>> - * @ev_src_ze:                 bit in event source register that
>> indicates
>> - *                             an event in Z direction
>> - * @ev_ths:                    event threshold register address
>> - * @ev_ths_mask:               mask for the threshold value
>> - * @ev_count:                  event count (period) register address
>> - *
>> - * Since not all chips supported by the driver support comparing high
>> pass
>> - * filtered data for events (interrupts), different interrupt sources a=
re
>> - * used for different chips and the relevant registers are included her=
e.
>> + * @supported_events:          event flags supported by this chip
>> + * @enabled_events:            event flags enabled and handled by this
>> driver
>>   */
>>  struct mma_chip_info {
>>         u8 chip_id;
>>         const struct iio_chan_spec *channels;
>>         int num_channels;
>>         const int mma_scales[3][2];
>> -       u8 ev_cfg;
>> -       u8 ev_cfg_ele;
>> -       u8 ev_cfg_chan_shift;
>> -       u8 ev_src;
>> -       u8 ev_src_xe;
>> -       u8 ev_src_ye;
>> -       u8 ev_src_ze;
>> -       u8 ev_ths;
>> -       u8 ev_ths_mask;
>> -       u8 ev_count;
>> +       int supported_events;
>> +       int enabled_events;
>>  };
>>
>>  enum {
>> @@ -602,9 +617,8 @@ static int mma8452_set_power_mode(struct
>> mma8452_data *data, u8 mode)
>>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>>  {
>>         int val;
>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>
>> -       val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>> +       val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG=
);
>>         if (val < 0)
>>                 return val;
>>
>> @@ -614,29 +628,28 @@ static int mma8452_freefall_mode_enabled(struct
>> mma8452_data *data)
>>  static int mma8452_set_freefall_mode(struct mma8452_data *data, bool
>> state)
>>  {
>>         int val;
>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>
>>         if ((state && mma8452_freefall_mode_enabled(data)) ||
>>             (!state && !(mma8452_freefall_mode_enabled(data))))
>>                 return 0;
>>
>> -       val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>> +       val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG=
);
>>         if (val < 0)
>>                 return val;
>>
>>         if (state) {
>> -               val |=3D BIT(idx_x + chip->ev_cfg_chan_shift);
>> -               val |=3D BIT(idx_y + chip->ev_cfg_chan_shift);
>> -               val |=3D BIT(idx_z + chip->ev_cfg_chan_shift);
>> +               val |=3D BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>> +               val |=3D BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>> +               val |=3D BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>                 val &=3D ~MMA8452_FF_MT_CFG_OAE;
>>         } else {
>> -               val &=3D ~BIT(idx_x + chip->ev_cfg_chan_shift);
>> -               val &=3D ~BIT(idx_y + chip->ev_cfg_chan_shift);
>> -               val &=3D ~BIT(idx_z + chip->ev_cfg_chan_shift);
>> +               val &=3D ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>> +               val &=3D ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>> +               val &=3D ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>                 val |=3D MMA8452_FF_MT_CFG_OAE;
>>         }
>>
>> -       return mma8452_change_config(data, chip->ev_cfg, val);
>> +       return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
>>  }
>>
>>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>> @@ -740,6 +753,36 @@ static int mma8452_write_raw(struct iio_dev
>> *indio_dev,
>>         return ret;
>>  }
>>
>> +static int mma8452_get_event_regs(struct mma8452_data *data,
>> +               const struct iio_chan_spec *chan, enum
>> iio_event_direction dir,
>> +               const struct mma8452_event_regs **ev_reg)
>> +{
>> +       if (!chan)
>> +               return -EINVAL;
>> +
>> +       switch (chan->type) {
>> +       case IIO_ACCEL:
>> +               switch (dir) {
>> +               case IIO_EV_DIR_RISING:
>> +                       if ((data->chip_info->supported_events
>> +                                       & MMA8452_INT_TRANS) &&
>> +                               (data->chip_info->enabled_events
>> +                                       & MMA8452_INT_TRANS))
>> +                               *ev_reg =3D &ev_regs_accel_rising;
>> +                       else
>> +                               *ev_reg =3D &ev_regs_accel_falling;
>>
>
> Not really intuitive. You see your semantic problem here. transient
> registers
> are just other kinds of events. We should never say "transient is for
> rising
> direction" or "ff_mt is for falling direction". any combination is fine.
> Only freefall
> mode needs one fix: remembering to which set of registers to fall back wh=
en
> disabling it.
>
>
> +                       return 0;
>> +               case IIO_EV_DIR_FALLING:
>> +                       *ev_reg =3D &ev_regs_accel_falling;
>> +                       return 0;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>  static int mma8452_read_thresh(struct iio_dev *indio_dev,
>>                                const struct iio_chan_spec *chan,
>>                                enum iio_event_type type,
>> @@ -749,21 +792,24 @@ static int mma8452_read_thresh(struct iio_dev
>> *indio_dev,
>>  {
>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>         int ret, us, power_mode;
>> +       const struct mma8452_event_regs *ev_regs;
>> +
>> +       ret =3D mma8452_get_event_regs(data, chan, dir, &ev_regs);
>> +       if (ret)
>> +               return ret;
>>
>>         switch (info) {
>>         case IIO_EV_INFO_VALUE:
>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>> -                                              data->chip_info->ev_ths);
>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>> ev_regs->ev_ths);
>>                 if (ret < 0)
>>                         return ret;
>>
>> -               *val =3D ret & data->chip_info->ev_ths_mask;
>> +               *val =3D ret & ev_regs->ev_ths_mask;
>>
>>                 return IIO_VAL_INT;
>>
>>         case IIO_EV_INFO_PERIOD:
>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>> -                                              data->chip_info->ev_count=
);
>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>> ev_regs->ev_count);
>>                 if (ret < 0)
>>                         return ret;
>>
>> @@ -809,14 +855,18 @@ static int mma8452_write_thresh(struct iio_dev
>> *indio_dev,
>>  {
>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>>         int ret, reg, steps;
>> +       const struct mma8452_event_regs *ev_regs;
>> +
>> +       ret =3D mma8452_get_event_regs(data, chan, dir, &ev_regs);
>> +       if (ret)
>> +               return ret;
>>
>>         switch (info) {
>>         case IIO_EV_INFO_VALUE:
>> -               if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
>> +               if (val < 0 || val > ev_regs->ev_ths_mask)
>>                         return -EINVAL;
>>
>> -               return mma8452_change_config(data,
>> data->chip_info->ev_ths,
>> -                                            val);
>> +               return mma8452_change_config(data, ev_regs->ev_ths, val)=
;
>>
>>         case IIO_EV_INFO_PERIOD:
>>                 ret =3D mma8452_get_power_mode(data);
>> @@ -830,8 +880,7 @@ static int mma8452_write_thresh(struct iio_dev
>> *indio_dev,
>>                 if (steps < 0 || steps > 0xff)
>>                         return -EINVAL;
>>
>> -               return mma8452_change_config(data,
>> data->chip_info->ev_count,
>> -                                            steps);
>> +               return mma8452_change_config(data, ev_regs->ev_count,
>> steps);
>>
>>         case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
>>                 reg =3D i2c_smbus_read_byte_data(data->client,
>> @@ -861,23 +910,18 @@ static int mma8452_read_event_config(struct
>> iio_dev *indio_dev,
>>                                      enum iio_event_direction dir)
>>  {
>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>         int ret;
>>
>>         switch (dir) {
>>         case IIO_EV_DIR_FALLING:
>>                 return mma8452_freefall_mode_enabled(data);
>>         case IIO_EV_DIR_RISING:
>> -               if (mma8452_freefall_mode_enabled(data))
>> -                       return 0;
>> -
>> -               ret =3D i2c_smbus_read_byte_data(data->client,
>> -                                              data->chip_info->ev_cfg);
>> +               ret =3D i2c_smbus_read_byte_data(data->client,
>> MMA8452_TRANSIENT_CFG);
>>                 if (ret < 0)
>>                         return ret;
>>
>> -               return !!(ret & BIT(chan->scan_index +
>> -                                   chip->ev_cfg_chan_shift));
>> +               return !!(ret & MMA8452_TRANSIENT_CFG_CHAN(cha
>> n->scan_index));
>> +
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -890,7 +934,6 @@ static int mma8452_write_event_config(struct
>> iio_dev *indio_dev,
>>                                       int state)
>>  {
>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>         int val, ret;
>>
>>         ret =3D mma8452_set_runtime_pm_state(data->client, state);
>> @@ -901,28 +944,18 @@ static int mma8452_write_event_config(struct
>> iio_dev *indio_dev,
>>         case IIO_EV_DIR_FALLING:
>>                 return mma8452_set_freefall_mode(data, state);
>>         case IIO_EV_DIR_RISING:
>> -               val =3D i2c_smbus_read_byte_data(data->client,
>> chip->ev_cfg);
>> +               val =3D i2c_smbus_read_byte_data(data->client,
>> MMA8452_TRANSIENT_CFG);
>>                 if (val < 0)
>>                         return val;
>>
>> -               if (state) {
>> -                       if (mma8452_freefall_mode_enabled(data)) {
>> -                               val &=3D ~BIT(idx_x +
>> chip->ev_cfg_chan_shift);
>> -                               val &=3D ~BIT(idx_y +
>> chip->ev_cfg_chan_shift);
>> -                               val &=3D ~BIT(idx_z +
>> chip->ev_cfg_chan_shift);
>> -                               val |=3D MMA8452_FF_MT_CFG_OAE;
>> -                       }
>> -                       val |=3D BIT(chan->scan_index +
>> chip->ev_cfg_chan_shift);
>> -               } else {
>> -                       if (mma8452_freefall_mode_enabled(data))
>> -                               return 0;
>> -
>> -                       val &=3D ~BIT(chan->scan_index +
>> chip->ev_cfg_chan_shift);
>> -               }
>> +               if (state)
>> +                       val |=3D MMA8452_TRANSIENT_CFG_CHAN(cha
>> n->scan_index);
>> +               else
>> +                       val &=3D ~MMA8452_TRANSIENT_CFG_CHAN(ch
>> an->scan_index);
>>
>> -               val |=3D chip->ev_cfg_ele;
>> +               val |=3D MMA8452_TRANSIENT_CFG_ELE;
>>
>> -               return mma8452_change_config(data, chip->ev_cfg, val);
>> +               return mma8452_change_config(data, MMA8452_TRANSIENT_CFG=
,
>> val);
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -934,35 +967,25 @@ static void mma8452_transient_interrupt(struct
>> iio_dev *indio_dev)
>>         s64 ts =3D iio_get_time_ns(indio_dev);
>>         int src;
>>
>> -       src =3D i2c_smbus_read_byte_data(data->client,
>> data->chip_info->ev_src);
>> +       src =3D i2c_smbus_read_byte_data(data->client,
>> MMA8452_TRANSIENT_SRC);
>>         if (src < 0)
>>                 return;
>>
>> -       if (mma8452_freefall_mode_enabled(data)) {
>> -               iio_push_event(indio_dev,
>> -                              IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>> -                                                 IIO_MOD_X_AND_Y_AND_Z,
>> -                                                 IIO_EV_TYPE_MAG,
>> -                                                 IIO_EV_DIR_FALLING),
>> -                              ts);
>> -               return;
>> -       }
>> -
>> -       if (src & data->chip_info->ev_src_xe)
>> +       if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
>>                 iio_push_event(indio_dev,
>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
X,
>>                                                   IIO_EV_TYPE_MAG,
>>                                                   IIO_EV_DIR_RISING),
>>                                ts);
>>
>> -       if (src & data->chip_info->ev_src_ye)
>> +       if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
>>                 iio_push_event(indio_dev,
>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
Y,
>>                                                   IIO_EV_TYPE_MAG,
>>                                                   IIO_EV_DIR_RISING),
>>                                ts);
>>
>> -       if (src & data->chip_info->ev_src_ze)
>> +       if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
>>                 iio_push_event(indio_dev,
>>                                IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_=
Z,
>>                                                   IIO_EV_TYPE_MAG,
>> @@ -974,7 +997,6 @@ static irqreturn_t mma8452_interrupt(int irq, void *=
p)
>>  {
>>         struct iio_dev *indio_dev =3D p;
>>         struct mma8452_data *data =3D iio_priv(indio_dev);
>> -       const struct mma_chip_info *chip =3D data->chip_info;
>>         int ret =3D IRQ_NONE;
>>         int src;
>>
>> @@ -982,15 +1004,29 @@ static irqreturn_t mma8452_interrupt(int irq, voi=
d
>> *p)
>>         if (src < 0)
>>                 return IRQ_NONE;
>>
>> +       if (!(src & data->chip_info->enabled_events))
>> +               return IRQ_NONE;
>> +
>>         if (src & MMA8452_INT_DRDY) {
>>                 iio_trigger_poll_chained(indio_dev->trig);
>>                 ret =3D IRQ_HANDLED;
>>         }
>>
>> -       if ((src & MMA8452_INT_TRANS &&
>> -            chip->ev_src =3D=3D MMA8452_TRANSIENT_SRC) ||
>> -           (src & MMA8452_INT_FF_MT &&
>> -            chip->ev_src =3D=3D MMA8452_FF_MT_SRC)) {
>> +       if (src & MMA8452_INT_FF_MT) {
>> +               if (mma8452_freefall_mode_enabled(data)) {
>> +                       s64 ts =3D iio_get_time_ns(indio_dev);
>> +
>> +                       iio_push_event(indio_dev,
>> +                                      IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>> +
>>  IIO_MOD_X_AND_Y_AND_Z,
>> +                                                         IIO_EV_TYPE_MA=
G,
>> +
>>  IIO_EV_DIR_FALLING),
>> +                                       ts);
>> +               }
>> +               ret =3D IRQ_HANDLED;
>> +       }
>> +
>> +       if (src & MMA8452_INT_TRANS) {
>>                 mma8452_transient_interrupt(indio_dev);
>>                 ret =3D IRQ_HANDLED;
>>         }
>> @@ -1222,96 +1258,87 @@ static const struct mma_chip_info
>> mma_chip_info_table[] =3D {
>>                  *      g * N * 1000000 / 2048 for N =3D 2, 4, 8 and
>> g=3D9.80665
>>                  */
>>                 .mma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 1,
>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>> +               /*
>> +                * Although we enable the interrupt sources once and for
>> +                * all here the event detection itself is not enabled
>> until
>> +                * userspace asks for it by mma8452_write_event_config()
>> +                */
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>>         },
>>         [mma8452] =3D {
>>                 .chip_id =3D MMA8452_DEVICE_ID,
>>                 .channels =3D mma8452_channels,
>>                 .num_channels =3D ARRAY_SIZE(mma8452_channels),
>>                 .mma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 1,
>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>> +               /*
>> +                * Although we enable the interrupt sources once and for
>> +                * all here the event detection itself is not enabled
>> until
>> +                * userspace asks for it by mma8452_write_event_config()
>> +                */
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>>         },
>>         [mma8453] =3D {
>>                 .chip_id =3D MMA8453_DEVICE_ID,
>>                 .channels =3D mma8453_channels,
>>                 .num_channels =3D ARRAY_SIZE(mma8453_channels),
>>                 .mma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} },
>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 1,
>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>> +               /*
>> +                * Although we enable the interrupt sources once and for
>> +                * all here the event detection itself is not enabled
>> until
>> +                * userspace asks for it by mma8452_write_event_config()
>> +                */
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>>         },
>>         [mma8652] =3D {
>>                 .chip_id =3D MMA8652_DEVICE_ID,
>>                 .channels =3D mma8652_channels,
>>                 .num_channels =3D ARRAY_SIZE(mma8652_channels),
>>                 .mma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>> -               .ev_cfg =3D MMA8452_FF_MT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 3,
>> -               .ev_src =3D MMA8452_FF_MT_SRC,
>> -               .ev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>> -               .ev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>> -               .ev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>> -               .ev_ths =3D MMA8452_FF_MT_THS,
>> -               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>> -               .ev_count =3D MMA8452_FF_MT_COUNT,
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_FF_MT,
>>         },
>>         [mma8653] =3D {
>>                 .chip_id =3D MMA8653_DEVICE_ID,
>>                 .channels =3D mma8653_channels,
>>                 .num_channels =3D ARRAY_SIZE(mma8653_channels),
>>                 .mma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} },
>> -               .ev_cfg =3D MMA8452_FF_MT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 3,
>> -               .ev_src =3D MMA8452_FF_MT_SRC,
>> -               .ev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>> -               .ev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>> -               .ev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>> -               .ev_ths =3D MMA8452_FF_MT_THS,
>> -               .ev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>> -               .ev_count =3D MMA8452_FF_MT_COUNT,
>> +               /*
>> +                * Although we enable the interrupt sources once and for
>> +                * all here the event detection itself is not enabled
>> until
>> +                * userspace asks for it by mma8452_write_event_config()
>> +                */
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_FF_MT,
>>         },
>>         [fxls8471] =3D {
>>                 .chip_id =3D FXLS8471_DEVICE_ID,
>>                 .channels =3D mma8451_channels,
>>                 .num_channels =3D ARRAY_SIZE(mma8451_channels),
>>                 .mma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>> -               .ev_cfg =3D MMA8452_TRANSIENT_CFG,
>> -               .ev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>> -               .ev_cfg_chan_shift =3D 1,
>> -               .ev_src =3D MMA8452_TRANSIENT_SRC,
>> -               .ev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>> -               .ev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>> -               .ev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>> -               .ev_ths =3D MMA8452_TRANSIENT_THS,
>> -               .ev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>> -               .ev_count =3D MMA8452_TRANSIENT_COUNT,
>> +               /*
>> +                * Although we enable the interrupt sources once and for
>> +                * all here the event detection itself is not enabled
>> until
>> +                * userspace asks for it by mma8452_write_event_config()
>> +                */
>> +               .supported_events =3D MMA8452_INT_DRDY |
>> +                                       MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>> +               .enabled_events =3D MMA8452_INT_TRANS |
>> +                                       MMA8452_INT_FF_MT,
>>         },
>>  };
>>
>> @@ -1509,16 +1536,6 @@ static int mma8452_probe(struct i2c_client *clien=
t,
>>                 return ret;
>>
>>         if (client->irq) {
>> -               /*
>> -                * Although we enable the interrupt sources once and for
>> -                * all here the event detection itself is not enabled
>> until
>> -                * userspace asks for it by mma8452_write_event_config()
>> -                */
>> -               int supported_interrupts =3D MMA8452_INT_DRDY |
>> -                                          MMA8452_INT_TRANS |
>> -                                          MMA8452_INT_FF_MT;
>> -               int enabled_interrupts =3D MMA8452_INT_TRANS |
>> -                                        MMA8452_INT_FF_MT;
>>                 int irq2;
>>
>>                 irq2 =3D of_irq_get_byname(client->dev.of_node, "INT2");
>> @@ -1528,7 +1545,7 @@ static int mma8452_probe(struct i2c_client *client=
,
>>                 } else {
>>                         ret =3D i2c_smbus_write_byte_data(client,
>>                                                         MMA8452_CTRL_REG=
5,
>> -
>>  supported_interrupts);
>> +                                       data->chip_info->supported_ev
>> ents);
>>                         if (ret < 0)
>>                                 return ret;
>>
>> @@ -1537,7 +1554,7 @@ static int mma8452_probe(struct i2c_client *client=
,
>>
>>                 ret =3D i2c_smbus_write_byte_data(client,
>>                                                 MMA8452_CTRL_REG4,
>> -                                               enabled_interrupts);
>> +                                       data->chip_info->enabled_events)=
;
>>                 if (ret < 0)
>>                         return ret;
>>
>
>

--089e082384e8c404790557efac7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPldlIHNob3VsZCBuZXZlciBzYXkgJnF1b3Q7dHJhbnNpZW50
IGlzIGZvciByaXNpbmc8YnI+ZGlyZWN0aW9uJnF1b3Q7IG9yICZxdW90O2ZmX210IGlzIGZvciBm
YWxsaW5nIGRpcmVjdGlvbiZxdW90Oy4gYW55IGNvbWJpbmF0aW9uIGlzIGZpbmUuPC9ibG9ja3F1
b3RlPjxkaXY+T2sgSSBhZ3JlZSB0aGF0IHRoZXJlIGlzIG5vIGhhcmQgYW5kIGZhc3QgcnVsZSB0
aGF0ICZxdW90O3RyYW5zaWVudCBpcyBmb3IgcmlzaW5nPC9kaXY+ZGlyZWN0aW9uJnF1b3Q7IG9y
ICZxdW90O2ZmX210IGlzIGZvciBmYWxsaW5nIGRpcmVjdGlvbiZxdW90Oy7CoDxkaXY+QnV0IGlu
IG91ciBjYXNlLCBkYXRhc2hlZXQgZm9yIHRoZXNlIGNoaXBzIGRlZmluZSB0aGVzZSBldmVudHMg
YmFzZWQgb27CoDwvZGl2PjxkaXY+YWNjZWxlcmF0aW9uIG1hZ25pdHVkZSByaXNpbmcgb3IgZmFs
bGluZyBiZWxvdyBhIHNldCB0aHJlc2hvbGQgdmFsdWUuPGRpdj48YnI+PGRpdj5Gb3IgcXVpY2sg
cmVmZXJlbmNlLCBiZWxvdyBleGNlcnB0cyBhcmUgZnJvbSBmeGxzODQ3MSBkYXRhc2hlZXQ6PC9k
aXY+PGRpdj5Nb3Rpb24gRXZlbnQ6ICZxdW90O1doZW4gdGhlIGFjY2VsZXJhdGlvbiBleGNlZWRz
IGENCnNldCB0aHJlc2hvbGQgZm9yIGEgc2V0IGFtb3VudCBvZiB0aW1lLMKgPC9kaXY+PGRpdj50
aGUgbW90aW9uIGludGVycnVwdCBpcyBhc3NlcnRlZC4mcXVvdDvCoDwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+RnJlZWZhbGwgZXZlbnQ6ICZxdW90O1RoZSBkZXRlY3Rpb24gb2Yg4oCcRnJlZWZh
bGzigJ0gaW52b2x2ZXMgdGhlIG1vbml0b3Jpbmcgb2YgdGhlIFgsIFksIGFuZCBaIGF4ZXPCoDwv
ZGl2PjxkaXY+Zm9yIHRoZSBjb25kaXRpb24gd2hlcmUgdGhlIGFjY2VsZXJhdGlvbiBtYWduaXR1
ZGUgaXMNCmJlbG93IGEgdXNlci1zcGVjaWZpZWQgdGhyZXNob2xkwqA8L2Rpdj48ZGl2PmZvciBh
IHVzZXItZGVmaW5hYmxlIGFtb3VudCBvZiB0aW1lJnF1b3Q7PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+VHJhbnNpZW50IGV2ZW50OiAmcXVvdDtXaGVuIHRoZSBoaWdoLXBhc3MgZmlsdGVy
IGlzIGJ5cGFzc2VkLCB0aGUgZnVuY3Rpb25hbGl0eSBiZWNvbWVzwqA8L2Rpdj48ZGl2PnNpbWls
YXIgdG8gdGhlIG1vdGlvbi1kZXRlY3Rpb24gZnVuY3Rpb247DQppbiB0aGlzIG1vZGUsIGFjY2Vs
ZXJhdGlvbiBncmVhdGVyIHRoYW7CoDwvZGl2PjxkaXY+YSBwcm9ncmFtbWFibGUgdGhyZXNob2xk
IGlzIGRldGVjdGVkIChhbG9uZyBhbiBheGlzKS4mcXVvdDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlRoZXJlZm9yZSBJIHRoaW5rIGluIHRoaXMgZHJpdmVyIGZyZWVmYWxsIGV2ZW50IGlzIGRl
ZmluZWQgYXMgJiMzOTtmYWxsaW5nJiMzOTsgZXZlbnQgdHlwZSBhbmQ8L2Rpdj48ZGl2Pm1vdGlv
biBldmVudCBpcyBkZWZpbmVkIGFzICYjMzk7cmlzaW5nJiMzOTsgZXZlbnQgdHlwZSBhbmQgVHJh
bnNpZW50IGlzIGFsc28gZGVmaW5lZCBhc8KgPC9kaXY+PGRpdj4mIzM5O3Jpc2luZyYjMzk7IGV2
ZW50IHR5cGUuIMKgPC9kaXY+PGRpdj7CoEFzIHlvdSBtaWdodCBhbHJlYWR5IGtub3cgdGhhdCBt
bWE4NTYyIGFuZCBtbWE4NTYzIGRvZXNuJiMzOTt0IGhhdmUgdHJhbnNpZW50IGV2ZW50IHN1cHBv
cnQ8L2Rpdj48ZGl2PmJ1dCB0aGV5IGRvIGhhdmUgZnJlZWZhbGwgYW5kIG1vdGlvbiBldmVudCBz
dXBwb3J0IHdoaWNoIGFyZSBkZWZpbmVkIGFzICYjMzk7ZmFsbCYjMzk7IGFuZCAmIzM5O3Jpc2Um
IzM5O8KgPC9kaXY+PGRpdj5ldmVudCB0eXBlcyByZXNwZWN0aXZlbHkuIFBsZWFzZSBub3RlIGlu
IHRoaXMgZHJpdmVyLCBtb3Rpb24gZXZlbnQgaXMgZW5hYmxlZC9jb25maWd1cmVkIG9ubHnCoDwv
ZGl2PjxkaXY+Zm9yIG1tYTg2NTIgYW5kIG1tYTg2NTMuPC9kaXY+PGRpdj5UaGVyZWZvcmUgaWYg
SSByZWFkL3dyaXRlIHN5c2ZzIG5vZGUgZm9yICYjMzk7cmlzZSYjMzk7IGl0IHNob3VsZCB1c2Ug
dGhlPGJyPjwvZGl2PjxkaXY+RkZfTVQgcmVnaXN0ZXJzIGZvciBtbWE4NjUyIGFuZCBtbWE4NTMs
IGJ1dCBmb3IgYWxsIG90aGVycyBsaWtlIG1tYTg0NTEsIG1tYTg0NTIgYW5kwqA8L2Rpdj48ZGl2
Pm1tYTg0NTMgd2hpY2ggaGFzIHRyYW5zaWVudCBldmVudCBzdXBwb3J0IGl0IHBpY2tzIHRoZSBU
cmFuc2llbnQgcmVnaXN0ZXJzIGlmIGVuYWJsZWQuIEFsc28gcGxlYXNlPC9kaXY+PGRpdj5ub3Rl
IHRyYW5zaWVudCBldmVudCBpcyBlbmFibGVkKGJ1dCBub3QgbW90aW9uIGV2ZW50KSBmb3IgbW1h
ODQ1MSwgbW1hODQ1MiBhbmQgbW1hODQ1My48L2Rpdj48ZGl2PlRoZSBwcm9ibGVtIHNlZW1zIGxp
a2Ugd2UgaGF2ZSB0d28gZGlmZmVyZW50IGV2ZW50cyhtb3Rpb24gYW5kIHRyYW5zaWVudCkgdGhh
dCBhcmUgZGVmaW5lZMKgPC9kaXY+PGRpdj5hcyBzYW1lIGV2ZW50IHR5cGUgJiMzOTtyaXNpbmcm
IzM5OyBidXQgaW4gZmFjdCBib3RoIG1vdGlvbiBhbmQgdHJhbnNpZW50IGFyZSBwcmV0dHkgbXVj
aCBzaW1pbGFyIGFzIHRoZXk8L2Rpdj48ZGl2PmJvdGggcmFpc2UgaW50ZXJydXB0IGZsYWcgd2hl
biB0aGUgYWNjZWxlcmF0aW9uIG1hZ25pdHVkZSByaXNlcyBhYm92ZSB0aGUgdGhyZXNob2xkLjwv
ZGl2PjxkaXY+T25seSBkaWZmZXJlbmNlIGlzIHRyYW5zaWVudCBldmVudCBoYXMgaXRzIG93biBl
dmVudCBjb25maWcgcmVnaXN0ZXJzIHdpdGggSGlnaCBwYXNzIGZpbHRlci7CoDwvZGl2PjxkaXY+
SWYgSFBGIGJ5cGFzc2VkIHVzaW5nIGNvbmZpZyByZWdpc3RlciB0cmFuc2llbnQgZXZlbnQgYWN0
cyBsaWtlIG1vdGlvbiBkZXRlY3Rpb24gZXZlbnQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5U
aGF0IHdhcyBteSB1bmRlcnN0YW5kaW5nIGJ1dCBwbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdy
b25nLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjhweCI+T25seSBmcmVlZmFsbMKgPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuOHB4
Ij5tb2RlIG5lZWRzIG9uZSBmaXg6IHJlbWVtYmVyaW5nIHRvIHdoaWNoIHNldCBvZiByZWdpc3Rl
cnMgdG8gZmFsbCBiYWNrIHdoZW48YnI+PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIu
OHB4Ij5kaXNhYmxpbmcgaXQuPC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2PkkgZG9uJiMzOTt0IHF1
aXRlIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiBieSAmIzM5OzxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTIuOHB4Ij50byBmYWxsIGJhY2vCoDwvc3Bhbj53aGVuIGRpc2FibGluZyBpdCYjMzk7LiBQ
bGVhc2UgZWxhYm9yYXRlLiBJIHdvdWxkwqA8L2Rpdj48ZGl2PmFwcHJlY2lhdGUgaWYgeW91IGNv
dWxkIHN1Z2dlc3QgeW91ciBsb2dpYyBpbiB0aGUgZm9ybSBvZiBwc2V1ZG8tY29kZS4gVGhhbmtz
IGZvciB5b3VyIHRpbWU8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIEF1ZyAyOCwgMjAxNyBhdCAyOjQ2IEFNLCBNYXJ0aW4g
S2VwcGxpbmdlciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzptYXJ0aW5rQHBv
c3Rlby5kZSIgdGFyZ2V0PSJfYmxhbmsiPm1hcnRpbmtAcG9zdGVvLmRlPC9hPiZndDs8L3NwYW4+
IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1Ij5BbSAyOC4wOC4yMDE3IDAyOjIzIHNj
aHJpZWIgSGFyaW5hdGggTmFtcGFsbHk6PGJyPg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+DQpUaGlzIGRyaXZlciBzdXBwb3J0cyBtdWx0aXBsZSBkZXZpY2Vz
IGxpa2UgbW1hODY1Myw8YnI+DQrCoCDCoCBtbWE4NjUyLCBtbWE4NDUyLCBtbWE4NDUzIGFuZCBm
eGxzODQ3MS4gQWxtb3N0IGFsbDxicj4NCsKgIMKgIHRoZXNlIGRldmljZXMgaGF2ZSBtb3JlIHRo
YW4gb25lIGV2ZW50Ljxicj4NCjxicj4NCsKgIMKgIEN1cnJlbnQgZHJpdmVyIGRlc2lnbiBoYXJk
Y29kZXMgdGhlIGV2ZW50IHNwZWNpZmljPGJyPg0KwqAgwqAgaW5mb3JtYXRpb24sIHNvIG9ubHkg
b25lIGV2ZW50IGNhbiBiZSBzdXBwb3J0ZWQgYnkgdGhpczxicj4NCsKgIMKgIGRyaXZlciBhdCBh
bnkgZ2l2ZW4gdGltZS48YnI+DQrCoCDCoCBBbHNvIGN1cnJlbnQgZGVzaWduIGRvZXNuJiMzOTt0
IGhhdmUgdGhlIGZsZXhpYmlsaXR5IHRvPGJyPg0KwqAgwqAgYWRkIG1vcmUgZXZlbnRzLjxicj4N
Cjxicj4NCsKgIMKgIFRoaXMgcGF0Y2ggaW1wcm92ZXMgYnkgZGV0YWNoaW5nIHRoZSBldmVudCBy
ZWxhdGVkPGJyPg0KwqAgwqAgaW5mb3JtYXRpb24gZnJvbSBjaGlwX2luZm8gc3RydWN0LGFuZCBi
YXNlZCBvbiBjaGFubmVsPGJyPg0KwqAgwqAgdHlwZSBhbmQgZXZlbnQgZGlyZWN0aW9uIHRoZSBj
b3JyZXNwb25kaW5nIGV2ZW50PGJyPg0KwqAgwqAgY29uZmlndXJhdGlvbiByZWdpc3RlcnMgYXJl
IHBpY2tlZCBkeW5hbWljYWxseS48YnI+DQrCoCDCoCBIZW5jZSBib3RoIHRyYW5zaWVudCBhbmQg
ZnJlZWZhbGwgZXZlbnRzIGNhbiBiZTxicj4NCsKgIMKgIGhhbmRsZWQgaW4gcmVhZC93cml0ZSBj
YWxsYmFja3MuPGJyPg0KPGJyPg0KwqAgwqAgQ2hhbmdlcyBhcmUgdGhvcm91Z2hseSB0ZXN0ZWQg
b24gZnhsczg0NzEgZGV2aWNlIG9uIGlteDZVTDxicj4NCsKgIMKgIEV2YWwgYm9hcmQgdXNpbmcg
aWlvX2V2ZW50X21vbml0b3IgdXNlciBzcGFjZSBwcm9ncmFtLjxicj4NCjxicj4NCsKgIMKgIEFm
dGVyIHRoaXMgZml4IGJvdGggRnJlZWZhbGwgYW5kIFRyYW5zaWVudCBldmVudHMgYXJlPGJyPg0K
wqAgwqAgaGFuZGxlZCBieSB0aGUgZHJpdmVyIHdpdGhvdXQgYW55IGNvbmZsaWN0cy48YnI+DQo8
YnI+DQrCoCDCoCBDaGFuZ2VzIHNpbmNlIHY0IC0mZ3Q7IHY1PGJyPg0KwqAgwqAgLUFkZCBzdXBw
b3J0ZWRfZXZlbnRzIGFuZCBlbmFibGVkX2V2ZW50czxicj4NCsKgIMKgIMKgaW4gY2hpcF9pbmZv
IHN0cnVjdHVyZSBzbyB0aGF0IGRldmljZXMobW1hODY1eCk8YnI+DQrCoCDCoCDCoHdoaWNoIGhh
cyBubyBzdXBwb3J0IGZvciB0cmFuc2llbnQgZXZlbnQgd2lsbDxicj4NCsKgIMKgIMKgZmFsbGJh
Y2sgdG8gZnJlZWZhbGwgZXZlbnQuIEhlbmNlIHRoaXMgcGF0Y2ggY2hhbmdlczxicj4NCsKgIMKg
IMKgd29uJiMzOTt0IGJyZWFrIGZvciBkZXZpY2VzIHRoYXQgY2FuJiMzOTt0IHN1cHBvcnQ8YnI+
DQrCoCDCoCDCoHRyYW5zaWVudCBldmVudHM8YnI+DQo8YnI+DQrCoCDCoCBDaGFuZ2VzIHNpbmNl
IHYzIC0mZ3Q7IHY0PGJyPg0KwqAgwqAgLUFkZCAmIzM5O2NvbnN0IHN0cnVjdCBldl9yZWdzX2Fj
Y2VsX2ZhbGxpbmcmIzM5Ozxicj4NCsKgIMKgIC1BZGQgJiMzOTtjb25zdCBzdHJ1Y3QgZXZfcmVn
c19hY2NlbF9yaXNpbmcmIzM5Ozxicj4NCsKgIMKgIC1SZWZhY3RvciBtbWE4NDUyX2dldF9ldmVu
dF9yZWdzIGZ1bmN0aW9uIHRvPGJyPg0KwqAgwqAgwqByZW1vdmUgdGhlIGZpbGwgaW4gdGhlIHN0
cnVjdCBhbmQgcmV0dXJuIGFib3ZlIHN0cnVjdHM8YnI+DQrCoCDCoCAtQ29uZGVuc2UgdGhlIGNv
bW1pdCYjMzk7cyBzdWJqZWN0IG1lc3NhZ2U8YnI+DQo8YnI+DQrCoCDCoCBDaGFuZ2VzIHNpbmNl
IHYyIC0mZ3Q7IHYzPGJyPg0KwqAgwqAgLUZpeCB0eXBvIGluIGNvbW1pdCBtZXNzYWdlPGJyPg0K
wqAgwqAgLVJlcGxhY2Ugd29yZCAmIzM5O0J1Z2ZpeCYjMzk7IHdpdGggJiMzOTtJbXByb3ZlbWVu
dHMmIzM5Ozxicj4NCsKgIMKgIC1EZXNjcmliZSBtb3JlIGFjY3VyYXRlIGNvbW1pdCBtZXNzYWdl
PGJyPg0KwqAgwqAgLVJlcGxhY2UgYnJlYWtzIHdpdGggcmV0dXJuczxicj4NCsKgIMKgIC1Jbml0
aWFsaXNlIHRyYW5zaWVudCBldmVudCB0aHJlc2hvbGQgbWFzazxicj4NCsKgIMKgIC1SZW1vdmUg
dW5yZWxhdGVkIGNoYW5nZSBvZiBJSU9fQUNDRUwgY2hhbm5lbCB0eXBlPGJyPg0KwqAgwqAgwqBj
aGVjayBpbiByZWFkL3dyaXRlIGV2ZW50IGNhbGxiYWNrczxicj4NCjxicj4NCsKgIMKgIENoYW5n
ZXMgc2luY2UgdjEgLSZndDsgdjI8YnI+DQrCoCDCoCAtRml4IGluZGVudGF0aW9uczxicj4NCsKg
IMKgIC1SZW1vdmUgdW51c2VkIGZpZWxkcyBpbiBtbWE4NDUyX2V2ZW50X3JlZ3Mgc3RydWN0PGJy
Pg0KwqAgwqAgLVJlbW92ZSByZWR1bmRhbnQgcmV0dXJuIHN0YXRlbWVudDxicj4NCsKgIMKgIC1S
ZW1vdmUgdW5yZWxhdGVkIGNoYW5nZXMgbGlrZSA8YSBocmVmPSJodHRwOi8vY2hlY2twYXRjaC5w
bCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Y2hlY2twYXRjaC5wbDwvYT4gd2Fy
bmluZyBmaXhlczxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IEhhcmluYXRoIE5hbXBhbGx5ICZs
dDs8YSBocmVmPSJtYWlsdG86aGFyaW5hdGg5MjJAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
aGFyaW5hdGg5MjJAZ21haWwuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGRyaXZlcnMvaWlv
L2FjY2VsL21tYTg0NTIuYyB8IDM0OSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS08d2Jy
Pi0tLS0tLS0tLS0tLS0tPGJyPg0KwqAxIGZpbGUgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyks
IDE2NiBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWNj
ZWwvbW1hODQ1Mi5jIGIvZHJpdmVycy9paW8vYWNjZWwvbW1hODQ1Mi5jPGJyPg0KaW5kZXggZWI2
ZTNkYy4uMGE5N2U2MWIgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9paW8vYWNjZWwvbW1hODQ1
Mi5jPGJyPg0KKysrIGIvZHJpdmVycy9paW8vYWNjZWwvbW1hODQ1Mi5jPGJyPg0KQEAgLTU5LDcg
KzU5LDkgQEA8YnI+DQrCoCNkZWZpbmUgTU1BODQ1Ml9GRl9NVF9USFPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAweDE3PGJyPg0KwqAjZGVmaW5lwqAgTU1BODQ1Ml9GRl9NVF9USFNf
TUFTS8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4N2Y8YnI+DQrCoCNkZWZp
bmUgTU1BODQ1Ml9GRl9NVF9DT1VOVMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MTg8
YnI+DQorI2RlZmluZSBNTUE4NDUyX0ZGX01UX0NIQU5fU0hJRlTCoCDCoCDCoCDCoDM8YnI+DQrC
oCNkZWZpbmUgTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
MHgxZDxicj4NCisjZGVmaW5lwqAgTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHX0NIQU4oY2hhPHdicj5u
KcKgIMKgIMKgIEJJVChjaGFuICsgMSk8YnI+DQrCoCNkZWZpbmXCoCBNTUE4NDUyX1RSQU5TSUVO
VF9DRkdfSFBGX0JZUMKgIMKgIMKgIMKgIMKgQklUKDApPGJyPg0KwqAjZGVmaW5lwqAgTU1BODQ1
Ml9UUkFOU0lFTlRfQ0ZHX0VMRcKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKDQpPGJyPg0KwqAjZGVm
aW5lIE1NQTg0NTJfVFJBTlNJRU5UX1NSQ8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MWU8
YnI+DQpAQCAtNjksNiArNzEsNyBAQDxicj4NCsKgI2RlZmluZSBNTUE4NDUyX1RSQU5TSUVOVF9U
SFPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDFmPGJyPg0KwqAjZGVmaW5lwqAgTU1BODQ1
Ml9UUkFOU0lFTlRfVEhTX01BU0vCoCDCoCDCoCDCoCDCoCDCoCBHRU5NQVNLKDYsIDApPGJyPg0K
wqAjZGVmaW5lIE1NQTg0NTJfVFJBTlNJRU5UX0NPVU5UwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMHgyMDxicj4NCisjZGVmaW5lIE1NQTg0NTJfVFJBTlNJRU5UX0NIQU5fU0hJ
RlQgMTxicj4NCsKgI2RlZmluZSBNTUE4NDUyX0NUUkxfUkVHMcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIDB4MmE8YnI+DQrCoCNkZWZpbmXCoCBNTUE4NDUyX0NUUkxfQUNUSVZFwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBCSVQoMCk8YnI+DQrCoCNkZWZpbmXCoCBNTUE4NDUy
X0NUUkxfRFJfTUFTS8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEdFTk1BU0soNSwgMyk8YnI+
DQpAQCAtMTA3LDYgKzExMCw0MiBAQCBzdHJ1Y3QgbW1hODQ1Ml9kYXRhIHs8YnI+DQrCoCDCoCDC
oCDCoCBjb25zdCBzdHJ1Y3QgbW1hX2NoaXBfaW5mbyAqY2hpcF9pbmZvOzxicj4NCsKgfTs8YnI+
DQo8YnI+DQorIC8qKjxicj4NCivCoCAqIHN0cnVjdCBtbWE4NDUyX2V2ZW50X3JlZ3MgLSBjaGlw
IHNwZWNpZmljIGRhdGEgcmVsYXRlZCB0byBldmVudHM8YnI+DQorwqAgKiBAZXZfY2ZnOsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXZlbnQgY29uZmlnIHJlZ2lzdGVyIGFkZHJlc3M8YnI+
DQorwqAgKiBAZXZfc3JjOsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXZlbnQgc291cmNl
IHJlZ2lzdGVyIGFkZHJlc3M8YnI+DQorwqAgKiBAZXZfdGhzOsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZXZlbnQgdGhyZXNob2xkIHJlZ2lzdGVyIGFkZHJlc3M8YnI+DQorwqAgKiBAZXZf
dGhzX21hc2s6wqAgwqAgwqAgwqAgwqAgwqAgwqAgbWFzayBmb3IgdGhlIHRocmVzaG9sZCB2YWx1
ZTxicj4NCivCoCAqIEBldl9jb3VudDrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGV2ZW50IGNv
dW50IChwZXJpb2QpIHJlZ2lzdGVyIGFkZHJlc3M8YnI+DQorwqAgKjxicj4NCivCoCAqIFNpbmNl
IG5vdCBhbGwgY2hpcHMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIgc3VwcG9ydCBjb21wYXJpbmcg
aGlnaCBwYXNzPGJyPg0KK8KgICogZmlsdGVyZWQgZGF0YSBmb3IgZXZlbnRzIChpbnRlcnJ1cHRz
KSwgZGlmZmVyZW50IGludGVycnVwdCBzb3VyY2VzIGFyZTxicj4NCivCoCAqIHVzZWQgZm9yIGRp
ZmZlcmVudCBjaGlwcyBhbmQgdGhlIHJlbGV2YW50IHJlZ2lzdGVycyBhcmUgaW5jbHVkZWQgaGVy
ZS48YnI+DQorwqAgKi88YnI+DQorc3RydWN0IG1tYTg0NTJfZXZlbnRfcmVncyB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdTggZXZfY2ZnOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHU4IGV2X3NyYzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1OCBldl90aHM7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdTggZXZfdGhzX21hc2s7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdTggZXZfY291bnQ7PGJyPg0KK307PGJyPg0KKzxicj4NCitzdGF0aWMg
Y29uc3Qgc3RydWN0IG1tYTg0NTJfZXZlbnRfcmVncyBldl9yZWdzX2FjY2VsX2ZhbGxpbmcgPSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NmZyA9IE1NQTg0NTJfRkZfTVRfQ0ZH
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmMgPSBNTUE4NDUyX0ZGX01UX1NS
Qyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfdGhzID0gTU1BODQ1Ml9GRl9NVF9U
SFMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3Roc19tYXNrID0gTU1BODQ1Ml9G
Rl9NVF9USFNfTUFTSyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY291bnQgPSBN
TUE4NDUyX0ZGX01UX0NPVU5UPGJyPg0KK307PGJyPg0KKzxicj4NCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IG1tYTg0NTJfZXZlbnRfcmVncyBldl9yZWdzX2FjY2VsX3Jpc2luZyA9IHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY2ZnID0gTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmMgPSBNTUE4NDUyX1RSQU5TSUVOVF9TUkMs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3RocyA9IE1NQTg0NTJfVFJBTlNJRU5U
X1RIUyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfdGhzX21hc2sgPSBNTUE4NDUy
X1RSQU5TSUVOVF9USFNfTUFTSyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY291
bnQgPSBNTUE4NDUyX1RSQU5TSUVOVF9DT1VOVCw8YnI+DQorfTs8YnI+DQorPGJyPg0KwqAvKio8
YnI+DQrCoCAqIHN0cnVjdCBtbWFfY2hpcF9pbmZvIC0gY2hpcCBzcGVjaWZpYyBkYXRhPGJyPg0K
wqAgKiBAY2hpcF9pZDrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFdIT19BTV9JIHJlZ2lz
dGVyJiMzOTtzIHZhbHVlPGJyPg0KQEAgLTExNiw0MCArMTU1LDE2IEBAIHN0cnVjdCBtbWE4NDUy
X2RhdGEgezxicj4NCsKgICogQG1tYV9zY2FsZXM6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc2NhbGUgZmFjdG9ycyBmb3IgY29udmVydGluZyByZWdpc3RlciB2YWx1ZXM8YnI+
DQrCoCAqwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0byBtL3Ne
MjsgMyBtb2RlczogMmcsIDRnLCA4ZzsgMiBpbnRlZ2Vyczxicj4NCsKgICrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBlciBtb2RlOiBtL3NeMiBhbmQgbWljcm8g
bS9zXjI8YnI+DQotICogQGV2X2NmZzrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBldmVu
dCBjb25maWcgcmVnaXN0ZXIgYWRkcmVzczxicj4NCi0gKiBAZXZfY2ZnX2VsZTrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXRjaCBiaXQgaW4gZXZlbnQgY29uZmlnIHJlZ2lz
dGVyPGJyPg0KLSAqIEBldl9jZmdfY2hhbl9zaGlmdDrCoCDCoCDCoCDCoCDCoG51bWJlciBvZiB0
aGUgYml0IHRvIGVuYWJsZSBldmVudHMgaW4gWDxicj4NCi0gKsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlyZWN0aW9uOyBpbiBldmVudCBjb25maWcgcmVnaXN0
ZXI8YnI+DQotICogQGV2X3NyYzrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBldmVudCBz
b3VyY2UgcmVnaXN0ZXIgYWRkcmVzczxicj4NCi0gKiBAZXZfc3JjX3hlOsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYml0IGluIGV2ZW50IHNvdXJjZSByZWdpc3RlciB0aGF0IGluZGljYXRlczxi
cj4NCi0gKsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYW4gZXZl
bnQgaW4gWCBkaXJlY3Rpb248YnI+DQotICogQGV2X3NyY195ZTrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJpdCBpbiBldmVudCBzb3VyY2UgcmVnaXN0ZXIgdGhhdCBpbmRpY2F0ZXM8YnI+DQot
ICrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFuIGV2ZW50IGlu
IFkgZGlyZWN0aW9uPGJyPg0KLSAqIEBldl9zcmNfemU6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBiaXQgaW4gZXZlbnQgc291cmNlIHJlZ2lzdGVyIHRoYXQgaW5kaWNhdGVzPGJyPg0KLSAqwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhbiBldmVudCBpbiBaIGRp
cmVjdGlvbjxicj4NCi0gKiBAZXZfdGhzOsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV2
ZW50IHRocmVzaG9sZCByZWdpc3RlciBhZGRyZXNzPGJyPg0KLSAqIEBldl90aHNfbWFzazrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgZm9yIHRoZSB0aHJlc2hvbGQgdmFsdWU8YnI+DQotICog
QGV2X2NvdW50OsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV2ZW50IGNvdW50IChwZXJpb2Qp
IHJlZ2lzdGVyIGFkZHJlc3M8YnI+DQotICo8YnI+DQotICogU2luY2Ugbm90IGFsbCBjaGlwcyBz
dXBwb3J0ZWQgYnkgdGhlIGRyaXZlciBzdXBwb3J0IGNvbXBhcmluZyBoaWdoIHBhc3M8YnI+DQot
ICogZmlsdGVyZWQgZGF0YSBmb3IgZXZlbnRzIChpbnRlcnJ1cHRzKSwgZGlmZmVyZW50IGludGVy
cnVwdCBzb3VyY2VzIGFyZTxicj4NCi0gKiB1c2VkIGZvciBkaWZmZXJlbnQgY2hpcHMgYW5kIHRo
ZSByZWxldmFudCByZWdpc3RlcnMgYXJlIGluY2x1ZGVkIGhlcmUuPGJyPg0KKyAqIEBzdXBwb3J0
ZWRfZXZlbnRzOsKgIMKgIMKgIMKgIMKgIGV2ZW50IGZsYWdzIHN1cHBvcnRlZCBieSB0aGlzIGNo
aXA8YnI+DQorICogQGVuYWJsZWRfZXZlbnRzOsKgIMKgIMKgIMKgIMKgIMKgIGV2ZW50IGZsYWdz
IGVuYWJsZWQgYW5kIGhhbmRsZWQgYnkgdGhpcyBkcml2ZXI8YnI+DQrCoCAqLzxicj4NCsKgc3Ry
dWN0IG1tYV9jaGlwX2luZm8gezxicj4NCsKgIMKgIMKgIMKgIHU4IGNoaXBfaWQ7PGJyPg0KwqAg
wqAgwqAgwqAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW5uZWxzOzxicj4NCsKgIMKg
IMKgIMKgIGludCBudW1fY2hhbm5lbHM7PGJyPg0KwqAgwqAgwqAgwqAgY29uc3QgaW50IG1tYV9z
Y2FsZXNbM11bMl07PGJyPg0KLcKgIMKgIMKgIMKgdTggZXZfY2ZnOzxicj4NCi3CoCDCoCDCoCDC
oHU4IGV2X2NmZ19lbGU7PGJyPg0KLcKgIMKgIMKgIMKgdTggZXZfY2ZnX2NoYW5fc2hpZnQ7PGJy
Pg0KLcKgIMKgIMKgIMKgdTggZXZfc3JjOzxicj4NCi3CoCDCoCDCoCDCoHU4IGV2X3NyY194ZTs8
YnI+DQotwqAgwqAgwqAgwqB1OCBldl9zcmNfeWU7PGJyPg0KLcKgIMKgIMKgIMKgdTggZXZfc3Jj
X3plOzxicj4NCi3CoCDCoCDCoCDCoHU4IGV2X3Roczs8YnI+DQotwqAgwqAgwqAgwqB1OCBldl90
aHNfbWFzazs8YnI+DQotwqAgwqAgwqAgwqB1OCBldl9jb3VudDs8YnI+DQorwqAgwqAgwqAgwqBp
bnQgc3VwcG9ydGVkX2V2ZW50czs8YnI+DQorwqAgwqAgwqAgwqBpbnQgZW5hYmxlZF9ldmVudHM7
PGJyPg0KwqB9Ozxicj4NCjxicj4NCsKgZW51bSB7PGJyPg0KQEAgLTYwMiw5ICs2MTcsOCBAQCBz
dGF0aWMgaW50IG1tYTg0NTJfc2V0X3Bvd2VyX21vZGUoc3RydWN0PGJyPg0KbW1hODQ1Ml9kYXRh
ICpkYXRhLCB1OCBtb2RlKTxicj4NCsKgc3RhdGljIGludCBtbWE4NDUyX2ZyZWVmYWxsX21vZGVf
ZW5hYmxlZCg8d2JyPnN0cnVjdCBtbWE4NDUyX2RhdGEgKmRhdGEpPGJyPg0KwqB7PGJyPg0KwqAg
wqAgwqAgwqAgaW50IHZhbDs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgbW1hX2NoaXBf
aW5mbyAqY2hpcCA9IGRhdGEtJmd0O2NoaXBfaW5mbzs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqB2
YWwgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoZGF0YS08d2JyPiZndDtjbGllbnQsIGNoaXAt
Jmd0O2V2X2NmZyk7PGJyPg0KK8KgIMKgIMKgIMKgdmFsID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9k
YXRhKGRhdGEtPHdicj4mZ3Q7Y2xpZW50LCBNTUE4NDUyX0ZGX01UX0NGRyk7PGJyPg0KwqAgwqAg
wqAgwqAgaWYgKHZhbCAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJu
IHZhbDs8YnI+DQo8YnI+DQpAQCAtNjE0LDI5ICs2MjgsMjggQEAgc3RhdGljIGludCBtbWE4NDUy
X2ZyZWVmYWxsX21vZGVfZW5hYmxlZCg8d2JyPnN0cnVjdDxicj4NCm1tYTg0NTJfZGF0YSAqZGF0
YSk8YnI+DQrCoHN0YXRpYyBpbnQgbW1hODQ1Ml9zZXRfZnJlZWZhbGxfbW9kZShzdHJ1PHdicj5j
dCBtbWE4NDUyX2RhdGEgKmRhdGEsIGJvb2wgc3RhdGUpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAg
wqAgaW50IHZhbDs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgbW1hX2NoaXBfaW5mbyAq
Y2hpcCA9IGRhdGEtJmd0O2NoaXBfaW5mbzs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAoKHN0
YXRlICZhbXA7JmFtcDsgbW1hODQ1Ml9mcmVlZmFsbF9tb2RlX2VuYWJsZWQoPHdicj5kYXRhKSkg
fHw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAoIXN0YXRlICZhbXA7JmFtcDsgIShtbWE4NDUyX2Zy
ZWVmYWxsX21vZGVfZW5hYmxlPHdicj5kKGRhdGEpKSkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0dXJuIDA7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgdmFsID0gaTJjX3NtYnVzX3Jl
YWRfYnl0ZV9kYXRhKGRhdGEtPHdicj4mZ3Q7Y2xpZW50LCBjaGlwLSZndDtldl9jZmcpOzxicj4N
CivCoCDCoCDCoCDCoHZhbCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShkYXRhLTx3YnI+Jmd0
O2NsaWVudCwgTU1BODQ1Ml9GRl9NVF9DRkcpOzxicj4NCsKgIMKgIMKgIMKgIGlmICh2YWwgJmx0
OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiB2YWw7PGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgaWYgKHN0YXRlKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFs
IHw9IEJJVChpZHhfeCArIGNoaXAtJmd0O2V2X2NmZ19jaGFuX3NoaWZ0KTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB2YWwgfD0gQklUKGlkeF95ICsgY2hpcC0mZ3Q7ZXZfY2ZnX2NoYW5f
c2hpZnQpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCB8PSBCSVQoaWR4X3ogKyBj
aGlwLSZndDtldl9jZmdfY2hhbl9zaGlmdCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dmFsIHw9IEJJVChpZHhfeCArIE1NQTg0NTJfRkZfTVRfQ0hBTl9TSElGVCk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgdmFsIHw9IEJJVChpZHhfeSArIE1NQTg0NTJfRkZfTVRfQ0hBTl9T
SElGVCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsIHw9IEJJVChpZHhfeiArIE1N
QTg0NTJfRkZfTVRfQ0hBTl9TSElGVCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdmFs
ICZhbXA7PSB+TU1BODQ1Ml9GRl9NVF9DRkdfT0FFOzxicj4NCsKgIMKgIMKgIMKgIH0gZWxzZSB7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsICZhbXA7PSB+QklUKGlkeF94ICsgY2hp
cC0mZ3Q7ZXZfY2ZnX2NoYW5fc2hpZnQpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZh
bCAmYW1wOz0gfkJJVChpZHhfeSArIGNoaXAtJmd0O2V2X2NmZ19jaGFuX3NoaWZ0KTs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgJmFtcDs9IH5CSVQoaWR4X3ogKyBjaGlwLSZndDtl
dl9jZmdfY2hhbl9zaGlmdCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsICZhbXA7
PSB+QklUKGlkeF94ICsgTU1BODQ1Ml9GRl9NVF9DSEFOX1NISUZUKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB2YWwgJmFtcDs9IH5CSVQoaWR4X3kgKyBNTUE4NDUyX0ZGX01UX0NIQU5f
U0hJRlQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCAmYW1wOz0gfkJJVChpZHhf
eiArIE1NQTg0NTJfRkZfTVRfQ0hBTl9TSElGVCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdmFsIHw9IE1NQTg0NTJfRkZfTVRfQ0ZHX09BRTs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0K
PGJyPg0KLcKgIMKgIMKgIMKgcmV0dXJuIG1tYTg0NTJfY2hhbmdlX2NvbmZpZyhkYXRhLCBjaGlw
LSZndDtldl9jZmcsIHZhbCk7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIG1tYTg0NTJfY2hhbmdl
X2NvbmZpZyhkYXRhLCBNTUE4NDUyX0ZGX01UX0NGRywgdmFsKTs8YnI+DQrCoH08YnI+DQo8YnI+
DQrCoHN0YXRpYyBpbnQgbW1hODQ1Ml9zZXRfaHBfZmlsdGVyX2ZyZXF1ZW5jPHdicj55KHN0cnVj
dCBtbWE4NDUyX2RhdGEgKmRhdGEsPGJyPg0KQEAgLTc0MCw2ICs3NTMsMzYgQEAgc3RhdGljIGlu
dCBtbWE4NDUyX3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LDxicj4NCsKgIMKg
IMKgIMKgIHJldHVybiByZXQ7PGJyPg0KwqB9PGJyPg0KPGJyPg0KK3N0YXRpYyBpbnQgbW1hODQ1
Ml9nZXRfZXZlbnRfcmVncyhzdHJ1Y3QgbW1hODQ1Ml9kYXRhICpkYXRhLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICpjaGFuLCBlbnVtIGlp
b19ldmVudF9kaXJlY3Rpb24gZGlyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0
IHN0cnVjdCBtbWE4NDUyX2V2ZW50X3JlZ3MgKipldl9yZWcpPGJyPg0KK3s8YnI+DQorwqAgwqAg
wqAgwqBpZiAoIWNoYW4pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5W
QUw7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHN3aXRjaCAoY2hhbi0mZ3Q7dHlwZSkgezxicj4N
CivCoCDCoCDCoCDCoGNhc2UgSUlPX0FDQ0VMOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN3aXRjaCAoZGlyKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBJSU9fRVZf
RElSX1JJU0lORzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
KGRhdGEtJmd0O2NoaXBfaW5mby0mZ3Q7c3VwcG9ydGVkX2U8d2JyPnZlbnRzPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFt
cDsgTU1BODQ1Ml9JTlRfVFJBTlMpICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoZGF0YS0mZ3Q7Y2hpcF9pbmZvLSZndDtlbmFi
bGVkX2V2ZTx3YnI+bnRzPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDsgTU1BODQ1Ml9JTlRfVFJBTlMpKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpldl9yZWcgPSAm
YW1wO2V2X3JlZ3NfYWNjZWxfcmlzaW5nOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVsc2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAqZXZfcmVnID0gJmFtcDtldl9yZWdzX2FjY2VsX2ZhbGxpbmc7PGJyPg0KPC9i
bG9ja3F1b3RlPg0KPGJyPjwvZGl2PjwvZGl2Pg0KTm90IHJlYWxseSBpbnR1aXRpdmUuIFlvdSBz
ZWUgeW91ciBzZW1hbnRpYyBwcm9ibGVtIGhlcmUuIHRyYW5zaWVudCByZWdpc3RlcnM8YnI+DQph
cmUganVzdCBvdGhlciBraW5kcyBvZiBldmVudHMuIFdlIHNob3VsZCBuZXZlciBzYXkgJnF1b3Q7
dHJhbnNpZW50IGlzIGZvciByaXNpbmc8YnI+DQpkaXJlY3Rpb24mcXVvdDsgb3IgJnF1b3Q7ZmZf
bXQgaXMgZm9yIGZhbGxpbmcgZGlyZWN0aW9uJnF1b3Q7LiBhbnkgY29tYmluYXRpb24gaXMgZmlu
ZS4gT25seSBmcmVlZmFsbDxicj4NCm1vZGUgbmVlZHMgb25lIGZpeDogcmVtZW1iZXJpbmcgdG8g
d2hpY2ggc2V0IG9mIHJlZ2lzdGVycyB0byBmYWxsIGJhY2sgd2hlbjxicj4NCmRpc2FibGluZyBp
dC48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1Ij48YnI+DQo8YnI+DQo8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNhc2UgSUlPX0VWX0RJUl9GQUxMSU5HOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCpldl9yZWcgPSAmYW1wO2V2X3JlZ3NfYWNjZWxfZmFsbGluZzs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biAtRUlOVkFMOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorfTxicj4NCis8YnI+DQrCoHN0YXRp
YyBpbnQgbW1hODQ1Ml9yZWFkX3RocmVzaChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3Ry
dWN0IGlpb19jaGFuX3NwZWMgKmNoYW4sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlbnVtIGlpb19ldmVudF90eXBlIHR5cGUsPGJyPg0KQEAgLTc0
OSwyMSArNzkyLDI0IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml9yZWFkX3RocmVzaChzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2LDxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBtbWE4NDUy
X2RhdGEgKmRhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOzxicj4NCsKgIMKgIMKgIMKgIGludCBy
ZXQsIHVzLCBwb3dlcl9tb2RlOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBtbWE4NDUy
X2V2ZW50X3JlZ3MgKmV2X3JlZ3M7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1tYTg0
NTJfZ2V0X2V2ZW50X3JlZ3MoZGF0YSwgY2hhbiwgZGlyLCAmYW1wO2V2X3JlZ3MpOzxicj4NCivC
oCDCoCDCoCDCoGlmIChyZXQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJl
dDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBzd2l0Y2ggKGluZm8pIHs8YnI+DQrCoCDCoCDCoCDC
oCBjYXNlIElJT19FVl9JTkZPX1ZBTFVFOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShkYXRhLTx3YnI+Jmd0O2NsaWVudCw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZGF0YS0mZ3Q7Y2hpcF9pbmZvLSZndDtldl90aHMpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldCA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShkYXRhLTx3YnI+
Jmd0O2NsaWVudCwgZXZfcmVncy0mZ3Q7ZXZfdGhzKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAocmV0ICZsdDsgMCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCByZXR1cm4gcmV0Ozxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCp2YWwg
PSByZXQgJmFtcDsgZGF0YS0mZ3Q7Y2hpcF9pbmZvLSZndDtldl90aHNfbWFzazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAqdmFsID0gcmV0ICZhbXA7IGV2X3JlZ3MtJmd0O2V2X3Roc19t
YXNrOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBJSU9fVkFMX0lO
VDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBjYXNlIElJT19FVl9JTkZPX1BFUklPRDo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoZGF0
YS08d2JyPiZndDtjbGllbnQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRhdGEtJmd0O2NoaXBfaW5mby0m
Z3Q7ZXZfY291bnQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IGkyY19zbWJ1
c19yZWFkX2J5dGVfZGF0YShkYXRhLTx3YnI+Jmd0O2NsaWVudCwgZXZfcmVncy0mZ3Q7ZXZfY291
bnQpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChyZXQgJmx0OyAwKTxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByZXQ7PGJyPg0KPGJyPg0K
QEAgLTgwOSwxNCArODU1LDE4IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml93cml0ZV90aHJlc2goc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2Rldiw8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3Qg
bW1hODQ1Ml9kYXRhICpkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTs8YnI+DQrCoCDCoCDCoCDC
oCBpbnQgcmV0LCByZWcsIHN0ZXBzOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBtbWE4
NDUyX2V2ZW50X3JlZ3MgKmV2X3JlZ3M7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldCA9IG1t
YTg0NTJfZ2V0X2V2ZW50X3JlZ3MoZGF0YSwgY2hhbiwgZGlyLCAmYW1wO2V2X3JlZ3MpOzxicj4N
CivCoCDCoCDCoCDCoGlmIChyZXQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IHJldDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBzd2l0Y2ggKGluZm8pIHs8YnI+DQrCoCDCoCDC
oCDCoCBjYXNlIElJT19FVl9JTkZPX1ZBTFVFOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmICh2YWwgJmx0OyAwIHx8IHZhbCAmZ3Q7IE1NQTg0NTJfVFJBTlNJRU5UX1RIU19NQVNLKTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh2YWwgJmx0OyAwIHx8IHZhbCAmZ3Q7IGV2
X3JlZ3MtJmd0O2V2X3Roc19tYXNrKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiAtRUlOVkFMOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiBtbWE4NDUyX2NoYW5nZV9jb25maWcoZGF0YSwgZGF0YS0mZ3Q7Y2hpcF9pbmZvLSZn
dDtldl90aHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZhbCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIG1tYTg0NTJfY2hhbmdlX2NvbmZpZyhkYXRhLCBldl9yZWdzLSZndDtldl90aHMs
IHZhbCk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgY2FzZSBJSU9fRVZfSU5GT19QRVJJT0Q6PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gbW1hODQ1Ml9nZXRfcG93ZXJfbW9kZShk
YXRhKTs8YnI+DQpAQCAtODMwLDggKzg4MCw3IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml93cml0ZV90
aHJlc2goc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoc3RlcHMgJmx0OyAwIHx8IHN0ZXBzICZndDsgMHhmZik8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVJTlZBTDs8YnI+DQo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gbW1hODQ1Ml9jaGFuZ2VfY29uZmlnKGRhdGEsIGRh
dGEtJmd0O2NoaXBfaW5mby0mZ3Q7ZXZfY291bnQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0ZXBzKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gbW1hODQ1Ml9jaGFuZ2VfY29uZmlnKGRh
dGEsIGV2X3JlZ3MtJmd0O2V2X2NvdW50LCBzdGVwcyk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
Y2FzZSBJSU9fRVZfSU5GT19ISUdIX1BBU1NfRklMVEVSXzM8d2JyPkRCOjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJlZyA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShkYXRhLTx3YnI+
Jmd0O2NsaWVudCw8YnI+DQpAQCAtODYxLDIzICs5MTAsMTggQEAgc3RhdGljIGludCBtbWE4NDUy
X3JlYWRfZXZlbnRfY29uZmlnKHN0cnU8d2JyPmN0PGJyPg0KaWlvX2RldiAqaW5kaW9fZGV2LDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZW51bSBpaW9fZXZlbnRfZGlyZWN0aW9uIGRpcik8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDC
oCBzdHJ1Y3QgbW1hODQ1Ml9kYXRhICpkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTs8YnI+DQot
wqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgbW1hX2NoaXBfaW5mbyAqY2hpcCA9IGRhdGEtJmd0O2No
aXBfaW5mbzs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgcmV0Ozxicj4NCjxicj4NCsKgIMKgIMKgIMKg
IHN3aXRjaCAoZGlyKSB7PGJyPg0KwqAgwqAgwqAgwqAgY2FzZSBJSU9fRVZfRElSX0ZBTExJTkc6
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIG1tYTg0NTJfZnJlZWZhbGxfbW9k
ZV9lbmFibGVkKDx3YnI+ZGF0YSk7PGJyPg0KwqAgwqAgwqAgwqAgY2FzZSBJSU9fRVZfRElSX1JJ
U0lORzo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobW1hODQ1Ml9mcmVlZmFsbF9t
b2RlX2VuYWJsZWQ8d2JyPihkYXRhKSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gMDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPHdicj4mZ3Q7Y2xpZW50LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkYXRhLSZndDtjaGlwX2luZm8tJmd0O2V2X2NmZyk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPHdicj4m
Z3Q7Y2xpZW50LCBNTUE4NDUyX1RSQU5TSUVOVF9DRkcpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGlmIChyZXQgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiByZXQ7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuICEhKHJldCAmYW1wOyBCSVQoY2hhbi0mZ3Q7c2Nhbl9pbmRleCArPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hpcC0mZ3Q7ZXZf
Y2ZnX2NoYW5fc2hpZnQpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gISEo
cmV0ICZhbXA7IE1NQTg0NTJfVFJBTlNJRU5UX0NGR19DSEFOKGNoYTx3YnI+bi0mZ3Q7c2Nhbl9p
bmRleCkpOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBkZWZhdWx0Ojxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJldHVybiAtRUlOVkFMOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQpAQCAt
ODkwLDcgKzkzNCw2IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml93cml0ZV9ldmVudF9jb25maWcoc3Ry
PHdicj51Y3Q8YnI+DQppaW9fZGV2ICppbmRpb19kZXYsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IHN0YXRlKTxicj4NCsKg
ezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBtbWE4NDUyX2RhdGEgKmRhdGEgPSBpaW9fcHJpdihp
bmRpb19kZXYpOzxicj4NCi3CoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBtbWFfY2hpcF9pbmZvICpj
aGlwID0gZGF0YS0mZ3Q7Y2hpcF9pbmZvOzxicj4NCsKgIMKgIMKgIMKgIGludCB2YWwsIHJldDs8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByZXQgPSBtbWE4NDUyX3NldF9ydW50aW1lX3BtX3N0YXRl
KGQ8d2JyPmF0YS0mZ3Q7Y2xpZW50LCBzdGF0ZSk7PGJyPg0KQEAgLTkwMSwyOCArOTQ0LDE4IEBA
IHN0YXRpYyBpbnQgbW1hODQ1Ml93cml0ZV9ldmVudF9jb25maWcoc3RyPHdicj51Y3Q8YnI+DQpp
aW9fZGV2ICppbmRpb19kZXYsPGJyPg0KwqAgwqAgwqAgwqAgY2FzZSBJSU9fRVZfRElSX0ZBTExJ
Tkc6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIG1tYTg0NTJfc2V0X2ZyZWVm
YWxsX21vZGUoZGF0YTx3YnI+LCBzdGF0ZSk7PGJyPg0KwqAgwqAgwqAgwqAgY2FzZSBJSU9fRVZf
RElSX1JJU0lORzo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgPSBpMmNfc21idXNf
cmVhZF9ieXRlX2RhdGEoZGF0YS08d2JyPiZndDtjbGllbnQsIGNoaXAtJmd0O2V2X2NmZyk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRh
KGRhdGEtPHdicj4mZ3Q7Y2xpZW50LCBNTUE4NDUyX1RSQU5TSUVOVF9DRkcpOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmICh2YWwgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiB2YWw7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKHN0YXRlKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaWYgKG1tYTg0NTJfZnJlZWZhbGxfbW9kZV9lbmFibGVkPHdicj4oZGF0YSkpIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgJmFt
cDs9IH5CSVQoaWR4X3ggKyBjaGlwLSZndDtldl9jZmdfY2hhbl9zaGlmdCk7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsICZhbXA7PSB+QklU
KGlkeF95ICsgY2hpcC0mZ3Q7ZXZfY2ZnX2NoYW5fc2hpZnQpOzxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCAmYW1wOz0gfkJJVChpZHhfeiAr
IGNoaXAtJmd0O2V2X2NmZ19jaGFuX3NoaWZ0KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgfD0gTU1BODQ1Ml9GRl9NVF9DRkdfT0FFOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgfD0gQklUKGNoYW4tJmd0O3NjYW5faW5kZXgg
KyBjaGlwLSZndDtldl9jZmdfY2hhbl9zaGlmdCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfSBlbHNlIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
bW1hODQ1Ml9mcmVlZmFsbF9tb2RlX2VuYWJsZWQ8d2JyPihkYXRhKSk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQotPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsICZhbXA7PSB+QklUKGNo
YW4tJmd0O3NjYW5faW5kZXggKyBjaGlwLSZndDtldl9jZmdfY2hhbl9zaGlmdCk7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChz
dGF0ZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwgfD0gTU1B
ODQ1Ml9UUkFOU0lFTlRfQ0ZHX0NIQU4oY2hhPHdicj5uLSZndDtzY2FuX2luZGV4KTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdmFsICZhbXA7PSB+TU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHX0NIQU4oY2g8d2Jy
PmFuLSZndDtzY2FuX2luZGV4KTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2
YWwgfD0gY2hpcC0mZ3Q7ZXZfY2ZnX2VsZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2
YWwgfD0gTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHX0VMRTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gbW1hODQ1Ml9jaGFuZ2VfY29uZmlnKGRhdGEsIGNoaXAtJmd0O2V2
X2NmZywgdmFsKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gbW1hODQ1Ml9j
aGFuZ2VfY29uZmlnKGRhdGEsIE1NQTg0NTJfVFJBTlNJRU5UX0NGRywgdmFsKTs8YnI+DQrCoCDC
oCDCoCDCoCBkZWZhdWx0Ojxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRUlO
VkFMOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQpAQCAtOTM0LDM1ICs5NjcsMjUgQEAgc3RhdGlj
IHZvaWQgbW1hODQ1Ml90cmFuc2llbnRfaW50ZXJydXB0KHN0PHdicj5ydWN0PGJyPg0KaWlvX2Rl
diAqaW5kaW9fZGV2KTxicj4NCsKgIMKgIMKgIMKgIHM2NCB0cyA9IGlpb19nZXRfdGltZV9ucyhp
bmRpb19kZXYpOzxicj4NCsKgIMKgIMKgIMKgIGludCBzcmM7PGJyPg0KPGJyPg0KLcKgIMKgIMKg
IMKgc3JjID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPHdicj4mZ3Q7Y2xpZW50LCBk
YXRhLSZndDtjaGlwX2luZm8tJmd0O2V2X3NyYyk7PGJyPg0KK8KgIMKgIMKgIMKgc3JjID0gaTJj
X3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGRhdGEtPHdicj4mZ3Q7Y2xpZW50LCBNTUE4NDUyX1RSQU5T
SUVOVF9TUkMpOzxicj4NCsKgIMKgIMKgIMKgIGlmIChzcmMgJmx0OyAwKTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBpZiAobW1hODQ1
Ml9mcmVlZmFsbF9tb2RlX2VuYWJsZWQ8d2JyPihkYXRhKSkgezxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlpb19wdXNoX2V2ZW50KGluZGlvX2Rldiw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSUlPX01PRF9FVkVOVF9DT0RFKElJT19BQ0NF
TCwgMCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fTU9EX1hfQU5EX1lfQU5EX1osPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX1RZUEVfTUFHLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oElJT19FVl9ESVJfRkFMTElORyksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHRzKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47
PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBpZiAoc3JjICZhbXA7
IGRhdGEtJmd0O2NoaXBfaW5mby0mZ3Q7ZXZfc3JjX3hlKTxicj4NCivCoCDCoCDCoCDCoGlmIChz
cmMgJmFtcDsgTU1BODQ1Ml9UUkFOU0lFTlRfU1JDX1hUUkFOU0UpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaWlvX3B1c2hfZXZlbnQoaW5kaW9fZGV2LDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX01PRF9FVkVOVF9DT0RFKElJT19B
Q0NFTCwgMCwgSUlPX01PRF9YLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElJT19FVl9UWVBFX01B
Ryw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJSU9fRVZfRElSX1JJU0lORyksPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cyk7PGJyPg0KPGJyPg0K
LcKgIMKgIMKgIMKgaWYgKHNyYyAmYW1wOyBkYXRhLSZndDtjaGlwX2luZm8tJmd0O2V2X3NyY195
ZSk8YnI+DQorwqAgwqAgwqAgwqBpZiAoc3JjICZhbXA7IE1NQTg0NTJfVFJBTlNJRU5UX1NSQ19Z
VFJBTlNFKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlpb19wdXNoX2V2ZW50KGluZGlv
X2Rldiw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oElJT19NT0RfRVZFTlRfQ09ERShJSU9fQUNDRUwsIDAsIElJT19NT0RfWSw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBJSU9fRVZfVFlQRV9NQUcsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSUlPX0VW
X0RJUl9SSVNJTkcpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgdHMpOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGlmIChzcmMgJmFtcDsgZGF0YS0m
Z3Q7Y2hpcF9pbmZvLSZndDtldl9zcmNfemUpPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHNyYyAmYW1w
OyBNTUE4NDUyX1RSQU5TSUVOVF9TUkNfWlRSQU5TRSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpaW9fcHVzaF9ldmVudChpbmRpb19kZXYsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fTU9EX0VWRU5UX0NPREUoSUlPX0FDQ0VMLCAw
LCBJSU9fTU9EX1osPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSUlPX0VWX1RZUEVfTUFHLDxicj4N
CkBAIC05NzQsNyArOTk3LDYgQEAgc3RhdGljIGlycXJldHVybl90IG1tYTg0NTJfaW50ZXJydXB0
KGludCBpcnEsIHZvaWQgKnApPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGlpb19k
ZXYgKmluZGlvX2RldiA9IHA7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IG1tYTg0NTJfZGF0YSAq
ZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7PGJyPg0KLcKgIMKgIMKgIMKgY29uc3Qgc3RydWN0
IG1tYV9jaGlwX2luZm8gKmNoaXAgPSBkYXRhLSZndDtjaGlwX2luZm87PGJyPg0KwqAgwqAgwqAg
wqAgaW50IHJldCA9IElSUV9OT05FOzxicj4NCsKgIMKgIMKgIMKgIGludCBzcmM7PGJyPg0KPGJy
Pg0KQEAgLTk4MiwxNSArMTAwNCwyOSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbW1hODQ1Ml9pbnRl
cnJ1cHQoaW50IGlycSwgdm9pZCAqcCk8YnI+DQrCoCDCoCDCoCDCoCBpZiAoc3JjICZsdDsgMCk8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gSVJRX05PTkU7PGJyPg0KPGJyPg0K
K8KgIMKgIMKgIMKgaWYgKCEoc3JjICZhbXA7IGRhdGEtJmd0O2NoaXBfaW5mby0mZ3Q7ZW5hYmxl
ZF9ldmVudDx3YnI+cykpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIElSUV9O
T05FOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBpZiAoc3JjICZhbXA7IE1NQTg0NTJfSU5UX0RS
RFkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpaW9fdHJpZ2dlcl9wb2xsX2NoYWlu
ZWQoaW5kaW88d2JyPl9kZXYtJmd0O3RyaWcpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldCA9IElSUV9IQU5ETEVEOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQotwqAgwqAg
wqAgwqBpZiAoKHNyYyAmYW1wOyBNTUE4NDUyX0lOVF9UUkFOUyAmYW1wOyZhbXA7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIGNoaXAtJmd0O2V2X3NyYyA9PSBNTUE4NDUyX1RSQU5TSUVOVF9TUkMp
IHx8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgKHNyYyAmYW1wOyBNTUE4NDUyX0lOVF9GRl9NVCAm
YW1wOyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNoaXAtJmd0O2V2X3NyYyA9PSBNTUE4
NDUyX0ZGX01UX1NSQykpIHs8YnI+DQorwqAgwqAgwqAgwqBpZiAoc3JjICZhbXA7IE1NQTg0NTJf
SU5UX0ZGX01UKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG1tYTg0NTJfZnJl
ZWZhbGxfbW9kZV9lbmFibGVkPHdicj4oZGF0YSkpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzNjQgdHMgPSBpaW9fZ2V0X3RpbWVfbnMoaW5kaW9fZGV2KTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWlvX3B1c2hfZXZl
bnQoaW5kaW9fZGV2LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBJSU9fTU9EX0VWRU5UX0NPREUoSUlPX0FDQ0VMLCAwLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElJT19NT0RfWF9BTkRfWV9BTkRfWiw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fRVZfVFlQRV9NQUcsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX0RJUl9GQUxMSU5HKSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0
cyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldCA9IElSUV9IQU5ETEVEOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgaWYgKHNyYyAmYW1wOyBNTUE4NDUyX0lOVF9UUkFOUykgezxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIG1tYTg0NTJfdHJhbnNpZW50X2ludGVycnVwdChpbjx3YnI+ZGlv
X2Rldik7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gSVJRX0hBTkRMRUQ7PGJy
Pg0KwqAgwqAgwqAgwqAgfTxicj4NCkBAIC0xMjIyLDk2ICsxMjU4LDg3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbW1hX2NoaXBfaW5mbzxicj4NCm1tYV9jaGlwX2luZm9fdGFibGVbXSA9IHs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCrCoCDCoCDCoCBnICogTiAqIDEwMDAwMDAgLyAy
MDQ4IGZvciBOID0gMiwgNCwgOCBhbmQgZz05LjgwNjY1PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAqLzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5tbWFfc2NhbGVzID0geyB7
MCwgMjM5NH0sIHswLCA0Nzg4fSwgezAsIDk1Nzd9IH0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLmV2X2NmZyA9IE1NQTg0NTJfVFJBTlNJRU5UX0NGRyw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAuZXZfY2ZnX2VsZSA9IE1NQTg0NTJfVFJBTlNJRU5UX0NGR19FTEUsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NmZ19jaGFuX3NoaWZ0ID0gMSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjID0gTU1BODQ1Ml9UUkFOU0lFTlRfU1JDLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmNfeGUgPSBNTUE4NDUyX1RSQU5TSUVOVF9T
UkNfWFRSQU5TRSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjX3llID0gTU1B
ODQ1Ml9UUkFOU0lFTlRfU1JDX1lUUkFOU0UsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LmV2X3NyY196ZSA9IE1NQTg0NTJfVFJBTlNJRU5UX1NSQ19aVFJBTlNFLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC5ldl90aHMgPSBNTUE4NDUyX1RSQU5TSUVOVF9USFMsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3Roc19tYXNrID0gTU1BODQ1Ml9UUkFOU0lFTlRfVEhT
X01BU0ssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NvdW50ID0gTU1BODQ1Ml9U
UkFOU0lFTlRfQ09VTlQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBBbHRob3VnaCB3ZSBlbmFibGUgdGhlIGludGVycnVwdCBz
b3VyY2VzIG9uY2UgYW5kIGZvcjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFsbCBo
ZXJlIHRoZSBldmVudCBkZXRlY3Rpb24gaXRzZWxmIGlzIG5vdCBlbmFibGVkIHVudGlsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogdXNlcnNwYWNlIGFza3MgZm9yIGl0IGJ5IG1tYTg0
NTJfd3JpdGVfZXZlbnRfY29uZmlnKCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuc3VwcG9ydGVkX2V2ZW50cyA9IE1NQTg0NTJf
SU5UX0RSRFkgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoE1NQTg0NTJfSU5UX1RSQU5TIHw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUE4NDUyX0lO
VF9GRl9NVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZW5hYmxlZF9ldmVudHMgPSBN
TUE4NDUyX0lOVF9UUkFOUyB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTU1BODQ1Ml9JTlRfRkZfTVQsPGJyPg0KwqAgwqAg
wqAgwqAgfSw8YnI+DQrCoCDCoCDCoCDCoCBbbW1hODQ1Ml0gPSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLmNoaXBfaWQgPSBNTUE4NDUyX0RFVklDRV9JRCw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAuY2hhbm5lbHMgPSBtbWE4NDUyX2NoYW5uZWxzLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKG1tYTg0NTJfY2hhbm5l
bHMpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5tbWFfc2NhbGVzID0geyB7MCwgOTU3
N30sIHswLCAxOTE1NH0sIHswLCAzODMwN30gfSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuZXZfY2ZnID0gTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC5ldl9jZmdfZWxlID0gTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZHX0VMRSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY2ZnX2NoYW5fc2hpZnQgPSAxLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC5ldl9zcmMgPSBNTUE4NDUyX1RSQU5TSUVOVF9TUkMsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3NyY194ZSA9IE1NQTg0NTJfVFJBTlNJRU5UX1NSQ19Y
VFJBTlNFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmNfeWUgPSBNTUE4NDUy
X1RSQU5TSUVOVF9TUkNfWVRSQU5TRSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZf
c3JjX3plID0gTU1BODQ1Ml9UUkFOU0lFTlRfU1JDX1pUUkFOU0UsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLmV2X3RocyA9IE1NQTg0NTJfVFJBTlNJRU5UX1RIUyw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAuZXZfdGhzX21hc2sgPSBNTUE4NDUyX1RSQU5TSUVOVF9USFNfTUFT
Syw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY291bnQgPSBNTUE4NDUyX1RSQU5T
SUVOVF9DT1VOVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqIEFsdGhvdWdoIHdlIGVuYWJsZSB0aGUgaW50ZXJydXB0IHNvdXJj
ZXMgb25jZSBhbmQgZm9yPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogYWxsIGhlcmUg
dGhlIGV2ZW50IGRldGVjdGlvbiBpdHNlbGYgaXMgbm90IGVuYWJsZWQgdW50aWw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB1c2Vyc3BhY2UgYXNrcyBmb3IgaXQgYnkgbW1hODQ1Ml93
cml0ZV9ldmVudF9jb25maWcoKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5zdXBwb3J0ZWRfZXZlbnRzID0gTU1BODQ1Ml9JTlRf
RFJEWSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgTU1BODQ1Ml9JTlRfVFJBTlMgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE1NQTg0NTJfSU5UX0ZG
X01ULDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5lbmFibGVkX2V2ZW50cyA9IE1NQTg0
NTJfSU5UX1RSQU5TIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUE4NDUyX0lOVF9GRl9NVCw8YnI+DQrCoCDCoCDCoCDC
oCB9LDxicj4NCsKgIMKgIMKgIMKgIFttbWE4NDUzXSA9IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAuY2hpcF9pZCA9IE1NQTg0NTNfREVWSUNFX0lELDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC5jaGFubmVscyA9IG1tYTg0NTNfY2hhbm5lbHMsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUobW1hODQ1M19jaGFubmVscyks
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLm1tYV9zY2FsZXMgPSB7IHswLCAzODMwN30s
IHswLCA3NjYxNH0sIHswLCAxNTMyMjh9IH0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LmV2X2NmZyA9IE1NQTg0NTJfVFJBTlNJRU5UX0NGRyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAuZXZfY2ZnX2VsZSA9IE1NQTg0NTJfVFJBTlNJRU5UX0NGR19FTEUsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NmZ19jaGFuX3NoaWZ0ID0gMSw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAuZXZfc3JjID0gTU1BODQ1Ml9UUkFOU0lFTlRfU1JDLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmNfeGUgPSBNTUE4NDUyX1RSQU5TSUVOVF9TUkNfWFRS
QU5TRSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjX3llID0gTU1BODQ1Ml9U
UkFOU0lFTlRfU1JDX1lUUkFOU0UsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3Ny
Y196ZSA9IE1NQTg0NTJfVFJBTlNJRU5UX1NSQ19aVFJBTlNFLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC5ldl90aHMgPSBNTUE4NDUyX1RSQU5TSUVOVF9USFMsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLmV2X3Roc19tYXNrID0gTU1BODQ1Ml9UUkFOU0lFTlRfVEhTX01BU0ss
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NvdW50ID0gTU1BODQ1Ml9UUkFOU0lF
TlRfQ09VTlQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKiBBbHRob3VnaCB3ZSBlbmFibGUgdGhlIGludGVycnVwdCBzb3VyY2Vz
IG9uY2UgYW5kIGZvcjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIGFsbCBoZXJlIHRo
ZSBldmVudCBkZXRlY3Rpb24gaXRzZWxmIGlzIG5vdCBlbmFibGVkIHVudGlsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICogdXNlcnNwYWNlIGFza3MgZm9yIGl0IGJ5IG1tYTg0NTJfd3Jp
dGVfZXZlbnRfY29uZmlnKCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuc3VwcG9ydGVkX2V2ZW50cyA9IE1NQTg0NTJfSU5UX0RS
RFkgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoE1NQTg0NTJfSU5UX1RSQU5TIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUE4NDUyX0lOVF9GRl9N
VCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZW5hYmxlZF9ldmVudHMgPSBNTUE4NDUy
X0lOVF9UUkFOUyB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgTU1BODQ1Ml9JTlRfRkZfTVQsPGJyPg0KwqAgwqAgwqAgwqAg
fSw8YnI+DQrCoCDCoCDCoCDCoCBbbW1hODY1Ml0gPSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLmNoaXBfaWQgPSBNTUE4NjUyX0RFVklDRV9JRCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAuY2hhbm5lbHMgPSBtbWE4NjUyX2NoYW5uZWxzLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIC5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKG1tYTg2NTJfY2hhbm5lbHMpLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5tbWFfc2NhbGVzID0geyB7MCwgOTU3N30sIHsw
LCAxOTE1NH0sIHswLCAzODMwN30gfSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZf
Y2ZnID0gTU1BODQ1Ml9GRl9NVF9DRkcsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2
X2NmZ19lbGUgPSBNTUE4NDUyX0ZGX01UX0NGR19FTEUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLmV2X2NmZ19jaGFuX3NoaWZ0ID0gMyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuZXZfc3JjID0gTU1BODQ1Ml9GRl9NVF9TUkMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLmV2X3NyY194ZSA9IE1NQTg0NTJfRkZfTVRfU1JDX1hIRSw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAuZXZfc3JjX3llID0gTU1BODQ1Ml9GRl9NVF9TUkNfWUhFLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmNfemUgPSBNTUE4NDUyX0ZGX01UX1NSQ19aSEUsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3RocyA9IE1NQTg0NTJfRkZfTVRfVEhTLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl90aHNfbWFzayA9IE1NQTg0NTJfRkZfTVRf
VEhTX01BU0ssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NvdW50ID0gTU1BODQ1
Ml9GRl9NVF9DT1VOVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuc3VwcG9ydGVkX2V2
ZW50cyA9IE1NQTg0NTJfSU5UX0RSRFkgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE1NQTg0NTJfSU5UX0ZGX01ULDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5lbmFibGVkX2V2ZW50cyA9IE1NQTg0NTJfSU5UX0ZG
X01ULDxicj4NCsKgIMKgIMKgIMKgIH0sPGJyPg0KwqAgwqAgwqAgwqAgW21tYTg2NTNdID0gezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5jaGlwX2lkID0gTU1BODY1M19ERVZJQ0VfSUQs
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmNoYW5uZWxzID0gbW1hODY1M19jaGFubmVs
cyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAubnVtX2NoYW5uZWxzID0gQVJSQVlfU0la
RShtbWE4NjUzX2NoYW5uZWxzKSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAubW1hX3Nj
YWxlcyA9IHsgezAsIDM4MzA3fSwgezAsIDc2NjE0fSwgezAsIDE1MzIyOH0gfSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY2ZnID0gTU1BODQ1Ml9GRl9NVF9DRkcsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NmZ19lbGUgPSBNTUE4NDUyX0ZGX01UX0NGR19FTEUs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X2NmZ19jaGFuX3NoaWZ0ID0gMyw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjID0gTU1BODQ1Ml9GRl9NVF9TUkMsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3NyY194ZSA9IE1NQTg0NTJfRkZfTVRfU1JD
X1hIRSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjX3llID0gTU1BODQ1Ml9G
Rl9NVF9TUkNfWUhFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmNfemUgPSBN
TUE4NDUyX0ZGX01UX1NSQ19aSEUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3Ro
cyA9IE1NQTg0NTJfRkZfTVRfVEhTLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl90
aHNfbWFzayA9IE1NQTg0NTJfRkZfTVRfVEhTX01BU0ssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLmV2X2NvdW50ID0gTU1BODQ1Ml9GRl9NVF9DT1VOVCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEFsdGhvdWdoIHdl
IGVuYWJsZSB0aGUgaW50ZXJydXB0IHNvdXJjZXMgb25jZSBhbmQgZm9yPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICogYWxsIGhlcmUgdGhlIGV2ZW50IGRldGVjdGlvbiBpdHNlbGYgaXMg
bm90IGVuYWJsZWQgdW50aWw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB1c2Vyc3Bh
Y2UgYXNrcyBmb3IgaXQgYnkgbW1hODQ1Ml93cml0ZV9ldmVudF9jb25maWcoKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5zdXBw
b3J0ZWRfZXZlbnRzID0gTU1BODQ1Ml9JTlRfRFJEWSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTU1BODQ1Ml9JTlRfRkZf
TVQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmVuYWJsZWRfZXZlbnRzID0gTU1BODQ1
Ml9JTlRfRkZfTVQsPGJyPg0KwqAgwqAgwqAgwqAgfSw8YnI+DQrCoCDCoCDCoCDCoCBbZnhsczg0
NzFdID0gezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5jaGlwX2lkID0gRlhMUzg0NzFf
REVWSUNFX0lELDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5jaGFubmVscyA9IG1tYTg0
NTFfY2hhbm5lbHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLm51bV9jaGFubmVscyA9
IEFSUkFZX1NJWkUobW1hODQ1MV9jaGFubmVscyksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgLm1tYV9zY2FsZXMgPSB7IHswLCAyMzk0fSwgezAsIDQ3ODh9LCB7MCwgOTU3N30gfSw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY2ZnID0gTU1BODQ1Ml9UUkFOU0lFTlRfQ0ZH
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9jZmdfZWxlID0gTU1BODQ1Ml9UUkFO
U0lFTlRfQ0ZHX0VMRSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfY2ZnX2NoYW5f
c2hpZnQgPSAxLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ldl9zcmMgPSBNTUE4NDUy
X1RSQU5TSUVOVF9TUkMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3NyY194ZSA9
IE1NQTg0NTJfVFJBTlNJRU5UX1NSQ19YVFJBTlNFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoC5ldl9zcmNfeWUgPSBNTUE4NDUyX1RSQU5TSUVOVF9TUkNfWVRSQU5TRSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfc3JjX3plID0gTU1BODQ1Ml9UUkFOU0lFTlRfU1JDX1pU
UkFOU0UsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmV2X3RocyA9IE1NQTg0NTJfVFJB
TlNJRU5UX1RIUyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZXZfdGhzX21hc2sgPSBN
TUE4NDUyX1RSQU5TSUVOVF9USFNfTUFTSyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAu
ZXZfY291bnQgPSBNTUE4NDUyX1RSQU5TSUVOVF9DT1VOVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIEFsdGhvdWdoIHdlIGVu
YWJsZSB0aGUgaW50ZXJydXB0IHNvdXJjZXMgb25jZSBhbmQgZm9yPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICogYWxsIGhlcmUgdGhlIGV2ZW50IGRldGVjdGlvbiBpdHNlbGYgaXMgbm90
IGVuYWJsZWQgdW50aWw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB1c2Vyc3BhY2Ug
YXNrcyBmb3IgaXQgYnkgbW1hODQ1Ml93cml0ZV9ldmVudF9jb25maWcoKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5zdXBwb3J0
ZWRfZXZlbnRzID0gTU1BODQ1Ml9JTlRfRFJEWSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTU1BODQ1Ml9JTlRfVFJBTlMg
fDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoE1NQTg0NTJfSU5UX0ZGX01ULDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC5lbmFibGVkX2V2ZW50cyA9IE1NQTg0NTJfSU5UX1RSQU5TIHw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNTUE4NDUyX0lO
VF9GRl9NVCw8YnI+DQrCoCDCoCDCoCDCoCB9LDxicj4NCsKgfTs8YnI+DQo8YnI+DQpAQCAtMTUw
OSwxNiArMTUzNiw2IEBAIHN0YXRpYyBpbnQgbW1hODQ1Ml9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByZXQ7PGJyPg0K
PGJyPg0KwqAgwqAgwqAgwqAgaWYgKGNsaWVudC0mZ3Q7aXJxKSB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBBbHRob3VnaCB3
ZSBlbmFibGUgdGhlIGludGVycnVwdCBzb3VyY2VzIG9uY2UgYW5kIGZvcjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqIGFsbCBoZXJlIHRoZSBldmVudCBkZXRlY3Rpb24gaXRzZWxmIGlz
IG5vdCBlbmFibGVkIHVudGlsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogdXNlcnNw
YWNlIGFza3MgZm9yIGl0IGJ5IG1tYTg0NTJfd3JpdGVfZXZlbnRfY29uZmlnKCk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQg
c3VwcG9ydGVkX2ludGVycnVwdHMgPSBNTUE4NDUyX0lOVF9EUkRZIHw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTU1B
ODQ1Ml9JTlRfVFJBTlMgfDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNTUE4NDUyX0lOVF9GRl9NVDs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgZW5hYmxlZF9pbnRlcnJ1cHRzID0gTU1BODQ1Ml9JTlRf
VFJBTlMgfDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBNTUE4NDUyX0lOVF9GRl9NVDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpbnQgaXJxMjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpcnEy
ID0gb2ZfaXJxX2dldF9ieW5hbWUoY2xpZW50LSZndDtkZXYuPHdicj5vZl9ub2RlLCAmcXVvdDtJ
TlQyJnF1b3Q7KTs8YnI+DQpAQCAtMTUyOCw3ICsxNTQ1LDcgQEAgc3RhdGljIGludCBtbWE4NDUy
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWU8d2JyPm50LDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE1NQTg0NTJfQ1RSTF9SRUc1LDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN1cHBvcnRlZF9pbnRlcnJ1cHRzKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYXRhLSZndDtjaGlw
X2luZm8tJmd0O3N1cHBvcnRlZF9ldjx3YnI+ZW50cyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJldDs8YnI+DQo8YnI+DQpAQCAt
MTUzNyw3ICsxNTU0LDcgQEAgc3RhdGljIGludCBtbWE4NDUyX3Byb2JlKHN0cnVjdCBpMmNfY2xp
ZW50ICpjbGllbnQsPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gaTJj
X3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllPHdicj5udCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBN
TUE4NDUyX0NUUkxfUkVHNCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbmFibGVkX2ludGVycnVwdHMp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRhdGEtJmd0O2NoaXBfaW5mby0mZ3Q7ZW5hYmxlZF9ldmVuPHdicj50cyk7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHJldDs8YnI+DQo8L2Jsb2NrcXVvdGU+
DQo8YnI+DQo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2Pg0K
--089e082384e8c404790557efac7f--
