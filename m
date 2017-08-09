Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbdHINhV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 09:37:21 -0400
Date: Wed, 9 Aug 2017 14:37:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: Re: [PATCH] iio: accel: Bugfix to enbale and allow different events
 to work parallely.
Message-ID: <20170809143709.0d506162@archlinux>
In-Reply-To: <1501499858-4476-1-git-send-email-harinath922@gmail.com>
References: <1501499858-4476-1-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 31 Jul 2017 07:17:38 -0400
Harinath Nampally <harinath922@gmail.com> wrote:

> This driver supports multiple devices like mma8653, mma8652, mma8452, mma8453 and
> fxls8471. Almost all these devices have more than one event. Current driver design
> hardcodes the event specific information, so only one event can be supported by this
> driver and current design doesn't have the flexibility to add more events.
> 
> This patch fixes by detaching the event related information from chip_info struct,
> and based on channel type and event direction the corresponding event configuration registers
> are picked dynamically. Hence multiple events can be handled in read/write callbacks.
> 
> Changes are thoroughly tested on fxls8471 device on imx6UL Eval board using iio_event_monitor user space program.
> 
> After this fix both Freefall and Transient events are handled by the driver without any conflicts.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
Just a quick process point before I catch up with the rest of the thread.
Please ensure you put the driver name in the patch title.  We have a lot
of accelerometers these days and doing that will help draw the attention
of people who care!

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 348 ++++++++++++++++++++++----------------------
>  1 file changed, 175 insertions(+), 173 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index eb6e3dc..114b0e3 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -59,7 +59,9 @@
>  #define MMA8452_FF_MT_THS			0x17
>  #define  MMA8452_FF_MT_THS_MASK			0x7f
>  #define MMA8452_FF_MT_COUNT			0x18
> +#define MMA8452_FF_MT_CHAN_SHIFT	3
>  #define MMA8452_TRANSIENT_CFG			0x1d
> +#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
>  #define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
>  #define MMA8452_TRANSIENT_SRC			0x1e
> @@ -69,6 +71,7 @@
>  #define MMA8452_TRANSIENT_THS			0x1f
>  #define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
>  #define MMA8452_TRANSIENT_COUNT			0x20
> +#define MMA8452_TRANSIENT_CHAN_SHIFT 1
>  #define MMA8452_CTRL_REG1			0x2a
>  #define  MMA8452_CTRL_ACTIVE			BIT(0)
>  #define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
> @@ -107,6 +110,40 @@ struct mma8452_data {
>  	const struct mma_chip_info *chip_info;
>  };
>  
> + /**
> +  * struct mma8452_event_regs - chip specific data related to events
> +  * @ev_cfg:			event config register address
> +  * @ev_cfg_ele:			latch bit in event config register
> +  * @ev_cfg_chan_shift:		number of the bit to enable events in X
> +  *				direction; in event config register
> +  * @ev_src:			event source register address
> +  * @ev_src_xe:			bit in event source register that indicates
> +  *				an event in X direction
> +  * @ev_src_ye:			bit in event source register that indicates
> +  *				an event in Y direction
> +  * @ev_src_ze:			bit in event source register that indicates
> +  *				an event in Z direction
> +  * @ev_ths:			event threshold register address
> +  * @ev_ths_mask:		mask for the threshold value
> +  * @ev_count:			event count (period) register address
> +  *
> +  * Since not all chips supported by the driver support comparing high pass
> +  * filtered data for events (interrupts), different interrupt sources are
> +  * used for different chips and the relevant registers are included here.
> +  */
> +struct mma8452_event_regs {
> +		u8 ev_cfg;
> +		u8 ev_cfg_ele;
> +		u8 ev_cfg_chan_shift;
> +		u8 ev_src;
> +		u8 ev_src_xe;
> +		u8 ev_src_ye;
> +		u8 ev_src_ze;
> +		u8 ev_ths;
> +		u8 ev_ths_mask;
> +		u8 ev_count;
> +};
> +
>  /**
>   * struct mma_chip_info - chip specific data
>   * @chip_id:			WHO_AM_I register's value
> @@ -116,40 +153,12 @@ struct mma8452_data {
>   * @mma_scales:			scale factors for converting register values
>   *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>   *				per mode: m/s^2 and micro m/s^2
> - * @ev_cfg:			event config register address
> - * @ev_cfg_ele:			latch bit in event config register
> - * @ev_cfg_chan_shift:		number of the bit to enable events in X
> - *				direction; in event config register
> - * @ev_src:			event source register address
> - * @ev_src_xe:			bit in event source register that indicates
> - *				an event in X direction
> - * @ev_src_ye:			bit in event source register that indicates
> - *				an event in Y direction
> - * @ev_src_ze:			bit in event source register that indicates
> - *				an event in Z direction
> - * @ev_ths:			event threshold register address
> - * @ev_ths_mask:		mask for the threshold value
> - * @ev_count:			event count (period) register address
> - *
> - * Since not all chips supported by the driver support comparing high pass
> - * filtered data for events (interrupts), different interrupt sources are
> - * used for different chips and the relevant registers are included here.
>   */
>  struct mma_chip_info {
>  	u8 chip_id;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
>  	const int mma_scales[3][2];
> -	u8 ev_cfg;
> -	u8 ev_cfg_ele;
> -	u8 ev_cfg_chan_shift;
> -	u8 ev_src;
> -	u8 ev_src_xe;
> -	u8 ev_src_ye;
> -	u8 ev_src_ze;
> -	u8 ev_ths;
> -	u8 ev_ths_mask;
> -	u8 ev_count;
>  };
>  
>  enum {
> @@ -394,11 +403,11 @@ static ssize_t mma8452_show_os_ratio_avail(struct device *dev,
>  }
>  
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
> -static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       mma8452_show_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
> -		       S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
> -static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, S_IRUGO,
> +		       0444, mma8452_show_hp_cutoff_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, 0444,
>  		       mma8452_show_os_ratio_avail, NULL, 0);
>  
>  static int mma8452_get_samp_freq_index(struct mma8452_data *data,
> @@ -602,9 +611,8 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  {
>  	int val;
> -	const struct mma_chip_info *chip = data->chip_info;
>  
> -	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> +	val = i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>  	if (val < 0)
>  		return val;
>  
> @@ -614,29 +622,28 @@ static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  static int mma8452_set_freefall_mode(struct mma8452_data *data, bool state)
>  {
>  	int val;
> -	const struct mma_chip_info *chip = data->chip_info;
>  
>  	if ((state && mma8452_freefall_mode_enabled(data)) ||
>  	    (!state && !(mma8452_freefall_mode_enabled(data))))
>  		return 0;
>  
> -	val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> +	val = i2c_smbus_read_byte_data(data->client, MMA8452_FF_MT_CFG);
>  	if (val < 0)
>  		return val;
>  
>  	if (state) {
> -		val |= BIT(idx_x + chip->ev_cfg_chan_shift);
> -		val |= BIT(idx_y + chip->ev_cfg_chan_shift);
> -		val |= BIT(idx_z + chip->ev_cfg_chan_shift);
> +		val |= BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> +		val |= BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> +		val |= BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>  		val &= ~MMA8452_FF_MT_CFG_OAE;
>  	} else {
> -		val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
> -		val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
> -		val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
> +		val &= ~BIT(idx_x + MMA8452_FF_MT_CHAN_SHIFT);
> +		val &= ~BIT(idx_y + MMA8452_FF_MT_CHAN_SHIFT);
> +		val &= ~BIT(idx_z + MMA8452_FF_MT_CHAN_SHIFT);
>  		val |= MMA8452_FF_MT_CFG_OAE;
>  	}
>  
> -	return mma8452_change_config(data, chip->ev_cfg, val);
> +	return mma8452_change_config(data, MMA8452_FF_MT_CFG, val);
>  }
>  
>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
> @@ -740,6 +747,50 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int mma8452_get_event_regs(const struct iio_chan_spec *chan,
> +	       enum iio_event_direction dir,
> +		   struct mma8452_event_regs *ev_regs
> +	       )
> +{
> +	if (!chan)
> +		return -EINVAL;
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_FALLING:
> +			ev_regs->ev_cfg = MMA8452_FF_MT_CFG;
> +			ev_regs->ev_cfg_ele = MMA8452_FF_MT_CFG_ELE;
> +			ev_regs->ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT;
> +			ev_regs->ev_src = MMA8452_FF_MT_SRC;
> +			ev_regs->ev_src_xe = MMA8452_FF_MT_SRC_XHE;
> +			ev_regs->ev_src_ye = MMA8452_FF_MT_SRC_YHE;
> +			ev_regs->ev_src_ze = MMA8452_FF_MT_SRC_ZHE;
> +			ev_regs->ev_ths = MMA8452_FF_MT_THS;
> +			ev_regs->ev_ths_mask = MMA8452_FF_MT_THS_MASK;
> +			ev_regs->ev_count = MMA8452_FF_MT_COUNT;
> +			break;
> +		case IIO_EV_DIR_RISING:
> +			ev_regs->ev_cfg = MMA8452_TRANSIENT_CFG;
> +			ev_regs->ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE;
> +			ev_regs->ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT;
> +			ev_regs->ev_src = MMA8452_TRANSIENT_SRC;
> +			ev_regs->ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE;
> +			ev_regs->ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE;
> +			ev_regs->ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE;
> +			ev_regs->ev_ths = MMA8452_TRANSIENT_THS;
> +			ev_regs->ev_ths_mask = MMA8452_TRANSIENT_THS_MASK;
> +			ev_regs->ev_count = MMA8452_TRANSIENT_COUNT;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  			       const struct iio_chan_spec *chan,
>  			       enum iio_event_type type,
> @@ -749,21 +800,24 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, us, power_mode;
> +	struct mma8452_event_regs ev_regs;
>  
> +	ret = mma8452_get_event_regs(chan, dir, &ev_regs);
> +	if (ret)
> +		return ret;
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		ret = i2c_smbus_read_byte_data(data->client,
> -					       data->chip_info->ev_ths);
> +		ret = i2c_smbus_read_byte_data(data->client, ev_regs.ev_ths);
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret & data->chip_info->ev_ths_mask;
> +		*val = ret & ev_regs.ev_ths_mask;
>  
>  		return IIO_VAL_INT;
>  
>  	case IIO_EV_INFO_PERIOD:
>  		ret = i2c_smbus_read_byte_data(data->client,
> -					       data->chip_info->ev_count);
> +									ev_regs.ev_count);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -809,14 +863,18 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, reg, steps;
> +	struct mma8452_event_regs ev_regs;
> +
> +	ret = mma8452_get_event_regs(chan, dir, &ev_regs);
> +	if (ret)
> +		return ret;
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
> +		if (val < 0 || val > ev_regs.ev_ths_mask)
>  			return -EINVAL;
>  
> -		return mma8452_change_config(data, data->chip_info->ev_ths,
> -					     val);
> +		return mma8452_change_config(data, ev_regs.ev_ths, val);
>  
>  	case IIO_EV_INFO_PERIOD:
>  		ret = mma8452_get_power_mode(data);
> @@ -830,8 +888,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  		if (steps < 0 || steps > 0xff)
>  			return -EINVAL;
>  
> -		return mma8452_change_config(data, data->chip_info->ev_count,
> -					     steps);
> +		return mma8452_change_config(data, ev_regs.ev_count, steps);
>  
>  	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
>  		reg = i2c_smbus_read_byte_data(data->client,
> @@ -861,26 +918,29 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	const struct mma_chip_info *chip = data->chip_info;
>  	int ret;
>  
> -	switch (dir) {
> -	case IIO_EV_DIR_FALLING:
> -		return mma8452_freefall_mode_enabled(data);
> -	case IIO_EV_DIR_RISING:
> -		if (mma8452_freefall_mode_enabled(data))
> -			return 0;
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_FALLING:
> +			return mma8452_freefall_mode_enabled(data);
> +		case IIO_EV_DIR_RISING:
> +			ret = i2c_smbus_read_byte_data(data->client,
> +										MMA8452_TRANSIENT_CFG);
> +			if (ret < 0)
> +				return ret;
>  
> -		ret = i2c_smbus_read_byte_data(data->client,
> -					       data->chip_info->ev_cfg);
> -		if (ret < 0)
> -			return ret;
> +			return ret & MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index) ? 1 : 0;
>  
> -		return !!(ret & BIT(chan->scan_index +
> -				    chip->ev_cfg_chan_shift));
> +		default:
> +			return -EINVAL;
> +		}
> +	break;
>  	default:
>  		return -EINVAL;
>  	}
> +	return 0;
>  }
>  
>  static int mma8452_write_event_config(struct iio_dev *indio_dev,
> @@ -890,39 +950,36 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  				      int state)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	const struct mma_chip_info *chip = data->chip_info;
>  	int val, ret;
>  
>  	ret = mma8452_set_runtime_pm_state(data->client, state);
> +
>  	if (ret)
>  		return ret;
>  
> -	switch (dir) {
> -	case IIO_EV_DIR_FALLING:
> -		return mma8452_set_freefall_mode(data, state);
> -	case IIO_EV_DIR_RISING:
> -		val = i2c_smbus_read_byte_data(data->client, chip->ev_cfg);
> -		if (val < 0)
> -			return val;
> -
> -		if (state) {
> -			if (mma8452_freefall_mode_enabled(data)) {
> -				val &= ~BIT(idx_x + chip->ev_cfg_chan_shift);
> -				val &= ~BIT(idx_y + chip->ev_cfg_chan_shift);
> -				val &= ~BIT(idx_z + chip->ev_cfg_chan_shift);
> -				val |= MMA8452_FF_MT_CFG_OAE;
> -			}
> -			val |= BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> -		} else {
> -			if (mma8452_freefall_mode_enabled(data))
> -				return 0;
> -
> -			val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		switch (dir) {
> +		case IIO_EV_DIR_FALLING:
> +			return mma8452_set_freefall_mode(data, state);
> +		case IIO_EV_DIR_RISING:
> +			val = i2c_smbus_read_byte_data(data->client,
> +											MMA8452_TRANSIENT_CFG);
> +			if (val < 0)
> +				return val;
> +
> +			if (state)
> +				val |= MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
> +			else
> +				val &= ~MMA8452_TRANSIENT_CFG_CHAN(chan->scan_index);
> +
> +			val |= MMA8452_TRANSIENT_CFG_ELE;
> +
> +			return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
> +		default:
> +			return -EINVAL;
>  		}
> -
> -		val |= chip->ev_cfg_ele;
> -
> -		return mma8452_change_config(data, chip->ev_cfg, val);
> +	break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -934,35 +991,25 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>  	s64 ts = iio_get_time_ns(indio_dev);
>  	int src;
>  
> -	src = i2c_smbus_read_byte_data(data->client, data->chip_info->ev_src);
> +	src = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_SRC);
>  	if (src < 0)
>  		return;
>  
> -	if (mma8452_freefall_mode_enabled(data)) {
> -		iio_push_event(indio_dev,
> -			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> -						  IIO_MOD_X_AND_Y_AND_Z,
> -						  IIO_EV_TYPE_MAG,
> -						  IIO_EV_DIR_FALLING),
> -			       ts);
> -		return;
> -	}
> -
> -	if (src & data->chip_info->ev_src_xe)
> +	if (src & MMA8452_TRANSIENT_SRC_XTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & data->chip_info->ev_src_ye)
> +	if (src & MMA8452_TRANSIENT_SRC_YTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>  						  IIO_EV_TYPE_MAG,
>  						  IIO_EV_DIR_RISING),
>  			       ts);
>  
> -	if (src & data->chip_info->ev_src_ze)
> +	if (src & MMA8452_TRANSIENT_SRC_ZTRANSE)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>  						  IIO_EV_TYPE_MAG,
> @@ -974,23 +1021,38 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	const struct mma_chip_info *chip = data->chip_info;
>  	int ret = IRQ_NONE;
> -	int src;
> +	int src, enabled_interrupts;
>  
>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>  	if (src < 0)
>  		return IRQ_NONE;
>  
> -	if (src & MMA8452_INT_DRDY) {
> +	enabled_interrupts = i2c_smbus_read_byte_data(data->client,
> +					MMA8452_CTRL_REG4);
> +	if (enabled_interrupts < 0)
> +		return enabled_interrupts;
> +
> +	if ((src & MMA8452_INT_DRDY) && (src & enabled_interrupts)) {
>  		iio_trigger_poll_chained(indio_dev->trig);
>  		ret = IRQ_HANDLED;
>  	}
>  
> -	if ((src & MMA8452_INT_TRANS &&
> -	     chip->ev_src == MMA8452_TRANSIENT_SRC) ||
> -	    (src & MMA8452_INT_FF_MT &&
> -	     chip->ev_src == MMA8452_FF_MT_SRC)) {
> +	if ((src & MMA8452_INT_FF_MT) && (src & enabled_interrupts)) {
> +		if (mma8452_freefall_mode_enabled(data)) {
> +			s64 ts = iio_get_time_ns(indio_dev);
> +
> +			iio_push_event(indio_dev,
> +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							  IIO_MOD_X_AND_Y_AND_Z,
> +							  IIO_EV_TYPE_MAG,
> +							  IIO_EV_DIR_FALLING),
> +				       ts);
> +		}
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if ((src & MMA8452_INT_TRANS) && (src & enabled_interrupts)) {
>  		mma8452_transient_interrupt(indio_dev);
>  		ret = IRQ_HANDLED;
>  	}
> @@ -1020,8 +1082,8 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  }
>  
>  static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
> -				  unsigned reg, unsigned writeval,
> -				  unsigned *readval)
> +				  unsigned int reg, unsigned int writeval,
> +				  unsigned int *readval)
>  {
>  	int ret;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> @@ -1222,96 +1284,36 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		 *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
>  		 */
>  		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
> -		.ev_cfg = MMA8452_TRANSIENT_CFG,
> -		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> -		.ev_cfg_chan_shift = 1,
> -		.ev_src = MMA8452_TRANSIENT_SRC,
> -		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> -		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> -		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> -		.ev_ths = MMA8452_TRANSIENT_THS,
> -		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> -		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
>  	[mma8452] = {
>  		.chip_id = MMA8452_DEVICE_ID,
>  		.channels = mma8452_channels,
>  		.num_channels = ARRAY_SIZE(mma8452_channels),
>  		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
> -		.ev_cfg = MMA8452_TRANSIENT_CFG,
> -		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> -		.ev_cfg_chan_shift = 1,
> -		.ev_src = MMA8452_TRANSIENT_SRC,
> -		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> -		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> -		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> -		.ev_ths = MMA8452_TRANSIENT_THS,
> -		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> -		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
>  	[mma8453] = {
>  		.chip_id = MMA8453_DEVICE_ID,
>  		.channels = mma8453_channels,
>  		.num_channels = ARRAY_SIZE(mma8453_channels),
>  		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
> -		.ev_cfg = MMA8452_TRANSIENT_CFG,
> -		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> -		.ev_cfg_chan_shift = 1,
> -		.ev_src = MMA8452_TRANSIENT_SRC,
> -		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> -		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> -		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> -		.ev_ths = MMA8452_TRANSIENT_THS,
> -		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> -		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
>  	[mma8652] = {
>  		.chip_id = MMA8652_DEVICE_ID,
>  		.channels = mma8652_channels,
>  		.num_channels = ARRAY_SIZE(mma8652_channels),
>  		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
> -		.ev_cfg = MMA8452_FF_MT_CFG,
> -		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> -		.ev_cfg_chan_shift = 3,
> -		.ev_src = MMA8452_FF_MT_SRC,
> -		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
> -		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
> -		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
> -		.ev_ths = MMA8452_FF_MT_THS,
> -		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> -		.ev_count = MMA8452_FF_MT_COUNT,
>  	},
>  	[mma8653] = {
>  		.chip_id = MMA8653_DEVICE_ID,
>  		.channels = mma8653_channels,
>  		.num_channels = ARRAY_SIZE(mma8653_channels),
>  		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
> -		.ev_cfg = MMA8452_FF_MT_CFG,
> -		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> -		.ev_cfg_chan_shift = 3,
> -		.ev_src = MMA8452_FF_MT_SRC,
> -		.ev_src_xe = MMA8452_FF_MT_SRC_XHE,
> -		.ev_src_ye = MMA8452_FF_MT_SRC_YHE,
> -		.ev_src_ze = MMA8452_FF_MT_SRC_ZHE,
> -		.ev_ths = MMA8452_FF_MT_THS,
> -		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> -		.ev_count = MMA8452_FF_MT_COUNT,
>  	},
>  	[fxls8471] = {
>  		.chip_id = FXLS8471_DEVICE_ID,
>  		.channels = mma8451_channels,
>  		.num_channels = ARRAY_SIZE(mma8451_channels),
>  		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
> -		.ev_cfg = MMA8452_TRANSIENT_CFG,
> -		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> -		.ev_cfg_chan_shift = 1,
> -		.ev_src = MMA8452_TRANSIENT_SRC,
> -		.ev_src_xe = MMA8452_TRANSIENT_SRC_XTRANSE,
> -		.ev_src_ye = MMA8452_TRANSIENT_SRC_YTRANSE,
> -		.ev_src_ze = MMA8452_TRANSIENT_SRC_ZTRANSE,
> -		.ev_ths = MMA8452_TRANSIENT_THS,
> -		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> -		.ev_count = MMA8452_TRANSIENT_COUNT,
>  	},
>  };
>  

