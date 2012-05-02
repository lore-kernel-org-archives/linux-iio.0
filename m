Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35694 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab2EBPJS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 May 2012 11:09:18 -0400
Message-ID: <4FA14E1A.4040005@cam.ac.uk>
Date: Wed, 02 May 2012 16:09:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio: documentation: Add out_altvoltage and friends
References: <1335957844-6172-1-git-send-email-michael.hennerich@analog.com> <4FA1468B.4060306@cam.ac.uk> <4FA14AF0.5050107@analog.com>
In-Reply-To: <4FA14AF0.5050107@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/2/2012 3:55 PM, Michael Hennerich wrote:
> On 05/02/2012 04:36 PM, Jonathan Cameron wrote:
>> On 5/2/2012 12:24 PM, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>
>>> Continuous frequency/clock generating devices, such as DDSs or PLLs
>>> should use out_altvolatge.
>>>
>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-bus-iio |   31 
>>> +++++++++++++++++++++++++++++++
>>>    1 files changed, 31 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
>>> b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 2ce4dad..f757a30 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -219,6 +219,7 @@ What:             
>>> /sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/in_voltage_scale
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>>>    What:               /sys/bus/iio/devices/iio:deviceX/in_accel_scale
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
>>> @@ -273,6 +274,7 @@ What:             
>>> /sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
>>>    What:               /sys/.../iio:deviceX/in_voltageX_scale_available
>>>    What:               
>>> /sys/.../iio:deviceX/in_voltage-voltage_scale_available
>>>    What:               
>>> /sys/.../iio:deviceX/out_voltageX_scale_available
>>> +What:                
>>> /sys/.../iio:deviceX/out_altvoltageX_scale_available
>>>    What:               
>>> /sys/.../iio:deviceX/in_capacitance_scale_available
>>>    KernelVersion:      2.635
>>>    Contact:    linux-iio@vger.kernel.org
>>> @@ -291,14 +293,19 @@ Description:
>>>                gives the 3dB frequency of the filter in Hz.
>>>
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
>>>    KernelVersion:      2.6.37
>>>    Contact:    linux-iio@vger.kernel.org
>>>    Description:
>>>                Raw (unscaled, no bias etc.) output voltage for
>>>                channel Y.  The number must always be specified and
>>>                unique if the output corresponds to a single channel.
>>> +             While DAC like devices typically use out_voltage,
>>> +             a continuous frequency generating device, such as
>>> +             a DDS or PLL should use out_altvolatge.
>>>
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY&Z_raw
>>>    KernelVersion:      2.6.37
>>>    Contact:    linux-iio@vger.kernel.org
>>>    Description:
>>> @@ -309,6 +316,8 @@ Description:
>>>
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
>>>    KernelVersion:      2.6.38
>>>    Contact:    linux-iio@vger.kernel.org
>>>    Description:
>>> @@ -323,6 +332,8 @@ Description:
>>>
>>>    What:               
>>> /sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
>>>    What:               
>>> /sys/.../iio:deviceX/out_voltage_powerdown_mode_available
>>> +What:                
>>> /sys/.../iio:deviceX/out_altvotlageY_powerdown_mode_available
>>> +What:                
>>> /sys/.../iio:deviceX/out_altvoltage_powerdown_mode_available
>>>    KernelVersion:      2.6.38
>>>    Contact:    linux-iio@vger.kernel.org
>>>    Description:
>>> @@ -331,6 +342,8 @@ Description:
>>>
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
>>>    What:               
>>> /sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
>>>    KernelVersion:      2.6.38
>>>    Contact:    linux-iio@vger.kernel.org
>>>    Description:
>>> @@ -339,6 +352,24 @@ Description:
>>>                normal operation. Y may be suppressed if all outputs are
>>>                controlled together.
>>>
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
>>> +KernelVersion:       3.4.0
>>> +Contact:     linux-iio@vger.kernel.org
>>> +Description:
>>> +             Output frequency for channel Y in Hz. The number must 
>>> always be
>>> +             specified and unique if the output corresponds to a 
>>> single
>>> +             channel.
>>> +
>>> +What:                
>>> /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
>>> +KernelVersion:       3.4.0
>>> +Contact:     linux-iio@vger.kernel.org
>>> +Description:
>>> +             Phase in radians of one frequency/clock output Y
>>> +             (out_altvoltageY) relative to another frequency/clock 
>>> output
>>> +             (out_altvoltageZ) of the device X. The number must 
>>> always be
>>> +             specified and unique if the output corresponds to a 
>>> single
>>> +             channel.
>>> +
>> Do we need a way of specifying which channel is channel z?  e.g. what
>> this is relative to?  Or do
>> we always assume it is relative to the channel 0?
> Right now it's assumed it's relative to a channel that sets
> phase to 0.
>
> The device in mind is a clock distribution IC featuring 14 channels.
> Each channel can be given a phase offset. When the device is put
> into SYNC, either a external supplied pulse, or by writing an
> sysfs attribute, the state machine starts the channels with
> it's dedicated phase offset.
>
> Side questions. Radian is a SI derived unit, however dealing with
> fractions and multiples of PI is a bit suboptimal within the kernel.
err... Would prefer radians just because someone will argue in favour
of degrees for gyroscopes etc if we let it in somewhere...

>
> Do you mind if we make phase use degrees or grads?
>
>>
>> Rest are fine.
>>>    What:               /sys/bus/iio/devices/iio:deviceX/events
>>>    KernelVersion:      2.6.35
>>>    Contact:    linux-iio@vger.kernel.org
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>

