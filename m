Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jonathan Cameron' <jic23@kernel.org>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 'Jonathan Cameron' <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org, 'Dan Carpenter' <dan.carpenter@oracle.com>,
 'Lars-Peter Clausen' <lars@metafoo.de>, Jingoo Han <jg1.han@samsung.com>
References: <007101ce882f$b4fa5c30$1eef1490$@samsung.com>
 <5209421E.7090401@kernel.org>
In-reply-to: <5209421E.7090401@kernel.org>
Subject: Re: [PATCH V2 2/2] staging: iio: replace strict_strto*() with kstrto*()
Date: Tue, 20 Aug 2013 10:54:41 +0900
Message-id: <004a01ce9d48$3c7304a0$b5590de0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

On Tuesday, August 13, 2013 5:14 AM, Jonathan Cameron wrote:
> On 07/24/13 06:36, Jingoo Han wrote:

[.....]

> Sorry it has taken me so long to get to this.  Was obviously going
> to be 'almost' as tedious to review as it would have been to put
> it together :)
> 
> You are brave taking this one as there are a lot of dragons
> hiding in this code.
> 
> In a few cases I'd have been tempted to strtobool warts and all.
> 
> Two choices in adt7316 are too short.
> Unsigned short in ad5933 should be u16 I think (to avoid
> any issues).
> If we are going for minimum length variables, the isl29018 use of
> an unsigned long for a value that at most equals 16 seems excessive.
> (I'm not sure we are aiming for minimal though..)
> Also in that driver, you fill an int with a kstrtouint.

Thank you for your comments. :-)
I agree with your opinions.
I will fix and send v2 patch soon.

Best regards,
Jingoo Han

> ADE7753 plays some evil games in using a signed longs to get the
> variables from userspace, not checking their range at all then writing
> them to a mixture of signed and unsigned 16 bit registers.
> Honestly I'd be tempted to leave that driver alone or trying and persuade
> Lars-Peter to take a look at it.  The datasheet is out there if you are
> feeling brave.
> 
> From a quick look, the ade7754, ade7758, ade7759, ade7854 play the same game.
> 
> > ---
> >  drivers/staging/iio/accel/sca3000_core.c           |    8 ++---
> >  drivers/staging/iio/accel/sca3000_ring.c           |    4 +--
> >  drivers/staging/iio/addac/adt7316.c                |   38 ++++++++++----------
> >  drivers/staging/iio/frequency/ad9832.c             |    4 +--
> >  drivers/staging/iio/frequency/ad9834.c             |    4 +--
> >  drivers/staging/iio/gyro/adis16260_core.c          |    4 +--
> >  drivers/staging/iio/impedance-analyzer/ad5933.c    |   12 +++----
> >  drivers/staging/iio/light/isl29018.c               |   12 +++----
> >  drivers/staging/iio/light/tsl2583.c                |   24 ++++++-------
> >  drivers/staging/iio/meter/ade7753.c                |   12 +++----
> >  drivers/staging/iio/meter/ade7754.c                |   12 +++----
> >  drivers/staging/iio/meter/ade7758_core.c           |   12 +++----
> >  drivers/staging/iio/meter/ade7759.c                |   12 +++----
> >  drivers/staging/iio/meter/ade7854.c                |   16 ++++-----
> >  drivers/staging/iio/resolver/ad2s1210.c            |   20 +++++------
> >  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   23 +++++-------
> >  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 +--
> >  17 files changed, 108 insertions(+), 113 deletions(-)
> >
