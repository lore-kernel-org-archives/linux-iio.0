Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Jun 2010 16:16:25 +0800
Message-ID: <AANLkTil0gGAy1qJFPizZyl0AvmUCMLMVOoaXGXXBNzOI@mail.gmail.com>
Subject: Re: [PATCH 0/6] Various cleanups.
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> This patch set is the result of taking a look at Barry Song's
> RFC. =C2=A0The idea was to get the simple uncontroversial elements
> of that in place before we move on to discussion of the more
> involved elements.
Thanks a lot for your great help.  I acked the three patches
abstracted from the discussion.

>
> One or two general cleanups have slipped in here as well.
>
> Jonathan Cameron (6):
> =C2=A0staging:iio: Use kasprintf to allocate and fill trig->name
> =C2=A0staging:iio:lis3l02dq remove unused set_ring_length function
> =C2=A0staging:iio: Add and convert drivers to use iio_alloc_pollfunc
> =C2=A0staging:iio: Add iio_triggered_ring postenable and predisable + use
> =C2=A0 =C2=A0in drivers
> =C2=A0staging:iio: remove timestamp field from trigger and pass instead
> =C2=A0 =C2=A0through pollfuncs
> =C2=A0staging:iio: replace combine_8_to_16 with be16_to_cpup where
> =C2=A0 =C2=A0possible.
>
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/accel/adis16209_trigger.c =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/accel/adis16240_trigger.c =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 53 +++++---------------
> =C2=A0drivers/staging/iio/adc/max1363_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 45 ++---------------
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/gyro/adis16260_trigger.c =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/imu/adis16300_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/imu/adis16350_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 51 ++++---------------
> =C2=A0drivers/staging/iio/imu/adis16400_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 10 ++--
> =C2=A0drivers/staging/iio/industrialio-trigger.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 48 ++++++++++++++----
> =C2=A0drivers/staging/iio/trigger.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 24 ++++++---
> =C2=A0drivers/staging/iio/trigger/iio-trig-gpio.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 12 ++---
> =C2=A0.../staging/iio/trigger/iio-trig-periodic-rtc.c =C2=A0 =C2=A0| =C2=
=A0 15 ++----
> =C2=A018 files changed, 164 insertions(+), 399 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
