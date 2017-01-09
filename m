Return-Path: <SRS0=U25M=YX=gmail.com=k.matthias12@kernel.org>
MIME-Version: 1.0
Sender: k.matthias12@gmail.com
In-Reply-To: <fa3259c5-d76b-bc93-e517-054ef249a861@kernel.org>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
 <alpine.DEB.2.02.1612201144140.4422@pmeerw.net> <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
 <alpine.DEB.2.02.1612201720550.9386@pmeerw.net> <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
 <fa3259c5-d76b-bc93-e517-054ef249a861@kernel.org>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Mon, 9 Jan 2017 02:59:11 +0100
Message-ID: <CAKNHny-OvwLC9c3tvyiyd7F+89QUAtkYEk2Va0JHEzgGGjPVWg@mail.gmail.com>
Subject: Re: Problems with using IIO buffers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-12-30 19:34 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> [...]
> Just to check.
>
> Triggering is per 'scan'. It's perhaps closer to the trigger on a camera
> that than on an oscilloscope if that helps.

Right... I am not yet sure if this is the thing I need to do to
acquire data quickly, but from looking at the other DAQ drivers it
seems to be.

> Are you firing the trigger multiple times?

Usually only once, but even then I should get data, right?

> It sounds like you are refilling the buffer in your driver so possibly
> we are looking at different problems in the two cases?

The problem is that I can't even make the iio_dummy driver work
properly, so even if there is a bug in my driver, the dummy driver at
least should work.
When using my actual driver, firing a trigger doesn't seem to run a scan at all.

> Perhaps post an RFC of your driver for us to take a look at?

I could certainly do that, maybe tomorrow - but I suppose there is a
more general issue with this, if I can't even get the iio_dummy driver
to work with the tools provided by libiio and the kernel userspace
tools. (It still feels a bit like I am missing some obvious
information...)

> Let us know if you got this sorted. I've been rather snowed under and
> out of touch for the last few weeks!

Thanks, I'll do - I am still out of ideas though - but maybe when I
look at this again tomorrow (after two weeks of not thinking about it)
I'll notice some obvious mistake ;-) (although that's probably
unlikely).

 --- Matthias
