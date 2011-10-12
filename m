Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:17290
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752703Ab1JLMPb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Oct 2011 08:15:31 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "greg@kroah.com" <greg@kroah.com>,
	"rdunlap@xenotime.net" <rdunlap@xenotime.net>
Date: Wed, 12 Oct 2011 13:14:05 +0100
Subject: RE: [PATCH] staging:iio: gpio build dependency fixing
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E750B042@LIMKCMBX1.ad.analog.com>
References: <1318413453-7702-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318413453-7702-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-10-12:
> Numerous drivers either had pointless includes of gpio.h
> or should have been dependent on GENERIC_GPIO and were not.
> Conversion of ads1210 to use array registration triggered
> build failures that highlighted all was not well.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>
> Randy pointed out the issue with ad2s1210 triggered by
> building without GENERIC_GPIO.  This motivated a quick
> use of git grep on all the drivers and this patch fixes
> all cases where there should have been a dependency,
> or where they was and shouldn't have been (be it implied
> by gpio.h includes).
>
> One has to wonder what the point in having stubs for the
> array calls is. I'll post on this point separately shortly.
>
> I have no idea what the sca3000 was checking those gpios
> for. It is probably lost somewhere in history but clearly
> doesn't make sense.
>
> Jonathan
>  drivers/staging/iio/accel/Kconfig          |    1 +
>  drivers/staging/iio/accel/adis16204_core.c |    1 -
>  drivers/staging/iio/accel/sca3000_core.c   |    7 +++----
>  drivers/staging/iio/adc/Kconfig            |    1 +
>  drivers/staging/iio/addac/Kconfig          |    1 +
>  drivers/staging/iio/dac/ad5504.c           |    1 -
>  drivers/staging/iio/dac/ad5624r_spi.c      |    1 -
>  drivers/staging/iio/dac/ad5686.c           |    1 -
>  drivers/staging/iio/dac/ad5791.c           |    1 -
>  drivers/staging/iio/gyro/adis16080_core.c  |    1 -
>  drivers/staging/iio/gyro/adis16260_core.c  |    1 -
>  drivers/staging/iio/gyro/adxrs450_core.c   |    1 -
>  drivers/staging/iio/magnetometer/Kconfig   |    1 +
>  drivers/staging/iio/meter/ade7753.c        |    1 -
>  drivers/staging/iio/meter/ade7754.c        |    1 -
>  drivers/staging/iio/meter/ade7758_core.c   |    1 -
>  drivers/staging/iio/meter/ade7759.c        |    1 -
>  drivers/staging/iio/meter/ade7854.c        |    1 -
>  drivers/staging/iio/resolver/Kconfig       |    2 ++
>  19 files changed, 9 insertions(+), 17 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



