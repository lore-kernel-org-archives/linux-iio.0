Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45854 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbcC1PGB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 11:06:01 -0400
Subject: Re: [PATCH v3] iio: dac: Add support for the AD5592R/AD5593R
 ADCs/DACs
To: Linus Walleij <linus.walleij@linaro.org>,
	Michael Hennerich <michael.hennerich@analog.com>
References: <1457009883-4017-1-git-send-email-michael.hennerich@analog.com>
 <56DAEDF4.6040008@kernel.org> <56DD7548.8050306@analog.com>
 <CACRpkdY=n30A5UkRX7avP7eWrPffh3faF8K_Ey2f2cs1GRZP7g@mail.gmail.com>
 <56EFFBB6.40806@analog.com>
 <CACRpkdYFUUoG--47qFA_za9X07qukST1vMBEoVC6J4z2LHcs3w@mail.gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Paul Cercueil <paul.cercueil@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F94856.60504@kernel.org>
Date: Mon, 28 Mar 2016 16:05:58 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdYFUUoG--47qFA_za9X07qukST1vMBEoVC6J4z2LHcs3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/16 08:49, Linus Walleij wrote:
> On Mon, Mar 21, 2016 at 2:48 PM, Michael Hennerich
> <michael.hennerich@analog.com> wrote:
> 
>> The thing is that the device directly supports an OPEN DRAIN mode.
>>
>> If the consumer asks for open drain mode - everything works as expected.
>> However instead of utilizing the on-chip feature, GPIOLIB will emulate open
>> drain behaviour by configuring the chip for input when someone writes logic
>> high.
>>
>> So the comment above was really meant to say -
>> remove on-chip OPEN DRAIN mode, consumers should use the GPIOLIB
>> implementation if required.
> 
> This is very interesting.
> 
> So if a hardware has *real* open drain, i.e. a bit in hardware that says
> "set me in open drain mode" we should manage this in gpiolib
> and provide a special callback in the vtable for it, right? Because it
> is certainly better to do this with hardware, if we can.
H*** yeah.  Funny how open drain stuff is popping up left right and centre
all of a sudden.
> 
> I'll send a draft patch and we can see if this is what you want.
Cool.  I like fast solutions ;)
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

