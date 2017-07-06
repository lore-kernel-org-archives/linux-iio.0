Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36370 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdGFSW3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jul 2017 14:22:29 -0400
Date: Thu, 6 Jul 2017 19:22:26 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: "Generic" MMIO ADC
Message-ID: <20170706192226.0898e0e7@jic23.retrosnub.co.uk>
In-Reply-To: <b9dc2313-53da-1566-c0e8-ac18599f59da@topic.nl>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl>
        <20170630145319.20ec3696@jic23.retrosnub.co.uk>
        <b9dc2313-53da-1566-c0e8-ac18599f59da@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 3 Jul 2017 14:37:35 +0200
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> ﻿On 30-06-17 15:53, Jonathan Cameron wrote:
> > On Fri, 30 Jun 2017 10:44:42 +0200
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >   
> >> ﻿I'm writing an IIO driver for a custom IP, which is pretty simple:
> >>
> >> - Map the registers to memory and register IRQ routine
> >> - To start acquisition, write a value to the config register
> >> - On interrupt, read data register, push it into queue
> >> - To stop, write another value to config.
> >>
> >> Would it be useful to provide this as a generic driver in Linux, so that you
> >> can provide the config register and data register offsets and values in the
> >> devicetree? That would make it work on a lot of similar project without
> >> everyone coding the same thing.  
> > 
> > Hi Mike,
> > 
> > I've brought in the devicetree bindings maintainers and list as well on this
> > discussion because in many ways it's more about the strategy on bindings
> > than the actual driver...  Also Linus Walleij for any experience handing
> > the gpio-mmio driver which strikes me as fairly similar in aim.
> > 
> > To the driver question, yes absolutely this would be a good thing to have.
> > The majority of ADCs out there are irritatingly more complex than what
> > you have.  Everyone seems to feel obliged to put in their own 'special
> > sauce'.
> > 
> > As for bindings, there are two options, either we
> > 
> > 1) As you suggest push all differences between different parts into the
> > bindings.  Note we'll still need a compatible list in the driver.
> > So this is something like gpio-mmio.c
> > 
> > 2) Do something similar to the irq generic_chip (CONFIG_GENERIC_IRQ)
> > infrastructure and actually have very slim wrapper drivers around a
> > library.   That allows those elements that are constrained by the
> > hardware to not need specifying in device tree bindings.
> >   
> >>
> >> And a related question: Is there a driver that's close to this?  
> > I can't immediately think of one, but it's possible that one
> > of the SoC ADC drivers is simple enough to describe this way.
> > 
> > So Mark / Rob.  You guys have experience with how the bindings
> > worked out for each approach.  Which do you prefer?
> > Either approach is fine with me.
> > 
> > Mike, perhaps you have an initial cut of some bindings that might
> > help the discussion to move along?  
> 
> I was thinking along these lines:
> 
> ... {
>     compatible = "iio-adc-generic-mmio";
>     reg = <0x43210000 4096>;
>     interrupt = <&gic 42 0>;
>     iio,start-sequence = <0x0 0x3> <0x4 0xff>;
>     iio,stop-sequence = <0x0 0x0>;
>     iio,data-register = <0x10>;
> };
> 
> Required:
>    compatible: must be "iio-adc-generic-mmio";
>    reg: Memory address and range of IP platform device
>    interrupt: Data-ready interrupt binding
> 
> Optional:
>    iio,data-register: Offset where to read data. Defaults to <0>.
>    iio,start-sequence: Array of <offset value> pairs. On start of acquisition
>                        the driver writes each value to each offset in order.
>    iio,stop-sequence: Array of <offset value> pairs to stop acquisition.
> 
> 
> And we could make up more properties as we go, like the number of valid data 
> bits and shift, interrupt rate and fifo buffer properties...
> 
> We could add normal clock and power supply bindings as well, so it would 
> enable them on starting data acquisition.
> 
> 
> For now the bad news is that the project was put on hold, so I'm not allowed 
> to spend serious development time now.
> 
Ah well, such is life unfortunately!  If it resurfaces then give this thread
a bump and we'll get back to thinking about it some more.

Obviously don't progress from other directions though if anyone else wants to
pick this up and run with it.

Jonathan
> 
> Kind regards,
> 
> Mike Looijmans
> System Expert
> 
> TOPIC Products
> Materiaalweg 4, NL-5681 RJ Best
> Postbus 440, NL-5680 AK Best
> Telefoon: +31 (0) 499 33 69 79
> E-mail: mike.looijmans@topicproducts.com
> Website: www.topicproducts.com
> 
> Please consider the environment before printing this e-mail
> 
> 
> 

