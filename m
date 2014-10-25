Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49900 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaJYTQD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:16:03 -0400
Message-ID: <544B7184.4080002@kernel.org>
Date: Sat, 25 Oct 2014 10:46:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	opw-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add ABI documentation for offset and scaled humidity
References: <1414064661-4645-1-git-send-email-roberta.dobrescu@gmail.com> <544A0F47.5070605@intel.com>
In-Reply-To: <544A0F47.5070605@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/10/14 09:35, Daniel Baluta wrote:
> 
> 
> On 10/23/2014 02:44 PM, Roberta Dobrescu wrote:
>> This patch adds ABI documentation entries for in_humidityrelative_offset
>> and in_humidityrelative_scale, since there is at least one user for these,
>> Si7005 humidity and temperature sensor driver.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> 
>> ---
>>   Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index d760b02..ffcadca 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -231,6 +231,7 @@ What:        /sys/bus/iio/devices/iio:deviceX/in_tempY_offset
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_temp_offset
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>> +What:        /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>>   KernelVersion:    2.6.35
>>   Contact:    linux-iio@vger.kernel.org
>>   Description:
>> @@ -266,6 +267,7 @@ What:       
>> /sys/bus/iio/devices/iio:deviceX/in_rot_from_north_magnetic_tilt_comp_sca
>>   What:       
>> /sys/bus/iio/devices/iio:deviceX/in_rot_from_north_true_tilt_comp_scale
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_pressure_scale
>> +What:        /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>>   KernelVersion:    2.6.35
>>   Contact:    linux-iio@vger.kernel.org
>>   Description:
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
