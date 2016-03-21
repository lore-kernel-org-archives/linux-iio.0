Return-Path: <Michael.Hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
 <56DAEDF4.6040008@kernel.org> <56DD7548.8050306@analog.com>
 <CACRpkdY=n30A5UkRX7avP7eWrPffh3faF8K_Ey2f2cs1GRZP7g@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, "Paul
 Cercueil" <paul.cercueil@analog.com>, Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk"
	<ijc+devicetree@hellion.org.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56EFFBB6.40806@analog.com>
Date: Mon, 21 Mar 2016 14:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdY=n30A5UkRX7avP7eWrPffh3faF8K_Ey2f2cs1GRZP7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/11/2016 05:37 PM, Linus Walleij wrote:
> On Mon, Mar 7, 2016 at 7:34 PM, Michael Hennerich
> <michael.hennerich@analog.com> wrote:
>> On 03/05/2016 03:32 PM, Jonathan Cameron wrote:
>
>>>> Changes since v2:
>>>>          * Use child nodes to describe channels
>>>>          * Fix probe return and driver remove path
>>>>          * Move locking closer to where its used
>>>>          * Remove WARN_ON but return error
>>>>          * Remove OPEN DRAIN configuration option
>>>
>>> Why? I don't particularly mind as of course you aren't obliged to support
>>> every option in a driver, but I'm curious ;)
>>
>> I'm not aware that someone asked for that feature.
>> Supporting it the proper way requires a new GPIOF flag for gpiolib, which we
>> can still discuss later, in case someone asks for it.
>
> We have:
> include/dt-bindings/gpio/gpio.h
>
> /*
>   * Open Drain/Collector is the combination of single-ended active low,
>   * Open Source/Emitter is the combination of single-ended active high.
>   */
> #define GPIO_OPEN_DRAIN (GPIO_SINGLE_ENDED | GPIO_ACTIVE_LOW)
> #define GPIO_OPEN_SOURCE (GPIO_SINGLE_ENDED | GPIO_ACTIVE_HIGH)
>
> So consumers can ask (in DT) for a line in open drain mode.
>
> FLAG_OPEN_DRAIN will be set internally in gpiolibs gpio_desc
> in of_find_gpio() as a result and it will behave as expected.
>
> Yours,
> Linus Walleij
>

Hi Linus,

The thing is that the device directly supports an OPEN DRAIN mode.

If the consumer asks for open drain mode - everything works as expected.
However instead of utilizing the on-chip feature, GPIOLIB will emulate 
open drain behaviour by configuring the chip for input when someone 
writes logic high.

So the comment above was really meant to say -
remove on-chip OPEN DRAIN mode, consumers should use the GPIOLIB 
implementation if required.



-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
