Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1479752480.6544.155.camel@linux.intel.com>
Subject: Re: [PATCH] iio: accel: hid-sensor-accel-3d: Add timestamp
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Mon, 21 Nov 2016 10:21:20 -0800
In-Reply-To: <e38151fe-881d-84bf-2963-5d260bc75222@kernel.org>
References: 
	<1479494029-193108-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <e38151fe-881d-84bf-2963-5d260bc75222@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2016-11-19 at 13:19 +0000, Jonathan Cameron wrote:
> On 18/11/16 18:33, Srinivas Pandruvada wrote:
> > 
> > Added timestamp channel. With this change, each sample has a
> > timestamp.
> > This timestamp can be from the sensor hub when present or local
> > kernel
> > timestamp. HID sensors can send timestamp with input data using
> > usage id
> > HID_USAGE_SENSOR_TIME_TIMESTAMP.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> What are the units for the hardware provided timestamp?  I couldn't
> immediately find
> a sensible answer in the hid usage tables!  It appeared to imply that
> the standard
> option was the same as for _time64 which is in seconds (and so seems
> unlikely!)
Good point. The unit is ns on my device. But I need to take care about
other combinations also. So I will resend this patch.

> 
> Also, I'm not clear if they always align with acceleration scans?
Each input report (which has all X, Y, Z) has a timestamp. So this will
align. 

> 
> So patch looks fine but more details needed.
> 
> J
> > 
> > ---
> >  drivers/iio/accel/hid-sensor-accel-3d.c | 29
> > +++++++++++++++++++++--------
> >  include/linux/hid-sensor-ids.h          |  1 +
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> > b/drivers/iio/accel/hid-sensor-accel-3d.c
> > index ab1e238..41215b6 100644
> > --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> > +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> > @@ -42,11 +42,13 @@ struct accel_3d_state {
> >  	struct hid_sensor_hub_callbacks callbacks;
> >  	struct hid_sensor_common common_attributes;
> >  	struct hid_sensor_hub_attribute_info
> > accel[ACCEL_3D_CHANNEL_MAX];
> > -	u32 accel_val[ACCEL_3D_CHANNEL_MAX];
> > +	/* Reserve for 3 channels + padding + timestamp */
> > +	u32 accel_val[ACCEL_3D_CHANNEL_MAX + 3];
> >  	int scale_pre_decml;
> >  	int scale_post_decml;
> >  	int scale_precision;
> >  	int value_offset;
> > +	int64_t timestamp;
> >  };
> >  
> >  static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
> > @@ -87,7 +89,8 @@ static const struct iio_chan_spec
> > accel_3d_channels[] = {
> >  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >  		BIT(IIO_CHAN_INFO_HYSTERESIS),
> >  		.scan_index = CHANNEL_SCAN_INDEX_Z,
> > -	}
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(3)
> >  };
> >  
> >  /* Adjust channel real bits based on report descriptor */
> > @@ -192,11 +195,11 @@ static const struct iio_info accel_3d_info =
> > {
> >  };
> >  
> >  /* Function to push data to buffer */
> > -static void hid_sensor_push_data(struct iio_dev *indio_dev, const
> > void *data,
> > -	int len)
> > +static void hid_sensor_push_data(struct iio_dev *indio_dev, void
> > *data,
> > +				 int len, int64_t timestamp)
> >  {
> >  	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
> > -	iio_push_to_buffers(indio_dev, data);
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > timestamp);
> >  }
> >  
> >  /* Callback handler to send event after all samples are received
> > and captured */
> > @@ -208,10 +211,17 @@ static int accel_3d_proc_event(struct
> > hid_sensor_hub_device *hsdev,
> >  	struct accel_3d_state *accel_state = iio_priv(indio_dev);
> >  
> >  	dev_dbg(&indio_dev->dev, "accel_3d_proc_event\n");
> > -	if (atomic_read(&accel_state-
> > >common_attributes.data_ready))
> > +	if (atomic_read(&accel_state-
> > >common_attributes.data_ready)) {
> > +		if (!accel_state->timestamp)
> > +			accel_state->timestamp =
> > iio_get_time_ns(indio_dev);
> > +
> >  		hid_sensor_push_data(indio_dev,
> > -				accel_state->accel_val,
> > -				sizeof(accel_state->accel_val));
> > +				     accel_state->accel_val,
> > +				     sizeof(accel_state-
> > >accel_val),
> > +				     accel_state->timestamp);
> > +
> > +		accel_state->timestamp = 0;
> Are we always guaranteed to get one timestamp per 'scan'?
Yes.

Thanks,
Srinivas

> > 
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -236,6 +246,9 @@ static int accel_3d_capture_sample(struct
> > hid_sensor_hub_device *hsdev,
> >  						*(u32 *)raw_data;
> >  		ret = 0;
> >  	break;
> > +	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
> > +		accel_state->timestamp = *(int64_t *)raw_data;
> > +	break;
> >  	default:
> >  		break;
> >  	}
> > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > sensor-ids.h
> > index f2ee90a..9a3a9db 100644
> > --- a/include/linux/hid-sensor-ids.h
> > +++ b/include/linux/hid-sensor-ids.h
> > @@ -95,6 +95,7 @@
> >  #define HID_USAGE_SENSOR_TIME_HOUR				
> > 0x200525
> >  #define HID_USAGE_SENSOR_TIME_MINUTE				
> > 0x200526
> >  #define HID_USAGE_SENSOR_TIME_SECOND				
> > 0x200527
> > +#define HID_USAGE_SENSOR_TIME_TIMESTAMP				
> > 0x200529
> >  
> >  /* Units */
> >  #define HID_USAGE_SENSOR_UNITS_NOT_SPECIFIED			
> > 0x00
> > 
> 
