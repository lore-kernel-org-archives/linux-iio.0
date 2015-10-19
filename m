Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5624CFA7.1030603@posteo.de>
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
	<5624CFA7.1030603@posteo.de>
Date: Mon, 19 Oct 2015 14:34:08 +0200
Message-ID: <CAGhQ9Vy2C+fHin=PwCrm9XERdSObe61jfTRfoSmRHLue2XjB0g@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer driver
From: Joachim  Eastwood <manabian@gmail.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Martin,

On 19 October 2015 at 13:10, Martin Kepplinger <martink@posteo.de> wrote:
> Am 2015-10-18 um 00:25 schrieb Joachim Eastwood:
>> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
>> I2C and SPI bus support. This is a rather simple driver that
>> currently doesn't support all the hardware features of MMA7455L.
>>
>> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>
> Think about adding support for MMA7456L as well. What's the difference
> between the two, except for the ID?

I think the driver should work with MMA7456L as well.
I have tried to figure out the difference between the two devices, but
the Freescale doesn't list them. One another annoying thing is that
the ID isn't actually stated in the data sheet (!). So for MMA7456L I
would guess it is 0x56, but there is no way to be sure.


regards,
Joachim Eastwood
