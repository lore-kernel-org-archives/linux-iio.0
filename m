Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <54A96525.2030200@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-5-git-send-email-octavian.purdila@intel.com>
	<54A96525.2030200@kernel.org>
Date: Mon, 5 Jan 2015 21:29:13 +1000
Message-ID: <CAE1zot+7DdscD6+D=XaX08Fpsbdheqn6OUPMSZYEMoRqV2m+rw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] iio: add support for hardware fifo
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 5, 2015 at 2:07 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/12/14 00:42, Octavian Purdila wrote:
>
> Thanks for taking this on!
>
> This all looks fairly sensible, though a few comments inline.
> One big semantic change I'd suggest is to allow the watermark
> level passed to the hardware to be a 'hint' rather than a hard
> and fast rull.  A lot of these hardware buffers are fairly small
> (perhaps 32 entries) and the devices can run fast so whilst
> we will obviously have to handle an interrupt often, we may well
> want to have a much larger software front end buffer with a
> much larger watermark.  For example, a 8192Hz accelerometer
> with 32 entry fifo (watermark at 16).  Will fire an interrupt 512 times
> a second.  Userspace might be only interested in getting data 32 times
> a second and hence want a watermark of 256 entries and probably have
> a buffer that is 512 entries long or more.
>

Very good point with the above example, but I find the hint approach a
bit too hard to diagnose and tune by the application.

Could we perhaps expose the hwfifo watermark as well, in addition to
the software watermark? We can even keep the hint behavior if the
application only touches the software watermark, but if it the
application directly sets the hwfifo level then we use that.

>> Some devices have hardware buffers that can store a number of samples
>> for later consumption. Hardware usually provides interrupts to notify
>> the processor when the fifo is full or when it has reached a certain
>> threshold. This helps with reducing the number of interrupts to the
>> host processor and thus it helps decreasing the power consumption.
>>
>> This patch adds support for hardware fifo to IIO by allowing the
>> drivers to register operations for flushing the hadware fifo and
>> setting the watermark level.
>
> Perhaps put something in here to observe that this is a different approach
> to the straight hardware buffer stuff we already have - of most interest
> for hybrid buffering rather than a pure hardware buffer.
>

Will do.

>>
>> A driver implementing hardware fifo support must also provide a
>> watermark trigger which must contain "watermark" in its name.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 22 +++++++++++++++++
>>  drivers/iio/industrialio-buffer.c       | 44 ++++++++++++++++++++++++++++-----
>>  include/linux/iio/iio.h                 | 17 +++++++++++++
>>  3 files changed, 77 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 7260f1f..6bb67ac 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1152,3 +1152,25 @@ Description:
>>               Poll will block until the watermark is reached.
>>               Blocking read will wait until the minimum between the requested
>>               read amount or the low water mark is available.
>> +             If the device has a hardware fifo this value is going to be used
>> +             for the hardware fifo watermark as well.
>
> I'd make this a litle vaguer (deliberately ;).   Perhaps used as a 'hint'
> for the hardware fifo watermark as well.  The reason being that if we set
> the software watermark at say 20 and the hardware only has 15 fifo entries,
> then we might want to be clever and say set the hardware fifo watershed to 10.
> For now that would be a decision of the hardware driver rather than one for
> the core.

Sure, I'll update the docs with what ever we end-up deciding its best :)

>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo-length
>> +KernelVersion:       3.20
>> +Contact:     linux-iio@vger.kernel.org
>> +Description:
>> +             A single positive integer specifying the maximum number of
>> +             samples that the hardware fifo has. If the device does not
>> +             support hardware fifo this is zero.
>> +             When a device supports hardware fifo it will expose a trigger
>> +             with the name that contains "watermark"
>> +             (e.g. i2c-BMC150A:00-watermark-dev0).
>> +             To use the hardware fifo the user must set an appropriate value
>> +             in the buffer/length and buffer/low_watermark entries and select
>> +             the watermark trigger. At that poin the hardware fifo will be
> point
>> +             enabled and the samples will be collected in a hardware buffer.
> Hmm. I wonder to a degree if the trigger approach really makes sense for
> fifo equiped devices.  We've deliberately not added one in a few existing
> cases.
>
> Otherwise, is there a reason to run this separately from a trigger not using
> the fifo.  Surely that's just the same as a watermark of 1?
>
> Anyhow, a point for discussion!

I might be misunderstand you here, but the reason for which we use a
separate trigger is to have a way to enable/disable FIFO mode, because
enabling the FIFO might have some downsides, e.g. more power
consumption. This matters only when the application is interested in
low latency sampling ( watermark of 1).

I don't know if this is really an issue in practice, but I chose the
safe option.

>
>> +             When the number of samples in the hardware fifo reaches the
>> +             watermark level the watermark trigger is issued and data is
>> +             flushed to the devices buffer.
>> +             A hardware buffer flush will also be triggered when reading from
>> +             the device buffer and there is not enough data available.
>> \ No newline at end of file
> Fix this..
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 7f74c7f..3da6d07 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -37,9 +37,17 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>>       return !list_empty(&buf->buffer_list);
>>  }
>>
>> -static size_t iio_buffer_data_available(struct iio_buffer *buf)
>> +static bool iio_buffer_data_available(struct iio_dev *indio_dev,
>> +                                   struct iio_buffer *buf, size_t required)
>>  {
>> -     return buf->access->data_available(buf);
>> +     size_t avail = buf->access->data_available(buf);
>> +
>> +     if (avail < required && indio_dev->hwfifo) {
>> +             indio_dev->hwfifo->flush(indio_dev);
>> +             avail = buf->access->data_available(buf);
>> +     }
>> +
>> +     return avail >= required;
> Does it make sense to move the decision in here?  Could just as easily
> have left this as returning the length and done the logic outside...
> I don't mind that much... However, we probably want to rename the function
> now that it is doing more than strictly querying availability.

I've put it here so that it affects both read and poll so that we
avoid avoid latencies if possible. Will change the name.

>
> Could also have flush take a parameter for what is desired and only read
> that many?  On relatively slow buses might make sense...

Good point, will add that.

>>  /**
>> + * struct iio_buffer_hwfifo_ops - hardware fifo operations
>> + *
>> + * @length:          [DRIVER] the hardware fifo length
>> + * @set_watermark:   [DRIVER] setups the watermark level
>> + * @flush:           [DRIVER] copies data from the hardware buffer to the
>> + *                   device buffer
>> + * @watermark_trig:  [DRIVER] an allocated and registered trigger containing
>> + *                   "watermark" in its name
> err. This last one isn't actually in the structure...

Yeah, I wanted to add some checks in the core to make sure that if the
driver is registering the hwfifo ops then it should allocate and
register a watermark trigger as well. If we decide to go with the
trigger approach, do you think it is a good idea to add the checks?
