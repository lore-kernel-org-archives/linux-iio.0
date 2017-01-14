Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33695 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdANRZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 12:25:56 -0500
Received: by mail-yb0-f194.google.com with SMTP id 123so2870829ybe.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2017 09:25:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Sat, 14 Jan 2017 18:25:52 +0100
Message-ID: <CAKNHny87kWbYW4jqkU2Jfsv2i3mk5bG1dewD548yQ8wV1uPTnA@mail.gmail.com>
Subject: Re: Using IIO for high-speed DAQ
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-01-14 17:12 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 13/01/17 14:13, Matthias Klumpp wrote:
>> Hello!
>> I would like to use IIO for high-speed data acquisition. In order to
>> do that I implemented a new IIO driver for the ADC chip I am using
>> (MAX1133, maximum sampling frequency 200ksps).
>>
>> The initial approach with triggered buffers was way too slow,
>> achieving only a maximum sampling frequency of 4ksps.
> Any idea where the bottle neck was specifically?  I'm guessing it
> might have been on the userspace side, but not certain.

The userspace side shouldn't be a problem, it is incredibly fast
(written to meet realtime deadlines even).

> [...]
>
> When you say use DMA, this part is an SPI device - so are you hand
> rolling DMA transfers from the spi controller?
>
> We've discussed in the past (long time ago now!) how to use spi
> controllers that support streaming modes but nothing has really come
> of it yet. What SPI controller are you using?
>
> Last time I was trying to do similar things (was a while ago now)
> I fairly quickly hit the limitation that the round trip time on SPI
> transfers even when using DMA was a lot longer than the theoretical.
> Any idea where you will be limited with that?

This is the problem - for each data acquisition, I make one spi_sync
call at time and I am really just hand-rolling SPI transfers from the
controller.
I think the gain in speed I saw came purely from the fact that I got
rid of the timer trigger, not so much from the DMA...

>> [...]
> Lars would indeed be the person I'd ask about this.  I've cc'd
> him directly as often emails get buried in the list and missed
> by people for at least a little while.
>
> Keep us informed of how you get on. Will be useful info for others.

Thank you a lot for your reply and pointers! This project I am working
on started quite small and now became way bigger than expected, with
me touching a lot of areas I have less knowledge of, so any feedback
has tremendous value.

Kind regards,
    Matthias
