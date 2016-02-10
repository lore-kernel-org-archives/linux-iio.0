Return-Path: <vilhelm.gray@gmail.com>
Date: Tue, 9 Feb 2016 21:19:04 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: Add IIO support for the DAC on the Apex Embedded
 Systems STX104
Message-ID: <20160210021904.GA13466@sophia>
References: <20160208175034.GA14727@sophia>
 <56BA6A15.9000601@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <56BA6A15.9000601@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Feb 09, 2016 at 10:37:09PM +0000, Jonathan Cameron wrote:
>My only real question is on the naming of the module parameter.
>Is it the equivalent of the io address that a load of ISA
>radio drivers seem to use?  (fed to me by grepping isa_register_driver)
>If so perhaps that's the 'standard' name as much as one exists for this?

Yes, you noted correctly that the stx104_base module parameter fulfills
the same function as the io module parameter used in many of the radio
drivers: it's an array holding the io port address of each device.
However, I find "io" to be a rather vague module parameter name, so I've
decided to use the more apt "stx104_base" name for my array of base
addresses.

As you've probably noticed, there are few ISA drivers existing in the
kernel baseline currently, so not much of a standard is set yet. I'm all
right with renaming the module parameter if you have a preference, just
as long as the name is more informative than simply "io."

For what it's worth, this driver is part of a series of PC/104 drivers
I've been submitting to various subsystems (in the hopes of improving
the lack of PC/104 support in the baseline Linux kernel); see
drivers/gpio/gpio-104-idio-16.c and drivers/gpio/gpio-104-idi-48.c for
example. I have thus far been following the convention of naming the
base address module parameter as "modname_base," where "modname" is the
respective module name.

William Breathitt Gray
