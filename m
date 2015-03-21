Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59500 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbCUMQh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2015 08:16:37 -0400
Message-ID: <550D6123.8080807@kernel.org>
Date: Sat, 21 Mar 2015 12:16:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v5 2/3] iio: add support for hardware fifo
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>	<1425491773-28499-3-git-send-email-octavian.purdila@intel.com>	<55047B00.9000800@kernel.org> <CAE1zotK1xxccif6d7pPSDRKoOWp8qNYO=-rvQjjzVU_=JGkF0A@mail.gmail.com>
In-Reply-To: <CAE1zotK1xxccif6d7pPSDRKoOWp8qNYO=-rvQjjzVU_=JGkF0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/15 10:05, Octavian Purdila wrote:
> On Sat, Mar 14, 2015 at 8:16 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On 04/03/15 17:56, Octavian Purdila wrote:
>>> Some devices have hardware buffers that can store a number of samples
>>> for later consumption. Hardware usually provides interrupts to notify
>>> the processor when the fifo is full or when it has reached a certain
>>> threshold. This helps with reducing the number of interrupts to the
>>> host processor and thus it helps decreasing the power consumption.
>>>
>>> This patch adds support for hardware fifo to IIO by adding drivers
>>> operations for flushing the hadware fifo and setting and getting the
>>> watermark level.
>>>
>>> Since a driver may support hardware fifo only when not in triggered
>>> buffer mode (due to different samantics of hardware fifo sampling and
>>> triggered sampling) this patch changes the IIO core code to allow
>>> falling back to non-triggered buffered mode if no trigger is enabled.
>>>
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> Bits and bobs inline
>>
>> Typo's and a comment on weird hardware possibilities..
>>
>> Also I'm not keen on some of the error handling.
>>
>> Sorry it too me so very long to look at this.  I keep thinking
>> it'll be fiddly and hence doing the easier stuff first only
>> to come to this and see that actually its very straight forward!.
> 
> Thank you for the review Jonathan ! I will try to be more responsive
> to help with the review process, sorry for the long absence.
You are welcome.  Take any time you need with this stuff. You are working
on an area we have all wanted for a while, but no one else has taken the
time to do it. Your hard work is very much appreciated!
> 
>>
>> Jonathan
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 25 ++++++++++++
>>>  drivers/iio/industrialio-buffer.c       | 69 +++++++++++++++++++++++++++------
>>>  include/linux/iio/iio.h                 | 26 +++++++++++++
>>>  3 files changed, 108 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 1283ca7..143ddf2d 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1264,3 +1264,28 @@ Description:
>>>               allows the application to block on poll with a timeout and read
>>>               the available samples after the timeout expires and thus have a
>>>               maximum delay guarantee.
>>> +
>>> +What:          /sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
>>> +KernelVersion: 3.21
>>> +Contact:       linux-iio@vger.kernel.org
>>> +Description:
>>> +            Read-only entry that contains a single integer specifying the
>>> +            current level for the hardware fifo watermark level. If this
>>> +            value is negative it means that the device does not support a
>>> +            hardware fifo. If this value is 0 it means that the hardware fifo
>>> +            is currently disabled.
>> I wonder if we should indicate lack of hardware support by just not exporting
>> this attribute in the first place?
> 
> OK, I don't see any reasons for which shouldn't work, I will give it a
> try in the next version.
> 
>>> +            If this value is strictly positive it signals that the hardware
>>> +            fifo of the device is active and that samples are stored in an
>>> +            internal hardware buffer. When the level of the hardware fifo
>>> +            reaches the watermark level the device will flush its internal
>>> +            buffer to the device buffer. Because of this a trigger is not
>>> +            needed to use the device in buffer mode.
>>> +            The hardware watermark level is set by the driver based on the
>>> +            value set by the user in buffer/watermark but taking into account
>>> +            the limitations of the hardware (e.g. most hardware buffers are
>>> +            limited to 32-64 samples).
>>> +            Because the sematics of triggers and hardware fifo may be
>>> +            different (e.g. the hadware fifo may record samples according to
>> hardware fifo
> 
> Ack.
> 
>>> +            the sample rate while an any-motion trigger generates samples
>>> +            based on the set rate of change) setting a trigger may disable
>>> +            the hardware fifo.
>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>>> index a4f4f07..b6f1bd4 100644
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -42,18 +42,47 @@ static size_t iio_buffer_data_available(struct iio_buffer *buf)
>>>       return buf->access->data_available(buf);
>>>  }
>>>
>>> +static int iio_buffer_flush_hwfifo(struct iio_dev *indio_dev,
>>> +                                struct iio_buffer *buf, size_t required)
>>> +{
>>> +     if (!indio_dev->info->hwfifo_flush)
>>> +             return -ENODEV;
>>> +
>>> +     return indio_dev->info->hwfifo_flush(indio_dev, required);
>>> +}
>>> +
>>>  static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>>> -                          size_t to_wait)
>>> +                          size_t to_wait, bool try_flush)
>>>  {
>>> +     size_t avail;
>>> +     int flushed = 0;
>>> +
>>>       /* wakeup if the device was unregistered */
>>>       if (!indio_dev->info)
>>>               return true;
>>>
>>>       /* drain the buffer if it was disabled */
>>> -     if (!iio_buffer_is_active(buf))
>>> +     if (!iio_buffer_is_active(buf)) {
>>>               to_wait = min_t(size_t, to_wait, 1);
>>> +             try_flush = false;
>>> +     }
>>> +
>>> +     avail = iio_buffer_data_available(buf);
>>>
>>> -     if (iio_buffer_data_available(buf) >= to_wait)
>>> +     if (avail >= to_wait) {
>> I'm not really following what this is for.
>> If to_wait = 0 and avail = 0 and we have requested a flush
>> then try to read 1 element?
>>
>> I think this only occurs on a non blocking read when nothing is
>> available?  What I don't understand is why we'd only try to read 1
>> sample.  Surely asking for as many as requested is more intuitive?
>>
> 
> Yes, good idea.
> 
>>> +             /* force a flush for non-blocking reads */
>>> +             if (!to_wait && !avail && try_flush)
>>> +                     iio_buffer_flush_hwfifo(indio_dev, buf, 1);
>>> +             return true;
>>> +     }
>>> +
>>> +     if (try_flush)
>>> +             flushed = iio_buffer_flush_hwfifo(indio_dev, buf,
>>> +                                               to_wait - avail);
>>> +     if (flushed <= 0)
>>> +             return false;
>>> +
>>> +     if (avail + flushed >= to_wait)
>>>               return true;
>>>
>>>       return false;
>>> @@ -92,7 +121,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>>
>>>       do {
>>>               ret = wait_event_interruptible(rb->pollq,
>>> -                                   iio_buffer_ready(indio_dev, rb, to_wait));
>>> +                            iio_buffer_ready(indio_dev, rb, to_wait, true));
>>>               if (ret)
>>>                       return ret;
>>>
>>> @@ -120,7 +149,7 @@ unsigned int iio_buffer_poll(struct file *filp,
>>>               return -ENODEV;
>>>
>>>       poll_wait(filp, &rb->pollq, wait);
>>> -     if (iio_buffer_ready(indio_dev, rb, rb->watermark))
>>> +     if (iio_buffer_ready(indio_dev, rb, rb->watermark, false))
>>>               return POLLIN | POLLRDNORM;
>>>       return 0;
>>>  }
>>> @@ -659,19 +688,16 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>>>               }
>>>       }
>>>       /* Definitely possible for devices to support both of these. */
>>> -     if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
>>> -             if (!indio_dev->trig) {
>>> -                     printk(KERN_INFO "Buffer not started: no trigger\n");
>>> -                     ret = -EINVAL;
>>> -                     /* Can only occur on first buffer */
>>> -                     goto error_run_postdisable;
>>> -             }
>>> +     if ((indio_dev->modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
>>>               indio_dev->currentmode = INDIO_BUFFER_TRIGGERED;
>>>       } else if (indio_dev->modes & INDIO_BUFFER_HARDWARE) {
>>>               indio_dev->currentmode = INDIO_BUFFER_HARDWARE;
>>>       } else if (indio_dev->modes & INDIO_BUFFER_SOFTWARE) {
>>>               indio_dev->currentmode = INDIO_BUFFER_SOFTWARE;
>>>       } else { /* Should never be reached */
>>> +             /* Can only occur on first buffer */
>>> +             if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
>>> +                     pr_info("Buffer not started: no trigger\n");
>>>               ret = -EINVAL;
>>>               goto error_run_postdisable;
>>>       }
>>> @@ -823,12 +849,28 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>>>       }
>>>
>>>       buffer->watermark = val;
>>> +
>>> +     if (indio_dev->info->hwfifo_set_watermark)
>>> +             indio_dev->info->hwfifo_set_watermark(indio_dev, val);
>>>  out:
>>>       mutex_unlock(&indio_dev->mlock);
>>>
>>>       return ret ? ret : len;
>>>  }
>>>
>>> +static ssize_t iio_buffer_show_hwfifo_watermark(struct device *dev,
>>> +                                             struct device_attribute *attr,
>>> +                                             char *buf)
>>> +{
>>> +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +     int ret = -1;
>>> +
>>> +     if (indio_dev->info->hwfifo_get_watermark)
>>> +             ret = indio_dev->info->hwfifo_get_watermark(indio_dev);
>> Any error code returned should be returned by this function to userspace.
>>
>> Also, ret = -1 would be EPERM, a possible error code.  Hence you need
>> to separate your handling of not supported from possible return values.
>>
>> if (indio_dev->info->hwfifo_get_watermark) {
>>         ret = indio_dev->info->hwfifo_get_watermark(indio_dev);
>>         if (ret < 0)
>>            return ret;
>>         return sprintf(buf, "%d\n", ret);
>> } else {
>>         return sprintf(buf, "-1\n");
>>
>> seems the simplest way to me.
> 
> If we make the entry visible only when we have the hw fifo supported
> then we can remove the else branch. What do you think?
exactly.
> 
>>> +
>>> +     return sprintf(buf, "%d\n", ret < -1 ? -1 : ret);
>>> +}
>>> +
>>>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>>>                  iio_buffer_write_length);
>>>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
>>> @@ -837,11 +879,14 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>>>                  iio_buffer_show_enable, iio_buffer_store_enable);
>>>  static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
>>>                  iio_buffer_show_watermark, iio_buffer_store_watermark);
>>> +static DEVICE_ATTR(hwfifo_watermark, S_IRUGO, iio_buffer_show_hwfifo_watermark,
>>> +                NULL);
>>>
>>>  static struct attribute *iio_buffer_attrs[] = {
>>>       &dev_attr_length.attr,
>>>       &dev_attr_enable.attr,
>>>       &dev_attr_watermark.attr,
>>> +     &dev_attr_hwfifo_watermark.attr,
>>>  };
>>>
>>>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 80d8550..1b1cd7d 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -338,6 +338,29 @@ struct iio_dev;
>>>   *                   provide a custom of_xlate function that reads the
>>>   *                   *args* and returns the appropriate index in registered
>>>   *                   IIO channels array.
>>> + * @hwfifo_set_watermark: function pointer to set the current hardware fifo
>>> + *                   watermark level. It receives the desired watermark as a
>>> + *                   hint and the device driver may adjust it to take into
>>> + *                   account hardware limitations. Setting the watermark to a
>>> + *                   strictly positive value should enable the hardware fifo
>>> + *                   if not already enabled. When the hardware fifo is
>>> + *                   enabled and its level reaches the watermark level the
>>> + *                   device must flush the samples stored in the hardware
>>> + *                   fifo to the device buffer.
>> Hmm. This one is interesting.  I wonder if we have devices with minimum
>> watermark levels.  I know that devices with fixed levels exist (sca3000 IIRC)
>> but in that case if we are below the level we can fallback to the data ready
>> signal (watermark of 1 effectively).  If the device provides no notification
>> that data capture is occuring until we reach a particular level (say 50% full)
>> then its not entirely clear whether we should turn the buffer on when a
>> watermark below that is set.
> 
> Interesting, in that case I think we should expose
> hwfifo_min_watermark to let userspace know how it needs to set the
> watermark level to enable the hardware fifo. Then we can update the
> ABI to say that the driver will enable the fifo if the watermark level
> is greater than hwfifo_min_watermark.
That would work nicely.
> 
> Related to this, I think we should also add hwfifo_max_watermark to
> make it easier to userspace to pick a good value.
Again, as information only attributes, they will help and add no
real ABI burden
> 
> One more thing: right now I am overloading the hwfifo_get_watermark
> (and hwfifio_watermark sysfs entry with information about whether the
> fifo is active. Hence if hwfifo is not active we return 0, otherwise
> we return the current hwfifo level. Given that some hardware may have
> additional hwfifo limitations (say perhaps not all values in the min
> .. max range are supported), perhaps is better to add a separate
> function and sysfs entry for checking if the hwfifo is active or not.
> This way userspace can set watermark then read hwfifo_watermark to see
> what is the actual watermark value without needing to start the buffer
> for checking that value. What do you think?
Either that or for non standard cases, just add an _available attribute
listing what it can be set to. 

I'd like to get much tighter listing of what is possible on all the attributes
we expose.  Working very slowly towards that ;)
> 
>>> Setting the watermark to 0
>>> + *                   should disable the hardware fifo. The device driver must
>>> + *                   disable the hardware fifo when a trigger with different
>>> + *                   sampling semantic (then the hardware fifo) is set
>> (than the...
>>> + *                   (e.g. when setting an any-motion trigger to a device
>>> + *                   that has its hardware fifo sample based on the set
>>> + *                   sample frequency).
>>> + * @hwfifo_get_watermark: function pointer to obtain the current hardware fifo
>>> + *                   watermark level
>>> + * @hwfifo_flush:    function pointer to flush the samples stored in the
>>> + *                   hardware fifo to the device buffer. The driver should
>>> + *                   not flush more then count samples. The function must
>> more than count
> 
> Oops :)
> 
>>> + *                   return the number of samples flushed, 0 if no samples
>>> + *                   were flushed or a negative integer if no samples were
>>> + *                   flushed and there was an error.
>>>   **/
>>>  struct iio_info {
>>>       struct module                   *driver_module;
>>> @@ -399,6 +422,9 @@ struct iio_info {
>>>                                 unsigned *readval);
>>>       int (*of_xlate)(struct iio_dev *indio_dev,
>>>                       const struct of_phandle_args *iiospec);
>>> +     int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
>>> +     int (*hwfifo_get_watermark)(struct iio_dev *indio_dev);
>>> +     int (*hwfifo_flush)(struct iio_dev *indio_dev, unsigned count);
>>>  };
>>>
>>>  /**
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

