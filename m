Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33243 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCSPnL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2015 11:43:11 -0400
Received: by wgbcc7 with SMTP id cc7so65928467wgb.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2015 08:43:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE1zot+ZJao0zDWNqpjH57oegiVq5E1kGM7dyAepUCd-REUSLQ@mail.gmail.com>
References: <1425491773-28499-1-git-send-email-octavian.purdila@intel.com>
	<1425491773-28499-2-git-send-email-octavian.purdila@intel.com>
	<55094327.9040903@metafoo.de>
	<CAE1zot+ZJao0zDWNqpjH57oegiVq5E1kGM7dyAepUCd-REUSLQ@mail.gmail.com>
Date: Thu, 19 Mar 2015 17:43:09 +0200
Message-ID: <CAE1zotLUw1EctGWrQ-+pudF_qmeKrUzzjjrzxvfpv5ayNjBAJw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: add watermark logic to iio read and poll
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 18, 2015 at 11:29 AM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Wed, Mar 18, 2015 at 11:19 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Looks good mostly, two things.
>>
>
> Thanks for the review Lars !
>
>> On 03/04/2015 06:56 PM, Octavian Purdila wrote:
>> [...]
>>>
>>> @@ -61,19 +80,24 @@ ssize_t iio_buffer_read_first_n_outer(struct file
>>> *filp, char __user *buf,
>>>         if (!rb || !rb->access->read_first_n)
>>>                 return -EINVAL;
>>>
>>> +       /*
>>> +        * If datum_size is 0 there will never be anything to read from
>>> the
>>> +        * buffer, so signal end of file now.
>>> +        */
>>> +       if (!datum_size)
>>> +               return 0;
>>> +
>>> +       if (!(filp->f_flags & O_NONBLOCK))
>>> +               to_wait = min_t(size_t, n / datum_size, rb->watermark);
>>> +
>>>         do {
>>> -               if (!iio_buffer_data_available(rb)) {
>>> -                       if (filp->f_flags & O_NONBLOCK)
>>> -                               return -EAGAIN;
>>
>>
>> If I understand this correctly we no longer return -EAGAIN if no data is
>> available in non blocking mode, but rather return 0. Which means
>> end-of-file, so it is not correct.
>>
>
> You are right, I'll add have to add back the if
> (!iio_buffer_data_available(rb) && (filp->f_flags & O_NONBLOCK))
> statement.
>
>>> +               ret = wait_event_interruptible(rb->pollq,
>>> +                                     iio_buffer_ready(indio_dev, rb,
>>> to_wait));
>>> +               if (ret)
>>> +                       return ret;
>>>
>>> -                       ret = wait_event_interruptible(rb->pollq,
>>> -                                       iio_buffer_data_available(rb) ||
>>> -                                       indio_dev->info == NULL);
>>> -                       if (ret)
>>> -                               return ret;
>>> -                       if (indio_dev->info == NULL)
>>> -                               return -ENODEV;
>>> -               }
>>> +               if (!indio_dev->info)
>>> +                       return -ENODEV;
>>>   [...]
>>> +
>>> +static ssize_t iio_buffer_store_watermark(struct device *dev,
>>> +                                         struct device_attribute *attr,
>>> +                                         const char *buf,
>>> +                                         size_t len)
>>> +{
>>> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +       struct iio_buffer *buffer = indio_dev->buffer;
>>> +       unsigned int val;
>>> +       int ret;
>>> +
>>> +       ret = kstrtouint(buf, 10, &val);
>>> +       if (ret)
>>> +               return ret;
>>> +       if (!val)
>>> +               return -EINVAL;
>>> +
>>> +       mutex_lock(&indio_dev->mlock);
>>> +
>>> +       if (val > buffer->length) {
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>
>>
>> This is missing the check for val == 0.
>>
>
> Unless I misunderstand you, the check is done right after kstrtouint()
> before taking the lock.
>
>>
>>> +
>>> +       if (iio_buffer_is_active(indio_dev->buffer)) {
>>> +               ret = -EBUSY;
>>> +               goto out;
>>> +       }
>>> +
>>> +       buffer->watermark = val;
>>> +out:
>>> +       mutex_unlock(&indio_dev->mlock);
>>> +
>>> +       return ret ? ret : len;
>>> +}
>>
>>
