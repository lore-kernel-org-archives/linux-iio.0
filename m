Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54396 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbaGDFwG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jul 2014 01:52:06 -0400
In-Reply-To: <53B5E0C5.8010908@linux.intel.com>
References: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com> <53B5E0C5.8010908@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/7] iio: hid-sensor-press: Fix return values
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 04 Jul 2014 06:51:57 +0100
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	linux-iio@vger.kernel.org
CC: spk.linux@gmail.com
Message-ID: <9a245535-437f-4807-9852-c5e72a5fc872@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by ? 

I'll take it with the vague agreement but nice to have a formal note of it in git!

On July 4, 2014 12:01:25 AM GMT+01:00, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>Thanks for the fix. Agree with the whole series.
>
>Thanks,
>Srinivas
>
>On 07/02/2014 11:44 PM, Sachin Kamat wrote:
>> IIO_CHAN_INFO_SAMP_FREQ and IIO_CHAN_INFO_HYSTERESIS cases ignored
>> the actual return values (which could be -EINVAL) and instead
>> returned IIO_VAL_INT_PLUS_MICRO always. Return the actual value
>> obtained from the functions. Both functions return
>IIO_VAL_INT_PLUS_MICRO
>> upon success.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>   drivers/iio/pressure/hid-sensor-press.c |    7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/hid-sensor-press.c
>b/drivers/iio/pressure/hid-sensor-press.c
>> index 1cd190c..2c0d2a4 100644
>> --- a/drivers/iio/pressure/hid-sensor-press.c
>> +++ b/drivers/iio/pressure/hid-sensor-press.c
>> @@ -78,7 +78,6 @@ static int press_read_raw(struct iio_dev
>*indio_dev,
>>   	struct press_state *press_state = iio_priv(indio_dev);
>>   	int report_id = -1;
>>   	u32 address;
>> -	int ret;
>>   	int ret_type;
>>   	s32 poll_value;
>>   
>> @@ -128,14 +127,12 @@ static int press_read_raw(struct iio_dev
>*indio_dev,
>>   		ret_type = IIO_VAL_INT;
>>   		break;
>>   	case IIO_CHAN_INFO_SAMP_FREQ:
>> -		ret = hid_sensor_read_samp_freq_value(
>> +		ret_type = hid_sensor_read_samp_freq_value(
>>   				&press_state->common_attributes, val, val2);
>> -		ret_type = IIO_VAL_INT_PLUS_MICRO;
>>   		break;
>>   	case IIO_CHAN_INFO_HYSTERESIS:
>> -		ret = hid_sensor_read_raw_hyst_value(
>> +		ret_type = hid_sensor_read_raw_hyst_value(
>>   				&press_state->common_attributes, val, val2);
>> -		ret_type = IIO_VAL_INT_PLUS_MICRO;
>>   		break;
>>   	default:
>>   		ret_type = -EINVAL;

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
