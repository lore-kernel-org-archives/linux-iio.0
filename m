Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37239 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbaGTMUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 08:20:06 -0400
Message-ID: <53CBB47F.9000903@kernel.org>
Date: Sun, 20 Jul 2014 13:22:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: Accelerometer events
References: <53C68F32.9050407@parkeon.com> <53CBAE8F.3010507@metafoo.de>
In-Reply-To: <53CBAE8F.3010507@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/14 12:57, Lars-Peter Clausen wrote:
> On 07/16/2014 04:41 PM, Martin Fuzzey wrote:
>> Hi all,
>>
>> I am in the process of adding events support to the mma8452 driver (patches
>> will be forthcoming when cooked a little more).
>>
>> However I have a few questions.
>>
>> The hardware can generate an interrupt when the absolute value of the high
>> pass filtered acceleration exceeds a configurable threshold.
>> This is called "transient detection" in the datasheet.
>> There is only a single threshold but the interrupt can be enabled or
>> disabled for each axis.
>>
>> So I define this as:
>> static const struct iio_event_spec mma8452_transient_event[] = {
>>      {
>>          .type = IIO_EV_TYPE_MAG,
>>          .dir = IIO_EV_DIR_RISING,
>>          .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>          .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>>      },
>> };
>>
>> That causes the following sysfs entries to be created:
>> # ls -l /sys/bus/iio/devices/iio:device0/events
>> -rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_mag_rising_value
>> -rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_x_mag_rising_en
>> -rw-r--r-- 1 root root 4096 Jul 16 13:25 in_accel_y_mag_rising_en
>> -rw-r--r-- 1 root root 4096 Jul 16 13:26 in_accel_z_mag_rising_en
>>
>> IE one enable switch per axis and one threshold (as expected).
>>
>> However Documentation/ABI/testing/sysfs-bus-iio seems to indicate that the
>> threshold values
>> should have raw or input variants.  [ /sys/.../events/in_accel_raw_mag_value]
>>
>> This part is handled by the core, not the driver. Is there a problem here?
Ah, implicitly the assumption is the events are in the same format as the channels.
We probably should have had the raw/input bit in there just in case they aren't.

>>
>> When raw values are used for the threshold, how is userspace to know the
>> conversion factor?
>> In the case of the mma8452 it cannot use the current scale factor available in
>>      /sys/bus/iio/devices/iio\:device0/in_accel_scale
>> because the transient detection is always configured using 8G/127 units,
>> regardless of the full
>> scale value (2G, 4G, 8G) selected for measurements.
>>
>> Does this mean there should be another in_accel_scale in the events sysfs
>> subdirectory?
>>
>
> So far the issue hasn't come up, so there is no support for this yet.
> But it should be possible to add support for it.
Yes, this is fine.  We already have cases where the event sampling frequency
for example is different from the main device sampling frequency resulting
an event sampling_frequency in the events directory and a device sampling_frequency
attribute in the top level directory.
>
>> My understanding of "rising"/"falling" is the crossing over / under the
>> threshold.
yup
>> However this hardware can only generate interrupts for exceeding the
>> threshold (for magnitude)
>> It can however determine the sign of the acceleration (+ve or -ve) when this
>> occurs - how should
>> this information be sent as an event?
>> I could use the "direction" attribute supplied to IIO_UNMOD_EVENT_CODE bit
>> this seems to be an abuse.
>
> Since there are also falling magnitude events using the direction bit
> doesn't really work since you couldn't distinguish between the two
> types of events. But adding a new field to the event that contains
> the sign of the magnitude should be possible.
The  moment you know the sign of the magnitude it stops being a magnitude
and becomes a generic threshold.  Report it as such and control it as such.
Don't worry that they have to be enabled together.  Just have two controls
and turning either of them on enables them both.  This happens all over the
place.  I suppose one day we might put a demux on the event path to cut
out unwanted reported events, but we have never cared yet.  If you really
care just cut them out in the driver if they aren't enabled.

>
>>
>> All this transient detection part works with high pass filtered data (and
>> the filter frequency is
>> configurable). There is no mention of high pass filters in the ABI, only low
>> pass. So how should this
>> be handled?
>
> Add a attribute that can configure the high pass filter frequency.
Yup.  We haven't done this until now as it hasn't been needed.  Hopefully
we made the ABI elements for lowpass filter naturally extend to a high
pass version.
>
>>
>> Finally I have been using the example userspace code in drivers/staging/Doc/
>> iio_event_monitor.c
>> But that does
>>      #include <linux/iio/events.h>
>>
>> Which is not exported by the kernel in include/uapi - is this a problem?
>> (Easy enough to hack around for testing
>> but if user space code is supposed to be using these interfaces...)
>
> Yep, that is a issue that needs to be fixed. We should clean these
> files up and remove things that shouldn't be exposed to userspace
> before moving the files to include/uapi.>
Yes.  The uapi stuff came along fairly recently and we haven't gotten
round to tidying up as we should.  Admittedly we weren't doing it correctly
for the old way either but that's not the point :)

Also, note that we should never be making any incompatible interface changes
in there (any more :) so sorting this out isn't all that urgent.
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

