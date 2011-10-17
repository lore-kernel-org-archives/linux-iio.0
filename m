Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4E9BF8D9.8030301@cam.ac.uk>
References: <1318333383-17663-1-git-send-email-jic23@cam.ac.uk>
	<1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
	<20111013143224.GO1098@sirena.org.uk>
	<4E96F9AC.9000001@cam.ac.uk>
	<20111013204410.GA17160@sirena.org.uk>
	<4E985C60.9020308@cam.ac.uk>
	<CAKnu2MrUkY2upFh5d6GGTNUr-=r_JKcxh5OQNV63bdOCa4F+zg@mail.gmail.com>
	<4E9BF8D9.8030301@cam.ac.uk>
Date: Mon, 17 Oct 2011 15:55:05 +0200
Message-ID: <CACRpkdaEUndv=-1hkKghx7BuOQFfHKONq0n86M+v=fTms3L04g@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, zdevai@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 17, 2011 at 11:43 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:

> Thanks for this Linus. It is more or less where I was heading with one
> exception. =A0I was going to link whole physical devices whereas I think
> you are proposing linking individual channels.

That's for the usecases I have at hand, I don't know which is more
common: grab the entire device and pick a few channels or grab
a single channel. I was thinking the latter would be most common
for in-kernel use.

If you need some inspiring code for how to handle registration of
mapping tables etc you can look at the API I'm pushing for the
pin control subsystem:
http://marc.info/?l=3Dlinux-kernel&m=3D131850357826490&w=3D2

> For the adc channel I'm not particularly keen on insisting every device
> have a unique name for every channel. =A0That breaks the effort we went t=
o
> in IIO to enforce consistent naming (for userspace interfaces) in the fir=
st
> place. =A0To my mind it should never be anything other than a number.

Doesn't feel like a big issue, plain numbers are fine for me.

I was more thinking along the line that in an embedded system an
on-system-in-chip GPADC sure has specific set-in-stone uses for
each channel, i.e. the pin it connects to is hardwired somewhere,
like channel 0 is "battery-voltage", pin 1 is "battery-temperature"
etc, which makes string descriptions make sense.

It doesn't make sense for an ADC card with 100 ADC:s for random
measurements, of course.

> struct adc_map {
> /* Input / output side */
> =A0 =A0 =A0 =A0struct device *adc_dev;
> =A0 =A0 =A0 =A0const char *adc_dev_name;
> =A0 =A0 =A0 =A0int channel_number;
> /* User side */
> =A0 =A0 =A0 =A0const char *channel;
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0const char *dev_name;
> };

OK that makes sense.

> Anyhow, I'll have a go at implementing this over the next few days. =A0Be=
fore I
> do that I am going to push out the proposal to move the core IIO infrastr=
ucture
> out of staging.

Good, my gut feeling is that right now it hurts the kernel more to
have IIO in staging than it could ever hurt it to have it in drivers/,
it is getting badly needed.

Yours,
Linus Walleij
