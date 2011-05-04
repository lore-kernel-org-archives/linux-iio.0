Return-Path: <amit.kucheria@verdurent.com>
MIME-Version: 1.0
In-Reply-To: <4DC11E71.4050407@cam.ac.uk>
References: <4DC11E71.4050407@cam.ac.uk>
Date: Wed, 4 May 2011 15:08:46 +0300
Message-ID: <BANLkTikWLJoqYiEAAsYM-mw4ufGbrDLhvw@mail.gmail.com>
Subject: Re: RFC small change to tsl2563 event interface.
From: Amit Kucheria <amit.kucheria@verdurent.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 4, 2011 at 12:37 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Hi Amit,
>
> As part of moving to an registration of IIO channels through
> a table of iio_chan_spec structures, I'm proposing to make
> a small change to the event interface for the tsl2563 driver.
>
> Currently it has
>
> =A0intensity0_both_thresh_en as a single sysfs attr enabling both
> rising and falling attributes (which have separate value attributes).
>
> I propose changing this to a pair of attrs which are interlinked
> (e.g. change one and you'll change the other - our interface
> spec has always allowed this as it's vital in more complex
> interlinked event cases).
>
> intensity0_both_thresh_falling_en =A0 =A0 intensity0_both_thresh_rising_e=
n
>
> It removes a fiddly special case (which I haven't figured out how to
> do!) from the core code.
>
> Any objections to this?
>

No real objections.

Cheers,
Amit
