Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:35555 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509AbbCDQBT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2015 11:01:19 -0500
Received: by wevl61 with SMTP id l61so47334229wev.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2015 08:01:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54F7197A.1030909@metafoo.de>
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>
	<1425399662-5539-2-git-send-email-octavian.purdila@intel.com>
	<54F5F380.7030509@metafoo.de>
	<CAE1zot+z7q5Oziv5rjxbWw0FO32eQciGOHQXLp5UG9zbeiNdBg@mail.gmail.com>
	<54F7197A.1030909@metafoo.de>
Date: Wed, 4 Mar 2015 18:01:16 +0200
Message-ID: <CAE1zotJEF43ByFRcq7J3f0MR6Ekwb+E76oV6cVWMK1y35rjCbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: add watermark logic to iio read and poll
From: Octavian Purdila <octavian.purdila@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 4, 2015 at 4:40 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/04/2015 02:55 PM, Octavian Purdila wrote:
> [...]
>>>>
>>>>    int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>>>> @@ -944,8 +1022,18 @@ static const void *iio_demux(struct iio_buffer
>>>> *buffer,
>>>>    static int iio_push_to_buffer(struct iio_buffer *buffer, const void
>>>> *data)
>>>>    {
>>>>          const void *dataout = iio_demux(buffer, data);
>>>> +       int ret;
>>>> +
>>>> +       ret = buffer->access->store_to(buffer, dataout);
>>>> +       if (ret)
>>>> +               return ret;
>>>>
>>>> -       return buffer->access->store_to(buffer, dataout);
>>>> +       /*
>>>> +        * We can't just test for watermark to decide if we wake the
>>>> poll
>>>> queue
>>>> +        * because read may request less samples than the watermark.
>>>> +        */
>>>> +       wake_up_interruptible(&buffer->pollq);
>>>
>>>
>>>
>>> What happened to poll parameters?
>>>
>>
>> I don't understand you question, can you please elaborate?
>
>
> Previously we were calling wake_up_interruptible_poll(&r->pollq, POLLIN |
> POLLRDNORM);
>

Ah, ok, I see. I will change it use wake_up_interruptible_poll.

Although it should not make any difference for IIO right now, as we
only support POLLIN/POLLRDNORM, right?

Also, I think we need to keep using a simple wake_up_interruptible in
iio_buffer_deactivate() since we probably want to wake-up userspace
for all events in that case.
