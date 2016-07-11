Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35724 "EHLO
	mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbcGKJLA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2016 05:11:00 -0400
MIME-Version: 1.0
In-Reply-To: <0da0328b-c0a2-215e-64be-5c27aa58572f@kernel.org>
References: <CAHNg1SoX_VFcKLYTmir9=Mh-UtLjGqJ_Q3xbfyxKv+HAAQGFCg@mail.gmail.com>
 <CAHNg1Sqe4FRKSzxPsXni6xYCBLQovAYvGoeNQpzi531J6V+K0A@mail.gmail.com> <0da0328b-c0a2-215e-64be-5c27aa58572f@kernel.org>
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Mon, 11 Jul 2016 14:40:58 +0530
Message-ID: <CAHNg1SqMRgmtcfdkRmP3abSPLcphQL7rWxO8v5JUOJS0MfAAvQ@mail.gmail.com>
Subject: Re: How to set Current register in IIO driver from sysfs
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the answers.
One more question:
What are volatile registers?
I couldn't understood the difference between volatile and writable
registers from max44000 driver.

Best Regards,
Pratik

On Sun, Jul 10, 2016 at 8:09 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/07/16 14:11, Pratik Prajapati wrote:
>> Including more members.
>>
>> On Sat, Jul 9, 2016 at 5:22 PM, Pratik Prajapati
>> <pratik.prajapati12@gmail.com> wrote:
>>> Hi,
> hi Pratik,
>>>
>>> I am trying to add support of adjusting IR led current in vcnl4000
>>> driver (has IR led current register for doing the same).
> This is always a bit of a 'rough' corner when it comes to what interface
> to do it with.  Strictly speaking this is typically just a regulator that
> happens to be used for this special purpose.  Sometimes they are tightly
> tied together with the input and sometime (on devices with more than one)
> there is no explicit linkage at all.
>
> In this particular case we seem to actually have a high frequency modulated
> LED driver so it's pretty tightly tied to this use.
>>>
>>> Below is what I have done till now:
>>>
>>> 1) Added Current channel in the vcnl4000_channels structure with
>>> separate mask IIO_CHAN_INFO_RAW
>>> 2) Reading the LED current register inside IIO_CURRENT case in vcnl4010_read_raw
>>> 3) Writing to LED current register inside IIO_CURRENT case in vcnl4010_write_raw
>>>
>>> Is this the correct way of setting Current register in IIO subsystem?
> That's about the best option we currently have. This is exactly how it's done
> in the max44000 driver for example.
>
> It's not an interface anyone is terribly happy with so you are welcome to
> suggestion alternatives (easy to add them as an additional interface to
> existing cases - which is why we haven't been that worried about ending up
> with the current less than ideal interface)
> The tight coupling in this particular case might justify something more
> explicitly linked to the proximity channel but as noted above it's not
> always that obvious (see the health/afe parts for example which are way
> too flexible in my view!)
>
> Jonathan
>
>
>>>
>>> Best Regards,
>>> Pratik Prajapati
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
