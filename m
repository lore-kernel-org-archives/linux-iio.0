Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38680 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbBHKkW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 05:40:22 -0500
Message-ID: <54D73D14.1080805@kernel.org>
Date: Sun, 08 Feb 2015 10:40:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Octavian Purdila <octavian.purdila@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 6/9] iio: bmc150: exit early if event / trigger state
 is not changed
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>	 <1422662408-8149-7-git-send-email-octavian.purdila@intel.com> <1423156173.2136.166.camel@spandruv-DESK3.jf.intel.com>
In-Reply-To: <1423156173.2136.166.camel@spandruv-DESK3.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/15 17:09, Srinivas Pandruvada wrote:
> On Sat, 2015-01-31 at 02:00 +0200, Octavian Purdila wrote: 
>> Previous of this patch the check was only done if we enabled the event
>> and it was already enabled. We can do the same if the event is
>> disabled and we want to disable it.
>>
>> The patch also adds the same check on the trigger code.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 
Another good standalone improvement.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 0873925..f040f40 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -748,7 +748,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>>  	int ret;
>>  
>> -	if (state && data->ev_enable_state)
>> +	if (state == data->ev_enable_state)
>>  		return 0;
>>  
>>  	mutex_lock(&data->mutex);
>> @@ -984,6 +984,18 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
>>  
>>  	mutex_lock(&data->mutex);
>>  
>> +	if (data->motion_trig == trig) {
>> +		if (data->motion_trigger_on == state) {
>> +			mutex_unlock(&data->mutex);
>> +			return 0;
>> +		}
>> +	} else {
>> +		if (data->dready_trigger_on == state) {
>> +			mutex_unlock(&data->mutex);
>> +			return 0;
>> +		}
>> +	}
>> +
>>  	if (!state && data->ev_enable_state && data->motion_trigger_on) {
>>  		data->motion_trigger_on = false;
>>  		mutex_unlock(&data->mutex);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

