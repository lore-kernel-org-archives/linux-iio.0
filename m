Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064AbbBHLCA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 06:02:00 -0500
Message-ID: <54D74225.9060508@kernel.org>
Date: Sun, 08 Feb 2015 11:01:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3 7/9] iio: bmc150: introduce bmc150_accel_interrupt
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com> <1422662408-8149-8-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-8-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/15 00:00, Octavian Purdila wrote:
> Since both triggers and events can share an interrupt, add a data
> structure that tracks the users of an interrupt so that it enables or
> disables it only for the first users and respectively last user.
> 
> This will allows us to easily add more events or triggers.
> 
> The patch also adds an interrupt enabled counter, so that we can
> easily know if we need to put the device in normal mode when the
> resume callback is issued.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
I'm still undecided on whether this should be using an irq_chip to
avoid reinventing the wheel.  The few drivers that doing things
similarly to what you have here all predate at least my knowledge
of that infrastructure.

Unless others (e.g. Srinivas have stron opinions on this),
lets go with what you have here for now, but very much keep in mind
that we might want to refactor it in future. Otherwise, I'll keep you
working on this patch set for another few months!
(In my mind this isn't the important bit at all!)

Having said that I'd like an Ack from Srinivas if possible.

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel.c | 77 ++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index f040f40..b23ad1b 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -147,10 +147,19 @@ struct bmc150_accel_chip_info {
>  	const struct bmc150_scale_info scale_table[4];
>  };
>  
> +struct bmc150_accel_interrupt {
> +	const struct bmc150_accel_interrupt_info *info;
> +	atomic_t users;
> +};
> +
> +#define BMC150_ACCEL_INTERRUPTS		2
> +
>  struct bmc150_accel_data {
>  	struct i2c_client *client;
> +	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
> +	atomic_t active_intr;
>  	struct mutex mutex;
>  	s16 buffer[8];
>  	u8 bw_bits;
> @@ -421,7 +430,7 @@ static const struct bmc150_accel_interrupt_info {
>  	u8 map_bitmask;
>  	u8 en_reg;
>  	u8 en_bitmask;
> -} bmc150_accel_interrupts[] = {
> +} bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
>  	{ /* data ready interrupt */
>  		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
>  		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
> @@ -438,12 +447,30 @@ static const struct bmc150_accel_interrupt_info {
>  	},
>  };
>  
> +static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
> +					  struct bmc150_accel_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
> +		data->interrupts[i].info = &bmc150_accel_interrupts[i];
> +}
> +
>  static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
> -				const struct bmc150_accel_interrupt_info *info,
> +				      struct bmc150_accel_interrupt *intr,
>  				      bool state)
>  {
> +	const struct bmc150_accel_interrupt_info *info = intr->info;
>  	int ret;
>  
> +	if (state) {
> +		if (atomic_inc_return(&intr->users) > 1)
> +			return 0;
> +	} else {
> +		if (atomic_dec_return(&intr->users) > 0)
> +			return 0;
> +	}
> +
>  	/*
>  	 * We will expect the enable and disable to do operation in
>  	 * in reverse order. This will happen here anyway as our
> @@ -493,6 +520,11 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
>  		goto out_fix_power_state;
>  	}
>  
> +	if (state)
> +		atomic_inc(&data->active_intr);
> +	else
> +		atomic_dec(&data->active_intr);
> +
>  	return 0;
>  
>  out_fix_power_state:
> @@ -500,20 +532,6 @@ out_fix_power_state:
>  	return ret;
>  }
>  
> -static int bmc150_accel_setup_any_motion_interrupt(
> -					struct bmc150_accel_data *data,
> -					bool status)
> -{
> -	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
> -					  status);
> -}
> -
> -static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
> -						 bool status)
> -{
> -	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
> -					  status);
> -}
>  
>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  {
> @@ -753,13 +771,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&data->mutex);
>  
> -	if (!state && data->motion_trigger_on) {
> -		data->ev_enable_state = 0;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> -	}
> -
> -	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
> +	ret = bmc150_accel_set_interrupt(data, &data->interrupts[1], state);
>  	if (ret < 0) {
>  		mutex_unlock(&data->mutex);
>  		return ret;
> @@ -996,19 +1008,15 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  		}
>  	}
>  
> -	if (!state && data->ev_enable_state && data->motion_trigger_on) {
> -		data->motion_trigger_on = false;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> -	}
> -
>  	if (data->motion_trig == trig) {
>  		ret = bmc150_accel_update_slope(data);
>  		if (!ret)
> -			ret = bmc150_accel_setup_any_motion_interrupt(data,
> -								      state);
> +			ret = bmc150_accel_set_interrupt(data,
> +							 &data->interrupts[1],
> +							 state);
>  	} else {
> -		ret = bmc150_accel_setup_new_data_interrupt(data, state);
> +		ret = bmc150_accel_set_interrupt(data, &data->interrupts[0],
> +						 state);
>  	}
>  	if (ret < 0) {
>  		mutex_unlock(&data->mutex);
> @@ -1210,6 +1218,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  			return ret;
>  		}
>  
> +		bmc150_accel_interrupts_setup(indio_dev, data);
> +
>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>  							   "%s-dev%d",
>  							   indio_dev->name,
> @@ -1325,8 +1335,7 @@ static int bmc150_accel_resume(struct device *dev)
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  
>  	mutex_lock(&data->mutex);
> -	if (data->dready_trigger_on || data->motion_trigger_on ||
> -							data->ev_enable_state)
> +	if (atomic_read(&data->active_intr))
>  		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>  	mutex_unlock(&data->mutex);
>  
> 

