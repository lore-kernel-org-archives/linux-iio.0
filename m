Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:55148 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeFPRq3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jun 2018 13:46:29 -0400
Date: Sat, 16 Jun 2018 18:46:26 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Mostly question of whether we should support floating point values
 from hardware (was Re: isl29501 and multiple calibration registers)
Message-ID: <20180616184626.24789092@archlinux>
In-Reply-To: <87po0si5z3.fsf@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
        <876037dc4f.fsf@gmail.com>
        <20180603153833.0710bc03@archlinux>
        <87o9gpbkpc.fsf@gmail.com>
        <20180610142909.278028c5@archlinux>
        <87wov5id5w.fsf@gmail.com>
        <87po0si5z3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 15 Jun 2018 14:34:08 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Hi,
> 
> I have another concern about I and Q representation. The formula given
> by Renesas to put them under decimal form is:
> 
>          (MSB << 8 + LSB) << EXP/100000
> 
> Given that EXP is an unsigned 8 bit integer, the maximum value of I and
> Q is ~2^255 which can only be represented as a double.
> 
> Hence, it is not possible to represent them under in_intensity0_i/q_raw
> even using a scale.
> 
> Same thing for I and Q calibbias (crosstalk values), the user can not
> input such a big number.
> 
> How could we proceed about it, would it be ok to represent those values
> as EXP << 16 + MSB << 8 + LSB both for raw and calibbias values?
No (unless I'm missunderstanding). That will be totally impossible to
interpret in userspace.

Hmm. This is a pain and frankly silly as there is no way the device
is even vaguely accurate over that sort of range.

Anyhow, so what can we do as these have to be combined into one value
to have a consistent interface?

Can we map this sanely to an ieee 64 bit floating point standard?
A bit fiddly given the totally odd way it comes from the device.

So the 100000 bit we can push off to a _scale attribute leaving us
with just (16 bit value) << (8 bit value).

Now standard floating point would need 1.value << (8 bit value) so
we'll need to search for the first set bit and adjust the exponent
as appropriate - hence the annoying need to put this in a double.

We'd still need an in kernel print function for a double but we can
lift that form an appropriately licensed c library - keep it in the
driver for now.

https://en.wikipedia.org/wiki/Double-precision_floating-point_format.

So in rough form...

fls('mantissa') will get us the most significant set bit. 
Shift the mantissa so that falls off the top and add that shift
to the exponent. 

Poke in the right places in a standard double.

Now this is where it gets even uglier.   IIO assumes 2 32 bit
parts so we'll need to mash it into those in some reasonable
(ish) fashion.  The core IIO then needs to pretty print it.

Hmm. This looks annoyingly like we may need to do some core
rework to make val and val2 64 bit relatively soon but I'd
rather we didn't stall this driver on that.

I'd like to hear other peoples inputs on this before we go to far.
Sensible to support floating point or not?

Jonathan


> 
> Thanks,
> 
> Mathieu

