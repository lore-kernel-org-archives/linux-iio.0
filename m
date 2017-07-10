Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdGJJgu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jul 2017 05:36:50 -0400
Subject: Re: [PATCH 5/9] iio: humidity: hts221: support active-low interrupts
To: Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-6-lorenzo.bianconi@st.com>
 <20170709193951.14caff79@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <ceef5860-91ee-a922-0dd7-8f2698192b9b@arm.com>
Date: Mon, 10 Jul 2017 10:36:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170709193951.14caff79@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 09/07/17 19:39, Jonathan Cameron wrote:
> On Sun,  9 Jul 2017 18:57:00 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> 
>> Add support for active low interrupts (IRQF_TRIGGER_LOW and
>> IRQF_TRIGGER_FALLING). Configure the device as active high or low
>> according to the requested irq line.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> Hi Lorenzo,
> 
> Sorry, you are getting caught up in a more general question I'd like to 
> pin down an answer for...
> 
> What should we be doing if we have a part that supports both high and
> low interrupts and/or rising and falling?
> 
> We actually have more than one possible thing we are configuring with
> one parameter.  If we are looking at shared interrupts or level
> converters it's more than possible we have an inversion going on between
> the two.   How is this represented to the two ends?
> 
> What's the right way of doing this?
> 
> I've added a few CCs that I think might chip in on this question!
> 
> My personal gut feeling is that the inverter should have explicit
> representation in the kernel.  We should be able to instantiate an
> irq_chip which is responsible for flipping it's sense.
> 
> You request an active high input on one side and it deals with
> the active low that needs to be requested upstream.
> 
> Chances are I'm missing something and this is already well handled!

We already have things like that, such as
drivers/irqchip/irq-mtk-sysirq.c (whose sole purpose in life is to
invert interrupt polarity).

Hope this helps,

	M.
-- 
Jazz is not dead. It just smells funny...
