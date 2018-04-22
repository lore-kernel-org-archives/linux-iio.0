Return-Path: <SRS0=zKlK=HL=gmail.com=davidjulianveenstra@kernel.org>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com> <e2eaff8115d8fd170767c76119cf6cdd2d1ebc92.1524247563.git.davidjulianveenstra@gmail.com> <20180421180843.3bd3042a@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de, daniel.baluta@nxp.com, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/13] staging: iio: Documentation: Add missing sysfs docs for angle channel
In-reply-to: <20180421180843.3bd3042a@archlinux>
Date: Sun, 22 Apr 2018 16:41:16 +0200
Message-ID: <87in8jmhgz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


On 21, April 2018 19:08, Jonathan Cameron wrote:

> On Fri, 20 Apr 2018 21:31:37 +0200
> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> The iio resolver drivers in staging use angle channels. This patch
>> add missing documentation for this type of channel.
>> 
>> As was discussed in [1], radians is chosen as the unit, to match the
>> unit of angular velocity.
>> 
>> [1] https://marc.info/?l=linux-driver-devel&m=152190078308330&w=2
>> 
>> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
>> ---
>> Change in v2:
>>   - Introduces in this version.
>> 
>>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 6a5f34b4d5b9..8ad0e55f99ee 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -190,6 +190,15 @@ Description:
>>  		but should match other such assignments on device).
>>  		Units after application of scale and offset are m/s^2.
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_x_raw
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_y_raw
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_z_raw
> This surprised me.  A resolver is not going to inherently have any
> notion of a particular axis.
> Would expect.
> in_angl_raw

For the attributes that were added, I tried to match it with
the angular velocity counterpart. But it indeed doesn't make
much sense to have an axis for a resolver. I'll remove axis
modifier for v3.

Best regards,
David Veenstra

>
> Jonathan
>
>> +KernelVersion:	4.17
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Angle about axis x, y or z (may be arbitrarily assigned). Units
>> +		after application of scale and offset are radians.
>> +
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
>> @@ -297,6 +306,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
>>  KernelVersion:	2.6.35
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> @@ -350,6 +360,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
>>  KernelVersion:	2.6.35
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
