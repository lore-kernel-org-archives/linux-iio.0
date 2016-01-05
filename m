Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34191 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbcAEL5H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2016 06:57:07 -0500
Received: by mail-wm0-f54.google.com with SMTP id u188so20222412wmu.1
        for <linux-iio@vger.kernel.org>; Tue, 05 Jan 2016 03:57:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <568AB86A.6070801@kernel.org>
References: <CAAn_ec90t=N1e1m8aUcBZRb5wsRwiz56WUzFCWqTrVHHhcAuBA@mail.gmail.com>
	<566C0A32.3030104@kernel.org>
	<CAAn_ec_=9syP4j+g5GRMCB-+7vCWE1XqryE6KWUm=auUBZE=uQ@mail.gmail.com>
	<566C1493.7090002@jic23.retrosnub.co.uk>
	<CAAn_ec_5UcQ5GVFx=byU6sKJ9u33LmUzFvoRvVgTko4GfDHnOA@mail.gmail.com>
	<CAAn_ec8BMT9fPc06YOc14Eh+8vpQGJW_Lv-BOqDCqS5UbZF3iQ@mail.gmail.com>
	<7665C9F2-AA7C-404F-AC43-2D045E330030@jic23.retrosnub.co.uk>
	<CAAn_ec97uYM5vPogeRFFsfh8vUTb9H8SVrJYiWbBZmy9b9xBhQ@mail.gmail.com>
	<0BBA92A2-6E6C-4CCA-A290-920CFB50FCAE@jic23.retrosnub.co.uk>
	<CAAn_ec-UJn9DFt=HodPAVvmm4s_4zwq=DF8un8U2ngLB+XXNDw@mail.gmail.com>
	<568A58C3.6060804@kernel.org>
	<568A69B8.9080406@metafoo.de>
	<568AB86A.6070801@kernel.org>
Date: Tue, 5 Jan 2016 19:57:05 +0800
Message-ID: <CAAn_ec8vhXx10P2q=uAPJgKF5Xymm688Mih3cTnTkMJgioW-_w@mail.gmail.com>
Subject: Re: read /dev/iio:device0 return -1 (Invalid argument)
From: Julio Cruz <jcsistemas2001@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Paul Cercueil <pcercuei@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

Thanks to your comments, I found out that the function in my kernel
iio_buffer_read_first_n_outer is different to the one that you
mentioned.

I was debugging a kernel version 3.10, that's include another
implementation of the function that we are talking. After some extra
effort, I could update to version 3.14 and effectively, the behavior
is as expected.

Very sorry for this misunderstanding.

BTW, in case of future problems, would be fine

Thanks

Julio


kernel 3.10:
---------------
ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
     size_t n, loff_t *f_ps)
{
    struct iio_dev *indio_dev = filp->private_data;
    struct iio_buffer *rb = indio_dev->buffer;

i   if (!rb || !rb->access->read_first_n)
        return -EINVAL;
    return rb->access->read_first_n(rb, n, buf);
}

kernel 3.14:
---------------
ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
     size_t n, loff_t *f_ps)
{
struct iio_dev *indio_dev = filp->private_data;
struct iio_buffer *rb = indio_dev->buffer;
int ret;

if (!indio_dev->info)
     return -ENODEV;

if (!rb || !rb->access->read_first_n)
     return -EINVAL;

do {
     if (!iio_buffer_data_available(rb)) {
          if (filp->f_flags & O_NONBLOCK)
               return -EAGAIN;

               ret = wait_event_interruptible(rb->pollq,
               iio_buffer_data_available(rb) ||
              indio_dev->info == NULL);
               if (ret)
                    return ret;
              if (indio_dev->info == NULL)
                    return -ENODEV;
     }

     ret = rb->access->read_first_n(rb, n, buf);
     if (ret == 0 && (filp->f_flags & O_NONBLOCK))
         ret = -EAGAIN;
     } while (ret == 0);

     return ret;
}

On Tue, Jan 5, 2016 at 2:22 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 04/01/16 12:46, Lars-Peter Clausen wrote:
>> On 01/04/2016 12:34 PM, Jonathan Cameron wrote:
>>> On 04/01/16 04:59, Julio Cruz wrote:
>>>> Hi Jonathan,
>>>>
>>>> Previously, you help me about an issue related with data loss. You suggest
>>>> me to debug deep in the core elements. I will try to summarize the results
>>>> below for future reference.
>>>>
>>>> When there is not data available in the buffer (kfifo), and the application
>>>> try to read data (using "read" function), it return zero (0).
>>>>
>>>> If libiio will be used to read the data, there is a problem (detailed at
>>>> https://github.com/analogdevicesinc/libiio/issues/23). In brief, Paul
>>>> (pcercuei) suggest me that this issue must be manage by the driver, in this
>>>> case, return -EAGAIN when there is not data available [Resource temporarily
>>>> unavailable (POSIX.1)].
>>>>
>>>> After review the core elements as suggested, I changed the line (in
>>>> function iio_read_first_n_kfifo of kfifo_buf.c) as below:
>>>>
>>>> - return copied;
>>>> + return copied == 0 ? -EAGAIN: copied;
>>>>
>>>> Do you think will be OK like this?
>>> Hmm.. This is an interesting one (thanks for tracking it down)
>>>
>>> The man page for read indeed allows for this to occur.
>>>
>>>        When attempting to read a file (other than a pipe or  FIFO)  that  sup‐
>>>        ports non-blocking reads and has no data currently available:
>>>
>>>         *  If  O_NONBLOCK  is  set,  read()  shall  return −1 and set errno to
>>>            [EAGAIN].
>>>
>>>
>>> However the issue here is that this is an ABI change and there may
>>> unfortunately be code out there relying on it returning 0.
>>
>> We never propagate 0 to userspace though. The referenced function is
>> iio_read_first_n_kfifo() which is an internal function. The function that
>> handles the userspace ABI is iio_buffer_read_first_n_outer() and here, as
>> Daniel pointed out, there are two things that can happen.
>>
>> We are in non-blocking mode and iio_read_first_n_kfifo() returns 0. In that
>> case we'll return -EAGAIN as mandated by the specification.
>>
>> We are in blocking mode and iio_read_first_n_kfifo() returns 0. In that case
>> we'll go back to waiting for more data and we'll only return if either data
>> was received or the application was interrupted by a signal. In the former
>> case we'll return the number of received bytes in the later case -ERESTARTSYS.
>>
>> So either way we should never return 0, something else must be going on.
>>
>>
>> Btw. letting iio_read_first_n_kfifo() return -EAGAIN will break blocking mode.
> That's what I get for thinking I remembered how this code works ;)
> Completely forgot the outer function did anything non trivial.
>
> Thanks Daniel / Lars for picking up on this!
>
> Oops.
>
> Jonathan
>>
>> - Lars
>>
>
