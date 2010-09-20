Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C977C26.2020602@iis.fraunhofer.de>
Date: Mon, 20 Sep 2010 17:22:14 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH 00/22 V2ish] staging:iio: implement _type (v2) and _index
 for scan elements
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Am 20.09.2010 16:12, schrieb Jonathan Cameron:
> This set combines v2 of the addtion of _type attrs and v1 for that
> of _index attrs.  With both of these present all current buffer data
> layouts are fully described.
>
> The _type attr patches have been updated as per Manuel's suggestion
> (using the variant I posted earlier today for constant _type)
> I have left those drivers with variable formats to specify their
> own functions locally.  These may be worth combining into some core
> functionality in the future.
>
> Manuel, if you are happy can I have your sign off on these
> (as it was your idea!)

Sure, do that!

>
> If anyone at Analog would like to ack the changes to their drivers
> that would be great.  Note that I'm still intending to merge the
> various IMU drivers - obviously those patches will need rebasing.
> They have only been updated here as this is  a relatively
> uncontroversial patch set so I would like to see it go to Greg asap.
>
> Hopefully this is the last time these abi elements will change.
> What we have here works for all drivers I have seen so far.  We
> can extend the _type attribute format to cover more interesting
> cases as and when we see them.
>
> The only remaining general attributes to pin down are the event
> ones.
>
> Thanks,
>
> Jonathan
>
> Jonathan Cameron (22):
>    staging:iio:lis3l02dq add _type attributes for all scan elements
>    staging:iio:max1363 add _type attributes for all scan elements
>    staging:iio:adis16209 add _type attributes for all scan elements
>    staging:iio:adis16240 add _type attributes for all scan elements
>    staging:iio:sca3000 add _type attributes for all scan elements
>    staging:iio:adis16260 add _type attributes for all scan elements
>    staging:iio:adis16300 add _type attributes for all scan elements
>    staging:iio:adis16350 add _type attributes for all scan elements
>    staging:iio:adis16400 add _type attributes for all scan elements
>    staging:iio: Remove unused bit_count from struct iio_scan_el
>    staging:iio: amend macros for SCAN_EL creation to add separate index
>      attr
>    staging:iio:lis3l02dq add _index attribute registration
>    staging:iio:adis16209 add _index attribute registration
>    staging:iio:adis16240 add _index attribute registration
>    staging:iio:adis16260 add _index attribute registration
>    staging:iio:adis16300 add _index attribute registration
>    staging:iio:adis16350 add _index attribute registration
>    staging:iio:adis16400 add _index attribute registration
>    staging:iio:max1363 add _index attribute registration
>    staging:iio:sca3000 add _index attribute registration
>    staging:iio: remove deprecated form of scan_el attribute naming.
>    staging:iio:sysfs abi documentation. Add _type and _index attrs
>
>   drivers/staging/iio/Documentation/sysfs-bus-iio |   40 +++--
>   drivers/staging/iio/accel/adis16209_ring.c      |   45 ++++--
>   drivers/staging/iio/accel/adis16240_ring.c      |   35 +++--
>   drivers/staging/iio/accel/lis3l02dq_ring.c      |   14 ++-
>   drivers/staging/iio/accel/sca3000_ring.c        |   55 +++---
>   drivers/staging/iio/adc/max1363_core.c          |  203 ++++++++++++++=
++-------
>   drivers/staging/iio/gyro/adis16260_ring.c       |   33 +++-
>   drivers/staging/iio/imu/adis16300_ring.c        |   48 ++++--
>   drivers/staging/iio/imu/adis16350_ring.c        |   56 ++++---
>   drivers/staging/iio/imu/adis16400_ring.c        |   63 +++++---
>   drivers/staging/iio/ring_generic.h              |   45 ++++--
>   11 files changed, 424 insertions(+), 213 deletions(-)
>


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de
