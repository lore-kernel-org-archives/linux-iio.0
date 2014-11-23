Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:52767 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbaKWXHA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Nov 2014 18:07:00 -0500
Message-ID: <5472688D.9010801@gmx.de>
Date: Mon, 24 Nov 2014 00:06:53 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@intel.com
Subject: Re: [RFC 6/8] iio: bmc150: introduce bmc150_accel_trigger
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com> <1416246966-3083-7-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-7-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Octavian Purdila schrieb am 17.11.2014 18:56:
> Add a separate structure for triggers and add the infrastructure to
> support an arbitrary number of triggers. Each trigger is associated
> with an interrupt and has an enabled/disabled state.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  drivers/iio/accel/bmc150-accel.c | 175 ++++++++++++++++++++++-----------------
>  1 file changed, 101 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 5a430dc..ed02ced 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -156,14 +156,21 @@ struct bmc150_accel_interrupt {
>  	atomic_t users;
>  };
>  
> +struct bmc150_accel_trigger {
> +	struct bmc150_accel_interrupt *intr;
> +	struct bmc150_accel_data *data;
> +	struct iio_trigger *indio_trig;
> +	bool enabled;
> +};
> +
>  #define BMC150_ACCEL_INTERRUPTS		2
> +#define BMC150_ACCEL_TRIGGERS		2
>  
>  struct bmc150_accel_data {
>  	struct i2c_client *client;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
> -	struct iio_trigger *dready_trig;
> -	struct iio_trigger *motion_trig;
>  	atomic_t active_intr;
> +	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
>  	s16 buffer[8];
>  	u8 bw_bits;
> @@ -171,8 +178,6 @@ struct bmc150_accel_data {
>  	u32 slope_thres;
>  	u32 range;
>  	int ev_enable_state;
> -	bool dready_trigger_on;
> -	bool motion_trigger_on;
>  	int64_t timestamp;
>  	const struct bmc150_accel_chip_info *chip_info;
>  };
> @@ -800,11 +805,14 @@ static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
>  				   struct iio_trigger *trig)
>  {
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int i;
>  
> -	if (data->dready_trig != trig && data->motion_trig != trig)
> -		return -EINVAL;
> +	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> +		if (data->triggers[i].indio_trig == trig)
> +			return 0;
> +	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> @@ -976,12 +984,12 @@ err_read:
>  
>  static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>  {
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> -	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	struct bmc150_accel_trigger *t = iio_trigger_get_drvdata(trig);
> +	struct bmc150_accel_data *data = t->data;
>  	int ret;
>  
>  	/* new data interrupts don't need ack */
> -	if (data->dready_trigger_on)
> +	if (t == &t->data->triggers[0])
>  		return 0;
>  
>  	mutex_lock(&data->mutex);
> @@ -1003,38 +1011,24 @@ static int bmc150_accel_trig_try_reen(struct iio_trigger *trig)
>  static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  						   bool state)
>  {
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> -	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	struct bmc150_accel_trigger *t = iio_trigger_get_drvdata(trig);
> +	struct bmc150_accel_data *data = t->data;
>  	int ret;
>  
>  	mutex_lock(&data->mutex);
>  
> -	if (data->motion_trig == trig) {
> -		if (data->motion_trigger_on == state) {
> -			mutex_unlock(&data->mutex);
> -			return 0;
> -		}
> -	} else {
> -		if (data->dready_trigger_on == state) {
> -			mutex_unlock(&data->mutex);
> -			return 0;
> -		}
> +	if (t->enabled == state) {
> +		mutex_unlock(&data->mutex);
> +		return 0;
>  	}
>  
> -	if (data->motion_trig == trig)
> -		ret = bmc150_accel_set_interrupt(data, &data->interrupts[1],
> -						 state);
> -	else
> -		ret = bmc150_accel_set_interrupt(data, &data->interrupts[0],
> -						 state);
> +	ret = bmc150_accel_set_interrupt(data, t->intr, state);
>  	if (ret < 0) {
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	if (data->motion_trig == trig)
> -		data->motion_trigger_on = state;
> -	else
> -		data->dready_trigger_on = state;
> +
> +	t->enabled = state;
>  
>  	mutex_unlock(&data->mutex);
>  
> @@ -1074,7 +1068,7 @@ static irqreturn_t bmc150_accel_event_handler(int irq, void *private)
>  							IIO_EV_DIR_EITHER),
>  							data->timestamp);
>  ack_intr_status:
> -	if (!data->dready_trigger_on)
> +	if (!data->triggers[0].enabled)
>  		ret = i2c_smbus_write_byte_data(data->client,
>  					BMC150_ACCEL_REG_INT_RST_LATCH,
>  					BMC150_ACCEL_INT_MODE_LATCH_INT |
> @@ -1087,13 +1081,16 @@ static irqreturn_t bmc150_accel_data_rdy_trig_poll(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +	int i;
>  
>  	data->timestamp = iio_get_time_ns();
>  
> -	if (data->dready_trigger_on)
> -		iio_trigger_poll(data->dready_trig);
> -	else if (data->motion_trigger_on)
> -		iio_trigger_poll(data->motion_trig);
> +	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> +		if (data->triggers[i].enabled) {
> +			iio_trigger_poll(data->triggers[i].indio_trig);
> +			break;
> +		}
> +	}
>  
>  	if (data->ev_enable_state)
>  		return IRQ_WAKE_THREAD;
> @@ -1145,6 +1142,69 @@ static int bmc150_accel_gpio_probe(struct i2c_client *client,
>  	return ret;
>  }
>  
> +static struct {
> +	int intr;
> +	const char *name;
> +} bmc150_accel_triggers[BMC150_ACCEL_TRIGGERS] = {
> +	{
> +		.intr = 0,
> +		.name = "%s-dev%d",
> +	},
> +	{
> +		.intr = 1,
> +		.name = "%s-any-motion-dev%d",
> +	},
> +};
> +
> +static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
> +					     int from)
> +{
> +	int i;
> +
> +	for (i = from; i >= 0; i++) {
> +		if (data->triggers[i].indio_trig) {
> +			iio_trigger_unregister(data->triggers[i].indio_trig);
> +			data->triggers[i].indio_trig = NULL;
Better use devm_iio_trigger_free()?
> +		}
> +		i--;
> +	}
i++ and i-- in the same loop looks like an infinite loop to me. Not to mention what happens on the second attempt to unregister the same trigger.
> +}
> +
> +static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
> +				       struct bmc150_accel_data *data)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> +		struct bmc150_accel_trigger *t = &data->triggers[i];
> +		const char *name = bmc150_accel_triggers[i].name;
> +		int intr = bmc150_accel_triggers[i].intr;
> +
> +		t->indio_trig = devm_iio_trigger_alloc(&data->client->dev, name,
> +						       indio_dev->name,
> +						       indio_dev->id);
> +		if (!t->indio_trig) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		t->indio_trig->dev.parent = &data->client->dev;
> +		t->indio_trig->ops = &bmc150_accel_trigger_ops;
> +		t->intr = &data->interrupts[intr];
> +		t->data = data;
> +		iio_trigger_set_drvdata(t->indio_trig, t);
> +
> +		ret = iio_trigger_register(t->indio_trig);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret)
> +		bmc150_accel_unregister_triggers(data, i);
I think this should be called with i - 1.
> +
> +	return ret;
> +}
> +
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> @@ -1215,36 +1275,10 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  
>  		bmc150_accel_interrupts_setup(indio_dev, data);
>  
> -		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> -							   "%s-dev%d",
> -							   indio_dev->name,
> -							   indio_dev->id);
> -		if (!data->dready_trig)
> -			return -ENOMEM;
> -
> -		data->motion_trig = devm_iio_trigger_alloc(&client->dev,
> -							  "%s-any-motion-dev%d",
> -							  indio_dev->name,
> -							  indio_dev->id);
> -		if (!data->motion_trig)
> -			return -ENOMEM;
> -
> -		data->dready_trig->dev.parent = &client->dev;
> -		data->dready_trig->ops = &bmc150_accel_trigger_ops;
> -		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> -		ret = iio_trigger_register(data->dready_trig);
> +		ret = bmc150_accel_triggers_setup(indio_dev, data);
>  		if (ret)
>  			return ret;
>  
> -		data->motion_trig->dev.parent = &client->dev;
> -		data->motion_trig->ops = &bmc150_accel_trigger_ops;
> -		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
> -		ret = iio_trigger_register(data->motion_trig);
> -		if (ret) {
> -			data->motion_trig = NULL;
> -			goto err_trigger_unregister;
> -		}
> -
>  		ret = iio_triggered_buffer_setup(indio_dev,
>  						 &iio_pollfunc_store_time,
>  						 bmc150_accel_trigger_handler,
> @@ -1276,13 +1310,10 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  err_iio_unregister:
>  	iio_device_unregister(indio_dev);
>  err_buffer_cleanup:
> -	if (data->dready_trig)
> +	if (indio_dev->pollfunc)
>  		iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
> -	if (data->dready_trig)
> -		iio_trigger_unregister(data->dready_trig);
> -	if (data->motion_trig)
> -		iio_trigger_unregister(data->motion_trig);
> +	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  
>  	return ret;
>  }
> @@ -1298,11 +1329,7 @@ static int bmc150_accel_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (data->dready_trig) {
> -		iio_triggered_buffer_cleanup(indio_dev);
> -		iio_trigger_unregister(data->dready_trig);
> -		iio_trigger_unregister(data->motion_trig);
> -	}
> +	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  
>  	mutex_lock(&data->mutex);
>  	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_DEEP_SUSPEND, 0);
> 

