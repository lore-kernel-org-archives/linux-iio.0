Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:53251 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaFFRPt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jun 2014 13:15:49 -0400
Received: by mail-oa0-f51.google.com with SMTP id n16so3162501oag.10
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2014 10:15:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5391E0D7.8050309@metafoo.de>
References: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr>
 <5391D279.5060909@metafoo.de> <CAJA4uhc+RdEmOgyK8f3VHTqgCdAbVtdko1EW8z3BDvFq8Y4Rzw@mail.gmail.com>
 <5391E0D7.8050309@metafoo.de>
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Date: Fri, 6 Jun 2014 19:15:28 +0200
Message-ID: <CAJA4uhfOGPZ_sZ1BC_OOPOOmy9YsGF8XpKjW9bE-8BSTkEdzoA@mail.gmail.com>
Subject: Re: [PATCH] iio: make blocking read wait for data
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2014-06-06 17:40 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:

> On 06/06/2014 05:12 PM, Josselin Costanzi wrote:
>>
>> 2014-06-06 16:38 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>>>
>>> On 06/06/2014 04:30 PM, Josselin Costanzi wrote:
>>>>
>>>> Currently the IIO buffer blocking read only wait until at least one
>>>> data element is available.
>>>
>>> But that is how it is supposed to work. With this patch for example you
>>> won't be able to read the last data from the buffer after the buffer has
>>> been disabled.
>>
>> I don't understand the usecase this patch breaks... If the buffer is
>> disabled then we return what was read alreay.
>
> If there is less data in the buffer than the amount of requested data you'll
> keep looping forever.

We are working with an accelerometer and the only trigger is periodic so we
didn't think of that since we are sure we end up with enough data.
Is there a way to know when if the trigger is done generating events and no
more data is expected?

Even with the patch as is, we can use a signal to interrupt the read so it's
possible for the userspace to set a timeout (this works with our userspace,
on a SIGINT we correctly get the data acquired so far).


>>> Or if for example n is not aligned to the sample size you'll also
>>> continue to loop forever.
>>
>> If n isn't aligned to the sample size, wouldn't iio_read_first_n_kfifo
>> still return data multiple of samples size? In that case we would copy
>> complete elements until we try to do a short read which would fail at
>> n < kfifo_esize(&kf->kf) (in iio_read_first_n_kfifo).
>
> The read_first_n() callback will make sure that it only returns full
> samples, which means if n is smaller than the sample size it will return 0.

In fact it won't return 0 but -EINVAL then read returns the size of
the data already
copied (this also works with our userspace program)


> Maybe start with which problem you are trying to address with this patch and
> then we can work forward from there to a solution. The current form of the
> patch changes the semantics of read() in a way they shouldn't be changed, so
> this is not only about the implementation bugs.

Our use case is we continuously get data from an accelerometer. The sample
frequency is relatively low (< 1KHz) so the userland ends up making one syscall
per sample when we would prefer to process the data by batches to reduce the cpu
load.
We would like to have the blocking read() semantics where we wait for the data
until the buffer is full unless there is an exceptional condition as
it's usually done for
ttys and sockets.

I think the patch doesn't break anything except for the case where the
trigger generates
a finite and unknown number of data samples and the userspace requests
more than this
amount of samples.
But in this scenario, without the patch, a blocking read does the same
as a poll followed
by a non blocking read which is the standard way to get a variable
amount of data.

-- 
Josselin Costanzi
  Embedded Linux System Engineer
