Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36546 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546AbbKCWRT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2015 17:17:19 -0500
Received: by igcg4 with SMTP id g4so3284603igc.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2015 14:17:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563653BB.8050307@kernel.org>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<1446295756-14364-1-git-send-email-manabian@gmail.com>
	<5636538C.8080905@kernel.org>
	<563653BB.8050307@kernel.org>
Date: Tue, 3 Nov 2015 23:17:18 +0100
Message-ID: <CAGhQ9VzgLsw2FPZv9Ws1CdXep-+GbQU_Bu_TC8Z0LZ1Z-5axNA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: add Freescale MMA7455L/MMA7456L 3-axis
 accelerometer driver
From: Joachim Eastwood <manabian@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 1 November 2015 at 19:02, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/11/15 18:01, Jonathan Cameron wrote:
>> On 31/10/15 12:49, Joachim Eastwood wrote:
>>> Add support for Freescale MMA7455L/MMA7456L 3-axis in 10-bit mode for
>>> I2C and SPI bus. This rather simple driver that currently doesn't
>>> support all the hardware features of MMA7455L/MMA7456L.
>>>
>>> Tested on Embedded Artist's LPC4357 Dev Kit with MMA7455L on I2C bus.
>>>
>>> Data sheets for the two devices can be found here:
>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf
>>> http://cache.freescale.com/files/sensors/doc/data_sheet/MMA7456L.pdf
>>>
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> A few really trivial gripes I'll deal with when applying.
>>
>> + the s/header/driver thing Martin picked up on.
> Forgot the important bit:
>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.

Thanks for fixing up and applying.

I can't seem to find it in your testing branch on
kernel/git/jic23/iio.git, though.


regards,
Joachim Eastwood
