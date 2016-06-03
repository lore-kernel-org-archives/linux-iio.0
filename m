Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60869 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcFCLIQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 07:08:16 -0400
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
To: Linus Walleij <linus.walleij@linaro.org>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
 <CACRpkdbch1dhUTdCMxLqLHY_cfmgtFvxKoBaCwf7w=RjV0vh7A@mail.gmail.com>
 <821accfa-33fc-9d64-2601-7feae77bf38a@intel.com>
 <a27872f0-6359-2c73-002c-2550ef6a9a2b@kernel.org>
 <CACRpkdZfqRTrKtPRbjUuEOn6s5VEmV9PJSRx6eCr+THHCOk2uA@mail.gmail.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9cb338ec-f223-cf7f-27fb-bd10a80f7f0a@kernel.org>
Date: Fri, 3 Jun 2016 12:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZfqRTrKtPRbjUuEOn6s5VEmV9PJSRx6eCr+THHCOk2uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/16 15:36, Linus Walleij wrote:
> On Sun, May 29, 2016 at 9:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 24/05/16 13:35, Crestez Dan Leonard wrote:
> 
>>> This might be completely crazy, but wouldn't it be possible to support
>>> gpio level interrupts purely in software? Just read the GPIO state again
>>> after the interrupt is unmasked and retrigger.
>>>
>>> This seems preferable to implementing per-driver workarounds. Perhaps it
>>> would even fit in some gpio-irqchip glue.
>>
>> That's precisely the question I raised way back when writing the lis3l02dq
>> driver.  Apparently someone once had a go but it never went anywhere...
> 
> It is maybe possible to do in some cases. What you have to do
> is to augment the GPIO irqchip driver to read the line status register
> after handling an IRQ, if level IRQ is desired, and if the line is still high
> after a rising edge or still low after a falling edge, just call the IRQ
> handler again.
> 
> This will not work with threaded interrupt handlers, because that
> code is in the "hard" path of the interrupt handling code, that
> gets executed in response to an IRQ signal.
> 
> What it would take is code to go back into the "hard" irq handler
> after the thread has run, and take a second lap in checking the
> line levels.
> 
> I don't know if that is possible to achieve in Linux, hm :/
It would probably be possible to do deep in the irq chip as you'd do
the check at the point of the interrupt being unmasked.  A little nasty
to then flip back into interrupt context to re trigger the interrupt
but could probably be done - perhaps by maintaining a parallel
interrupt chip that is closer to an IIO trigger (i.e. entirely fake).

Would be easier if only rerunning the threaded part though..

Is it worth it?  Doubtful.

Cc'd the IRQCHIP maintainers in case they want to add anything or
give pointers to a previous similar discussion.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

