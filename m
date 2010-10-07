Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56164 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab0JGVnl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Oct 2010 17:43:41 -0400
Date: Thu, 7 Oct 2010 14:41:37 -0700
From: Greg KH <greg@kroah.com>
To: rklein@nvidia.com
Cc: jic23@cam.ac.uk, joe@perches.com, achew@nvidia.com, olof@lixom.net,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, ldewangan@nvidia.com
Subject: Re: [PATCH v5] staging: iio: light: Adding driver for ISL29018 ALS
Message-ID: <20101007214137.GA9269@kroah.com>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 07, 2010 at 12:48:03PM -0700, rklein@nvidia.com wrote:
> From: Rhyland Klein <rklein@nvidia.com>
>=20
> adding support for the ISL 29018 ambient light and proximity sensor.
>=20
> Addressed comments from reviews by Jonathan Cameron and Joe Perches
>   * Removed some excess dbg prints that only printed function name
>   * Renamed some properties to make them more descriptive
>   * Added a property to list available adc resolutions
>   * Defined arrays for resolutions/ranges as static const
>   * Change loops initialization to memset for extensibility.
>     * used sizeof() instead of ARRAY_SIZE() to be safer
>   * Added a property to list available adc ranges
>=20
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Too bad no one actually compiled this driver:
  CC [M]  drivers/staging/iio/light/isl29018.o
drivers/staging/iio/light/isl29018.c:420:8: error: =E2=80=98show_prox_i=
nfrared_suppression=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c:433:1: error: =E2=80=98iio_dev_att=
r_range_available=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c:435:1: error: =E2=80=98iio_dev_att=
r_adc_resolution_available=E2=80=99 undeclared here (not in a function)
drivers/staging/iio/light/isl29018.c: In function =E2=80=98isl29018_chi=
p_init=E2=80=99:
drivers/staging/iio/light/isl29018.c:451:6: warning: unused variable =E2=
=80=98i=E2=80=99
drivers/staging/iio/light/isl29018.c: At top level:
drivers/staging/iio/light/isl29018.c:350:16: warning: =E2=80=98show_pro=
x_infrared_supression=E2=80=99 defined but not used
drivers/staging/iio/light/isl29018.c:416:1: warning: =E2=80=98iio_const=
_attr_range_available=E2=80=99 defined but not used
drivers/staging/iio/light/isl29018.c:417:1: warning: =E2=80=98iio_const=
_attr_adc_resolution_available=E2=80=99 defined but not used
make[2]: *** [drivers/staging/iio/light/isl29018.o] Error 1
make[1]: *** [drivers/staging/iio/light] Error 2
make: *** [_module_drivers/staging/iio] Error 2

Please fix this up before resending it.

thanks,

greg k-h
