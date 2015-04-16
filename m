Return-Path: <knaack.h@gmx.de>
Message-ID: <5530396F.2050406@gmx.de>
Date: Fri, 17 Apr 2015 00:36:31 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: doc: Describe scale attributes for event
 thresholds
References: <20150219141553.27001.18825.stgit@localhost> <20150219141604.27001.24235.stgit@localhost> <54FDA09A.6060705@kernel.org>
In-Reply-To: <54FDA09A.6060705@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron schrieb am 09.03.2015 um 14:31:
> On 19/02/15 14:16, Martin Fuzzey wrote:
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Applied to the togreg branch of iio.git. 
> These have been in the effective ABI for a while even if
> we didn't have them documented so this patch stands
> fine on it's own.
> 
Annoyingly, there is a new version scheme. Who likes to adjust
this one here?

> Jonathan
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio |   18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index ab592dd..d15a61d 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -613,6 +613,24 @@ Description:
>>  		value is in raw device units or in processed units (as _raw
>>  		and _input do on sysfs direct channel read attributes).
>>  
>> +What:		/sys/.../events/in_accel_scale
>> +What:		/sys/.../events/in_accel_peak_scale
>> +What:		/sys/.../events/in_anglvel_scale
>> +What:		/sys/.../events/in_magn_scale
>> +What:		/sys/.../events/in_rot_from_north_magnetic_scale
>> +What:		/sys/.../events/in_rot_from_north_true_scale
>> +What:		/sys/.../events/in_voltage_scale
>> +What:		/sys/.../events/in_voltage_supply_scale
>> +What:		/sys/.../events/in_temp_scale
>> +What:		/sys/.../events/in_illuminance_scale
>> +What:		/sys/.../events/in_proximity_scale
>> +KernelVersion:	3.21
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +                Specifies the conversion factor from the standard units
>> +                to device specific units used to set the event trigger
>> +                threshold.
>> +
>>  What:		/sys/.../events/in_accel_x_thresh_rising_hysteresis
>>  What:		/sys/.../events/in_accel_x_thresh_falling_hysteresis
>>  What:		/sys/.../events/in_accel_x_thresh_either_hysteresis
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
