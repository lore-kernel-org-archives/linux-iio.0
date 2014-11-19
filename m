Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 19 Nov 2014 09:31:35 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
    mranostay@gmail.com
Subject: Re: [PATCH 0/2] iio: driver for Semtech SX9500
In-Reply-To: <546BC450.7000000@kernel.org>
Message-ID: <alpine.DEB.2.02.1411190919000.28661@pmeerw.net>
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com> <alpine.DEB.2.02.1411171622140.3424@pmeerw.net> <546BC201.10405@kernel.org> <546BC450.7000000@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hi,

> >>> The device does not estimate distance, it only outputs a single bit which
> >>> indicates proximity.  We use 0 to mean that an object is close and 1 otherwise,
> >>> sort of an uncalibrated distance.  From what I understand in the ABI
> >>> specification, this is allowed.
> >>
> >> perhaps the input subsystem would be a better fit for this driver/device?
> >> what is it typically used for?
> >>
> >> regards, p.
> >>
> > Hi Peter,
> > 
> > Whilst it may be the case that this particular one might have a reasonable
> > home in input, these are often integrated with ambient light sensors
> > and as such we already have a quite a few proximity sensors in IIO...
> > 
> > Interestingly there is one obvious proximity sensor in input and that
> > is a dual ambient light/ proximity part though I can't see any way
> > of reading the light side of it.  Interesting...
> Note that, given it describes itself as a button trip I can entirely see
> your point with this one!  I wrote my reply before opening the datasheet.
> oops.
> 
> The device does seem to provide access to measurements related to
> the capacitance sensed so might be rather more flexible than just
> a button though.

yes, it depends what you want to use it for
if there is some aspect of measurement I think it has a place in IIO

the chip can report proximity values (reg. 0x21)

the proposed driver just seems to be targetted at realizing a button...

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
