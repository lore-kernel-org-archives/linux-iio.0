Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46677 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdBYQvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:51:37 -0500
Subject: Re: [PATCH] iio: hid-sensor-trigger: Change get poll value function
 order to avoid sensor properties losing after resume from S3
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1487755058-31310-1-git-send-email-hongyan.song@intel.com>
 <1487741996.19408.0.camel@intel.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f73506c-2bdd-c527-cd13-76594a1a7375@kernel.org>
Date: Sat, 25 Feb 2017 16:51:33 +0000
MIME-Version: 1.0
In-Reply-To: <1487741996.19408.0.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/17 05:40, Pandruvada, Srinivas wrote:
> On Wed, 2017-02-22 at 17:17 +0800, Song Hongyan wrote:
>> In function _hid_sensor_power_state(), when
>> hid_sensor_read_poll_value()
>> is called, sensor's all properties will be updated by the value from
>> sensor hardware/firmware.
>> In some implementation, sensor hardware/firmware will do a power
>> cycle
>> during S3. In this case, after resume, once
>> hid_sensor_read_poll_value()
>> is called, sensor's all properties which are kept by driver during S3
>> will be changed to default value.
>> But instead, if a set feature function is called first, sensor
>> hardware/firmware will be recovered to the last status. So change the
>> sensor_hub_set_feature() calling order to behind of set feature
>> function
>> to avoid sensor properties lose.
>>
>> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi Song,

The patch message, whilst excellent on the technical detail, gives me
no sense of urgency on this. Is this a fix we want to have heading for
stable ASAP or are we looking at something seen in some developmental
hardware for example?
Links to bug reports, or examples of hardware suffering from the issue
are always helpful as well.

Also for something like this a 'fixes' tag is very helpful when people
are looking to back port it.

Anyhow, I'm going to hold off on taking this one until I have more
information. Right now it makes little difference as the next fixes
pull request from me will probably not be until next weekend.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> index a3cce3a..ecf592d 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> @@ -51,8 +51,6 @@ static int _hid_sensor_power_state(struct
>> hid_sensor_common *st, bool state)
>>  			st->report_state.report_id,
>>  			st->report_state.index,
>>  			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EV
>> ENTS_ENUM);
>> -
>> -		poll_value = hid_sensor_read_poll_value(st);
>>  	} else {
>>  		int val;
>>  
>> @@ -89,7 +87,9 @@ static int _hid_sensor_power_state(struct
>> hid_sensor_common *st, bool state)
>>  	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
>>  			       st->power_state.index,
>>  			       sizeof(state_val), &state_val);
>> -	if (state && poll_value)
>> +	if (state)
>> +		poll_value = hid_sensor_read_poll_value(st);
>> +	if (poll_value > 0)
>>  		msleep_interruptible(poll_value * 2);
>>  
>>  	return 0;N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==

