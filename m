Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <b59ff168-c82e-26ed-9192-a491d97c5d6d@metafoo.de>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com> <1478846078-22207-2-git-send-email-eraretuya@gmail.com> <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de> <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org> <CACRpkdY6dJGGAZtVNrYwV9uBzGYRH40aqCtL6XZkEQS2uaiK4w@mail.gmail.com> <b59ff168-c82e-26ed-9192-a491d97c5d6d@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available with corresponding scale
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 14 Nov 2016 22:15:04 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Linus Walleij <linus.walleij@linaro.org>,Jonathan Cameron <jic23@kernel.org>
CC: Eva Rachel Retuya <eraretuya@gmail.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,Michael Hennerich <Michael.Hennerich@analog.com>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald <pmeerw@pmeerw.net>,Greg KH <gregkh@linuxfoundation.org>
Message-ID: <0F7D932A-3232-4F33-9F46-98789442D721@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 14 November 2016 18:53:28 GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 11/14/2016 05:58 PM, Linus Walleij wrote:
>> On Sat, Nov 12, 2016 at 3:24 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> 
>>> Is it just me who thought, we need a fixed GPI like a fixed
>regulator?
Probably didn't help clarity that I described it as an input pin whereas it's kind of like having an 
output pin whose state you can't change...

>>> Would allow this sort of fixed wiring to be simply defined.
>>>
>>> Linus, worth exploring?
>> 
>> So if fixed regulator is for a voltage provider, this would be
>> pretty much the inverse: deciding for a voltage range by switching
>> a GPIO.
>
>It's about figuring out the setting of a "GPIO" that can't be changed
>from
>software.
>
>Devices sometimes, instead of a configuration bus like I2C or SPI, use
>simple input pins, that can either be set to high or low, to allow
>software
>the state of the device. The GPIO API is typically used to configure
>these pins.
>
>This works fine as long as the pin is connected to a GPIO. But
>sometimes the
>system designer decides that a settings does not need to be
>configurable, in
>this case the pin will be tied to logic low or high directly on the PCB
>without any GPIO controller being involved.
>
>Sometimes a driver wants to know how the pin is wired up so it can
>report to
>userspace this part runs in the following mode and the mode can't be
>changed. In a sense it is like a reverse GPIO hog.
>
>Considering that this is a common usecase the question was how this can
>be
>implemented in a driver independent way to avoid code duplication and
>slightly different variations of what is effectively the same DT/ACPI
>binding.
>
>E.g. lets say for a configurable pin you use
>
>	range-gpio = <&gpio ...>;
>
>and for a static pin
>
>	range-gpio-fixed = <1>;
>
>Or something similar.
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
