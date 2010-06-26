Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C25EDD3.2080503@cam.ac.uk>
Date: Sat, 26 Jun 2010 13:08:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/11] Mixed bag of IIO patches.
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/24/10 22:02, Jonathan Cameron wrote:

As it has been a month, I've sent these on to Greg KH.

Thanks,

Jonathan
> I will probably break these up into a couple of separate series
> at a later date given some are fixes and others extensions
> of drivers.
> 
> The first couple of patces are updated version of various ones
> previously posted ot the list.
> 
> The last couple add event support to tsl2563 and max1363
> (a company who will remain nameless forgot some pull ups
> on their sensor board so I've only recently modified one
> to actually have working interrupt lines for these two parts)
> 
> Technically both these devices support smbus alert but for
> now I'm handling the interrupt as a conventional interrupt
> as I'll need to look at adding smbus alert support to the i2c
> driver in question first.
> (Also note it's rather oddly inverted on the board in question
> so for most people the interrupts are inverted in the driver
> currently.)
> 
> Incidentally if someone wants to see a chip that does everything
> in almost as pathological a way as possible, please have a close
> read of the max1363 data sheet.
> 
> The only change likely to effect other drivers was getting
> rid of the iio_work_cont. It was one of those 'general'
> elements that turned out to not actually occur terribly
> often. I know of no current true users including none in
> the blackfin tree (though last time I checked you had a lot
> of them defined and unused!)
> 
> Jonathan Cameron (11):
>   staging:iio:max1363 use device_id instead of searching on name again
>   staging:iio:max1363 trivial code and comment cleanups.
>   staging:iio:lis3l02dq cleanups
>   staging:iio:kxsd9 remove unnecessary includes
>   staging:iio: Remove used iio_work_cont definition and all references
>   staging:iio: Remove unnecessary event_idr and all references
>   staging:iio: Code cleanups
>   staging:iio: Fix IIO_EVENT_ATTR initialization of list head
>   staging:iio: tsl2563 abi fixes and interrupt handling
>   staging:iio: Add ability to have event attributes with awkward names
>   staging:iio:max1363 add theshold event support
> 
>  drivers/staging/iio/accel/adis16209.h      |    3 -
>  drivers/staging/iio/accel/adis16220.h      |    1 -
>  drivers/staging/iio/accel/adis16240.h      |    2 -
>  drivers/staging/iio/accel/kxsd9.c          |    6 -
>  drivers/staging/iio/accel/lis3l02dq.h      |    4 +-
>  drivers/staging/iio/accel/lis3l02dq_core.c |   25 +-
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    8 -
>  drivers/staging/iio/adc/adc.h              |    3 +
>  drivers/staging/iio/adc/max1363.h          |   46 +-
>  drivers/staging/iio/adc/max1363_core.c     |  854 +++++++++++++++++++++++++---
>  drivers/staging/iio/adc/max1363_ring.c     |   10 +-
>  drivers/staging/iio/chrdev.h               |    3 -
>  drivers/staging/iio/gyro/adis16260.h       |    2 -
>  drivers/staging/iio/iio.h                  |   51 +--
>  drivers/staging/iio/imu/adis16300.h        |    2 -
>  drivers/staging/iio/imu/adis16300_core.c   |    8 -
>  drivers/staging/iio/imu/adis16350.h        |    2 -
>  drivers/staging/iio/imu/adis16400.h        |    2 -
>  drivers/staging/iio/imu/adis16400_core.c   |    8 -
>  drivers/staging/iio/industrialio-core.c    |   22 +-
>  drivers/staging/iio/industrialio-ring.c    |    4 +-
>  drivers/staging/iio/industrialio-trigger.c |    3 +-
>  drivers/staging/iio/light/light.h          |    7 +-
>  drivers/staging/iio/light/tsl2563.c        |  389 ++++++++++---
>  drivers/staging/iio/sysfs.h                |   14 +-
>  25 files changed, 1127 insertions(+), 352 deletions(-)
> 
> 
