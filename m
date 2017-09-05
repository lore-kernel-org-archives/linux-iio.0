Return-Path: <SRS0=xhL7=AG=zonque.org=daniel@kernel.org>
Subject: Re: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
To: Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Andrew F. Davis" <afd@ti.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
 <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
 <CAK8P3a2L+wOER7LwXApD_YrVA7Zi9D96FZC5zAm_+aSy+qG0rg@mail.gmail.com>
 <20170905101144.GA23808@wunner.de>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <524a1c8e-93c1-d905-dc39-b154290beb86@zonque.org>
Date: Tue, 5 Sep 2017 12:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170905101144.GA23808@wunner.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/05/2017 12:11 PM, Lukas Wunner wrote:
> On Tue, Sep 05, 2017 at 11:56:02AM +0200, Arnd Bergmann wrote:
>> On Tue, Sep 5, 2017 at 11:44 AM, Lukas Wunner <lukas@wunner.de> wrote:
>>> The Texas Instruments DAC7512 has the exact same pinout, programming
>>> interface and power-down modes as the Texas Instruments DAC121S101 and
>>> Analog Devices AD5320, which are already supported by the IIO driver
>>> ad5446.c.  Remove the duplicate misc driver.
>>>
>>> This requires user space to migrate to the standardized IIO sysfs ABI.
>>> (In other words, it needs to change a filename.)
>>>
>>> The IIO driver supports the chip's features more fully, e.g. the ability
>>> to power down the output or choose one of the available powerdown modes.
>>>
>>> There is an oddity with the misc driver in that it initializes the SPI
>>> slave to SPI_MODE_0, in contradiction to the datasheet which specifies
>>> that data is latched in on the falling edge, implying that SPI_MODE_1
>>> or SPI_MODE_2 must be used.  Another oddity is that Kconfig and the
>>> MODULE_DESCRIPTION() claim the chip has 16-bit resolution although it
>>> actually has 12-bit.
>>>
>>> Datasheets:
>>> http://www.ti.com/lit/ds/symlink/dac7512.pdf
>>> http://www.ti.com/lit/ds/symlink/dac121s101.pdf
>>> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5320.pdf
>>>
>>> Cc: Daniel Mack <daniel@zonque.org>
>>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Good catch, removing duplicate code is usually a good idea.
>>
>> However, for the incompatible user space ABI change, we need a better
>> reasoning why this is safe to do and won't catch users by surprise.
>>
>> If anyone relies on the old ABI and can't be expected to change,
>> we need to stay compatible. Do we know who uses the old driver?
> Daniel introduced it for use in Raumfeld speakers.
> 
> The IIO subsystem predates this driver by a few months.  I don't know
> why it uses a nonstandard file in sysfs and wasn't based on IIO.
> 
> I'm wondering if the driver has ever worked because of the SPI_MODE_0
> issue mentioned above.  If it did, it must have been by accident.
> Or the datasheet is wrong, which seems unlikely.

That's true, but the devices that do are EOL for a long time, and they
don't use mainline kernels anyway, for multiple reasons. So that
shouldn't constrain us, and I'm all for replacing that driver with
something that has a real infrastructure.

  Acked-by: Daniel Mack <daniel@zonque.org>


Thanks,
Daniel
