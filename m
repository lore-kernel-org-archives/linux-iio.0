Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47933 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcAFS7E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2016 13:59:04 -0500
Subject: Re: read /dev/iio:device0 return -1 (Invalid argument)
To: Julio Cruz <jcsistemas2001@gmail.com>
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
 <568A58C3.6060804@kernel.org> <568A69B8.9080406@metafoo.de>
 <568AB86A.6070801@kernel.org>
 <CAAn_ec8vhXx10P2q=uAPJgKF5Xymm688Mih3cTnTkMJgioW-_w@mail.gmail.com>
 <568D5C9A.6010901@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Paul Cercueil <pcercuei@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568D63F4.9000707@kernel.org>
Date: Wed, 6 Jan 2016 18:59:00 +0000
MIME-Version: 1.0
In-Reply-To: <568D5C9A.6010901@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/16 18:27, Jonathan Cameron wrote:
> On 05/01/16 11:57, Julio Cruz wrote:
>> Dear All,
>>
>> Thanks to your comments, I found out that the function in my kernel
>> iio_buffer_read_first_n_outer is different to the one that you
>> mentioned.
>>
>> I was debugging a kernel version 3.10, that's include another
>> implementation of the function that we are talking. After some extra
>> effort, I could update to version 3.14 and effectively, the behavior
>> is as expected.
> Cool and thanks for letting us know - back then it seems we didn't support
> blocking reads which explains the problem.  Btw, you have my sympathies
> with older kernels, I'm trying to bring up a board for the first time since
> I ran 3.7 on it and it's proving 'interesting'... Unfortunately it's
> the only source of lis3l02dq that I have and I'd like to merge the old
> staging driver into the more recent generic st_sensors driver.  Fun fun fun!
Wow. After I found an appropriate config file it came straight up.  Not bad
on a board that I doubt anyone has booted with a kernel dating from the last
4 years ;)  Vendor kernel (such as it was) was 2.6.14 dating back 11 years now.

Anyhow, couldn't resist spreading my relief that I didn't have to do a 4 year
bisection.. given it takes about 10 minutes to flash each time it would have
been a very boring Saturday.
>>
>> Very sorry for this misunderstanding.
> That's fine. None of us managed to remember that this was the case
> for older kernels!
>>
>> BTW, in case of future problems, would be fine
>>
>> Thanks
>>
>> Julio
>>
>>
>> kernel 3.10:
>> ---------------
>> ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>      size_t n, loff_t *f_ps)
>> {
>>     struct iio_dev *indio_dev = filp->private_data;
>>     struct iio_buffer *rb = indio_dev->buffer;
>>
>> i   if (!rb || !rb->access->read_first_n)
>>         return -EINVAL;
>>     return rb->access->read_first_n(rb, n, buf);
>> }
>>
>> kernel 3.14:
>> ---------------
>> ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>      size_t n, loff_t *f_ps)
>> {
>> struct iio_dev *indio_dev = filp->private_data;
>> struct iio_buffer *rb = indio_dev->buffer;
>> int ret;
>>
>> if (!indio_dev->info)
>>      return -ENODEV;
>>
>> if (!rb || !rb->access->read_first_n)
>>      return -EINVAL;
>>
>> do {
>>      if (!iio_buffer_data_available(rb)) {
>>           if (filp->f_flags & O_NONBLOCK)
>>                return -EAGAIN;
>>
>>                ret = wait_event_interruptible(rb->pollq,
>>                iio_buffer_data_available(rb) ||
>>               indio_dev->info == NULL);
>>                if (ret)
>>                     return ret;
>>               if (indio_dev->info == NULL)
>>                     return -ENODEV;
>>      }
>>
>>      ret = rb->access->read_first_n(rb, n, buf);
>>      if (ret == 0 && (filp->f_flags & O_NONBLOCK))
>>          ret = -EAGAIN;
>>      } while (ret == 0);
>>
>>      return ret;
>> }
>>
>> On Tue, Jan 5, 2016 at 2:22 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 04/01/16 12:46, Lars-Peter Clausen wrote:
>>>> On 01/04/2016 12:34 PM, Jonathan Cameron wrote:
>>>>> On 04/01/16 04:59, Julio Cruz wrote:
>>>>>> Hi Jonathan,
>>>>>>
>>>>>> Previously, you help me about an issue related with data loss. You suggest
>>>>>> me to debug deep in the core elements. I will try to summarize the results
>>>>>> below for future reference.
>>>>>>
>>>>>> When there is not data available in the buffer (kfifo), and the application
>>>>>> try to read data (using "read" function), it return zero (0).
>>>>>>
>>>>>> If libiio will be used to read the data, there is a problem (detailed at
>>>>>> https://github.com/analogdevicesinc/libiio/issues/23). In brief, Paul
>>>>>> (pcercuei) suggest me that this issue must be manage by the driver, in this
>>>>>> case, return -EAGAIN when there is not data available [Resource temporarily
>>>>>> unavailable (POSIX.1)].
>>>>>>
>>>>>> After review the core elements as suggested, I changed the line (in
>>>>>> function iio_read_first_n_kfifo of kfifo_buf.c) as below:
>>>>>>
>>>>>> - return copied;
>>>>>> + return copied == 0 ? -EAGAIN: copied;
>>>>>>
>>>>>> Do you think will be OK like this?
>>>>> Hmm.. This is an interesting one (thanks for tracking it down)
>>>>>
>>>>> The man page for read indeed allows for this to occur.
>>>>>
>>>>>        When attempting to read a file (other than a pipe or  FIFO)  that  sup‐
>>>>>        ports non-blocking reads and has no data currently available:
>>>>>
>>>>>         *  If  O_NONBLOCK  is  set,  read()  shall  return −1 and set errno to
>>>>>            [EAGAIN].
>>>>>
>>>>>
>>>>> However the issue here is that this is an ABI change and there may
>>>>> unfortunately be code out there relying on it returning 0.
>>>>
>>>> We never propagate 0 to userspace though. The referenced function is
>>>> iio_read_first_n_kfifo() which is an internal function. The function that
>>>> handles the userspace ABI is iio_buffer_read_first_n_outer() and here, as
>>>> Daniel pointed out, there are two things that can happen.
>>>>
>>>> We are in non-blocking mode and iio_read_first_n_kfifo() returns 0. In that
>>>> case we'll return -EAGAIN as mandated by the specification.
>>>>
>>>> We are in blocking mode and iio_read_first_n_kfifo() returns 0. In that case
>>>> we'll go back to waiting for more data and we'll only return if either data
>>>> was received or the application was interrupted by a signal. In the former
>>>> case we'll return the number of received bytes in the later case -ERESTARTSYS.
>>>>
>>>> So either way we should never return 0, something else must be going on.
>>>>
>>>>
>>>> Btw. letting iio_read_first_n_kfifo() return -EAGAIN will break blocking mode.
>>> That's what I get for thinking I remembered how this code works ;)
>>> Completely forgot the outer function did anything non trivial.
>>>
>>> Thanks Daniel / Lars for picking up on this!
>>>
>>> Oops.
>>>
>>> Jonathan
>>>>
>>>> - Lars
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

