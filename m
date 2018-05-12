Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELJpj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 05:45:39 -0400
Date: Sat, 12 May 2018 10:45:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
Message-ID: <20180512104533.7d74aa01@archlinux>
In-Reply-To: <CAOf5uw=KfbgtBRkw4OTk+6oGYFfv4dbh4bM_P9zqPjd1MhjV9Q@mail.gmail.com>
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
        <20180506183745.325e67b8@archlinux>
        <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
        <c9d22ad5-ba57-486a-fad9-7e1260dc2b62@metafoo.de>
        <20180507181714.34760596@archlinux>
        <CAOf5uwkX70XULEAgb_yZVGrCEqvDzZn+o-FV8vAC5ytKvjQc4w@mail.gmail.com>
        <CAOf5uw=KfbgtBRkw4OTk+6oGYFfv4dbh4bM_P9zqPjd1MhjV9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 9 May 2018 11:19:51 +0200
Michael Nazzareno Trimarchi <michael@amarulasolutions.com> wrote:

> Hi Jonathan
> 
> 
> On Wed, May 9, 2018 at 11:01 AM, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> > Hi
> >
> > On Mon, May 7, 2018 at 7:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:  
> >> On Mon, 7 May 2018 18:55:16 +0200
> >> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>  
> >>> On 05/07/2018 06:44 PM, Lars-Peter Clausen wrote:  
> >>> > On 05/06/2018 07:37 PM, Jonathan Cameron wrote:  
> >>> >> On Sun,  6 May 2018 15:30:47 +0200
> >>> >> Michael Trimarchi <michael@amarulasolutions.com> wrote:
> >>> >>  
> >>> >>> The following functions are supported:
> >>> >>> - write, read potentiometer value
> >>> >>>
> >>> >>> Value are exported in DBm because it's used as an audio
> >>> >>> attenuator  
> >>> >>
> >>> >> This is interesting.  The problem is that there is no way for
> >>> >> userspace to know that it is reporting in DBm rather than
> >>> >> reporting a linear gain or a straight forward resistance.
> >>> >>
> >>> >> This is rather closer in operation to the analog front end
> >>> >> driver I took the other day than to the other potentiometers
> >>> >> we have drivers for.
> >>> >>
> >>> >> Anyhow, how to solve this?  Two options come to mind.
> >>> >> 1) Look up table mapping to linear gain as per current ABI
> >>> >> 2) Add a new channel type to represent the fact we are
> >>> >> looking at a logarithmic value, letting us handle it as DB.  
> >>> >
> >>> > Yeah, I guess it is a bit difficult. I don't think this should be a separate
> >>> > type since we are still describing the same thing, just the scale is
> >>> > logarithmic rather than linear. Translation table doesn't work either since
> >>> > your values would get ridiculous small/large. We could add a db suffix to
> >>> > the type, but that's just terrible. I guess the best we can do is have a
> >>> > scale attribute that says 1dB.  
> >>>
> >>> The other problem of course is that dB is a relative unit. The ratio of one
> >>> value to another. Whereas our normal scale refers to an absolute value.  
> >> I'm really not keen on this.  We have done the separate types
> >> for humidity already, where we had relative (which is a ratio) and absolute
> >> (which isn't).  It's not pretty though.
> >>
> >> Potentially we could define a new attribute that says this one is
> >> is db or linear but that's ugly too.
> >>
> >> As you asked, are we looking at a part that gets used for anything other
> >> than audio or not?  If just audio, alsa driver does indeed make more sense.
> >>  
> >
> > This can be used in audio but even in other field. It's just a potentiometer.
> > Can I know what is wrong to use the same approch of audio ampliefier that we
> > have already in the iio tree?
> >  
> 
> cat /sys/bus/iio/devices/iio:device1/out_altvoltage0_hardwaregain
> -10.000000 dB
> echo -10 > /sys/bus/iio/devices/iio:device1/out_altvoltage0_hardwaregain

Wow, somehow that entire thing had slipped my mind.  I guess we went
through the whole question of how to support dB scales years ago
and it has just been very little used.

Hmm. Sorry for my absent mindedness! Anyhow, there are a few additional
comments that need cleaning up.

It is going to be a little odd as the only potentiometer (I think) that
is acting as a scale free attenuator, rather that being controlled on the basis
of resistance, but for the part that seems to make sense so fair enough.

I'm slightly curious to know what you have this wired up to though?
Are the inputs and outputs invisible to the kernel or is this feeding
into another device?

If we are feeding another device then the work recently done on a
generic AFE driver may be useful.  At somepoint we'll need a version
of that which deals with standalone amplifiers and attenuators anyway,
but I don't know if it is useful to you.

Jonathan

Jonathan


> 
> uname -a
> Linux linaro-alip 4.4.93 #7 SMP Sun May 6 13:23:08 CEST 2018 armv7l GNU/Linux
> 
> Michael
> 
> > Michael
> >  
> >> Jonathan  
> >
> >
> >
> > --
> > | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> > | COO  -  Founder                                      Cruquiuskade 47 |
> > | +31(0)851119172                                 Amsterdam 1018 AM NL |
> > |                  [`as] http://www.amarulasolutions.com               |  
> 
> 
> 

