Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34396 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161355AbcFBOgT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 10:36:19 -0400
Received: by mail-oi0-f49.google.com with SMTP id e72so80135146oib.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jun 2016 07:36:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a27872f0-6359-2c73-002c-2550ef6a9a2b@kernel.org>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
	<6c5cc47895ca35fce84b6b01a3ecf7df928aa197.1463164919.git.leonard.crestez@intel.com>
	<CACRpkdbch1dhUTdCMxLqLHY_cfmgtFvxKoBaCwf7w=RjV0vh7A@mail.gmail.com>
	<821accfa-33fc-9d64-2601-7feae77bf38a@intel.com>
	<a27872f0-6359-2c73-002c-2550ef6a9a2b@kernel.org>
Date: Thu, 2 Jun 2016 16:36:18 +0200
Message-ID: <CACRpkdZfqRTrKtPRbjUuEOn6s5VEmV9PJSRx6eCr+THHCOk2uA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: st_sensors: Use level interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 29, 2016 at 9:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 24/05/16 13:35, Crestez Dan Leonard wrote:

>> This might be completely crazy, but wouldn't it be possible to support
>> gpio level interrupts purely in software? Just read the GPIO state again
>> after the interrupt is unmasked and retrigger.
>>
>> This seems preferable to implementing per-driver workarounds. Perhaps it
>> would even fit in some gpio-irqchip glue.
>
> That's precisely the question I raised way back when writing the lis3l02dq
> driver.  Apparently someone once had a go but it never went anywhere...

It is maybe possible to do in some cases. What you have to do
is to augment the GPIO irqchip driver to read the line status register
after handling an IRQ, if level IRQ is desired, and if the line is still high
after a rising edge or still low after a falling edge, just call the IRQ
handler again.

This will not work with threaded interrupt handlers, because that
code is in the "hard" path of the interrupt handling code, that
gets executed in response to an IRQ signal.

What it would take is code to go back into the "hard" irq handler
after the thread has run, and take a second lap in checking the
line levels.

I don't know if that is possible to achieve in Linux, hm :/

Yours,
Linus Walleij
