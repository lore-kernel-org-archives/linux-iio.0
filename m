Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7F5BB3.8060504@iis.fraunhofer.de>
Date: Thu, 02 Sep 2010 10:09:23 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] Trivial fixes
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------020505000001070503020004"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020505000001070503020004
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id KAA07443

Fairly good patches, you can add my signed-off.

Am 01.09.2010 16:57, schrieb Jonathan Cameron:
> Hi All,
>
> This is a pretty simple clean up set.  Mostly removes
> some dead code in various places and cleans up the documentation
> somewhat.
>
> Please take a quick look.
>
> Jonathan
>
> Jonathan Cameron (9):
>    staging:iio: convert idr to ida as pointer never provided
>    staging:iio: simplify logic in iio_interrupt_handler
>    staging:iio: unecessary header removal and kernel doc clean up
>    staging:iio: Remove long dead function definitions from headers
>    staging:iio: Remove deprecated ATTR_TEMP in favour of ATTR_TEMP_RAW
>    staging:iio: Make use of the convenient IIO_TRIGGER_NAME_ATTR macro
>    staging:iio: remove odd structure definition.
>    staging:iio: lis3l02dqbuffersimple.c bring example up to date.
>    staging:iio:documentation - partial update to make more of it true.
>
>   .../iio/Documentation/lis3l02dqbuffersimple.c      |    4 +-
>   drivers/staging/iio/Documentation/overview.txt     |   17 ++--
>   .../{sysfs-class-iio =3D>  sysfs-bus-iio}             |    0
>   drivers/staging/iio/Documentation/userspace.txt    |   54 +----------=
--
>   drivers/staging/iio/accel/adis16209_core.c         |    4 +-
>   drivers/staging/iio/accel/adis16209_trigger.c      |    2 +-
>   drivers/staging/iio/accel/adis16240_trigger.c      |    2 +-
>   drivers/staging/iio/accel/lis3l02dq_ring.c         |    3 +-
>   drivers/staging/iio/chrdev.h                       |    2 -
>   drivers/staging/iio/gyro/adis16260_trigger.c       |    2 +-
>   drivers/staging/iio/iio.h                          |    8 +-
>   drivers/staging/iio/imu/adis16300_trigger.c        |    2 +-
>   drivers/staging/iio/imu/adis16350_trigger.c        |    2 +-
>   drivers/staging/iio/imu/adis16400_trigger.c        |    2 +-
>   drivers/staging/iio/industrialio-core.c            |   76 ++++++++---=
-------
>   drivers/staging/iio/industrialio-ring.c            |   11 +--
>   drivers/staging/iio/ring_generic.h                 |   69 +++++++++++=
+++--
>   drivers/staging/iio/sysfs.h                        |   83 -----------=
---------
>   drivers/staging/iio/trigger.h                      |    6 +-
>   drivers/staging/iio/trigger/iio-trig-gpio.c        |    2 +-
>   .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   12 +---
>   21 files changed, 127 insertions(+), 236 deletions(-)
>   rename drivers/staging/iio/Documentation/{sysfs-class-iio =3D>  sysfs=
-bus-iio} (100%)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------020505000001070503020004
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------020505000001070503020004--
