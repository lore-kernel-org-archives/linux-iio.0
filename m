Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:38747 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbbCDNzT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2015 08:55:19 -0500
Received: by wesw55 with SMTP id w55so46448111wes.5
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2015 05:55:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54F5F380.7030509@metafoo.de>
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
	<1425399662-5539-2-git-send-email-octavian.purdila@intel.com>
	<54F5F380.7030509@metafoo.de>
Date: Wed, 4 Mar 2015 15:55:17 +0200
Message-ID: <CAE1zot+z7q5Oziv5rjxbWw0FO32eQciGOHQXLp5UG9zbeiNdBg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: add watermark logic to iio read and poll
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 3, 2015 at 7:46 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/03/2015 05:21 PM, Octavian Purdila wrote:
> [...]

Hi Lars,

Thank you for the review!

>>
>> @@ -61,26 +64,48 @@ ssize_t iio_buffer_read_first_n_outer(struct file
>> *filp, char __user *buf,
>>         if (!rb || !rb->access->read_first_n)
>>                 return -EINVAL;
>>
>> -       do {
>> -               if (!iio_buffer_data_available(rb)) {
>> -                       if (filp->f_flags & O_NONBLOCK)
>> -                               return -EAGAIN;
>> +       /*
>> +        * If datum_size is 0 there will never be anything to read from
>> the
>> +        * buffer, so signal end of file now.
>> +        */
>> +       if (!datum_size)
>> +               return 0;
>>
>> +       to_read = min_t(size_t, n / datum_size, rb->watermark);
>
>
> I'd maybe call it wakeup_threshold.
>
>> +
>> +       do {
>> +               if (filp->f_flags & O_NONBLOCK) {
>> +                       if (!iio_buffer_data_available(rb)) {
>> +                               ret = -EAGAIN;
>> +                               break;
>> +                       }
>> +               } else {
>>                         ret = wait_event_interruptible(rb->pollq,
>> -                                       iio_buffer_data_available(rb) ||
>> -                                       indio_dev->info == NULL);
>> +                              iio_buffer_data_available(rb) >= to_read ||
>> +                                                      indio_dev->info ==
>> NULL);
>
>
> This needs also to evaluate to true if the buffer is disabled so we have a
> chance to read any amount residue sample that are less than watermark.
>

Good point.

>>                         if (ret)
>>                                 return ret;
>> -                       if (indio_dev->info == NULL)
>> -                               return -ENODEV;
>> +                       if (indio_dev->info == NULL) {
>> +                               ret = -ENODEV;
>> +                               break;
>> +                       }
>>                 }
>>
>> -               ret = rb->access->read_first_n(rb, n, buf);
>> -               if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>> -                       ret = -EAGAIN;
>> -        } while (ret == 0);
>> +               ret = rb->access->read_first_n(rb, n, buf + count);
>> +               if (ret < 0)
>> +                       break;
>>
>> -       return ret;
>> +               count += ret;
>> +               n -= ret;
>> +               to_read -= ret / datum_size;
>
>
>
> This will underflow if there are more than watermark sample in the buffer
> and and more than watermark samples have been requested by userspace...
>
>
>> +        } while (to_read > 0);
>
>
> ... and then we get trapped in a very long loop.
>
> In my opinion there is no need to change the loop at all, only update the
> wakeup condition.
>

Correct, how did I miss that :/ I will rewrite the code to keep the
loop unchanged.

>> +
>> +       if (count)
>> +               return count;
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return -EAGAIN;
>>   }
>>
>>   /**
>> @@ -96,9 +121,8 @@ unsigned int iio_buffer_poll(struct file *filp,
>>                 return -ENODEV;
>>
>>         poll_wait(filp, &rb->pollq, wait);
>> -       if (iio_buffer_data_available(rb))
>> +       if (iio_buffer_data_available(rb) >= rb->watermark)
>
>
> Same here needs to wakeup if the buffer is disabled and there is at least
> one sample.
>

Ok.

>>                 return POLLIN | POLLRDNORM;
>> -       /* need a way of knowing if there may be enough data... */
>>         return 0;
>>   }
>>
> [...]
>>
>> @@ -418,7 +443,16 @@ static ssize_t iio_buffer_write_length(struct device
>> *dev,
>>         }
>>         mutex_unlock(&indio_dev->mlock);
>>
>> -       return ret ? ret : len;
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (buffer->length)
>> +               val = buffer->length;
>> +
>> +       if (val < buffer->watermark)
>> +               buffer->watermark = val;
>
>
> Needs to be inside the locked section.
>

Ok.

>> +
>> +       return len;
>>   }
>
> [...]
>>
>> +static ssize_t iio_buffer_store_watermark(struct device *dev,
>> +                                         struct device_attribute *attr,
>> +                                         const char *buf,
>> +                                         size_t len)
>> +{
>> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +       struct iio_buffer *buffer = indio_dev->buffer;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = kstrtouint(buf, 10, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val > buffer->length)
>
>
> Same here.

Ok.

>
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&indio_dev->mlock);
>> +       if (iio_buffer_is_active(indio_dev->buffer)) {
>> +               ret = -EBUSY;
>> +               goto out;
>> +       }
>> +
>> +       buffer->watermark = val;
>
>
> We should probably reject 0.
>

I agree.

>> +       ret = 0;
>> +out:
>> +       mutex_unlock(&indio_dev->mlock);
>> +       return ret ? ret : len;
>> +}
>> +
>
> [...]
>>
>>   int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>> @@ -944,8 +1022,18 @@ static const void *iio_demux(struct iio_buffer
>> *buffer,
>>   static int iio_push_to_buffer(struct iio_buffer *buffer, const void
>> *data)
>>   {
>>         const void *dataout = iio_demux(buffer, data);
>> +       int ret;
>> +
>> +       ret = buffer->access->store_to(buffer, dataout);
>> +       if (ret)
>> +               return ret;
>>
>> -       return buffer->access->store_to(buffer, dataout);
>> +       /*
>> +        * We can't just test for watermark to decide if we wake the poll
>> queue
>> +        * because read may request less samples than the watermark.
>> +        */
>> +       wake_up_interruptible(&buffer->pollq);
>
>
> What happened to poll parameters?
>

I don't understand you question, can you please elaborate?
