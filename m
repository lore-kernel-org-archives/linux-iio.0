Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:38203 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbbJSOK4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Oct 2015 10:10:56 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 7A781209A8
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2015 16:10:53 +0200 (CEST)
Message-ID: <5624F98E.4010800@posteo.de>
Date: Mon, 19 Oct 2015 16:09:18 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>
CC: jic23@kernel.org, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer
 driver
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>	<5624CFA7.1030603@posteo.de>	<CAGhQ9Vy2C+fHin=PwCrm9XERdSObe61jfTRfoSmRHLue2XjB0g@mail.gmail.com>	<5624E878.1020200@posteo.de> <CAGhQ9VyEaev+nNCbQmWq6cdfeP5Jtrh9oEM=4c16_3uGnj5UPA@mail.gmail.com>
In-Reply-To: <CAGhQ9VyEaev+nNCbQmWq6cdfeP5Jtrh9oEM=4c16_3uGnj5UPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-10-19 um 15:43 schrieb Joachim Eastwood:
> On 19 October 2015 at 14:56, Martin Kepplinger <martink@posteo.de> wrote:
>> Am 2015-10-19 um 14:34 schrieb Joachim Eastwood:
>>> Hi Martin,
>>>
>>> On 19 October 2015 at 13:10, Martin Kepplinger <martink@posteo.de> wrote:
>>>> Am 2015-10-18 um 00:25 schrieb Joachim Eastwood:
>>>>> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
>>>>> I2C and SPI bus support. This is a rather simple driver that
>>>>> currently doesn't support all the hardware features of MMA7455L.
>>>>>
>>>>> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
>>>>>
>>>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>>>> ---
>>>>
>>>> Think about adding support for MMA7456L as well. What's the difference
>>>> between the two, except for the ID?
>>>
>>> I think the driver should work with MMA7456L as well.
>>> I have tried to figure out the difference between the two devices, but
>>> the Freescale doesn't list them. One another annoying thing is that
>>> the ID isn't actually stated in the data sheet (!). So for MMA7456L I
>>> would guess it is 0x56, but there is no way to be sure.
>>>
>>
>> You're right, that's messy. I asked freescale about it and we'll see
>> if/when there's an answer.
> 
> ah, nice. Thanks for taking the time to doing that.
> 

MMA7456L's WHO_AM_I value should also be 0x55, see
https://community.freescale.com/thread/378035

You could think about renaming the driver to mma745xl which is this
"series".

At least you can add MMA7456L to your Kconfig and all your docs.

                        martin

