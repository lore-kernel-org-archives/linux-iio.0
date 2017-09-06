Return-Path: <SRS0=FH5O=AH=linux.intel.com=srinivas.pandruvada@kernel.org>
Message-ID: <1504710618.83811.158.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/7] iio: accel: kxcjk1003: support Kionix KXTF9
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?=
	 <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler
	 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Date: Wed, 06 Sep 2017 08:10:18 -0700
In-Reply-To: <20170903124335.19dcb386@archlinux>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
	 <20170903124335.19dcb386@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-09-03 at 12:43 +0100, Jonathan Cameron wrote:
> On Tue, 22 Aug 2017 00:03:29 +0200
> Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> 
> > 
> > This series adds support for KXTF9 accelerometer. It is mostly
> > compatible
> > to KXCJK, but replaces motion direction interrupt with tap
> > detection
> > (not supported in this implementation, yet).
> > 
> > First 5 patches are refactorings with no outside-visible effects.
> > Patch 6 fixes sysfs attribute name of sampling_frequency_avail
> > to match sampling_frequency attribute it describes.
> > Patch 7 finally adds support for KXTF9 accelerometers.
> 
> Cc'd Srinivas (original author of this driver - should really have
> been cc'd
> from the start).
Michal, if you update series, please copy me.

> 
> Michał: I'm assuming you don't have the parts already supported by
> the driver?
> 
> Srinivas: Are you likely to get time to take a quick look at this
> series any
> time in the next few weeks?
I will look either this week or next week.

> 
> Even better if you still have test hardware to check nothing broke on
> the
> original supported parts (not to worry if not!)
I don't, but will check around.

Thanks,
Srinivas




> We are past the point where these are going to make the coming merge
> window
> anyway so have plenty of time.
> 
> Thanks,
> 
> Jonathan
> 
> p.s. If anyone else has the parts already supported by this driver
> and
> can give the changes a quick check that would be great!
> > 
> > 
> > Michał Mirosław (7):
> >   iio: accel: kxcjk1003: refactor ODR setting
> >   iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
> >   iio: accel: kxcjk1013: extract report_motion_event() from
> > interrupt
> >     handler
> >   iio: accel: kxcjk1013: rename motion direction bits
> >   iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail
> > dynamic
> >   iio: accel: kxcjk1013: make sampling_frequency_avail per-type
> >   iio: accel: kxcjk1013: add support for KXTF9
> > 
> >  drivers/iio/accel/Kconfig      |   4 +-
> >  drivers/iio/accel/kxcjk-1013.c | 366 ++++++++++++++++++++++++++---
> > ------------
> >  2 files changed, 235 insertions(+), 135 deletions(-)
> > 
> 
