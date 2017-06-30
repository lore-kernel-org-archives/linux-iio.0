Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170630145319.20ec3696@jic23.retrosnub.co.uk>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl> <20170630145319.20ec3696@jic23.retrosnub.co.uk>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 30 Jun 2017 10:33:05 -0500
Message-ID: <CAL_JsqJ4gD=sSW40qE_gbKDBG_NA6eng_sr26b-4AV5D0uXjkA@mail.gmail.com>
Subject: Re: "Generic" MMIO ADC
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 30, 2017 at 8:53 AM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Fri, 30 Jun 2017 10:44:42 +0200
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> =EF=BB=BFI'm writing an IIO driver for a custom IP, which is pretty simp=
le:
>>
>> - Map the registers to memory and register IRQ routine
>> - To start acquisition, write a value to the config register
>> - On interrupt, read data register, push it into queue
>> - To stop, write another value to config.
>>
>> Would it be useful to provide this as a generic driver in Linux, so that=
 you
>> can provide the config register and data register offsets and values in =
the
>> devicetree? That would make it work on a lot of similar project without
>> everyone coding the same thing.
>
> Hi Mike,
>
> I've brought in the devicetree bindings maintainers and list as well on t=
his
> discussion because in many ways it's more about the strategy on bindings
> than the actual driver...  Also Linus Walleij for any experience handing
> the gpio-mmio driver which strikes me as fairly similar in aim.
>
> To the driver question, yes absolutely this would be a good thing to have=
.
> The majority of ADCs out there are irritatingly more complex than what
> you have.  Everyone seems to feel obliged to put in their own 'special
> sauce'.
>
> As for bindings, there are two options, either we
>
> 1) As you suggest push all differences between different parts into the
> bindings.  Note we'll still need a compatible list in the driver.
> So this is something like gpio-mmio.c
>
> 2) Do something similar to the irq generic_chip (CONFIG_GENERIC_IRQ)
> infrastructure and actually have very slim wrapper drivers around a
> library.   That allows those elements that are constrained by the
> hardware to not need specifying in device tree bindings.
>
>>
>> And a related question: Is there a driver that's close to this?
> I can't immediately think of one, but it's possible that one
> of the SoC ADC drivers is simple enough to describe this way.
>
> So Mark / Rob.  You guys have experience with how the bindings
> worked out for each approach.  Which do you prefer?
> Either approach is fine with me.

The latter case. Specific bindings can map to a generic driver or
evolve to a specific driver if the generic one becomes inadequate.

Rob
