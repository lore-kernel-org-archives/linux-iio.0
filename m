Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <20141118133725.DEB5D4029E@saturn.retrosnub.co.uk>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-2-git-send-email-octavian.purdila@intel.com>
	<20141118133725.DEB5D4029E@saturn.retrosnub.co.uk>
Date: Tue, 18 Nov 2014 17:21:42 +0200
Message-ID: <CAE1zotJ28ngRnWNkMKygpnriqypyAC0rozvTmm1PXTibfMTqWw@mail.gmail.com>
Subject: Re: [RFC 1/8] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

>> +
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_fifo_length
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_accel_fifo_length
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_magn_fifo_length
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_length
>> +KernelVersion: 3.19
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               The maximum number of samples that the hardware fifo can
>> +               store.
>
> This provides information useful in debugging, but userspace should not
> care other than in how this constrains the watershed point.
>

This is useful for the application so that it can increase the device
buffer size in order to be able to use the hardware fifo, since the
data will be flushed from the hardware fifo to the device buffer. I
should have probably explain that.

>> +
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_fifo_mode
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_accel_fifo_mode
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_magn_fifo_mode
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_mode
>> +KernelVersion: 3.19
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               The mode in which the hardware fifo currently operates.
>> The
>> +               supported values are "disabled", "fifo" and "stream".
>> +               In disabled mode the hardware fifo is not operational.
>> +               In fifo mode the samples are stored until the fifo is full
>> at
>> +               which point all subsequent samples are discarded.
>> +               In stream mode, when the fifo is full new samples start to
>> +               overrride old samples.
>
> In stream mode we end up with a nasty hybrid of a front end ring buffer
> pushing into a fifo.  I can see you want to support the hardware fully
> but for now am unconvinced that it ever makes sense to use stream mode.
> If user space wants the latest data it is because it is time critical and
> hence it won't want to have a fifo in the way.  If it wants to not drop
> data then the fifo should be fine.  Ultimately if we are hitting the
> limit where this choice matters then we have a nasty problem...

The stream mode can help when we want to collect data while the CPU is
a sleep. See this Android reference:

http://source.android.com/devices/sensors/batching.html#behavior_in_suspend_mode

>>
>> +               If the hardware supports it, IIO_EVENT_TYPE_FIFO_FULL and
>> +               IIO_EVENT_TYPE_FIFO_WATERMARK events will be generated
>> when they
>> +               are enabled by the application and the fifo is full and,
>> +               respectively, when the fifo level reaches the watermark
>> +               level.
>
> In a sense fifo full is an error rather than a useful event.  Now error
> reporting is an area we don't have well covered.  Suggestions welcome!

Yes, it is an error. Still, I think it is an useful event. For
example, userspace can take note of this and reduce the watermark
level.

>>
>> +               The watermark level can be set by the application by
>> configuring
>> +               the IIO_EVENT_TYPE_FIFO_WATERMARK value
>> (IIO_EV_INFO_VALUE).
>> +
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_fifo_mode_available
>> +What:
>> /sys/bus/iio/devices/iio:deviceX/in_accel_fifo_mode_available
>> +What:
>> /sys/bus/iio/devices/iio:deviceX/in_magn_fifo_mode_available
>> +What:
>> /sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_mode_available
>> +KernelVersion: 3.19
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               The modes that the hardware fifo supports.
>> +
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_fifo_flush
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_accel_fifo_flush
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_magn_fifo_flush
>> +What:          /sys/bus/iio/devices/iio:deviceX/in_anglvel_fifo_flush
>> +KernelVersion: 3.19
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               Writting to this entry will cause the device to flush the
>> data
>> +               from the hardware fifo into the device buffer.
>
> This is an interesting concept.  Why would userspace want to have control
> of the rough time of the buffer read out?  If it is using the watershed
> event, then why not make it push the data to the software buffer when that
> occurs?  If not and we have no events on the buffer then I think we'd
> want to push this polling into the kernel as it would depend on the
> (hopefully known) sampling frequency and the size of the hardware buffer...
>

Yes, for most cases the watershed interrupt should be the one that
drives flushing the hardware fifo.

Having this knob helps the application balance power and latency, as
I've explain in the other email.

>
>
>> diff --git a/drivers/iio/industrialio-core.c
>> b/drivers/iio/industrialio-core.c
>> index af3e76d..17e84c3 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -113,6 +113,8 @@ static const char * const iio_chan_info_postfix[] = {
>>         [IIO_CHAN_INFO_HARDWAREGAIN] = "hardwaregain",
>>         [IIO_CHAN_INFO_HYSTERESIS] = "hysteresis",
>>         [IIO_CHAN_INFO_INT_TIME] = "integration_time",
>> +       [IIO_CHAN_INFO_FIFO_LENGTH] = "fifo_length",
>> +       [IIO_CHAN_INFO_FIFO_FLUSH] = "fifo_flush",
>
> Where is the watermark level set?
>>

I have defined watermark as an event, so the watermark value is set in
in write_event_value (just as for e.g. ROC).
