Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1420570433.4459.105.camel@spandruv-desktop.jf.intel.com>
Subject: Re: [PATCH v2 05/11] iio: bmc150: refactor slope duration and
 threshold update
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
 linux-iio@vger.kernel.org,  Laurentiu Palcu <laurentiu.palcu@intel.com>
Date: Tue, 06 Jan 2015 10:53:53 -0800
In-Reply-To: <54A96870.1000206@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	 <1419122556-8100-6-git-send-email-octavian.purdila@intel.com>
	 <54A96870.1000206@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2015-01-04 at 16:21 +0000, Jonathan Cameron wrote: 
> On 21/12/14 00:42, Octavian Purdila wrote:
> > Move the slope duration and threshold update in separate functions
> > to reduce code duplicate between chip init and motion interrupt setup.
> > 
> > The patch also moves the update from the motion interrupt setup
> > function to the write event function so that we can later refactor the
> > interrupt code.
> The side effect of this is that these will get updated at a different
> point in time from before.  Previously these values would only get
> updated when the event was enabled (or the trigger).  So to change
> them a disable / enable cycle was needed. Now they happen the moment
> they are relevant.
> 
> I prefer the new option, but it is an ABI change (be it one most people
> won't notice!)
I did purposely this way.
IMO when user is changing critical parameters he should disable and re
enable to avoid undesirable side effects. 
We have similar situation in other  thermal drivers where user can
change policy parameters. Initially we let them change while zone is
enabled (system is armed), this led to undesirable side effects due to
race conditions.

Thanks,
Srinivas

> 
> Hence I'd like an Ack from Srinivas and time for comments from others
> before taking this one.
> 
> Otherwise, looks good ;)
> 
> Jonathan
> > 
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > ---
> >  drivers/iio/accel/bmc150-accel.c | 110 ++++++++++++++++++++++-----------------
> >  1 file changed, 63 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> > index 22c096c..92f1d2b 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel.c
> > @@ -266,6 +266,52 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
> >  	return -EINVAL;
> >  }
> >  
> > +static int bmc150_accel_update_slope_threshold(struct bmc150_accel_data *data,
> > +					       int val)
> > +{
> > +	int ret = 0;
> > +
> > +	val &= 0xFF;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
> > +					val);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> > +		return ret;
> > +	}
> > +	data->slope_thres = val;
> > +
> > +	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bmc150_accel_update_slope_duration(struct bmc150_accel_data *data,
> > +					      int val)
> > +{
> > +	int ret;
> > +
> > +	val &= BMC150_ACCEL_SLOPE_DUR_MASK;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> > +		return ret;
> > +	}
> > +	val |= ret & ~BMC150_ACCEL_SLOPE_DUR_MASK;
> > +	ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> > +					val);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error write reg_int_5\n");
> > +		return ret;
> > +	}
> > +	data->slope_dur = val;
> > +
> > +	dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
> > +
> > +	return ret;
> > +}
> > +
> >  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> >  {
> >  	int ret;
> > @@ -304,32 +350,16 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> >  
> >  	data->range = BMC150_ACCEL_DEF_RANGE_4G;
> >  
> > -	/* Set default slope duration */
> > -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> > -		return ret;
> > -	}
> > -	data->slope_dur |= BMC150_ACCEL_DEF_SLOPE_DURATION;
> > -	ret = i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_INT_5,
> > -					data->slope_dur);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_5\n");
> > +	/* Set default slope duration and thresholds */
> > +	ret = bmc150_accel_update_slope_duration(data,
> > +					 BMC150_ACCEL_DEF_SLOPE_DURATION);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > -	dev_dbg(&data->client->dev, "slope_dur %x\n", data->slope_dur);
> >  
> > -	/* Set default slope thresholds */
> > -	ret = i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_INT_6,
> > -					BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> > +	ret = bmc150_accel_update_slope_threshold(data,
> > +					  BMC150_ACCEL_DEF_SLOPE_THRESHOLD);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > -	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> > -	dev_dbg(&data->client->dev, "slope_thres %x\n", data->slope_thres);
> >  
> >  	/* Set default as latched interrupts */
> >  	ret = i2c_smbus_write_byte_data(data->client,
> > @@ -372,24 +402,6 @@ static int bmc150_accel_setup_any_motion_interrupt(
> >  	}
> >  
> >  	if (status) {
> > -		/* Set slope duration (no of samples) */
> > -		ret = i2c_smbus_write_byte_data(data->client,
> > -						BMC150_ACCEL_REG_INT_5,
> > -						data->slope_dur);
> > -		if (ret < 0) {
> > -			dev_err(&data->client->dev, "Error write reg_int_5\n");
> > -			return ret;
> > -		}
> > -
> > -		/* Set slope thresholds */
> > -		ret = i2c_smbus_write_byte_data(data->client,
> > -						BMC150_ACCEL_REG_INT_6,
> > -						data->slope_thres);
> > -		if (ret < 0) {
> > -			dev_err(&data->client->dev, "Error write reg_int_6\n");
> > -			return ret;
> > -		}
> > -
> >  		/*
> >  		 * New data interrupt is always non-latched,
> >  		 * which will have higher priority, so no need
> > @@ -726,7 +738,7 @@ static int bmc150_accel_read_event(struct iio_dev *indio_dev,
> >  		*val = data->slope_thres;
> >  		break;
> >  	case IIO_EV_INFO_PERIOD:
> > -		*val = data->slope_dur & BMC150_ACCEL_SLOPE_DUR_MASK;
> > +		*val = data->slope_dur;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> > @@ -743,23 +755,27 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
> >  				    int val, int val2)
> >  {
> >  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> > +	int ret;
> >  
> >  	if (data->ev_enable_state)
> >  		return -EBUSY;
> >  
> >  	switch (info) {
> >  	case IIO_EV_INFO_VALUE:
> > -		data->slope_thres = val;
> > +		mutex_lock(&data->mutex);
> > +		ret = bmc150_accel_update_slope_threshold(data, val);
> > +		mutex_unlock(&data->mutex);
> >  		break;
> >  	case IIO_EV_INFO_PERIOD:
> > -		data->slope_dur &= ~BMC150_ACCEL_SLOPE_DUR_MASK;
> > -		data->slope_dur |= val & BMC150_ACCEL_SLOPE_DUR_MASK;
> > +		mutex_lock(&data->mutex);
> > +		ret = bmc150_accel_update_slope_duration(data, val);
> > +		mutex_unlock(&data->mutex);
> >  		break;
> >  	default:
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> >  	}
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int bmc150_accel_read_event_config(struct iio_dev *indio_dev,
> > 
> 
