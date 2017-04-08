Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38002 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdDHQKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 12:10:04 -0400
Subject: Re: [PATCH] iio: hid-sensor: Store restore poll and hysteresis on S3
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20170408001317.4769-1-srinivas.pandruvada@linux.intel.com>
 <18b8c19a-e657-2532-00de-d38efa584241@kernel.org>
Cc: linux-iio@vger.kernel.org, stable@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1d7ed396-5325-b98a-6cfa-7e8f1adf333f@kernel.org>
Date: Sat, 8 Apr 2017 17:10:02 +0100
MIME-Version: 1.0
In-Reply-To: <18b8c19a-e657-2532-00de-d38efa584241@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/17 15:17, Jonathan Cameron wrote:
> On 08/04/17 01:13, Srinivas Pandruvada wrote:
>> This change undo the change done by 'commit 3bec24747446
>> ("iio: hid-sensor-trigger: Change get poll value function order to avoid
>> sensor properties losing after resume from S3")' as this breaks some
>> USB/i2c sensor hubs.
>>
>> Instead of relying on HW for restoring poll and hysteresis, driver stores
>> and restores on resume (S3). In this way user space modified settings are
>> not lost for any kind of sensor hub behavior.
>>
>> In this change, whenever user space modifies sampling frequency or
>> hysteresis driver will get the feature value from the hub and store in the
>> per device hid_sensor_common data structure. On resume callback from S3,
>> system will set the feature to sensor hub, if user space ever modified the
>> feature value.
>>
>> Fixes: 3bec24747446 ("iio: hid-sensor-trigger: Change get poll value function order to avoid sensor properties losing after resume from S3")
>> Reported-by: Ritesh Raj Sarraf <rrs@researchut.com>
>> Tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
>> Tested-by: Song, Hongyan <hongyan.song@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Applied. Hoping this is the final fix on these related issues!
> 
Srinivas,  one quick comment on this.  Things were left hanging I think in
the thread that lead to it.  I'd have appreciated a tiny bit of history in
here to convince me that Hongyan was happy with the fix (I did compare
this with the original and can see how you changed it, but would have
liked to have not have to have bothered!

Jonathan
> Jonathan
>> ---
>>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 26 ++++++++++++++++++++--
>>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 20 ++++++++++++++---
>>  include/linux/hid-sensor-hub.h                     |  2 ++
>>  3 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> index 7afdac42..efd3151 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> @@ -221,7 +221,15 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
>>  	if (ret < 0 || value < 0)
>>  		ret = -EINVAL;
>>  
>> -	return ret;
>> +	ret = sensor_hub_get_feature(st->hsdev,
>> +				     st->poll.report_id,
>> +				     st->poll.index, sizeof(value), &value);
>> +	if (ret < 0 || value < 0)
>> +		return -EINVAL;
>> +
>> +	st->poll_interval = value;
>> +
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL(hid_sensor_write_samp_freq_value);
>>  
>> @@ -266,7 +274,16 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
>>  	if (ret < 0 || value < 0)
>>  		ret = -EINVAL;
>>  
>> -	return ret;
>> +	ret = sensor_hub_get_feature(st->hsdev,
>> +				     st->sensitivity.report_id,
>> +				     st->sensitivity.index, sizeof(value),
>> +				     &value);
>> +	if (ret < 0 || value < 0)
>> +		return -EINVAL;
>> +
>> +	st->raw_hystersis = value;
>> +
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
>>  
>> @@ -369,6 +386,9 @@ int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
>>  	/* Default unit of measure is milliseconds */
>>  	if (st->poll.units == 0)
>>  		st->poll.units = HID_USAGE_SENSOR_UNITS_MILLISECOND;
>> +
>> +	st->poll_interval = -1;
>> +
>>  	return 0;
>>  
>>  }
>> @@ -397,6 +417,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>>  			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
>>  			 &st->sensitivity);
>>  
>> +	st->raw_hystersis = -1;
>> +
>>  	sensor_hub_input_get_attribute_info(hsdev,
>>  					    HID_INPUT_REPORT, usage_id,
>>  					    HID_USAGE_SENSOR_TIME_TIMESTAMP,
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> index ecf592d..6082934 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> @@ -51,6 +51,8 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>>  			st->report_state.report_id,
>>  			st->report_state.index,
>>  			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM);
>> +
>> +		poll_value = hid_sensor_read_poll_value(st);
>>  	} else {
>>  		int val;
>>  
>> @@ -87,9 +89,7 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>>  	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
>>  			       st->power_state.index,
>>  			       sizeof(state_val), &state_val);
>> -	if (state)
>> -		poll_value = hid_sensor_read_poll_value(st);
>> -	if (poll_value > 0)
>> +	if (state && poll_value)
>>  		msleep_interruptible(poll_value * 2);
>>  
>>  	return 0;
>> @@ -127,6 +127,20 @@ static void hid_sensor_set_power_work(struct work_struct *work)
>>  	struct hid_sensor_common *attrb = container_of(work,
>>  						       struct hid_sensor_common,
>>  						       work);
>> +
>> +	if (attrb->poll_interval >= 0)
>> +		sensor_hub_set_feature(attrb->hsdev, attrb->poll.report_id,
>> +				       attrb->poll.index,
>> +				       sizeof(attrb->poll_interval),
>> +				       &attrb->poll_interval);
>> +
>> +	if (attrb->raw_hystersis >= 0)
>> +		sensor_hub_set_feature(attrb->hsdev,
>> +				       attrb->sensitivity.report_id,
>> +				       attrb->sensitivity.index,
>> +				       sizeof(attrb->raw_hystersis),
>> +				       &attrb->raw_hystersis);
>> +
>>  	_hid_sensor_power_state(attrb, true);
>>  }
>>  
>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>> index 7ef111d..f32d7c3 100644
>> --- a/include/linux/hid-sensor-hub.h
>> +++ b/include/linux/hid-sensor-hub.h
>> @@ -231,6 +231,8 @@ struct hid_sensor_common {
>>  	unsigned usage_id;
>>  	atomic_t data_ready;
>>  	atomic_t user_requested_state;
>> +	int poll_interval;
>> +	int raw_hystersis;
>>  	struct iio_trigger *trigger;
>>  	int timestamp_ns_scale;
>>  	struct hid_sensor_hub_attribute_info poll;
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

