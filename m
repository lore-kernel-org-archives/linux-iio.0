Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16786 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbdI2Rqa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Sep 2017 13:46:30 -0400
Message-ID: <1506707189.3098.5.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/8] iio: accel: kxcjk1003: support Kionix KXTF9
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Fri, 29 Sep 2017 10:46:29 -0700
In-Reply-To: <20170924160502.22767fa4@archlinux>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
         <20170924160502.22767fa4@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-09-24 at 16:05 +0100, Jonathan Cameron wrote:
> On Sun, 17 Sep 2017 17:00:59 +0200
> Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> 
> > This series adds support for KXTF9 accelerometer. It is mostly
> > compatible
> > to KXCJK, but replaces motion direction interrupt with tap
> > detection
> > (not supported in this implementation, yet).
> > 
> > First 4 patches are refactorings with no outside-visible effects.
> > Patch 5 fixes sysfs attribute name of sampling_frequency_avail
> > 	to match sampling_frequency attribute it describes.
> > Patch 6 adds support for KXTF9 accelerometers.
> > Patch 7 drops -1013 suffix from driver name.
> > 
> 
> I'm more or less happy with the first 6 patches, but would like to
> leave
> time from Srinivas to have a chance to look at them.
> 
Although I can't test the first 6 pages looks fine to me.

Thanks,
Srinivas

> Give me a bump if I seem to have forgotten them in a week or so.
> We are still fairly early in this cycle, so not too much of a rush
> thankfully.
> 
> Jonathan
> 
> > ---
> > v3:
> > 	- renamed samp_freq_avail[]
> > 	- dropped direction bits rename
> > 	- added driver rename
> > 	- rebased against v4.14-rc1
> > v2:
> > 	- removed register renaming
> > 	- split report_motion_event() patch
> > ---
> > 
> > Michał Mirosław (8):
> >   iio: accel: kxcjk1003: refactor ODR setting
> >   iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
> >   iio: accel: kxcjk1013: extract report_motion_event() from
> > interrupt
> >     handler
> >   iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail
> > dynamic
> >   iio: accel: kxcjk1013: make sampling_frequency_avail per-type
> >   iio: accel: kxcjk1013: add support for KXTF9
> >   iio: accel: kxcjk1013: remove unused platform data struct
> >   iio: accel: kxcjk1013: drop variation number from driver's name
> > 
> >  drivers/iio/accel/Kconfig            |    9 +-
> >  drivers/iio/accel/Makefile           |    2 +-
> >  drivers/iio/accel/kxcjk-1013.c       | 1426 ----------------------
> > ----------
> >  drivers/iio/accel/kxcjk.c            | 1514
> > ++++++++++++++++++++++++++++++++++
> >  include/linux/iio/accel/kxcjk_1013.h |   22 -
> >  5 files changed, 1519 insertions(+), 1454 deletions(-)
> >  delete mode 100644 drivers/iio/accel/kxcjk-1013.c
> >  create mode 100644 drivers/iio/accel/kxcjk.c
> >  delete mode 100644 include/linux/iio/accel/kxcjk_1013.h
> > 
> 
> 
