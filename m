Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9894 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140AbbDJKhC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Apr 2015 06:37:02 -0400
Date: Fri, 10 Apr 2015 13:36:58 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: sx9500: optimize power usage
Message-ID: <20150410103658.GB11961@vdogaru>
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
 <1428065254-6444-3-git-send-email-vlad.dogaru@intel.com>
 <5526A876.8040108@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5526A876.8040108@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 09, 2015 at 05:27:34PM +0100, Jonathan Cameron wrote:
> On 03/04/15 13:47, Vlad Dogaru wrote:
> > In the interest of lowering power usage, we only activate the proximity
> > channels and interrupts that we are currently using.
> > 
> > For raw reads, we activate the corresponding channel and the data ready
> > interrupt and wait for the interrupt to trigger.  Thus, it is no longer
> > optional to register an irq.
> This change bothers me.  We may well have people with the device that
> don't have the interrupt wired and if they are already using the driver
> then we have a resulting regression.
> 
> Any chance we could have an alternative of a registering polling or similar
> to identify when the interrupt would have occured?

Sure, I have a patch queued up that calls msleep instead of waiting for
an interrupt if one is not available.

But I'm not exactly sure which patches I should resend.  You mentioned
you applied some of the series, but I can't find anything in testing or
togreg.

Or am i confused and you would rather I resent the whole series?

> 
> > 
> > The following types of usage patterns may overlap:
> > 
> > * raw proximity reads (need a single data ready interrupt)
> We often avoid this complexity by just failing raw reads when
> the buffer is running but the solution you have here is pretty
> elegant.
> > * trigger usage (needs data ready interrupts as long as active)
> > * proximity events (need near/far interrupts)
> > * triggered buffer reads (don't need any interrupts, but are usually
> > coupled with our own trigger.
> 
> An alternative, perhaps more standard method, would be to handle this via
> an interrupt chip and let that infrastructure be responisble for the
> underlying real interrupts. I'm not sure which approach would be more
> complex though so perhaps, though I'd have gone that way, what you have
> here is the best way...
> 
> > 
> > To mitigate all possible patterns, we implement usage counting for all
> > the resources used: data ready interrupts, near/far interrupts and
> > individual channels.
> > 
> > The device enters sleep mode as documented in the data sheet when its
> > buffer, trigger and events are disabled, and no raw reads are currently
> > running.
> > 
> > Because of this new usage pattern, it is important that we give the
> > device a chance to perform an initial compensation for all its channels
> > at probe time.
> > 
> > Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> > ---
> >  drivers/iio/proximity/sx9500.c | 376 +++++++++++++++++++++++++++++++++--------
> >  1 file changed, 302 insertions(+), 74 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> > index f62d0b6..94c56f3 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/regmap.h>
> >  #include <linux/pm.h>
> > +#include <linux/delay.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> > @@ -74,6 +75,7 @@
> >  #define SX9500_CONVDONE_IRQ		BIT(3)
> >  
> >  #define SX9500_PROXSTAT_SHIFT		4
> > +#define SX9500_COMPSTAT_MASK		GENMASK(3, 0)
> >  
> >  #define SX9500_NUM_CHANNELS		4
> >  
> > @@ -92,6 +94,9 @@ struct sx9500_data {
> >  	u16 *buffer;
> >  	/* Remember enabled channels and sample rate during suspend. */
> >  	unsigned int suspend_ctrl0;
> > +	struct completion completion;
> > +	int data_rdy_users, close_far_users;
> > +	int channel_users[SX9500_NUM_CHANNELS];
> >  };
> >  
> >  static const struct iio_event_spec sx9500_events[] = {
> > @@ -194,7 +199,67 @@ static const struct regmap_config sx9500_regmap_config = {
> >  	.volatile_table = &sx9500_volatile_regs,
> >  };
> >  
> > -static int sx9500_read_proximity(struct sx9500_data *data,
> > +static int sx9500_inc_users(struct sx9500_data *data, int *counter,
> > +			    unsigned int reg, unsigned int bitmask)
> > +{
> > +	(*counter)++;
> > +	if (*counter != 1)
> > +		/* Bit is already active, nothing to do. */
> > +		return 0;
> > +
> > +	return regmap_update_bits(data->regmap, reg, bitmask, bitmask);
> > +}
> > +
> > +static int sx9500_dec_users(struct sx9500_data *data, int *counter,
> > +			    unsigned int reg, unsigned int bitmask)
> > +{
> > +	(*counter)--;
> > +	if (*counter != 0)
> > +		/* There are more users, do not deactivate. */
> > +		return 0;
> > +
> > +	return regmap_update_bits(data->regmap, reg, bitmask, 0);
> > +}
> > +
> > +static int sx9500_inc_chan_users(struct sx9500_data *data, int chan)
> > +{
> > +	return sx9500_inc_users(data, &data->channel_users[chan],
> > +				SX9500_REG_PROX_CTRL0, BIT(chan));
> > +}
> > +
> > +static int sx9500_dec_chan_users(struct sx9500_data *data, int chan)
> > +{
> > +	return sx9500_dec_users(data, &data->channel_users[chan],
> > +				SX9500_REG_PROX_CTRL0, BIT(chan));
> > +}
> > +
> > +static int sx9500_inc_data_rdy_users(struct sx9500_data *data)
> > +{
> > +	return sx9500_inc_users(data, &data->data_rdy_users,
> > +				SX9500_REG_IRQ_MSK, SX9500_CONVDONE_IRQ);
> > +}
> > +
> > +static int sx9500_dec_data_rdy_users(struct sx9500_data *data)
> > +{
> > +	return sx9500_dec_users(data, &data->data_rdy_users,
> > +				SX9500_REG_IRQ_MSK, SX9500_CONVDONE_IRQ);
> > +}
> > +
> > +static int sx9500_inc_close_far_users(struct sx9500_data *data)
> > +{
> > +	return sx9500_inc_users(data, &data->close_far_users,
> > +				SX9500_REG_IRQ_MSK,
> > +				SX9500_CLOSE_IRQ | SX9500_FAR_IRQ);
> > +}
> > +
> > +static int sx9500_dec_close_far_users(struct sx9500_data *data)
> > +{
> > +	return sx9500_dec_users(data, &data->close_far_users,
> > +				SX9500_REG_IRQ_MSK,
> > +				SX9500_CLOSE_IRQ | SX9500_FAR_IRQ);
> > +}
> > +
> > +static int sx9500_read_prox_data(struct sx9500_data *data,
> >  				 const struct iio_chan_spec *chan,
> >  				 int *val)
> >  {
> > @@ -203,15 +268,66 @@ static int sx9500_read_proximity(struct sx9500_data *data,
> >  
> >  	ret = regmap_write(data->regmap, SX9500_REG_SENSOR_SEL, chan->channel);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> >  
> >  	ret = regmap_bulk_read(data->regmap, SX9500_REG_USE_MSB, &regval, 2);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> >  
> >  	*val = 32767 - (s16)be16_to_cpu(regval);
> > +	ret = IIO_VAL_INT;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int sx9500_read_proximity(struct sx9500_data *data,
> > +				 const struct iio_chan_spec *chan,
> > +				 int *val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = sx9500_inc_chan_users(data, chan->channel);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = sx9500_inc_data_rdy_users(data);
> > +	if (ret < 0)
> > +		goto out_dec_chan;
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	ret = wait_for_completion_interruptible(&data->completion);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	return IIO_VAL_INT;
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = sx9500_read_prox_data(data, chan, val);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = sx9500_dec_chan_users(data, chan->channel);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = sx9500_dec_data_rdy_users(data);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = IIO_VAL_INT;
> > +
> > +	goto out;
> > +
> > +out_dec_chan:
> > +	sx9500_dec_chan_users(data, chan->channel);
> > +out:
> > +	mutex_unlock(&data->mutex);
> > +	reinit_completion(&data->completion);
> > +
> > +	return ret;
> >  }
> >  
> >  static int sx9500_read_samp_freq(struct sx9500_data *data,
> > @@ -239,7 +355,6 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
> >  			   int *val, int *val2, long mask)
> >  {
> >  	struct sx9500_data *data = iio_priv(indio_dev);
> > -	int ret;
> >  
> >  	switch (chan->type) {
> >  	case IIO_PROXIMITY:
> > @@ -247,10 +362,7 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
> >  		case IIO_CHAN_INFO_RAW:
> >  			if (iio_buffer_enabled(indio_dev))
> >  				return -EBUSY;
> > -			mutex_lock(&data->mutex);
> > -			ret = sx9500_read_proximity(data, chan, val);
> > -			mutex_unlock(&data->mutex);
> > -			return ret;
> > +			return sx9500_read_proximity(data, chan, val);
> >  		case IIO_CHAN_INFO_SAMP_FREQ:
> >  			return sx9500_read_samp_freq(data, val, val2);
> >  		default:
> > @@ -321,28 +433,16 @@ static irqreturn_t sx9500_irq_handler(int irq, void *private)
> >  	return IRQ_WAKE_THREAD;
> >  }
> >  
> > -static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
> > +static void sx9500_push_events(struct iio_dev *indio_dev)
> >  {
> > -	struct iio_dev *indio_dev = private;
> > -	struct sx9500_data *data = iio_priv(indio_dev);
> >  	int ret;
> >  	unsigned int val, chan;
> > -
> > -	mutex_lock(&data->mutex);
> > -
> > -	ret = regmap_read(data->regmap, SX9500_REG_IRQ_SRC, &val);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "i2c transfer error in irq\n");
> > -		goto out;
> > -	}
> > -
> > -	if (!(val & (SX9500_CLOSE_IRQ | SX9500_FAR_IRQ)))
> > -		goto out;
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> >  
> >  	ret = regmap_read(data->regmap, SX9500_REG_STAT, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "i2c transfer error in irq\n");
> > -		goto out;
> > +		return;
> >  	}
> >  
> >  	val >>= SX9500_PROXSTAT_SHIFT;
> > @@ -357,15 +457,34 @@ static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
> >  			/* No change on this channel. */
> >  			continue;
> >  
> > -		dir = new_prox ? IIO_EV_DIR_FALLING :
> > -			IIO_EV_DIR_RISING;
> > -		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> > -					  chan,
> > -					  IIO_EV_TYPE_THRESH,
> > -					  dir);
> > +		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > +		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
> > +					  IIO_EV_TYPE_THRESH, dir);
> >  		iio_push_event(indio_dev, ev, iio_get_time_ns());
> >  		data->prox_stat[chan] = new_prox;
> >  	}
> > +}
> > +
> > +static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = regmap_read(data->regmap, SX9500_REG_IRQ_SRC, &val);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "i2c transfer error in irq\n");
> > +		goto out;
> > +	}
> > +
> > +	if (val & (SX9500_CLOSE_IRQ | SX9500_FAR_IRQ))
> > +		sx9500_push_events(indio_dev);
> > +
> > +	if (val & SX9500_CONVDONE_IRQ)
> > +		complete_all(&data->completion);
> >  
> >  out:
> >  	mutex_unlock(&data->mutex);
> > @@ -394,9 +513,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
> >  				     int state)
> >  {
> >  	struct sx9500_data *data = iio_priv(indio_dev);
> > -	int ret, i;
> > -	bool any_active = false;
> > -	unsigned int irqmask;
> > +	int ret;
> >  
> >  	if (chan->type != IIO_PROXIMITY || type != IIO_EV_TYPE_THRESH ||
> >  	    dir != IIO_EV_DIR_EITHER)
> > @@ -404,24 +521,32 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
> >  
> >  	mutex_lock(&data->mutex);
> >  
> > -	data->event_enabled[chan->channel] = state;
> > +	if (state == 1) {
> Is if (state) not sufficient?
> > +		ret = sx9500_inc_chan_users(data, chan->channel);
> > +		if (ret < 0)
> > +			goto out_unlock;
> > +		ret = sx9500_inc_close_far_users(data);
> > +		if (ret < 0)
> > +			goto out_undo_chan;
> > +	} else {
> > +		ret = sx9500_dec_chan_users(data, chan->channel);
> > +		if (ret < 0)
> > +			goto out_unlock;
> > +		ret = sx9500_dec_close_far_users(data);
> > +		if (ret < 0)
> > +			goto out_undo_chan;
> > +	}
> >  
> > -	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> > -		if (data->event_enabled[i]) {
> > -			any_active = true;
> > -			break;
> > -		}
> > +	data->event_enabled[chan->channel] = state;
> > +	goto out_unlock;
> >  
> > -	irqmask = SX9500_CLOSE_IRQ | SX9500_FAR_IRQ;
> > -	if (any_active)
> > -		ret = regmap_update_bits(data->regmap, SX9500_REG_IRQ_MSK,
> > -					 irqmask, irqmask);
> > +out_undo_chan:
> > +	if (state == 1)
> > +		sx9500_dec_chan_users(data, chan->channel);
> >  	else
> > -		ret = regmap_update_bits(data->regmap, SX9500_REG_IRQ_MSK,
> > -					 irqmask, 0);
> > -
> > +		sx9500_inc_chan_users(data, chan->channel);
> > +out_unlock:
> >  	mutex_unlock(&data->mutex);
> > -
> >  	return ret;
> >  }
> >  
> > @@ -472,12 +597,16 @@ static int sx9500_set_trigger_state(struct iio_trigger *trig,
> >  
> >  	mutex_lock(&data->mutex);
> >  
> > -	ret = regmap_update_bits(data->regmap, SX9500_REG_IRQ_MSK,
> > -				 SX9500_CONVDONE_IRQ,
> > -				 state ? SX9500_CONVDONE_IRQ : 0);
> > -	if (ret == 0)
> > -		data->trigger_enabled = state;
> > +	if (state)
> > +		ret = sx9500_inc_data_rdy_users(data);
> > +	else
> > +		ret = sx9500_dec_data_rdy_users(data);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	data->trigger_enabled = state;
> >  
> > +out:
> >  	mutex_unlock(&data->mutex);
> >  
> >  	return ret;
> > @@ -499,7 +628,7 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
> >  
> >  	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> >  			 indio_dev->masklength) {
> > -		ret = sx9500_read_proximity(data, &indio_dev->channels[bit],
> > +		ret = sx9500_read_prox_data(data, &indio_dev->channels[bit],
> >  					    &val);
> >  		if (ret < 0)
> >  			goto out;
> > @@ -518,6 +647,62 @@ out:
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +static int sx9500_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret, i;
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> > +		if (test_bit(i, indio_dev->active_scan_mask)) {
> > +			ret = sx9500_inc_chan_users(data, i);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> > +	if (ret)
> > +		for (i = i - 1; i >= 0; i--)
> > +			if (test_bit(i, indio_dev->active_scan_mask))
> > +				sx9500_dec_chan_users(data, i);
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int ret, i;
> > +
> > +	iio_triggered_buffer_predisable(indio_dev);
> > +
> > +	mutex_lock(&data->mutex);
> > +
> > +	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> > +		if (test_bit(i, indio_dev->active_scan_mask)) {
> > +			ret = sx9500_dec_chan_users(data, i);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> > +	if (ret)
> > +		for (i = i - 1; i >= 0; i--)
> > +			if (test_bit(i, indio_dev->active_scan_mask))
> > +				sx9500_inc_chan_users(data, i);
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
> > +	.preenable = sx9500_buffer_preenable,
> > +	.postenable = iio_triggered_buffer_postenable,
> > +	.predisable = sx9500_buffer_predisable,
> > +};
> > +
> >  struct sx9500_reg_default {
> >  	u8 reg;
> >  	u8 def;
> > @@ -573,11 +758,44 @@ static const struct sx9500_reg_default sx9500_default_regs[] = {
> >  	},
> >  	{
> >  		.reg = SX9500_REG_PROX_CTRL0,
> > -		/* Scan period: 30ms, all sensors enabled. */
> > -		.def = 0x0f,
> > +		/* Scan period: 30ms, all sensors disabled. */
> > +		.def = 0x00,
> >  	},
> >  };
> >  
> > +/* Activate all channels and perform an initial compensation. */
> > +static int sx9500_init_compensation(struct iio_dev *indio_dev)
> > +{
> > +	struct sx9500_data *data = iio_priv(indio_dev);
> > +	int i, ret;
> > +	unsigned int val;
> > +
> > +	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
> > +				 GENMASK(SX9500_NUM_CHANNELS, 0),
> > +				 GENMASK(SX9500_NUM_CHANNELS, 0));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (i = 10; i >= 0; i--) {
> > +		usleep_range(10000, 20000);
> > +		ret = regmap_read(data->regmap, SX9500_REG_STAT, &val);
> > +		if (ret < 0)
> > +			goto out;
> > +		if (!(val & SX9500_COMPSTAT_MASK))
> > +			break;
> > +	}
> > +
> > +	if (i < 0) {
> > +		dev_err(&data->client->dev, "initial compensation timed out");
> > +		ret = -ETIMEDOUT;
> > +	}
> > +
> > +out:
> > +	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
> > +			   GENMASK(SX9500_NUM_CHANNELS, 0), 0);
> > +	return ret;
> > +}
> > +
> >  static int sx9500_init_device(struct iio_dev *indio_dev)
> >  {
> >  	struct sx9500_data *data = iio_priv(indio_dev);
> > @@ -605,6 +823,10 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
> >  			return ret;
> >  	}
> >  
> > +	ret = sx9500_init_compensation(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -652,6 +874,7 @@ static int sx9500_probe(struct i2c_client *client,
> >  	data = iio_priv(indio_dev);
> >  	data->client = client;
> >  	mutex_init(&data->mutex);
> > +	init_completion(&data->completion);
> >  	data->trigger_enabled = false;
> >  
> >  	data->regmap = devm_regmap_init_i2c(client, &sx9500_regmap_config);
> > @@ -671,30 +894,35 @@ static int sx9500_probe(struct i2c_client *client,
> >  	if (client->irq <= 0)
> >  		client->irq = sx9500_gpio_probe(client, data);
> >  
> > -	if (client->irq > 0) {
> > -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > -				sx9500_irq_handler, sx9500_irq_thread_handler,
> > -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -				SX9500_IRQ_NAME, indio_dev);
> > -		if (ret < 0)
> > -			return ret;
> > +	if (client->irq <= 0) {
> > +		dev_err(&client->dev, "no valid irq found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +					sx9500_irq_handler,
> > +					sx9500_irq_thread_handler,
> > +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +					SX9500_IRQ_NAME, indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -		data->trig = devm_iio_trigger_alloc(&client->dev,
> > -				"%s-dev%d", indio_dev->name, indio_dev->id);
> > -		if (!data->trig)
> > -			return -ENOMEM;
> > +	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> > +					    indio_dev->name, indio_dev->id);
> > +	if (!data->trig)
> > +		return -ENOMEM;
> >  
> > -		data->trig->dev.parent = &client->dev;
> > -		data->trig->ops = &sx9500_trigger_ops;
> > -		iio_trigger_set_drvdata(data->trig, indio_dev);
> > +	data->trig->dev.parent = &client->dev;
> > +	data->trig->ops = &sx9500_trigger_ops;
> > +	iio_trigger_set_drvdata(data->trig, indio_dev);
> >  
> > -		ret = iio_trigger_register(data->trig);
> > -		if (ret)
> > -			return ret;
> > -	}
> > +	ret = iio_trigger_register(data->trig);
> > +	if (ret)
> > +		return ret;
> >  
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > -					 sx9500_trigger_handler, NULL);
> > +					 sx9500_trigger_handler,
> > +					 &sx9500_buffer_setup_ops);
> >  	if (ret < 0)
> >  		goto out_trigger_unregister;
> >  
> > 
> 
