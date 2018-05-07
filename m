Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbeEGRRT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 May 2018 13:17:19 -0400
Date: Mon, 7 May 2018 18:17:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
Message-ID: <20180507181714.34760596@archlinux>
In-Reply-To: <c9d22ad5-ba57-486a-fad9-7e1260dc2b62@metafoo.de>
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
        <20180506183745.325e67b8@archlinux>
        <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
        <c9d22ad5-ba57-486a-fad9-7e1260dc2b62@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 7 May 2018 18:55:16 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 05/07/2018 06:44 PM, Lars-Peter Clausen wrote:
> > On 05/06/2018 07:37 PM, Jonathan Cameron wrote:  
> >> On Sun,  6 May 2018 15:30:47 +0200
> >> Michael Trimarchi <michael@amarulasolutions.com> wrote:
> >>  
> >>> The following functions are supported:
> >>> - write, read potentiometer value
> >>>
> >>> Value are exported in DBm because it's used as an audio
> >>> attenuator  
> >>
> >> This is interesting.  The problem is that there is no way for
> >> userspace to know that it is reporting in DBm rather than
> >> reporting a linear gain or a straight forward resistance.
> >>
> >> This is rather closer in operation to the analog front end
> >> driver I took the other day than to the other potentiometers
> >> we have drivers for.
> >>
> >> Anyhow, how to solve this?  Two options come to mind.
> >> 1) Look up table mapping to linear gain as per current ABI
> >> 2) Add a new channel type to represent the fact we are
> >> looking at a logarithmic value, letting us handle it as DB.  
> > 
> > Yeah, I guess it is a bit difficult. I don't think this should be a separate
> > type since we are still describing the same thing, just the scale is
> > logarithmic rather than linear. Translation table doesn't work either since
> > your values would get ridiculous small/large. We could add a db suffix to
> > the type, but that's just terrible. I guess the best we can do is have a
> > scale attribute that says 1dB.  
> 
> The other problem of course is that dB is a relative unit. The ratio of one
> value to another. Whereas our normal scale refers to an absolute value.
I'm really not keen on this.  We have done the separate types
for humidity already, where we had relative (which is a ratio) and absolute
(which isn't).  It's not pretty though.

Potentially we could define a new attribute that says this one is
is db or linear but that's ugly too.

As you asked, are we looking at a part that gets used for anything other
than audio or not?  If just audio, alsa driver does indeed make more sense.

Jonathan
