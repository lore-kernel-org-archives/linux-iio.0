Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-236.synserver.de ([212.40.185.236]:1145 "EHLO
	smtp-out-234.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755514AbbCDOlG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2015 09:41:06 -0500
Message-ID: <54F7197A.1030909@metafoo.de>
Date: Wed, 04 Mar 2015 15:40:58 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: Re: [PATCH v4 1/3] iio: add watermark logic to iio read and poll
References: <1425399662-5539-1-git-send-email-octavian.purdila@intel.com>	<1425399662-5539-2-git-send-email-octavian.purdila@intel.com>	<54F5F380.7030509@metafoo.de> <CAE1zot+z7q5Oziv5rjxbWw0FO32eQciGOHQXLp5UG9zbeiNdBg@mail.gmail.com>
In-Reply-To: <CAE1zot+z7q5Oziv5rjxbWw0FO32eQciGOHQXLp5UG9zbeiNdBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2015 02:55 PM, Octavian Purdila wrote:
[...]
>>>    int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>>> @@ -944,8 +1022,18 @@ static const void *iio_demux(struct iio_buffer
>>> *buffer,
>>>    static int iio_push_to_buffer(struct iio_buffer *buffer, const void
>>> *data)
>>>    {
>>>          const void *dataout = iio_demux(buffer, data);
>>> +       int ret;
>>> +
>>> +       ret = buffer->access->store_to(buffer, dataout);
>>> +       if (ret)
>>> +               return ret;
>>>
>>> -       return buffer->access->store_to(buffer, dataout);
>>> +       /*
>>> +        * We can't just test for watermark to decide if we wake the poll
>>> queue
>>> +        * because read may request less samples than the watermark.
>>> +        */
>>> +       wake_up_interruptible(&buffer->pollq);
>>
>>
>> What happened to poll parameters?
>>
>
> I don't understand you question, can you please elaborate?

Previously we were calling wake_up_interruptible_poll(&r->pollq, POLLIN | 
POLLRDNORM);

