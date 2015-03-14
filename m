Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56262 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbCNSjs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 14:39:48 -0400
Message-ID: <55048073.5080603@kernel.org>
Date: Sat, 14 Mar 2015 18:39:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: bmc150: introduce bmc150_accel_interrupt
References: <1425399478-5464-1-git-send-email-octavian.purdila@intel.com>	 <1425399478-5464-3-git-send-email-octavian.purdila@intel.com>	 <54FC30FF.8080703@kernel.org> <1425933634.2797.3.camel@spandruv-mobl2.hf.intel.com>
In-Reply-To: <1425933634.2797.3.camel@spandruv-mobl2.hf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 20:40, Srinivas Pandruvada wrote:
> On Sun, 2015-03-08 at 11:22 +0000, Jonathan Cameron wrote:
>> On 03/03/15 16:17, Octavian Purdila wrote:
>>> Since both triggers and events can share an interrupt, add a data
>>> structure that tracks the users of an interrupt so that it enables or
>>> disables it only for the first users and respectively last user.
>>>
>>> This will allows us to easily add more events or triggers.
>>>
>>> The patch also adds an interrupt enabled counter, so that we can
>>> easily know if we need to put the device in normal mode when the
>>> resume callback is issued.
>>>
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> As I stated before I'd like an Ack from Srinivas on this
>> (obviously Srinivas, if you've handed the driver maintenance over
>> to Octavian just let me know and I'll stop pestering you ;)
> 
> Reviewed-by:: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> 
> I prefer to test before Acks. Since Octavian is adding Fifo support and
> many changes, If Octavian wants he can take over the maintenance of this
> driver.
> 
cool. Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Thanks,
> Srinivas
> 
>>
> 
>> Jonathan
>>> ---
>>>  drivers/iio/accel/bmc150-accel.c | 86 ++++++++++++++++++++++++----------------
>>>  1 file changed, 51 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>>> index 74ee54e..70497c3 100644
>>> --- a/drivers/iio/accel/bmc150-accel.c
>>> +++ b/drivers/iio/accel/bmc150-accel.c
>>> @@ -147,10 +147,24 @@ struct bmc150_accel_chip_info {
>>>  	const struct bmc150_scale_info scale_table[4];
>>>  };
>>>  
>>> +struct bmc150_accel_interrupt {
>>> +	const struct bmc150_accel_interrupt_info *info;
>>> +	atomic_t users;
>>> +};
>>> +
>>> +enum bmc150_accel_interrupt_id {
>>> +	BMC150_ACCEL_INT_DATA_READY,
>>> +	BMC150_ACCEL_INT_ANY_MOTION,
>>> +	BMC150_ACCEL_INT_WATERMARK,
>>> +	BMC150_ACCEL_INTERRUPTS,
>>> +};
>>> +
>>>  struct bmc150_accel_data {
>>>  	struct i2c_client *client;
>>> +	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>>>  	struct iio_trigger *dready_trig;
>>>  	struct iio_trigger *motion_trig;
>>> +	atomic_t active_intr;
>>>  	struct mutex mutex;
>>>  	s16 buffer[8];
>>>  	u8 bw_bits;
>>> @@ -421,7 +435,7 @@ static const struct bmc150_accel_interrupt_info {
>>>  	u8 map_bitmask;
>>>  	u8 en_reg;
>>>  	u8 en_bitmask;
>>> -} bmc150_accel_interrupts[] = {
>>> +} bmc150_accel_interrupts[BMC150_ACCEL_INTERRUPTS] = {
>>>  	{ /* data ready interrupt */
>>>  		.map_reg = BMC150_ACCEL_REG_INT_MAP_1,
>>>  		.map_bitmask = BMC150_ACCEL_INT_MAP_1_BIT_DATA,
>>> @@ -438,12 +452,30 @@ static const struct bmc150_accel_interrupt_info {
>>>  	},
>>>  };
>>>  
>>> -static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
>>> -				const struct bmc150_accel_interrupt_info *info,
>>> +static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
>>> +					  struct bmc150_accel_data *data)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)
>>> +		data->interrupts[i].info = &bmc150_accel_interrupts[i];
>>> +}
>>> +
>>> +static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
>>>  				      bool state)
>>>  {
>>> +	struct bmc150_accel_interrupt *intr = &data->interrupts[i];
>>> +	const struct bmc150_accel_interrupt_info *info = intr->info;
>>>  	int ret;
>>>  
>>> +	if (state) {
>>> +		if (atomic_inc_return(&intr->users) > 1)
>>> +			return 0;
>>> +	} else {
>>> +		if (atomic_dec_return(&intr->users) > 0)
>>> +			return 0;
>>> +	}
>>> +
>>>  	/*
>>>  	 * We will expect the enable and disable to do operation in
>>>  	 * in reverse order. This will happen here anyway as our
>>> @@ -493,6 +525,11 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data,
>>>  		goto out_fix_power_state;
>>>  	}
>>>  
>>> +	if (state)
>>> +		atomic_inc(&data->active_intr);
>>> +	else
>>> +		atomic_dec(&data->active_intr);
>>> +
>>>  	return 0;
>>>  
>>>  out_fix_power_state:
>>> @@ -500,20 +537,6 @@ out_fix_power_state:
>>>  	return ret;
>>>  }
>>>  
>>> -static int bmc150_accel_setup_any_motion_interrupt(
>>> -					struct bmc150_accel_data *data,
>>> -					bool status)
>>> -{
>>> -	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[1],
>>> -					  status);
>>> -}
>>> -
>>> -static int bmc150_accel_setup_new_data_interrupt(struct bmc150_accel_data *data,
>>> -						 bool status)
>>> -{
>>> -	return bmc150_accel_set_interrupt(data, &bmc150_accel_interrupts[0],
>>> -					  status);
>>> -}
>>>  
>>>  static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>>>  {
>>> @@ -753,13 +776,8 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>>>  
>>>  	mutex_lock(&data->mutex);
>>>  
>>> -	if (!state && data->motion_trigger_on) {
>>> -		data->ev_enable_state = 0;
>>> -		mutex_unlock(&data->mutex);
>>> -		return 0;
>>> -	}
>>> -
>>> -	ret =  bmc150_accel_setup_any_motion_interrupt(data, state);
>>> +	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_ANY_MOTION,
>>> +					 state);
>>>  	if (ret < 0) {
>>>  		mutex_unlock(&data->mutex);
>>>  		return ret;
>>> @@ -996,19 +1014,16 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>>  		}
>>>  	}
>>>  
>>> -	if (!state && data->ev_enable_state && data->motion_trigger_on) {
>>> -		data->motion_trigger_on = false;
>>> -		mutex_unlock(&data->mutex);
>>> -		return 0;
>>> -	}
>>> -
>>>  	if (data->motion_trig == trig) {
>>>  		ret = bmc150_accel_update_slope(data);
>>>  		if (!ret)
>>> -			ret = bmc150_accel_setup_any_motion_interrupt(data,
>>> -								      state);
>>> +			ret = bmc150_accel_set_interrupt(data,
>>> +						 BMC150_ACCEL_INT_ANY_MOTION,
>>> +							 state);
>>>  	} else {
>>> -		ret = bmc150_accel_setup_new_data_interrupt(data, state);
>>> +		ret = bmc150_accel_set_interrupt(data,
>>> +						 BMC150_ACCEL_INT_DATA_READY,
>>> +						 state);
>>>  	}
>>>  	if (ret < 0) {
>>>  		mutex_unlock(&data->mutex);
>>> @@ -1206,6 +1221,8 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>>  			return ret;
>>>  		}
>>>  
>>> +		bmc150_accel_interrupts_setup(indio_dev, data);
>>> +
>>>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
>>>  							   "%s-dev%d",
>>>  							   indio_dev->name,
>>> @@ -1321,8 +1338,7 @@ static int bmc150_accel_resume(struct device *dev)
>>>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>>>  
>>>  	mutex_lock(&data->mutex);
>>> -	if (data->dready_trigger_on || data->motion_trigger_on ||
>>> -							data->ev_enable_state)
>>> +	if (atomic_read(&data->active_intr))
>>>  		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
>>>  	mutex_unlock(&data->mutex);
>>>  
>>>
>>
> 
> 

