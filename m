Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53B2C758.6090602@linux.intel.com>
Date: Tue, 01 Jul 2014 07:36:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
 linux-iio@vger.kernel.org
CC: lars@metafoo.de, yannick.bedhomme@mobile-devices.fr
Subject: Re: [PATCH 2/2] iio: add watermark logic to iio read and poll
References: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr> <1403886001-23354-3-git-send-email-josselin.costanzi@mobile-devices.fr> <53B02149.8050900@kernel.org>
In-Reply-To: <53B02149.8050900@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

d
On 06/29/2014 07:23 AM, Jonathan Cameron wrote:
> On 27/06/14 17:20, Josselin Costanzi wrote:
>> Currently the IIO buffer blocking read only wait until at least one
>> data element is available.
>> This patch makes the reader sleep until enough data is collected before
>> returning to userspace. This should limit the read() calls count when
>> trying to get data in batches.
>>
>> Co-author: Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>
> If Yannick is happy to do so, just both sign off on it as Co-author won't
> get picked up by any automated processing of sign offs etc.
>> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
>
> I'm mostly happy with this, though a few bits need cleaning up.
> (inline).
>
> The interaction with the sca3000 buffer is a little interesting but 
> that one
> was always going to be odd.
>
> I'd be interested to hear comments on this from Lars and Srinivas in 
> particular
> as I know they are both interested in this aspect.  It's a non trivial
> change so I want a nice warm fuzzy feeling before taking it ;)

Great.  In my case the watermark will keep the processor in deep idle state
for longer time for power save.
So for example my HW Fifo can store 64 samples, then
watermark can set up to 64, so that chip doesn't wake up processor.
This all depends on how long delay the user space can take.

Can we export the maximum value of low water mark user space
can set? If not we have to set to max possible driver can have
when user space asks for some higher value.
As we do for frequencies and others, can we also give this information
to user space?

Also some helper inline functions to get the value instead of directly
to a driver instead of directly using r->low_watermark?

Thanks,
Srinivas

>
> Jonathan eee
>> ---
>>   Documentation/ABI/testing/sysfs-bus-iio  |  21 ++++
>>   drivers/iio/industrialio-buffer.c        | 188 
>> +++++++++++++++++++++++++++----
>>   drivers/iio/kfifo_buf.c                  |  15 +--
>>   drivers/staging/iio/accel/sca3000_ring.c |   4 +-
>>   include/linux/iio/buffer.h               |  48 +++++++-
>>   5 files changed, 244 insertions(+), 32 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index a9757dc..0a4662e 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -933,3 +933,24 @@ Description:
>>           x y z w. Here x, y, and z component represents the axis about
>>           which a rotation will occur and w component represents the
>>           amount of rotation.
>> +
>> +What: /sys/bus/iio/devices/iio:deviceX/buffer/low_watermark
>> +KernelVersion:    3.16
>> +Contact:    linux-iio@vger.kernel.org
>> +Description:
>> +        A single positive integer specifying the maximum number of scan
>> +        elements to wait for.
>> +        Poll will block until the watermark is reached.
>> +        Blocking read will wait until the minimum between the requested
>> +        read amount or the low water mark is available.
>> +
>> +What:        /sys/bus/iio/devices/iio:deviceX/buffer/timeout
>> +KernelVersion:    3.16
>> +Contact:    linux-iio@vger.kernel.org
>> +Description:
>> +        A single non-negative integer that represents an activity
>> +        timeout in microseconds for which we wait during blocking read
>> +        operation. The timer is reset each time a new sample is added
>> +        to the buffer.
>> +        By default its value is zero which indicates the read operation
>> +        will not timeout.
>> diff --git a/drivers/iio/industrialio-buffer.c 
>> b/drivers/iio/industrialio-buffer.c
>> index 2952ee0..c8ee523 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -37,7 +37,7 @@ static bool iio_buffer_is_active(struct iio_buffer 
>> *buf)
>>       return !list_empty(&buf->buffer_list);
>>   }
>>
>> -static bool iio_buffer_data_available(struct iio_buffer *buf)
>> +static size_t iio_buffer_data_available(struct iio_buffer *buf)
>>   {
>>       return buf->access->data_available(buf);
>>   }
>> @@ -53,6 +53,11 @@ ssize_t iio_buffer_read_first_n_outer(struct file 
>> *filp, char __user *buf,
>>   {
>>       struct iio_dev *indio_dev = filp->private_data;
>>       struct iio_buffer *rb = indio_dev->buffer;
> oops, been meaning to clear this out.  Still called rb from when we
> actually had a ring buffer...  Anyhow, not relevant to this series...
>
>> +    size_t datum_size = rb->access->get_bytes_per_datum(rb);
> I can see where you are coming from, but right now datum_size returns
> an integer, so I'm a little dubious on the conversion to a size_t.
> It might make sense to move the function definition over to a size_t...
>
>> +    size_t to_read = min_t(size_t, n / datum_size, rb->low_watermark);
>> +    size_t data_available;
>> +    size_t count = 0;
>> +    long timeout = -1;
>>       int ret;
>>
>>       if (!indio_dev->info)
>> @@ -62,25 +67,49 @@ ssize_t iio_buffer_read_first_n_outer(struct file 
>> *filp, char __user *buf,
>>           return -EINVAL;
>>
>>       do {
>> -        if (!iio_buffer_data_available(rb)) {
>> -            if (filp->f_flags & O_NONBLOCK)
>> -                return -EAGAIN;
>> +        data_available = iio_buffer_data_available(rb);
>>
>> -            ret = wait_event_interruptible(rb->pollq,
>> -                    iio_buffer_data_available(rb) ||
>> -                    indio_dev->info == NULL);
>> -            if (ret)
>> -                return ret;
>> -            if (indio_dev->info == NULL)
>> -                return -ENODEV;
>> +        if (filp->f_flags & O_NONBLOCK) {
>> +            if (!data_available) {
>> +                ret = -EAGAIN;
>> +                break;
>> +            }
>> +        } else {
>> +            if (data_available < to_read) {
>> +                timeout = wait_event_interruptible_timeout(
>> +                    rb->pollq,
>> +                    iio_buffer_data_available(rb) >= to_read ||
>> +                    indio_dev->info == NULL,
>> +                    rb->timeout);
>> +
>> +                if (indio_dev->info == NULL) {
>> +                    ret = -ENODEV;
>> +                    break;
>> +                }
>> +
>> +                if (timeout < 0) {
>> +                    ret = timeout;
>> +                    break;
>> +                }
>> +            }
>>           }
>>
>> -        ret = rb->access->read_first_n(rb, n, buf);
>> -        if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>> -            ret = -EAGAIN;
>> -     } while (ret == 0);
>> +        ret = rb->access->read_first_n(rb, n, buf + count);
>> +        if (ret < 0)
>> +            break;
>>
>> -    return ret;
>> +        count += ret;
>> +        n -= ret;
>> +        to_read -= ret / datum_size;
>> +     } while (to_read > 0 && timeout > 0);
>> +
>> +    if (count)
>> +        return count;
>> +    if (ret < 0)
>> +        return ret;
> This gets a little fiddly as we might have an error on a second pass
> through the while loop.  Under those circumstances it will be eaten
> up without being reported whcih I'm generally against! I'd normally
> argue reporting the error is more important than reporting the
> data we have maanged to gather.
>> +
>> +    WARN_ON(timeout);
>> +    return -EAGAIN;
>>   }
>>
>>   /**
>> @@ -96,9 +125,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>>           return -ENODEV;
>>
>>       poll_wait(filp, &rb->pollq, wait);
>> -    if (iio_buffer_data_available(rb))
>> +    if (iio_buffer_data_available(rb) >= rb->low_watermark)
>>           return POLLIN | POLLRDNORM;
> Perfectly possible to end up with a watermark of 0 I think...
> (see below).  That would make this condition pass even with no
> data which is less than ideal.  I think you need a special case
> for that.
>> -    /* need a way of knowing if there may be enough data... */
>>       return 0;
>>   }
>>
>> @@ -123,6 +151,8 @@ void iio_buffer_init(struct iio_buffer *buffer)
>>       INIT_LIST_HEAD(&buffer->buffer_list);
>>       init_waitqueue_head(&buffer->pollq);
>>       kref_init(&buffer->ref);
>> +    buffer->low_watermark = 1;
>> +    buffer->timeout = MAX_SCHEDULE_TIMEOUT;
>>   }
>>   EXPORT_SYMBOL(iio_buffer_init);
>>
>> @@ -442,7 +472,16 @@ ssize_t iio_buffer_write_length(struct device *dev,
>>       }
>>       mutex_unlock(&indio_dev->mlock);
>>
>> -    return ret ? ret : len;
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (buffer->access->get_length)
>> +        val = buffer->access->get_length(buffer);
>> +
>> +    if (val < buffer->low_watermark)
>> +        buffer->low_watermark = val;
>
> Let me think this through...
>
> Initially on kfifo buffers the buffer isn't initialized.  Hence it should
> report as length 0. Thus the watermark is clamped to 0.  I'd just start
> the watermark at 0 and interpret that as no watermark enabled.
>
> To set one up, the buffer length would have to be set first then the
> watermark level.
>> +
>> +    return len;
>>   }
>>   EXPORT_SYMBOL(iio_buffer_write_length);
>>
>> @@ -513,6 +552,7 @@ static void iio_buffer_activate(struct iio_dev 
>> *indio_dev,
>>   static void iio_buffer_deactivate(struct iio_buffer *buffer)
>>   {
>>       list_del_init(&buffer->buffer_list);
>> +    wake_up_interruptible(&buffer->pollq);
>>       iio_buffer_put(buffer);
>>   }
>>
>> @@ -792,6 +832,105 @@ done:
>>   }
>>   EXPORT_SYMBOL(iio_buffer_store_enable);
>>
>> +ssize_t iio_buffer_show_watermark(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   char *buf)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct iio_buffer *buffer = indio_dev->buffer;
>> +
>> +    return sprintf(buf, "%u\n", buffer->low_watermark);
>> +}
>> +EXPORT_SYMBOL(iio_buffer_show_watermark);
>> +
>> +ssize_t iio_buffer_store_watermark(struct device *dev,
>> +                struct device_attribute *attr,
>> +                const char *buf,
>> +                size_t len)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct iio_buffer *buffer = indio_dev->buffer;
>> +    unsigned int val;
>> +    int ret;
>> +
>> +    ret = kstrtouint(buf, 10, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (buffer->access->get_length &&
>> +        (val > buffer->access->get_length(buffer)))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&indio_dev->mlock);
>> +    if (iio_buffer_is_active(indio_dev->buffer)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    buffer->low_watermark = val;
>> +    ret = 0;
> Don't need this ret = 0...
>> +out:
>> +    mutex_unlock(&indio_dev->mlock);
>> +    return ret ? ret : len;
>> +}
>> +EXPORT_SYMBOL(iio_buffer_store_watermark);
>> +
>> +static int iio_buffer_timeout_set(struct iio_buffer *buffer, long 
>> timeout_us)
>> +{
>> +    if (timeout_us > 0) {
>> +        buffer->timeout = usecs_to_jiffies(timeout_us);
>> +    } else if (timeout_us == 0){
>> +        buffer->timeout = MAX_SCHEDULE_TIMEOUT;
>> +    } else {
>> +        return -EINVAL;
>> +    }
> Excess brackets and spacing interesting around them!
>> +    return 0;
>> +}
>> +
>> +static long iio_buffer_timeout_get(struct iio_buffer *buffer)
>> +{
>> +    if (buffer->timeout != MAX_SCHEDULE_TIMEOUT)
>> +        return jiffies_to_usecs(buffer->timeout);
>> +    return 0;
>> +}
>> +
>> +ssize_t iio_buffer_show_timeout(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   char *buf)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct iio_buffer *buffer = indio_dev->buffer;
> I'd drop the local copy of buffer and just put it directly in below.
>> +
>> +    return sprintf(buf, "%ld\n", iio_buffer_timeout_get(buffer));
>> +}
>> +EXPORT_SYMBOL(iio_buffer_show_timeout);
>> +
>> +ssize_t iio_buffer_store_timeout(struct device *dev,
>> +                struct device_attribute *attr,
>> +                const char *buf,
>> +                size_t len)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct iio_buffer *buffer = indio_dev->buffer;
>> +    long val;
>> +    int ret;
>> +
>> +    ret = kstrtol(buf, 10, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mutex_lock(&indio_dev->mlock);
>> +    if (iio_buffer_is_active(indio_dev->buffer)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +    ret = iio_buffer_timeout_set(buffer, val);
>> +out:
>> +    mutex_unlock(&indio_dev->mlock);
>> +    return ret ? ret : len;
>> +}
>> +EXPORT_SYMBOL(iio_buffer_store_timeout);
>> +
>>   /**
>>    * iio_validate_scan_mask_onehot() - Validates that exactly one 
>> channel is selected
>>    * @indio_dev: the iio device
>> @@ -913,8 +1052,17 @@ static const void *iio_demux(struct iio_buffer 
>> *buffer,
>>   static int iio_push_to_buffer(struct iio_buffer *buffer, const void 
>> *data)
>>   {
>>       const void *dataout = iio_demux(buffer, data);
>> +    int ret;
>>
>> -    return buffer->access->store_to(buffer, dataout);
>> +    ret = buffer->access->store_to(buffer, dataout);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* We can't just test for watermark to decide if we wake the 
>> poll queue
>> +     * because read may request less samples than the watermark
>> +     */
> Multiline comment syntax please. + fewer rather than less.
>> + wake_up_interruptible(&buffer->pollq);
> blank line here would be nice.
>> +    return 0;
>>   }
>>
>>   static void iio_buffer_demux_free(struct iio_buffer *buffer)
>> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
>> index 7134e8a..79ceb35 100644
>> --- a/drivers/iio/kfifo_buf.c
>> +++ b/drivers/iio/kfifo_buf.c
>> @@ -54,10 +54,14 @@ static int iio_get_length_kfifo(struct iio_buffer 
>> *r)
>>
>>   static IIO_BUFFER_ENABLE_ATTR;
>>   static IIO_BUFFER_LENGTH_ATTR;
>> +static IIO_BUFFER_WATERMARK_ATTR;
>> +static IIO_BUFFER_TIMEOUT_ATTR;
>>
>>   static struct attribute *iio_kfifo_attributes[] = {
>>       &dev_attr_length.attr,
>>       &dev_attr_enable.attr,
>> +    &dev_attr_low_watermark.attr,
>> +    &dev_attr_timeout.attr,
>>       NULL,
>>   };
>>
>> @@ -107,9 +111,6 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>>       ret = kfifo_in(&kf->kf, data, 1);
>>       if (ret != 1)
>>           return -EBUSY;
>> -
>> -    wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
>> -
>>       return 0;
>>   }
>>
>> @@ -133,16 +134,16 @@ static int iio_read_first_n_kfifo(struct 
>> iio_buffer *r,
>>       return copied;
>>   }
>>
>> -static bool iio_kfifo_buf_data_available(struct iio_buffer *r)
>> +static size_t iio_kfifo_buf_data_available(struct iio_buffer *r)
>>   {
>>       struct iio_kfifo *kf = iio_to_kfifo(r);
>> -    bool empty;
>> +    size_t samples;
>>
>>       mutex_lock(&kf->user_lock);
>> -    empty = kfifo_is_empty(&kf->kf);
>> +    samples = kfifo_len(&kf->kf);
>>       mutex_unlock(&kf->user_lock);
>>
>> -    return !empty;
>> +    return samples;
>>   }
>>
>>   static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
>> diff --git a/drivers/staging/iio/accel/sca3000_ring.c 
>> b/drivers/staging/iio/accel/sca3000_ring.c
>> index 33f0e92..91f838f 100644
>> --- a/drivers/staging/iio/accel/sca3000_ring.c
>> +++ b/drivers/staging/iio/accel/sca3000_ring.c
>> @@ -141,9 +141,9 @@ static int 
>> sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
>>       return 6;
>>   }
>>
>> -static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
>> +static size_t sca3000_ring_buf_data_available(struct iio_buffer *r)
>>   {
>> -    return r->stufftoread;
>> +    return r->stufftoread ? r->low_watermark : 0;
> In this case, what sets the low_watermark?  Whilst the interface is a 
> mess
> in this driver (rather old ;) it does have information about how much 
> data is
> available.  From what I recall, it has two interrupts at 50% and 75% that
> tell us there is data.  Perhaps we set the low_watermark = 50% of the 
> buffer
> at the start?  Then this will more or less work.  Either that or make 
> the two
> read interrupt being configured set the watermark as desired (and make 
> them
> mutually exclusive if they aren't already.
>
>>   }
>>
>>   static IIO_BUFFER_ENABLE_ATTR;
>> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
>> index 5193927..837f5ec 100644
>> --- a/include/linux/iio/buffer.h
>> +++ b/include/linux/iio/buffer.h
>> @@ -21,8 +21,8 @@ struct iio_buffer;
>>    * struct iio_buffer_access_funcs - access functions for buffers.
>>    * @store_to:        actually store stuff to the buffer
>>    * @read_first_n:    try to get a specified number of bytes (must 
>> exist)
>> - * @data_available:    indicates whether data for reading from the 
>> buffer is
>> - *            available.
>> + * @data_available:    indicates how much data is available for 
>> reading from
>> + *            the buffer.
>>    * @request_update:    if a parameter change has been marked, 
>> update underlying
>>    *            storage.
>>    * @get_bytes_per_datum:get current bytes per datum
>> @@ -45,7 +45,7 @@ struct iio_buffer_access_funcs {
>>       int (*read_first_n)(struct iio_buffer *buffer,
>>                   size_t n,
>>                   char __user *buf);
>> -    bool (*data_available)(struct iio_buffer *buffer);
>> +    size_t (*data_available)(struct iio_buffer *buffer);
>>
>>       int (*request_update)(struct iio_buffer *buffer);
>>
>> @@ -76,6 +76,10 @@ struct iio_buffer_access_funcs {
>>    * @demux_bounce:    [INTERN] buffer for doing gather from incoming 
>> scan.
>>    * @buffer_list:    [INTERN] entry in the devices list of current 
>> buffers.
>>    * @ref:        [INTERN] reference count of the buffer.
>> + * @low_watermark:    [INTERN] number of datums for poll/blocking 
>> read to
>> + *             wait for.
>> + * @timeout:        [INTERN] inactivity timeout in jiffies for blocking
>> + *             read.
>>    */
>>   struct iio_buffer {
>>       int                    length;
>> @@ -93,6 +97,8 @@ struct iio_buffer {
>>       void                    *demux_bounce;
>>       struct list_head            buffer_list;
>>       struct kref                ref;
>> +    unsigned int                low_watermark;
>> +    unsigned long                timeout;
>>   };
>>
>>   /**
>> @@ -201,6 +207,34 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>>   ssize_t iio_buffer_show_enable(struct device *dev,
>>                      struct device_attribute *attr,
>>                      char *buf);
>> +/**
>> + * iio_buffer_show_watermark() - attr to see the read watermark
> */ preferred for kernel-doc. Also ideally document the parameters
> however silly it may seem.
>> + **/
>> +ssize_t iio_buffer_show_watermark(struct device *dev,
>> +                struct device_attribute *attr,
>> +                char *buf);
>> +/**
>> + * iio_buffer_store_watermark() - attr to configure the read watermark
>> + **/
>> +ssize_t iio_buffer_store_watermark(struct device *dev,
>> +                struct device_attribute *attr,
>> +                const char *buf,
>> +                size_t len);
>> +/**
>> + * iio_buffer_show_timeout() - attr to see the read timeout 
>> (microseconds)
>> + * Note: if no timeout is set, returns 0
>> + **/
>> +ssize_t iio_buffer_show_timeout(struct device *dev,
>> +                struct device_attribute *attr,
>> +                char *buf);
>> +/**
>> + * iio_buffer_store_timeout() - attr to configure read timeout 
>> (microseconds)
>> + * Note: to disable the timeout, write 0
>> + **/
>> +ssize_t iio_buffer_store_timeout(struct device *dev,
>> +                struct device_attribute *attr,
>> +                const char *buf,
>> +                size_t len);
>>   #define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | 
>> S_IWUSR,    \
>>                          iio_buffer_read_length,    \
>>                          iio_buffer_write_length)
>> @@ -209,6 +243,14 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>>                          iio_buffer_show_enable,    \
>>                          iio_buffer_store_enable)
>>
>> +#define IIO_BUFFER_WATERMARK_ATTR DEVICE_ATTR(low_watermark, S_IRUGO 
>> | S_IWUSR,    \
>> +                       iio_buffer_show_watermark,    \
>> +                       iio_buffer_store_watermark)
>> +
>> +#define IIO_BUFFER_TIMEOUT_ATTR DEVICE_ATTR(timeout, S_IRUGO | 
>> S_IWUSR,    \
>> +                       iio_buffer_show_timeout,    \
>> +                       iio_buffer_store_timeout)
>> +
>>   bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>>       const unsigned long *mask);
>>
>>
>
>
