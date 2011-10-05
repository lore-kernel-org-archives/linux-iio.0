Return-Path: <groeck@ericsson.com>
Date: Wed, 5 Oct 2011 03:29:36 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Device-drivers-devel@blackfin.uclinux.org" <Device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] staging:iio:adc:ad7314 removal. Supported via hwmon.
Message-ID: <20111005102936.GA15283@ericsson.com>
References: <1317378054-9511-1-git-send-email-jic23@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D59177146E7343656@LIMKCMBX1.ad.analog.com>
 <20111005094009.GA14989@ericsson.com>
 <4E8C2C54.2060605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4E8C2C54.2060605@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 05, 2011 at 06:07:16AM -0400, Jonathan Cameron wrote:
> On 10/05/11 10:40, Guenter Roeck wrote:
> > On Wed, Oct 05, 2011 at 04:39:01AM -0400, Hennerich, Michael wrote:
> >> Jonathan Cameron wrote on 2011-09-30:
> >>> Driver ported over to hwmon where it fits much better.
> >>>
> >>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> >>
> >> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >>> ---
> >>> Technically there is a slight loss of functionality in the hwmon
> >>> driver (no power down mode).
> >>>
> >>> Otherwise, lets clear this one out.
> >>>
> >>> 3 more to go on my removal list ;)
> >>> adt7310, adt7410 and adt75.
> >>>
> > 
> > Just noticed this part. ADT75 is the Analog version of LM75. 
> > Any reason not to use the standard LM75 driver instead ?
> Fine by me!  I didn't realise that was the case.  Thanks for pointing it
> out.
> 
> Michael, are you happy with simply adding the id to the lm75 driver and
> dropping the iio one?  I can always do the actual patches if that helps.

LM75 / ADT75 does not have an ID register, unfortunately. The code uses some kind 
of heuristics to detect it. Someone will have to test if the LM75 driver works;
if not, we'll have to come up with a mechanism to detect ADT75. I requested samples, 
but it looks like I asked for too many lately and could only get ADT75A, not ADT75B.
I hope there are no register differences between the variants.

> > 
> > On a side note, the iio adt75 driver won't work properly if oneshot is configured.
> > I'll leave it to the readers to figure out why ;).
> I dread to think, these few are a mess.
> 
> > 
> > Regarding the power down mode, shouldn't this be supported using the standard 
> > suspend/resume API with CONFIG_PM ? Or does iio have a parallel mechanism ?
> It's more a case of run time power management.  Suspend support should indeed
> be in there, but typically people want to shut these chips down if no one cares
> about them, not just on suspend. Now we can apply heuristics (no one has
> buffered access open, and any sysfs read is slow enough to bring the chip up
> from powerdown anyway).  Normally that sort of stuff is a little fiddly so we

Hmmm ... not true for ADT75, really. Per datasheet, the chip takes 1.7ms to come out
of shutdown and then requires another 60ms for a conversion (hint, hint, for the oneshot
problem suggested above). sysfs may be slow, but it is not _that_ slow.

Thanks,
Guenter
