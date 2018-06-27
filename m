Return-Path: <m.othacehe@gmail.com>
References: <87a7snd8r7.fsf@gmail.com> <876037dc4f.fsf@gmail.com> <20180603153833.0710bc03@archlinux> <87o9gpbkpc.fsf@gmail.com> <20180610142909.278028c5@archlinux> <87wov5id5w.fsf@gmail.com> <87po0si5z3.fsf@gmail.com> <20180616184626.24789092@archlinux>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: Mostly question of whether we should support floating point values from hardware (was Re: isl29501 and multiple calibration registers)
In-reply-to: <20180616184626.24789092@archlinux>
Date: Wed, 27 Jun 2018 15:43:38 +0200
Message-ID: <87vaa4tkdx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Hi Jonathan,

> https://en.wikipedia.org/wiki/Double-precision_floating-point_format.
>
> So in rough form...
>
> fls('mantissa') will get us the most significant set bit. 
> Shift the mantissa so that falls off the top and add that shift
> to the exponent. 
>
> Poke in the right places in a standard double.

Yes, understood, this way we can format Intersil float representation
(m*2^e) to IEEE754 (1.m*2^e).

> Now this is where it gets even uglier.   IIO assumes 2 32 bit
> parts so we'll need to mash it into those in some reasonable
> (ish) fashion.  The core IIO then needs to pretty print it.

An option would be to add IIO_VAL_DOUBLE format value that would print
ieee754 double in a similar way as '%a' option of glibc' printf
([-]0xh.hhhhp).

A "iio_double_to_int" function would also be needed to parse a user
inputed number under '%a' representation into two 'int' passed to
write_raw.

> Hmm. This looks annoyingly like we may need to do some core
> rework to make val and val2 64 bit relatively soon but I'd
> rather we didn't stall this driver on that.

Yes the splitting would be really ugly as the mantissa on 52 bit will
have to be splitted in two parts, something like:

val: sign | exponent | mantissa (20 most valuable bits)
val2: mantissa (32 last bits)

Or something as dirty as that ...

All of this seems really hacky but would allow user to input big
floating values (that won't fit into val.val2 format with val and val2
on 32 or even 64 bit format).

What do you think ?

Thanks,

Mathieu
