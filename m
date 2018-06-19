Return-Path: <m.othacehe@gmail.com>
References: <87a7snd8r7.fsf@gmail.com> <876037dc4f.fsf@gmail.com> <20180603153833.0710bc03@archlinux> <87o9gpbkpc.fsf@gmail.com> <20180610142909.278028c5@archlinux> <87wov5id5w.fsf@gmail.com> <20180616181355.769b990e@archlinux>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, "pierre-moana.levesque\@parrot.com" <pierre-moana.levesque@parrot.com>
Subject: Re: isl29501 and multiple calibration registers
In-reply-to: <20180616181355.769b990e@archlinux>
Date: Tue, 19 Jun 2018 12:24:48 +0200
Message-ID: <87k1qvhy4v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Hi Jonathan,

> I'm not really keen on doing that (as hardware gain has a well defined
> different meaning).  This is a rather opaque device specific value.

Ok, I'll keep it as an extended field then.

> This is interesting as it's specifically documented as requiring no external
> actions.  Oh well, another clear datasheet.

:)

> You are welcome, this is a fiddly device!  Sane hardware would store
> all these in on chip flash, but I guess it's a cost thing to not do so.

I sent a patch with the updated documentation and the driver
itself. Note that I left the read/write of float values as TODO
(returning -EINVAL when asked for).

This way I hope we can keep reviewing this driver, will trying to find
the best way to deal with those annoying floating numbers.

Thanks,

Mathieu

(I cc'd Pierre-Moana who is working with me on this driver)
