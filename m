Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:9290 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdGGHqi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2017 03:46:38 -0400
Date: Fri, 7 Jul 2017 15:44:48 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: "Generic" MMIO ADC
Message-ID: <20170707154448.00006dec@huawei.com>
In-Reply-To: <CACRpkdaZ=qSbdVxgw4DH_tOeZb0pZBYhhJJOozFn2pn25F_Kag@mail.gmail.com>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl>
        <20170630145319.20ec3696@jic23.retrosnub.co.uk>
        <b9dc2313-53da-1566-c0e8-ac18599f59da@topic.nl>
        <CACRpkdaZ=qSbdVxgw4DH_tOeZb0pZBYhhJJOozFn2pn25F_Kag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 6 Jul 2017 23:37:04 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Jul 3, 2017 at 2:37 PM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
> > I was thinking along these lines:
> >
> > ... {
> >    compatible = "iio-adc-generic-mmio";
> >    reg = <0x43210000 4096>;
> >    interrupt = <&gic 42 0>;
> >    iio,start-sequence = <0x0 0x3> <0x4 0xff>;
> >    iio,stop-sequence = <0x0 0x0>;  
> 
> Nope. We are not going to invent scripting languages inside device tree.
> No sequences please. This is the start of what we call a jam table.
> 
> We had this discussion a long time ago when starting to convert all the ARM
> platforms to device tree: sequences should be expressed in code, not in
> the device tree. Because next thing that happens is that you want to encode
> a for() loop or if() or while().
> 
> The reason is that device tree is already part of open firmware, which already
> has a scripting language: FCode (based on forth). This is then used to create
> BIOS routines along the lines of what you're suggesting. So if you insist on
> writing a BIOS, by all means write a BIOS, but not inside DT, use FCode
> and figure out how to bridge that.
> 
> But I think it's easier to just write a normal driver really.
> 
> Compare to ACPI, which has AML, for the very same purpose, and DSDT
> for describing the hardware.
> 
> Since ACPI is now starting to share parts of the DT bindings), things would
> get very weird if we did things like this. Should they also implement a
> compatible interpreter, rather than call their (very much in-use) AML
> snippets?
Ah that was matching up with my gut feeling on the matter.  Thanks for the detailed
response Linus.   Anyhow, doesn't mean the concept of such a driver is bad, merely that
the tables should form part of the driver code (much like any other driver that supports
a number of different parts) and be selected by the compatible string.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


