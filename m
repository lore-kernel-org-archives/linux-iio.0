Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755766AbdGKSxD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jul 2017 14:53:03 -0400
Date: Tue, 11 Jul 2017 19:52:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 5/9] iio: humidity: hts221: support active-low
 interrupts
Message-ID: <20170711195259.3f146762@kernel.org>
In-Reply-To: <ceef5860-91ee-a922-0dd7-8f2698192b9b@arm.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
        <20170709165704.26311-6-lorenzo.bianconi@st.com>
        <20170709193951.14caff79@kernel.org>
        <ceef5860-91ee-a922-0dd7-8f2698192b9b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 10 Jul 2017 10:36:47 +0100
Marc Zyngier <marc.zyngier@arm.com> wrote:

> Hi Jonathan,
> 
> On 09/07/17 19:39, Jonathan Cameron wrote:
> > On Sun,  9 Jul 2017 18:57:00 +0200
> > Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
> >   
> >> Add support for active low interrupts (IRQF_TRIGGER_LOW and
> >> IRQF_TRIGGER_FALLING). Configure the device as active high or low
> >> according to the requested irq line.
> >>
> >> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>  
> > Hi Lorenzo,
> > 
> > Sorry, you are getting caught up in a more general question I'd like to 
> > pin down an answer for...
> > 
> > What should we be doing if we have a part that supports both high and
> > low interrupts and/or rising and falling?
> > 
> > We actually have more than one possible thing we are configuring with
> > one parameter.  If we are looking at shared interrupts or level
> > converters it's more than possible we have an inversion going on between
> > the two.   How is this represented to the two ends?
> > 
> > What's the right way of doing this?
> > 
> > I've added a few CCs that I think might chip in on this question!
> > 
> > My personal gut feeling is that the inverter should have explicit
> > representation in the kernel.  We should be able to instantiate an
> > irq_chip which is responsible for flipping it's sense.
> > 
> > You request an active high input on one side and it deals with
> > the active low that needs to be requested upstream.
> > 
> > Chances are I'm missing something and this is already well handled!  
> 
> We already have things like that, such as
> drivers/irqchip/irq-mtk-sysirq.c (whose sole purpose in life is to
> invert interrupt polarity).
> 
> Hope this helps,
> 
> 	M.
Thanks Marc,

I think it would need generalising a fair bit, but in principle that
is doing exactly what is needed (just run with generic irq_chip
callbacks except for irq_set_type).

The registration logic seems rather convoluted, but I haven't yet
dug into why it is like that.  Certainly seems like we should be
able to get away with something rather less involved by not
trying to do it quite so efficiently.  For this particular
case I think we'd probably instantiate an irq chip per inverted
irq (there is no connection between them really).

Now the tricky bit as ever is going to be getting the bindings right.
The ones for the example you give are somewhat device specific.

Jonathan


