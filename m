Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49815 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbADQ33 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 11:29:29 -0500
Message-ID: <54A96A68.8040503@kernel.org>
Date: Sun, 04 Jan 2015 16:29:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 07/11] iio: bmc150: exit early if event / trigger state
 is not changed
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-8-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-8-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:
> Previous of this patch the check was only done if we enabled the event
> and it was already enabled. We can do the same if the event is
> disabled and we want to disable it.
> 
> The patch also adds the same check on the trigger code.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Another sensible stand alone change.  Will take this whenever
the earlier patches are ready.

> ---
>  drivers/iio/accel/bmc150-accel.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 53d1d1d..aaad2fb 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -765,7 +765,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (state && data->ev_enable_state)
> +	if (state == data->ev_enable_state)
>  		return 0;
>  
>  	mutex_lock(&data->mutex);
> @@ -1001,6 +1001,18 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  	mutex_lock(&data->mutex);
>  
> +	if (data->motion_trig == trig) {
> +		if (data->motion_trigger_on == state) {
> +			mutex_unlock(&data->mutex);
> +			return 0;
> +		}
> +	} else {
> +		if (data->dready_trigger_on == state) {
> +			mutex_unlock(&data->mutex);
> +			return 0;
> +		}
> +	}
> +
>  	if (!state && data->ev_enable_state && data->motion_trigger_on) {
>  		data->motion_trigger_on = false;
>  		mutex_unlock(&data->mutex);
> 

