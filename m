Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37565 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbcADM3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 07:29:08 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so210970764wmf.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Jan 2016 04:29:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <568A58C3.6060804@kernel.org>
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
Date: Mon, 4 Jan 2016 14:29:07 +0200
Message-ID: <CAEnQRZDYSZpU8Si2VE-aYkLnka1VAB=h-4HhGcng1UPDYeAziw@mail.gmail.com>
Subject: Re: read /dev/iio:device0 return -1 (Invalid argument)
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julio Cruz <jcsistemas2001@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 4, 2016 at 1:34 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 04/01/16 04:59, Julio Cruz wrote:
>> Hi Jonathan,
>>
>> Previously, you help me about an issue related with data loss. You suggest
>> me to debug deep in the core elements. I will try to summarize the results
>> below for future reference.
>>
>> When there is not data available in the buffer (kfifo), and the application
>> try to read data (using "read" function), it return zero (0).
>>
>> If libiio will be used to read the data, there is a problem (detailed at
>> https://github.com/analogdevicesinc/libiio/issues/23). In brief, Paul
>> (pcercuei) suggest me that this issue must be manage by the driver, in this
>> case, return -EAGAIN when there is not data available [Resource temporarily
>> unavailable (POSIX.1)].
>>
>> After review the core elements as suggested, I changed the line (in
>> function iio_read_first_n_kfifo of kfifo_buf.c) as below:
>>
>> - return copied;
>> + return copied == 0 ? -EAGAIN: copied;
>>
>> Do you think will be OK like this?

I assume you are doing a blocking read. Because otherwise your situation
should already be  handled in industrialio-buffer.c: 143,

In iio_buffer_read_first_n_outer function we have:

»       »       ret = rb->access->read_first_n(rb, n, buf);
»       »       if (ret == 0 && (filp->f_flags & O_NONBLOCK))
»       »       »       ret = -EAGAIN;
»        } while (ret == 0);

Now, if you are doing a blocking read and your read() returns 0 then
there is a bug in IIO core and it must be fixed! :)

We should again investigate iio_buffer_read_first_n function where,
with a special attention to this condition:

Can you paste here the parameters/ret values for relevant
open and read system calls done by your application?

»       »       ret = wait_event_interruptible(rb->pollq,
»       »             iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size));
»       »       if (ret)
»       »       »       return ret;

This part should block until there is some data available.

> Hmm.. This is an interesting one (thanks for tracking it down)
>
> The man page for read indeed allows for this to occur.
>
>        When attempting to read a file (other than a pipe or  FIFO)  that  sup‐
>        ports non-blocking reads and has no data currently available:
>
>         *  If  O_NONBLOCK  is  set,  read()  shall  return −1 and set errno to
>            [EAGAIN].
>
>
> However the issue here is that this is an ABI change and there may
> unfortunately be code out there relying on it returning 0.
>
> Most of the time a read will only be made in response to poll informing the
> userspace code that there is something available.  Whilst obviously we
> should try and fix the case of it reading when there isn't, I am a little
> curious to how you hit this case.
>
> So what do others think?  Much chance of us breaking any userspace
> code by making this change?
