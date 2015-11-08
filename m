Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43889 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbbKHPtE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 10:49:04 -0500
Subject: Re: [PATCH v4] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
To: Joachim Eastwood <manabian@gmail.com>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
 <1446295756-14364-1-git-send-email-manabian@gmail.com>
 <5636538C.8080905@kernel.org> <563653BB.8050307@kernel.org>
 <CAGhQ9VzgLsw2FPZv9Ws1CdXep-+GbQU_Bu_TC8Z0LZ1Z-5axNA@mail.gmail.com>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F6EEE.70303@kernel.org>
Date: Sun, 8 Nov 2015 15:49:02 +0000
MIME-Version: 1.0
In-Reply-To: <CAGhQ9VzgLsw2FPZv9Ws1CdXep-+GbQU_Bu_TC8Z0LZ1Z-5axNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/15 22:17, Joachim Eastwood wrote:
> Hi Jonathan,
> 
> On 1 November 2015 at 19:02, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 01/11/15 18:01, Jonathan Cameron wrote:
>>> On 31/10/15 12:49, Joachim Eastwood wrote:
>>>> Add support for Freescale MMA7455L/MMA7456L 3-axis in 10-bit mode for
>>>> I2C and SPI bus. This rather simple driver that currently doesn't
>>>> support all the hardware features of MMA7455L/MMA7456L.
>>>>
>>>> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C bus.
>>>>
>>>> Data sheets for the two devices can be found here:
>>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
>>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>>>>
>>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>> A few really trivial gripes I'll deal with when applying.
>>>
>>> + the s/header/driver thing Martin picked up on.
>> Forgot the important bit:
>>
>> Applied to the togreg branch of iio.git - initially pushed out as
>> testing for the autobuilders to play with it.
> 
> Thanks for fixing up and applying.
> 
> I can't seem to find it in your testing branch on
> kernel/git/jic23/iio.git, though.
Sorry, more than likely I failed to push out. Once my local build
tests are done I'll be pushing out today.

Have a habit of reaching the end of a review time when someone shouts
dinner then failing to remember to come back later and push stuff out.

oops.

Jonathan
> 
> 
> regards,
> Joachim Eastwood
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

