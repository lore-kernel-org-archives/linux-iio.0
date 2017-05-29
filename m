Return-Path: <SRS0=ZzAN=5D=cogentembedded.com=nikita.yoush@kernel.org>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Jonathan Cameron <jic23@kernel.org>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
 <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
 <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com>
 <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
 <20170524203808.34aec03a@kernel.org>
 <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
 <20170528164238.56884259@kernel.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>,
 Linus Walleij <linus.walleij@linaro.org>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <222206a9-d4a5-1e9b-698c-11112380fe1d@cogentembedded.com>
Date: Mon, 29 May 2017 10:57:04 +0300
MIME-Version: 1.0
In-Reply-To: <20170528164238.56884259@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

>> - Thinking further on this, I realized that for common case signal
>> polarity is something defined by chip, and thus this knowledge belongs
>> to chip's driver and not to chip user's device tree. Moreover, device
>> tree writer could easily be not aware of signal polarity (too many
>> datasheets are NDA-closed), thus hello copy-pasting, try-and-check and
>> other counterproductive approaches.
>>
>> - Then Vladimir pointed real-life case with signal inversion by handmade
>> level shifter. Although scope of this is likely limited to hw labs,
>> support for this is wanted and thus some way to override polarity in
>> chip user's dts be available.  Still, this should be optional, without
>> requiring dts to always define polarity of each gpio.
>
> I have real hardware that effectively does the equivalent for interrupt
> lines coming into the processor from some sensors.  Note quite the same,
> but shows these things often do turn up as a fix on 'real' hardware.

Well no doubt that sometimes there is need to invert polarity for
particular use case.

But still forcing explicit definition of polarity of each and every gpio
usage is a bad way to solve this.

> You are correct, this needs some wider guidance.  I've cc'd Linus
> Walleij more to make sure he has a heads up than to suggest
> we continue this conversation in this thread.

As I've already written elsewhere, possible solution is a new pair of
gpio flags, GPIO_DEFAULT_POLARITY / GPIO_INVERTED_POLARITY, which means
that polarity of signal is, corresponding, chip's default or inverted
chip's default.  And matching API for drivers to set default when
requesting gpio.

> 
> I don't know what the 'correct' way forward is.  Funnily enough
> my immediate thought is to it it with a big hammer and define
> an inverting gpiochip to represent the possible inverter.
> So a bit like a gpiochip setting on i2c but in this case
> it sits on a gpio.  So when you set the front gpio
> (representing the inverter) it knows to set the opposite
> on the actual gpio on the processor.

This may be alternative to GPIO_DEFAULT_POLARITY /
GPIO_INVERTED_POLARITY, that perhaps allows for device tree to better
follow schematics.  Still this does not play well with existing
requirement to explicitly set ACTIVE_LOW / ACTIVE_HIGH at gpio usage side.


Nikita

P.S.

Another view is that for such a trivial entity as gpio, we already have
- physical gpio values,
- logical values that come from ACTIVE_LOW / ACTIVE_HIGH,
- for gpios used as interrupts, active low / active high irq's,
and discussing addition more to that... for simplification? Joking?

At least, if adding default-polarity / inverted-polarity, this should be
done mutually-exclusive with active-high / active-low.  And if adding
inverter gpiochip, then also this should be mutual exclusive with
setting active-high / active-low.
