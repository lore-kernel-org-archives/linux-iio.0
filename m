Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b59ff168-c82e-26ed-9192-a491d97c5d6d@metafoo.de>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-2-git-send-email-eraretuya@gmail.com> <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
 <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org> <CACRpkdY6dJGGAZtVNrYwV9uBzGYRH40aqCtL6XZkEQS2uaiK4w@mail.gmail.com>
 <b59ff168-c82e-26ed-9192-a491d97c5d6d@metafoo.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Nov 2016 00:12:55 +0100
Message-ID: <CACRpkdbWqxUWc+40AYSY7XX2ZFYSZEBcU3FusOrunG+-GCZGwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Eva Rachel Retuya <eraretuya@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 14, 2016 at 7:53 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> It's about figuring out the setting of a "GPIO" that can't be changed from
> software.
>
> Devices sometimes, instead of a configuration bus like I2C or SPI, use
> simple input pins, that can either be set to high or low, to allow software
> the state of the device. The GPIO API is typically used to configure these pins.
>
> This works fine as long as the pin is connected to a GPIO. But sometimes the
> system designer decides that a settings does not need to be configurable, in
> this case the pin will be tied to logic low or high directly on the PCB
> without any GPIO controller being involved.
>
> Sometimes a driver wants to know how the pin is wired up so it can report to
> userspace this part runs in the following mode and the mode can't be
> changed. In a sense it is like a reverse GPIO hog.
>
> Considering that this is a common usecase the question was how this can be
> implemented in a driver independent way to avoid code duplication and
> slightly different variations of what is effectively the same DT/ACPI binding.
>
> E.g. lets say for a configurable pin you use
>
>         range-gpio = <&gpio ...>;
>
> and for a static pin
>
>         range-gpio-fixed = <1>;
>
> Or something similar.

Aha I understand.

Usually I feel we need not shoehorn stuff into GPIO because it is convenient,
it might be best to leave the GPIO optional and if it is not there, look for
a custom attribute that represents the "hogging" to 0/1. I think trying
to extend GPIO bindings to cover it is overgeneralization, instead go
for a local binding for this kind of devices.

But mainly it is a question to the DT bindings maintainers.

Yours,
Linus Walleij
