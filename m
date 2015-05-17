Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59064 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbEQJZy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 05:25:54 -0400
Message-ID: <55585E9E.8060404@kernel.org>
Date: Sun, 17 May 2015 10:25:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	srinivas.pandruvada@linux.intel.com, irina.tirdea@intel.com,
	octavian.purdila@intel.com, linux-iio@vger.kernel.org
CC: adriana.reus@intel.com
Subject: Re: [PATCH 1/2] iio: gyro: bmg160: remove redundant field
References: <1431523809-13824-1-git-send-email-vlad.dogaru@intel.com> <1431523809-13824-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1431523809-13824-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 14:30, Vlad Dogaru wrote:
> Replace the 'timestamp' field in struct bmg160_data with the identically
> named field in iio_poll_func and with calls to iio_get_time_ns().
> 
> The reported timestamps may be slightly different, but the advantage is
> that we no longer assume that the buffer of bmg160 is triggered by its
> own trigger.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Your patch message rather undersells the advantages of this change but otherwise
a good change to make.  The timing difference will probably be very very small.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 4415f55..d36af62 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -108,7 +108,6 @@ struct bmg160_data {
>  	int slope_thres;
>  	bool dready_trigger_on;
>  	bool motion_trigger_on;
> -	int64_t timestamp;
>  };
>  
>  enum bmg160_axis {
> @@ -835,7 +834,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
>  	mutex_unlock(&data->mutex);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   data->timestamp);
> +					   pf->timestamp);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> @@ -938,21 +937,21 @@ static irqreturn_t bmg160_event_handler(int irq, void *private)
>  							IIO_MOD_X,
>  							IIO_EV_TYPE_ROC,
>  							dir),
> -							data->timestamp);
> +							iio_get_time_ns());
>  	if (ret & BMG160_ANY_MOTION_BIT_Y)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>  							0,
>  							IIO_MOD_Y,
>  							IIO_EV_TYPE_ROC,
>  							dir),
> -							data->timestamp);
> +							iio_get_time_ns());
>  	if (ret & BMG160_ANY_MOTION_BIT_Z)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
>  							0,
>  							IIO_MOD_Z,
>  							IIO_EV_TYPE_ROC,
>  							dir),
> -							data->timestamp);
> +							iio_get_time_ns());
>  
>  ack_intr_status:
>  	if (!data->dready_trigger_on) {
> @@ -973,8 +972,6 @@ static irqreturn_t bmg160_data_rdy_trig_poll(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct bmg160_data *data = iio_priv(indio_dev);
>  
> -	data->timestamp = iio_get_time_ns();
> -
>  	if (data->dready_trigger_on)
>  		iio_trigger_poll(data->dready_trig);
>  	else if (data->motion_trigger_on)
> @@ -1105,7 +1102,7 @@ static int bmg160_probe(struct i2c_client *client,
>  		}
>  
>  		ret = iio_triggered_buffer_setup(indio_dev,
> -						 NULL,
> +						 iio_pollfunc_store_time,
>  						 bmg160_trigger_handler,
>  						 NULL);
>  		if (ret < 0) {
> 

