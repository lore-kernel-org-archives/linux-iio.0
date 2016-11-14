Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34731 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbcKNSxh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 13:53:37 -0500
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-2-git-send-email-eraretuya@gmail.com>
 <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
 <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org>
 <CACRpkdY6dJGGAZtVNrYwV9uBzGYRH40aqCtL6XZkEQS2uaiK4w@mail.gmail.com>
Cc: Eva Rachel Retuya <eraretuya@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b59ff168-c82e-26ed-9192-a491d97c5d6d@metafoo.de>
Date: Mon, 14 Nov 2016 19:53:28 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdY6dJGGAZtVNrYwV9uBzGYRH40aqCtL6XZkEQS2uaiK4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/14/2016 05:58 PM, Linus Walleij wrote:
> On Sat, Nov 12, 2016 at 3:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Is it just me who thought, we need a fixed GPI like a fixed regulator?
>> Would allow this sort of fixed wiring to be simply defined.
>>
>> Linus, worth exploring?
> 
> So if fixed regulator is for a voltage provider, this would be
> pretty much the inverse: deciding for a voltage range by switching
> a GPIO.

It's about figuring out the setting of a "GPIO" that can't be changed from
software.

Devices sometimes, instead of a configuration bus like I2C or SPI, use
simple input pins, that can either be set to high or low, to allow software
the state of the device. The GPIO API is typically used to configure these pins.

This works fine as long as the pin is connected to a GPIO. But sometimes the
system designer decides that a settings does not need to be configurable, in
this case the pin will be tied to logic low or high directly on the PCB
without any GPIO controller being involved.

Sometimes a driver wants to know how the pin is wired up so it can report to
userspace this part runs in the following mode and the mode can't be
changed. In a sense it is like a reverse GPIO hog.

Considering that this is a common usecase the question was how this can be
implemented in a driver independent way to avoid code duplication and
slightly different variations of what is effectively the same DT/ACPI binding.

E.g. lets say for a configurable pin you use

	range-gpio = <&gpio ...>;

and for a static pin

	range-gpio-fixed = <1>;

Or something similar.

