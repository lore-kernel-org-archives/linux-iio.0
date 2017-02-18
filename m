Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33882 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbdBRTQD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 14:16:03 -0500
Subject: Re: [RFC 0/4] iio: trigger: Add OF support and GPIO based trigger
To: Daniel Baluta <daniel.baluta@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <CAEnQRZDey70TR=nU4rpFyVMqDuUFAGc2SpNCmraUO5x29n1+ow@mail.gmail.com>
Cc: linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3a2d79be-d39d-10d8-6ff4-d8aea9560263@kernel.org>
Date: Sat, 18 Feb 2017 19:07:12 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDey70TR=nU4rpFyVMqDuUFAGc2SpNCmraUO5x29n1+ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/02/17 16:23, Daniel Baluta wrote:
> On Fri, Feb 17, 2017 at 6:03 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>> Hi,
>>
>> I send this as an RFC, as I'm digging to try to get as generic
>> as possible GPIO based trigger support, as discussed earlier in
>> other patchset "Add EXTI GPIO trigger support to STM32 ADC":
>> https://www.spinics.net/lists/arm-kernel/msg559091.html
>>
>> Following various comments on this, I sent this RFC to address two
>> topics, that I see as possible prerequisite:
>> - Add trigger OF support
>> - GPIO based trigger
> 
> I wonder if we could use configfs to create and configure
> a GPIO based trigger.
> 
> You should just create another trigger type (look into
> drivers/iio/trigger/iio-trig-hrtimer.c)
> the userspace API will look like this:
> 
> # cd /config/iio/triggers
> # insert your iio-trig-gpio
> # setup the global parameters for the GPIO (the local params can be
> set via dts/acpi)
> # cd /config/iio/trigers/gpios/
> 
> #mkdir t1
> 
> And this will create an io-gpio-trigger named t1.
> 
> Not sure this fits your usecase but would be nice to consider.
> 
It might potentially make sense to support both DT or similar instantiation and
instantiation from userspace. Primary route seems to me to always be DT based
though as we are dealing with wiring...

So I'm unconvinced on the configfs option, but might be talked round.
> thanks,
> Daniel.
> 

