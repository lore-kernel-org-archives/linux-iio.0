Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33490 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdF3OAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2017 10:00:01 -0400
Received: by mail-io0-f170.google.com with SMTP id h64so24455994iod.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2017 07:00:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630145319.20ec3696@jic23.retrosnub.co.uk>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl> <20170630145319.20ec3696@jic23.retrosnub.co.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Jun 2017 15:59:59 +0200
Message-ID: <CACRpkdZ0FKgbVJeLoFcYZF8Xd+oYn8mja1dy-ij6ArNGNC7O8w@mail.gmail.com>
Subject: Re: "Generic" MMIO ADC
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 30, 2017 at 3:53 PM, Jonathan Cameron
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

The gpio-mmio is for the simple case where we have one bit per
GPIO, one bit reads/writes value, one bit sets direction etc.

(I am happy we did not call it "gpio-simple" because these "simple"
things are seldom simple in practice. So MMIO ADC is a good name.)

I would ask the following architectural questions:

- Is it really that simple, no clocks, regulator etc?

- Is it advisible to have it as a child of a syscon, using "simple-mfd"
  to spawn the child device c.f.
  Documentation/devicetree/bindings/leds/register-bit-led.txt
  drivers/leds/leds-syscon.c

- drivers/power/reset/syscon-*
  also use the syscon child approach

Yours,
Linus Walleij
