Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>, "manuel.stahl@iis.fraunhofer.de"
	<manuel.stahl@iis.fraunhofer.de>
Date: Wed, 13 Jul 2011 12:04:04 +0100
Subject: RE: [PATCH 4/4] staging:iio:imu:adis16400 remove now unused headers.
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713EA0CD0E5D@LIMKCMBX1.ad.analog.com>
References: <1310399887-4049-1-git-send-email-jic23@cam.ac.uk>
 <1310399887-4049-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310399887-4049-5-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-11:
> These should really have gone away with the code that needed them.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/imu/adis16400_ring.c    |    7 -------
>  drivers/staging/iio/imu/adis16400_trigger.c |    6 ------
>  2 files changed, 0 insertions(+), 13 deletions(-)
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c
> b/drivers/staging/iio/imu/adis16400_ring.c index d07c86b..ef38477 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c +++
> b/drivers/staging/iio/imu/adis16400_ring.c @@ -1,18 +1,11 @@
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/gpio.h>
> -#include <linux/workqueue.h>
>  #include <linux/mutex.h> -#include <linux/device.h> #include
>  <linux/kernel.h> #include <linux/spi/spi.h> #include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/bitops.h>
>
>  #include "../iio.h" -#include "../sysfs.h" #include "../ring_sw.h"
>  #include "../trigger.h" #include "adis16400.h"
> diff --git a/drivers/staging/iio/imu/adis16400_trigger.c
> b/drivers/staging/iio/imu/adis16400_trigger.c index 4e1f295..3860d92
> 100644 --- a/drivers/staging/iio/imu/adis16400_trigger.c +++
> b/drivers/staging/iio/imu/adis16400_trigger.c @@ -1,14 +1,8 @@
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/spi/spi.h>
>
>  #include "../iio.h" -#include "../sysfs.h" #include "../trigger.h"
>  #include "adis16400.h"

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
