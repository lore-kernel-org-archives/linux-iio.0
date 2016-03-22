Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32882 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbcCVItz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2016 04:49:55 -0400
Received: by mail-oi0-f44.google.com with SMTP id d205so165395936oia.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2016 01:49:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56EFFBB6.40806@analog.com>
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
	<56DAEDF4.6040008@kernel.org>
	<56DD7548.8050306@analog.com>
	<CACRpkdY=n30A5UkRX7avP7eWrPffh3faF8K_Ey2f2cs1GRZP7g@mail.gmail.com>
	<56EFFBB6.40806@analog.com>
Date: Tue, 22 Mar 2016 09:49:55 +0100
Message-ID: <CACRpkdYFUUoG--47qFA_za9X07qukST1vMBEoVC6J4z2LHcs3w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
From: Linus Walleij <linus.walleij@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 21, 2016 at 2:48 PM, Michael Hennerich
<michael.hennerich@analog.com> wrote:

> The thing is that the device directly supports an OPEN DRAIN mode.
>
> If the consumer asks for open drain mode - everything works as expected.
> However instead of utilizing the on-chip feature, GPIOLIB will emulate open
> drain behaviour by configuring the chip for input when someone writes logic
> high.
>
> So the comment above was really meant to say -
> remove on-chip OPEN DRAIN mode, consumers should use the GPIOLIB
> implementation if required.

This is very interesting.

So if a hardware has *real* open drain, i.e. a bit in hardware that says
"set me in open drain mode" we should manage this in gpiolib
and provide a special callback in the vtable for it, right? Because it
is certainly better to do this with hardware, if we can.

I'll send a draft patch and we can see if this is what you want.

Yours,
Linus Walleij
