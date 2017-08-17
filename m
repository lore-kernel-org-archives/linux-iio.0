Return-Path: <SRS0=R56z=7T=posteo.de=martink@kernel.org>
Date: Thu, 17 Aug 2017 13:24:53 +0200
In-Reply-To: <0a512995-3fd5-e38e-73a6-417337515ce6@gmail.com>
References: <1502750644-8854-1-git-send-email-harinath922@gmail.com> <alpine.DEB.2.20.1708161455420.27224@vps.pmeerw.net> <0a512995-3fd5-e38e-73a6-417337515ce6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio: accel: mma8452: Bugfix to enbale and allow different events to work parallely.
To: Harinath Nampally <harinath922@gmail.com>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: jic23@kernel.org,knaack.h@gmx.de,lars@metafoo.de,gregkh@linuxfoundation.org,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,amsfield22@gmail.com
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <13587F36-588D-4011-8E70-A8892F81887E@posteo.de>
List-ID: <linux-iio@vger.kernel.org>



Am 17=2E August 2017 02:39:05 MESZ schrieb Harinath Nampally <harinath922@=
gmail=2Ecom>:
>> Hello,
>>
>> fixes are always welcome, some comments regarding the patch
>Thanks for the review=2E
>>
>> in subject: typo "enable"
>Will fix it=2E
>>> This driver supports multiple devices like mma8653, mma8652,
>mma8452, mma8453 and
>>> fxls8471=2E Almost all these devices have more than one event=2E Curre=
nt
>driver design
>>> hardcodes the event specific information, so only one event can be
>supported by this
>>> driver and current design doesn't have the flexibility to add more
>events=2E
>>  =20
>>> This patch fixes by detaching the event related information from
>chip_info struct,
>>> and based on channel type and event direction the corresponding
>event configuration registers
>>> are picked dynamically=2E Hence multiple events can be handled in
>read/write callbacks=2E
>> which chip can have which event(s)?
>I am planning to add 'supported events' field in
>
>struct mma_chip_info which indicates which chip can have which events=2E
>During initialization in 'mma_chip_info_table' would set this
>'supported events' field for each chip=2E
>But I wonder should I add those changes as part of this patch?

is it necessary or can it be documentation?

And this patch should have been called "v2"=2E please include a persistent=
 version history to v3 of this patch=2E

thanks

>
>>  =20
>>> Changes are thoroughly tested on fxls8471 device on imx6UL Eval
>board using iio_event_monitor user space program=2E
>>>
>>> After this fix both Freefall and Transient events are handled by the
>driver without any conflicts=2E
>> thanks, p=2E
>>  =20
>>> Signed-off-by: Harinath Nampally <harinath922@gmail=2Ecom>
>>> ---
>>>   drivers/iio/accel/mma8452=2Ec | 309
>++++++++++++++++++++------------------------
>>>   1 file changed, 141 insertions(+), 168 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/mma8452=2Ec
>b/drivers/iio/accel/mma8452=2Ec
>>> index eb6e3dc=2E=2E1b83e52 100644
>>> --- a/drivers/iio/accel/mma8452=2Ec
>>> +++ b/drivers/iio/accel/mma8452=2Ec
>>> @@ -59,7 +59,9 @@
>>>   #define MMA8452_FF_MT_THS			0x17
>>>   #define  MMA8452_FF_MT_THS_MASK			0x7f
>>>   #define MMA8452_FF_MT_COUNT			0x18
>>> +#define MMA8452_FF_MT_CHAN_SHIFT	3
>>>   #define MMA8452_TRANSIENT_CFG			0x1d
>>> +#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
>>>   #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
>>>   #define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
>>>   #define MMA8452_TRANSIENT_SRC			0x1e
>>> @@ -69,6 +71,7 @@
>>>   #define MMA8452_TRANSIENT_THS			0x1f
>>>   #define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
>>>   #define MMA8452_TRANSIENT_COUNT			0x20
>>> +#define MMA8452_TRANSIENT_CHAN_SHIFT 1
>>>   #define MMA8452_CTRL_REG1			0x2a
>>>   #define  MMA8452_CTRL_ACTIVE			BIT(0)
>>>   #define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
>>> @@ -107,6 +110,26 @@ struct mma8452_data {
>>>   	const struct mma_chip_info *chip_info;
>>>   };
>>>  =20
>>> + /**
>>> +  * struct mma8452_event_regs - chip specific data related to
>events
>>> +  * @ev_cfg:			event config register address
>>> +  * @ev_src:			event source register address
>>> +  * @ev_ths:			event threshold register address
>>> +  * @ev_ths_mask:		mask for the threshold value
>>> +  * @ev_count:			event count (period) register address
>>> +  *
>>> +  * Since not all chips supported by the driver support comparing
>high pass
>>> +  * filtered data for events (interrupts), different interrupt
>sources are
>>> +  * used for different chips and the relevant registers are
>included here=2E
>>> +  */
>>> +struct mma8452_event_regs {
>>> +		u8 ev_cfg;
>>> +		u8 ev_src;
>>> +		u8 ev_ths;
>>> +		u8 ev_ths_mask;
>>> +		u8 ev_count;
>>> +};
>>> +
>>>   /**
>>>    * struct mma_chip_info - chip specific data
>>>    * @chip_id:			WHO_AM_I register's value
>>> @@ -116,40 +139,12 @@ struct mma8452_data {
>>>    * @mma_scales:			scale factors for converting register values
>>>    *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>>>    *				per mode: m/s^2 and micro m/s^2
>>> - * @ev_cfg:			event config register address
>>> - * @ev_cfg_ele:			latch bit in event config register
>>> - * @ev_cfg_chan_shift:		number of the bit to enable events in X
>>> - *				direction; in event config register
>>> - * @ev_src:			event source register address
>>> - * @ev_src_xe:			bit in event source register that indicates
>>> - *				an event in X direction
>>> - * @ev_src_ye:			bit in event source register that indicates
>>> - *				an event in Y direction
>>> - * @ev_src_ze:			bit in event source register that indicates
>>> - *				an event in Z direction
>>> - * @ev_ths:			event threshold register address
>>> - * @ev_ths_mask:		mask for the threshold value
>>> - * @ev_count:			event count (period) register address
>>> - *
>>> - * Since not all chips supported by the driver support comparing
>high pass
>>> - * filtered data for events (interrupts), different interrupt
>sources are
>>> - * used for different chips and the relevant registers are included
>here=2E
>>>    */
>>>   struct mma_chip_info {
>>>   	u8 chip_id;
>>>   	const struct iio_chan_spec *channels;
>>>   	int num_channels;
>>>   	const int mma_scales[3][2];
>>> -	u8 ev_cfg;
>>> -	u8 ev_cfg_ele;
>>> -	u8 ev_cfg_chan_shift;
>>> -	u8 ev_src;
>>> -	u8 ev_src_xe;
>>> -	u8 ev_src_ye;
>>> -	u8 ev_src_ze;
>>> -	u8 ev_ths;
>>> -	u8 ev_ths_mask;
>>> -	u8 ev_count;
>>>   };
>>>  =20
>>>   enum {
>>> @@ -602,9 +597,8 @@ static int mma8452_set_power_mode(struct
>mma8452_data *data, u8 mode)
>>>   static int mma8452_freefall_mode_enabled(struct mma8452_data
>*data)
>>>   {
>>>   	int val;
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>  =20
>>> -	val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +	val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>>>   	if (val < 0)
>>>   		return val;
>>>  =20
>>> @@ -614,29 +608,28 @@ static int
>mma8452_freefall_mode_enabled(struct mma8452_data *data)
>>>   static int mma8452_set_freefall_mode(struct mma8452_data *data,
>bool state)
>>>   {
>>>   	int val;
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>  =20
>>>   	if ((state && mma8452_freefall_mode_enabled(data)) ||
>>>   	    (!state && !(mma8452_freefall_mode_enabled(data))))
>>>   		return 0;
>>>  =20
>>> -	val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +	val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>>>   	if (val < 0)
>>>   		return val;
>>>  =20
>>>   	if (state) {
>>> -		val |=3D BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -		val |=3D BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -		val |=3D BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +		val |=3D BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val |=3D BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val |=3D BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>   		val &=3D ~MMA8452_FF_MT_CFG_OAE;
>>>   	} else {
>>> -		val &=3D ~BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -		val &=3D ~BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -		val &=3D ~BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +		val &=3D ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val &=3D ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val &=3D ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>   		val |=3D MMA8452_FF_MT_CFG_OAE;
>>>   	}
>>>  =20
>>> -	return mma8452_change_config(data, chip->ev_cfg, val);
>>> +	return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
>>>   }
>>>  =20
>>>   static int mma8452_set_hp_filter_frequency(struct mma8452_data
>*data,
>>> @@ -740,6 +733,39 @@ static int mma8452_write_raw(struct iio_dev
>*indio_dev,
>>>   	return ret;
>>>   }
>>>  =20
>>> +static int mma8452_get_event_regs(const struct iio_chan_spec *chan,
>>> +	       enum iio_event_direction dir,
>>> +		   struct mma8452_event_regs *ev_regs
>>> +	       )
>>> +{
>>> +	if (!chan)
>>> +		return -EINVAL;
>>> +	switch (chan->type) {
>>> +	case IIO_ACCEL:
>>> +		switch (dir) {
>>> +		case IIO_EV_DIR_FALLING:
>>> +			ev_regs->ev_cfg =3D MMA8452_FF_MT_CFG;
>>> +			ev_regs->ev_src =3D MMA8452_FF_MT_SRC;
>>> +			ev_regs->ev_ths =3D MMA8452_FF_MT_THS;
>>> +			ev_regs->ev_ths_mask =3D MMA8452_FF_MT_THS_MASK;
>>> +			ev_regs->ev_count =3D MMA8452_FF_MT_COUNT;
>>> +			break;
>>> +		case IIO_EV_DIR_RISING:
>>> +			ev_regs->ev_cfg =3D MMA8452_TRANSIENT_CFG;
>>> +			ev_regs->ev_src =3D MMA8452_TRANSIENT_SRC;
>>> +			ev_regs->ev_ths =3D MMA8452_TRANSIENT_THS;
>> ev_ths_mask is not set here
>>
>Good catch! Will fix it=2E
>>> +			ev_regs->ev_count =3D MMA8452_TRANSIENT_COUNT;
>>> +			break;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +	return 0;
>> could replace 'breaks' with return 0 to save some lines and simplify
>> control flow
>Sure=2E
>>> +}
>>> +
>>>   static int mma8452_read_thresh(struct iio_dev *indio_dev,
>>>   			       const struct iio_chan_spec *chan,
>>>   			       enum iio_event_type type,
>>> @@ -749,21 +775,23 @@ static int mma8452_read_thresh(struct iio_dev
>*indio_dev,
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>>   	int ret, us, power_mode;
>>> +	struct mma8452_event_regs ev_regs;
>>>  =20
>>> +	ret =3D mma8452_get_event_regs(chan, dir, &ev_regs);
>>> +	if (ret)
>>> +		return ret;
>>>   	switch (info) {
>>>   	case IIO_EV_INFO_VALUE:
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_ths);
>>> +		ret =3D i2c_smbus_read_byte_data(data->client, ev_regs=2Eev_ths);
>>>   		if (ret < 0)
>>>   			return ret;
>>>  =20
>>> -		*val =3D ret & data->chip_info->ev_ths_mask;
>>> +		*val =3D ret & ev_regs=2Eev_ths_mask;
>>>  =20
>>>   		return IIO_VAL_INT;
>>>  =20
>>>   	case IIO_EV_INFO_PERIOD:
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_count);
>>> +		ret =3D i2c_smbus_read_byte_data(data->client, ev_regs=2Eev_count);
>>>   		if (ret < 0)
>>>   			return ret;
>>>  =20
>>> @@ -809,14 +837,18 @@ static int mma8452_write_thresh(struct iio_dev
>*indio_dev,
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>>   	int ret, reg, steps;
>>> +	struct mma8452_event_regs ev_regs;
>>> +
>>> +	ret =3D mma8452_get_event_regs(chan, dir, &ev_regs);
>>> +	if (ret)
>>> +		return ret;
>>>  =20
>>>   	switch (info) {
>>>   	case IIO_EV_INFO_VALUE:
>>> -		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
>>> +		if (val < 0 || val > ev_regs=2Eev_ths_mask)
>>>   			return -EINVAL;
>>>  =20
>>> -		return mma8452_change_config(data, data->chip_info->ev_ths,
>>> -					     val);
>>> +		return mma8452_change_config(data, ev_regs=2Eev_ths, val);
>>>  =20
>>>   	case IIO_EV_INFO_PERIOD:
>>>   		ret =3D mma8452_get_power_mode(data);
>>> @@ -830,8 +862,7 @@ static int mma8452_write_thresh(struct iio_dev
>*indio_dev,
>>>   		if (steps < 0 || steps > 0xff)
>>>   			return -EINVAL;
>>>  =20
>>> -		return mma8452_change_config(data, data->chip_info->ev_count,
>>> -					     steps);
>>> +		return mma8452_change_config(data, ev_regs=2Eev_count, steps);
>>>  =20
>>>   	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
>>>   		reg =3D i2c_smbus_read_byte_data(data->client,
>>> @@ -861,23 +892,23 @@ static int mma8452_read_event_config(struct
>iio_dev *indio_dev,
>>>   				     enum iio_event_direction dir)
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>   	int ret;
>>>  =20
>>> -	switch (dir) {
>>> -	case IIO_EV_DIR_FALLING:
>>> -		return mma8452_freefall_mode_enabled(data);
>>> -	case IIO_EV_DIR_RISING:
>>> -		if (mma8452_freefall_mode_enabled(data))
>>> -			return 0;
>>> +	switch (chan->type) {
>>> +	case IIO_ACCEL:
>> this adds a check for chan-type =3D=3D IIO_ACCESS, so strictly this wou=
ld
>be
>> an unrelated change=2E=2E=2E
>Ok will remove it from this patch=2E
>>> +		switch (dir) {
>>> +		case IIO_EV_DIR_FALLING:
>>> +			return mma8452_freefall_mode_enabled(data);
>>> +		case IIO_EV_DIR_RISING:
>>> +			ret =3D i2c_smbus_read_byte_data(data->client,
>MMA8452_TRANSIENT_CFG);
>>> +			if (ret < 0)
>>> +				return ret;
>>>  =20
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_cfg);
>>> -		if (ret < 0)
>>> -			return ret;
>>> +			return !!(ret & MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index));
>>>  =20
>>> -		return !!(ret & BIT(chan->scan_index +
>>> -				    chip->ev_cfg_chan_shift));
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>>   	default:
>>>   		return -EINVAL;
>>>   	}
>>> @@ -890,39 +921,33 @@ static int mma8452_write_event_config(struct
>iio_dev *indio_dev,
>>>   				      int state)
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>   	int val, ret;
>>>  =20
>>>   	ret =3D mma8452_set_runtime_pm_state(data->client, state);
>>>   	if (ret)
>>>   		return ret;
>>>  =20
>>> -	switch (dir) {
>>> -	case IIO_EV_DIR_FALLING:
>>> -		return mma8452_set_freefall_mode(data, state);
>>> -	case IIO_EV_DIR_RISING:
>>> -		val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> -		if (val < 0)
>>> -			return val;
>>> -
>>> -		if (state) {
>>> -			if (mma8452_freefall_mode_enabled(data)) {
>>> -				val &=3D ~BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -				val &=3D ~BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -				val &=3D ~BIT(idx_z + chip->ev_cfg_chan_shift);
>>> -				val |=3D MMA8452_FF_MT_CFG_OAE;
>>> -			}
>>> -			val |=3D BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>>> -		} else {
>>> -			if (mma8452_freefall_mode_enabled(data))
>>> -				return 0;
>>> -
>>> -			val &=3D ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
>>> +	switch (chan->type) {
>>> +	case IIO_ACCEL:
>>> +		switch (dir) {
>>> +		case IIO_EV_DIR_FALLING:
>>> +			return mma8452_set_freefall_mode(data, state);
>>> +		case IIO_EV_DIR_RISING:
>>> +			val =3D i2c_smbus_read_byte_data(data->client,
>MMA8452_TRANSIENT_CFG);
>>> +			if (val < 0)
>>> +				return val;
>>> +
>>> +			if (state)
>>> +				val |=3D MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
>>> +			else
>>> +				val &=3D ~MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
>>> +
>>> +			val |=3D MMA8452_TRANSIENT_CFG_ELE;
>>> +
>>> +			return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
>>> +		default:
>>> +			return -EINVAL;
>>>   		}
>>> -
>>> -		val |=3D chip->ev_cfg_ele;
>>> -
>>> -		return mma8452_change_config(data, chip->ev_cfg, val);
>>>   	default:
>>>   		return -EINVAL;
>>>   	}
>>> @@ -934,35 +959,25 @@ static void mma8452_transient_interrupt(struct
>iio_dev *indio_dev)
>>>   	s64 ts =3D iio_get_time_ns(indio_dev);
>>>   	int src;
>>>  =20
>>> -	src =3D i2c_smbus_read_byte_data(data->client,
>data->chip_info->ev_src);
>>> +	src =3D i2c_smbus_read_byte_data(data->client,
>MMA8452_TRANSIENT_SRC);
>>>   	if (src < 0)
>>>   		return;
>>>  =20
>>> -	if (mma8452_freefall_mode_enabled(data)) {
>>> -		iio_push_event(indio_dev,
>>> -			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> -						  IIO_MOD_X_AND_Y_AND_Z,
>>> -						  IIO_EV_TYPE_MAG,
>>> -						  IIO_EV_DIR_FALLING),
>>> -			       ts);
>>> -		return;
>>> -	}
>>> -
>>> -	if (src & data->chip_info->ev_src_xe)
>>> +	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
>>>   		iio_push_event(indio_dev,
>>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>>>   						  IIO_EV_TYPE_MAG,
>>>   						  IIO_EV_DIR_RISING),
>>>   			       ts);
>>>  =20
>>> -	if (src & data->chip_info->ev_src_ye)
>>> +	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
>>>   		iio_push_event(indio_dev,
>>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>>>   						  IIO_EV_TYPE_MAG,
>>>   						  IIO_EV_DIR_RISING),
>>>   			       ts);
>>>  =20
>>> -	if (src & data->chip_info->ev_src_ze)
>>> +	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
>>>   		iio_push_event(indio_dev,
>>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>>>   						  IIO_EV_TYPE_MAG,
>>> @@ -974,23 +989,41 @@ static irqreturn_t mma8452_interrupt(int irq,
>void *p)
>>>   {
>>>   	struct iio_dev *indio_dev =3D p;
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>   	int ret =3D IRQ_NONE;
>>> -	int src;
>>> +	int src, enabled_interrupts;
>>>  =20
>>>   	src =3D i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>>>   	if (src < 0)
>>>   		return IRQ_NONE;
>>>  =20
>>> +	enabled_interrupts =3D i2c_smbus_read_byte_data(data->client,
>>> +					MMA8452_CTRL_REG4);
>>> +	if (enabled_interrupts < 0)
>>> +		return enabled_interrupts;
>>> +
>>> +	if (!(src & enabled_interrupts))
>>> +		return IRQ_NONE;
>>> +
>>>   	if (src & MMA8452_INT_DRDY) {
>>>   		iio_trigger_poll_chained(indio_dev->trig);
>>>   		ret =3D IRQ_HANDLED;
>>>   	}
>>>  =20
>>> -	if ((src & MMA8452_INT_TRANS &&
>>> -	     chip->ev_src =3D=3D MMA8452_TRANSIENT_SRC) ||
>>> -	    (src & MMA8452_INT_FF_MT &&
>>> -	     chip->ev_src =3D=3D MMA8452_FF_MT_SRC)) {
>>> +	if (src & MMA8452_INT_FF_MT) {
>>> +		if (mma8452_freefall_mode_enabled(data)) {
>>> +			s64 ts =3D iio_get_time_ns(indio_dev);
>>> +
>>> +			iio_push_event(indio_dev,
>>> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
>>> +							  IIO_MOD_X_AND_Y_AND_Z,
>>> +							  IIO_EV_TYPE_MAG,
>>> +							  IIO_EV_DIR_FALLING),
>>> +				       ts);
>>> +		}
>>> +		ret =3D IRQ_HANDLED;
>>> +	}
>>> +
>>> +	if (src & MMA8452_INT_TRANS) {
>>>   		mma8452_transient_interrupt(indio_dev);
>>>   		ret =3D IRQ_HANDLED;
>>>   	}
>>> @@ -1222,96 +1255,36 @@ static const struct mma_chip_info
>mma_chip_info_table[] =3D {
>>>   		 *	g * N * 1000000 / 2048 for N =3D 2, 4, 8 and g=3D9=2E80665
>>>   		 */
>>>   		=2Emma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>>> -		=2Eev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 1,
>>> -		=2Eev_src =3D MMA8452_TRANSIENT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -		=2Eev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -		=2Eev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -		=2Eev_ths =3D MMA8452_TRANSIENT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_TRANSIENT_COUNT,
>>>   	},
>>>   	[mma8452] =3D {
>>>   		=2Echip_id =3D MMA8452_DEVICE_ID,
>>>   		=2Echannels =3D mma8452_channels,
>>>   		=2Enum_channels =3D ARRAY_SIZE(mma8452_channels),
>>>   		=2Emma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>>> -		=2Eev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 1,
>>> -		=2Eev_src =3D MMA8452_TRANSIENT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -		=2Eev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -		=2Eev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -		=2Eev_ths =3D MMA8452_TRANSIENT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_TRANSIENT_COUNT,
>>>   	},
>>>   	[mma8453] =3D {
>>>   		=2Echip_id =3D MMA8453_DEVICE_ID,
>>>   		=2Echannels =3D mma8453_channels,
>>>   		=2Enum_channels =3D ARRAY_SIZE(mma8453_channels),
>>>   		=2Emma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} },
>>> -		=2Eev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 1,
>>> -		=2Eev_src =3D MMA8452_TRANSIENT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -		=2Eev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -		=2Eev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -		=2Eev_ths =3D MMA8452_TRANSIENT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_TRANSIENT_COUNT,
>>>   	},
>>>   	[mma8652] =3D {
>>>   		=2Echip_id =3D MMA8652_DEVICE_ID,
>>>   		=2Echannels =3D mma8652_channels,
>>>   		=2Enum_channels =3D ARRAY_SIZE(mma8652_channels),
>>>   		=2Emma_scales =3D { {0, 9577}, {0, 19154}, {0, 38307} },
>>> -		=2Eev_cfg =3D MMA8452_FF_MT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 3,
>>> -		=2Eev_src =3D MMA8452_FF_MT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>>> -		=2Eev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>>> -		=2Eev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>>> -		=2Eev_ths =3D MMA8452_FF_MT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_FF_MT_COUNT,
>>>   	},
>>>   	[mma8653] =3D {
>>>   		=2Echip_id =3D MMA8653_DEVICE_ID,
>>>   		=2Echannels =3D mma8653_channels,
>>>   		=2Enum_channels =3D ARRAY_SIZE(mma8653_channels),
>>>   		=2Emma_scales =3D { {0, 38307}, {0, 76614}, {0, 153228} },
>>> -		=2Eev_cfg =3D MMA8452_FF_MT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_FF_MT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 3,
>>> -		=2Eev_src =3D MMA8452_FF_MT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_FF_MT_SRC_XHE,
>>> -		=2Eev_src_ye =3D MMA8452_FF_MT_SRC_YHE,
>>> -		=2Eev_src_ze =3D MMA8452_FF_MT_SRC_ZHE,
>>> -		=2Eev_ths =3D MMA8452_FF_MT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_FF_MT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_FF_MT_COUNT,
>>>   	},
>>>   	[fxls8471] =3D {
>>>   		=2Echip_id =3D FXLS8471_DEVICE_ID,
>>>   		=2Echannels =3D mma8451_channels,
>>>   		=2Enum_channels =3D ARRAY_SIZE(mma8451_channels),
>>>   		=2Emma_scales =3D { {0, 2394}, {0, 4788}, {0, 9577} },
>>> -		=2Eev_cfg =3D MMA8452_TRANSIENT_CFG,
>>> -		=2Eev_cfg_ele =3D MMA8452_TRANSIENT_CFG_ELE,
>>> -		=2Eev_cfg_chan_shift =3D 1,
>>> -		=2Eev_src =3D MMA8452_TRANSIENT_SRC,
>>> -		=2Eev_src_xe =3D MMA8452_TRANSIENT_SRC_XTRANSE,
>>> -		=2Eev_src_ye =3D MMA8452_TRANSIENT_SRC_YTRANSE,
>>> -		=2Eev_src_ze =3D MMA8452_TRANSIENT_SRC_ZTRANSE,
>>> -		=2Eev_ths =3D MMA8452_TRANSIENT_THS,
>>> -		=2Eev_ths_mask =3D MMA8452_TRANSIENT_THS_MASK,
>>> -		=2Eev_count =3D MMA8452_TRANSIENT_COUNT,
>>>   	},
>>>   };
>>>  =20
>>>
>
>On 08/16/2017 09:12 AM, Peter Meerwald-Stadler wrote:
>> Hello,
>>
>> fixes are always welcome, some comments regarding the patch
>>
>> in subject: typo "enable"
>>
>>> This driver supports multiple devices like mma8653, mma8652,
>mma8452, mma8453 and
>>> fxls8471=2E Almost all these devices have more than one event=2E Curre=
nt
>driver design
>>> hardcodes the event specific information, so only one event can be
>supported by this
>>> driver and current design doesn't have the flexibility to add more
>events=2E
>>  =20
>>> This patch fixes by detaching the event related information from
>chip_info struct,
>>> and based on channel type and event direction the corresponding
>event configuration registers
>>> are picked dynamically=2E Hence multiple events can be handled in
>read/write callbacks=2E
>> which chip can have which event(s)?
>>  =20
>>> Changes are thoroughly tested on fxls8471 device on imx6UL Eval
>board using iio_event_monitor user space program=2E
>>>
>>> After this fix both Freefall and Transient events are handled by the
>driver without any conflicts=2E
>> thanks, p=2E
>>  =20
>>> Signed-off-by: Harinath Nampally <harinath922@gmail=2Ecom>
>>> ---
>>>   drivers/iio/accel/mma8452=2Ec | 309
>++++++++++++++++++++------------------------
>>>   1 file changed, 141 insertions(+), 168 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/mma8452=2Ec
>b/drivers/iio/accel/mma8452=2Ec
>>> index eb6e3dc=2E=2E1b83e52 100644
>>> --- a/drivers/iio/accel/mma8452=2Ec
>>> +++ b/drivers/iio/accel/mma8452=2Ec
>>> @@ -59,7 +59,9 @@
>>>   #define MMA8452_FF_MT_THS			0x17
>>>   #define  MMA8452_FF_MT_THS_MASK			0x7f
>>>   #define MMA8452_FF_MT_COUNT			0x18
>>> +#define MMA8452_FF_MT_CHAN_SHIFT	3
>>>   #define MMA8452_TRANSIENT_CFG			0x1d
>>> +#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
>>>   #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
>>>   #define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
>>>   #define MMA8452_TRANSIENT_SRC			0x1e
>>> @@ -69,6 +71,7 @@
>>>   #define MMA8452_TRANSIENT_THS			0x1f
>>>   #define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
>>>   #define MMA8452_TRANSIENT_COUNT			0x20
>>> +#define MMA8452_TRANSIENT_CHAN_SHIFT 1
>>>   #define MMA8452_CTRL_REG1			0x2a
>>>   #define  MMA8452_CTRL_ACTIVE			BIT(0)
>>>   #define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
>>> @@ -107,6 +110,26 @@ struct mma8452_data {
>>>   	const struct mma_chip_info *chip_info;
>>>   };
>>>  =20
>>> + /**
>>> +  * struct mma8452_event_regs - chip specific data related to
>events
>>> +  * @ev_cfg:			event config register address
>>> +  * @ev_src:			event source register address
>>> +  * @ev_ths:			event threshold register address
>>> +  * @ev_ths_mask:		mask for the threshold value
>>> +  * @ev_count:			event count (period) register address
>>> +  *
>>> +  * Since not all chips supported by the driver support comparing
>high pass
>>> +  * filtered data for events (interrupts), different interrupt
>sources are
>>> +  * used for different chips and the relevant registers are
>included here=2E
>>> +  */
>>> +struct mma8452_event_regs {
>>> +		u8 ev_cfg;
>>> +		u8 ev_src;
>>> +		u8 ev_ths;
>>> +		u8 ev_ths_mask;
>>> +		u8 ev_count;
>>> +};
>>> +
>>>   /**
>>>    * struct mma_chip_info - chip specific data
>>>    * @chip_id:			WHO_AM_I register's value
>>> @@ -116,40 +139,12 @@ struct mma8452_data {
>>>    * @mma_scales:			scale factors for converting register values
>>>    *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>>>    *				per mode: m/s^2 and micro m/s^2
>>> - * @ev_cfg:			event config register address
>>> - * @ev_cfg_ele:			latch bit in event config register
>>> - * @ev_cfg_chan_shift:		number of the bit to enable events in X
>>> - *				direction; in event config register
>>> - * @ev_src:			event source register address
>>> - * @ev_src_xe:			bit in event source register that indicates
>>> - *				an event in X direction
>>> - * @ev_src_ye:			bit in event source register that indicates
>>> - *				an event in Y direction
>>> - * @ev_src_ze:			bit in event source register that indicates
>>> - *				an event in Z direction
>>> - * @ev_ths:			event threshold register address
>>> - * @ev_ths_mask:		mask for the threshold value
>>> - * @ev_count:			event count (period) register address
>>> - *
>>> - * Since not all chips supported by the driver support comparing
>high pass
>>> - * filtered data for events (interrupts), different interrupt
>sources are
>>> - * used for different chips and the relevant registers are included
>here=2E
>>>    */
>>>   struct mma_chip_info {
>>>   	u8 chip_id;
>>>   	const struct iio_chan_spec *channels;
>>>   	int num_channels;
>>>   	const int mma_scales[3][2];
>>> -	u8 ev_cfg;
>>> -	u8 ev_cfg_ele;
>>> -	u8 ev_cfg_chan_shift;
>>> -	u8 ev_src;
>>> -	u8 ev_src_xe;
>>> -	u8 ev_src_ye;
>>> -	u8 ev_src_ze;
>>> -	u8 ev_ths;
>>> -	u8 ev_ths_mask;
>>> -	u8 ev_count;
>>>   };
>>>  =20
>>>   enum {
>>> @@ -602,9 +597,8 @@ static int mma8452_set_power_mode(struct
>mma8452_data *data, u8 mode)
>>>   static int mma8452_freefall_mode_enabled(struct mma8452_data
>*data)
>>>   {
>>>   	int val;
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>  =20
>>> -	val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +	val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>>>   	if (val < 0)
>>>   		return val;
>>>  =20
>>> @@ -614,29 +608,28 @@ static int
>mma8452_freefall_mode_enabled(struct mma8452_data *data)
>>>   static int mma8452_set_freefall_mode(struct mma8452_data *data,
>bool state)
>>>   {
>>>   	int val;
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>  =20
>>>   	if ((state && mma8452_freefall_mode_enabled(data)) ||
>>>   	    (!state && !(mma8452_freefall_mode_enabled(data))))
>>>   		return 0;
>>>  =20
>>> -	val =3D i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
>>> +	val =3D i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>>>   	if (val < 0)
>>>   		return val;
>>>  =20
>>>   	if (state) {
>>> -		val |=3D BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -		val |=3D BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -		val |=3D BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +		val |=3D BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val |=3D BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val |=3D BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>   		val &=3D ~MMA8452_FF_MT_CFG_OAE;
>>>   	} else {
>>> -		val &=3D ~BIT(idx_x + chip->ev_cfg_chan_shift);
>>> -		val &=3D ~BIT(idx_y + chip->ev_cfg_chan_shift);
>>> -		val &=3D ~BIT(idx_z + chip->ev_cfg_chan_shift);
>>> +		val &=3D ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val &=3D ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
>>> +		val &=3D ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>>>   		val |=3D MMA8452_FF_MT_CFG_OAE;
>>>   	}
>>>  =20
>>> -	return mma8452_change_config(data, chip->ev_cfg, val);
>>> +	return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
>>>   }
>>>  =20
>>>   static int mma8452_set_hp_filter_frequency(struct mma8452_data
>*data,
>>> @@ -740,6 +733,39 @@ static int mma8452_write_raw(struct iio_dev
>*indio_dev,
>>>   	return ret;
>>>   }
>>>  =20
>>> +static int mma8452_get_event_regs(const struct iio_chan_spec *chan,
>>> +	       enum iio_event_direction dir,
>>> +		   struct mma8452_event_regs *ev_regs
>>> +	       )
>>> +{
>>> +	if (!chan)
>>> +		return -EINVAL;
>>> +	switch (chan->type) {
>>> +	case IIO_ACCEL:
>>> +		switch (dir) {
>>> +		case IIO_EV_DIR_FALLING:
>>> +			ev_regs->ev_cfg =3D MMA8452_FF_MT_CFG;
>>> +			ev_regs->ev_src =3D MMA8452_FF_MT_SRC;
>>> +			ev_regs->ev_ths =3D MMA8452_FF_MT_THS;
>>> +			ev_regs->ev_ths_mask =3D MMA8452_FF_MT_THS_MASK;
>>> +			ev_regs->ev_count =3D MMA8452_FF_MT_COUNT;
>>> +			break;
>>> +		case IIO_EV_DIR_RISING:
>>> +			ev_regs->ev_cfg =3D MMA8452_TRANSIENT_CFG;
>>> +			ev_regs->ev_src =3D MMA8452_TRANSIENT_SRC;
>>> +			ev_regs->ev_ths =3D MMA8452_TRANSIENT_THS;
>>
>> ev_ths_mask is not set here
>>
>>> +			ev_regs->ev_count =3D MMA8452_TRANSIENT_COUNT;
>>> +			break;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +	return 0;
>> could replace 'breaks' with return 0 to save some lines and simplify
>> control flow
>>
>>> +}
>>> +
>>>   static int mma8452_read_thresh(struct iio_dev *indio_dev,
>>>   			       const struct iio_chan_spec *chan,
>>>   			       enum iio_event_type type,
>>> @@ -749,21 +775,23 @@ static int mma8452_read_thresh(struct iio_dev
>*indio_dev,
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>>   	int ret, us, power_mode;
>>> +	struct mma8452_event_regs ev_regs;
>>>  =20
>>> +	ret =3D mma8452_get_event_regs(chan, dir, &ev_regs);
>>> +	if (ret)
>>> +		return ret;
>>>   	switch (info) {
>>>   	case IIO_EV_INFO_VALUE:
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_ths);
>>> +		ret =3D i2c_smbus_read_byte_data(data->client, ev_regs=2Eev_ths);
>>>   		if (ret < 0)
>>>   			return ret;
>>>  =20
>>> -		*val =3D ret & data->chip_info->ev_ths_mask;
>>> +		*val =3D ret & ev_regs=2Eev_ths_mask;
>>>  =20
>>>   		return IIO_VAL_INT;
>>>  =20
>>>   	case IIO_EV_INFO_PERIOD:
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_count);
>>> +		ret =3D i2c_smbus_read_byte_data(data->client, ev_regs=2Eev_count);
>>>   		if (ret < 0)
>>>   			return ret;
>>>  =20
>>> @@ -809,14 +837,18 @@ static int mma8452_write_thresh(struct iio_dev
>*indio_dev,
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>>   	int ret, reg, steps;
>>> +	struct mma8452_event_regs ev_regs;
>>> +
>>> +	ret =3D mma8452_get_event_regs(chan, dir, &ev_regs);
>>> +	if (ret)
>>> +		return ret;
>>>  =20
>>>   	switch (info) {
>>>   	case IIO_EV_INFO_VALUE:
>>> -		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
>>> +		if (val < 0 || val > ev_regs=2Eev_ths_mask)
>>>   			return -EINVAL;
>>>  =20
>>> -		return mma8452_change_config(data, data->chip_info->ev_ths,
>>> -					     val);
>>> +		return mma8452_change_config(data, ev_regs=2Eev_ths, val);
>>>  =20
>>>   	case IIO_EV_INFO_PERIOD:
>>>   		ret =3D mma8452_get_power_mode(data);
>>> @@ -830,8 +862,7 @@ static int mma8452_write_thresh(struct iio_dev
>*indio_dev,
>>>   		if (steps < 0 || steps > 0xff)
>>>   			return -EINVAL;
>>>  =20
>>> -		return mma8452_change_config(data, data->chip_info->ev_count,
>>> -					     steps);
>>> +		return mma8452_change_config(data, ev_regs=2Eev_count, steps);
>>>  =20
>>>   	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
>>>   		reg =3D i2c_smbus_read_byte_data(data->client,
>>> @@ -861,23 +892,23 @@ static int mma8452_read_event_config(struct
>iio_dev *indio_dev,
>>>   				     enum iio_event_direction dir)
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>   	int ret;
>>>  =20
>>> -	switch (dir) {
>>> -	case IIO_EV_DIR_FALLING:
>>> -		return mma8452_freefall_mode_enabled(data);
>>> -	case IIO_EV_DIR_RISING:
>>> -		if (mma8452_freefall_mode_enabled(data))
>>> -			return 0;
>>> +	switch (chan->type) {
>>> +	case IIO_ACCEL:
>> this adds a check for chan-type =3D=3D IIO_ACCESS, so strictly this wou=
ld
>be
>> an unrelated change=2E=2E=2E
>>
>>> +		switch (dir) {
>>> +		case IIO_EV_DIR_FALLING:
>>> +			return mma8452_freefall_mode_enabled(data);
>>> +		case IIO_EV_DIR_RISING:
>>> +			ret =3D i2c_smbus_read_byte_data(data->client,
>MMA8452_TRANSIENT_CFG);
>>> +			if (ret < 0)
>>> +				return ret;
>>>  =20
>>> -		ret =3D i2c_smbus_read_byte_data(data->client,
>>> -					       data->chip_info->ev_cfg);
>>> -		if (ret < 0)
>>> -			return ret;
>>> +			return !!(ret & MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index));
>>>  =20
>>> -		return !!(ret & BIT(chan->scan_index +
>>> -				    chip->ev_cfg_chan_shift));
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>>   	default:
>>>   		return -EINVAL;
>>>   	}
>>> @@ -890,39 +921,33 @@ static int mma8452_write_event_config(struct
>iio_dev *indio_dev,
>>>   				      int state)
>>>   {
>>>   	struct mma8452_data *data =3D iio_priv(indio_dev);
>>> -	const struct mma_chip_info *chip =3D data->chip_info;
>>>   	int val, ret;
>>>  =20
>>>   	ret =3D mma8452_set_runtime_pm_state(data->client, state);
>>>   	if (ret)
>>>   		retu

--=20
Martin Kepplinger
http://martinkepplinger=2Ecom
sent from mobile
