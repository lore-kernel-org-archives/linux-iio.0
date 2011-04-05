Return-Path: <greg@kroah.com>
Date: Tue, 5 Apr 2011 12:21:30 -0700
From: Greg KH <greg@kroah.com>
To: cliff.cai@analog.com
Cc: gregkh@suse.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/2] staging: IIO driver for Analog Devices Digital
 Output Gyroscope ADXRS450
Message-ID: <20110405192130.GA10106@kroah.com>
References: <1301025958-2175-1-git-send-email-cliff.cai@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1301025958-2175-1-git-send-email-cliff.cai@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 25, 2011 at 12:05:57PM +0800, cliff.cai@analog.com wrote:
> From: Cliff Cai <cliff.cai@analog.com>
>=20
> Add new IIO driver for Analog Devices digital output gyroscope ADXRS450
>=20
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

This breaks the build:
  CC [M]  drivers/staging/iio/gyro/adxrs450_core.o
drivers/staging/iio/gyro/adxrs450_core.c:329:70: error: expected =E2=80=98=
)=E2=80=99 before numeric constant
drivers/staging/iio/gyro/adxrs450_core.c:337:3: error: =E2=80=98iio_dev_a=
ttr_gyro_z_quadrature_correction_raw=E2=80=99 undeclared here (not in a f=
unction)
drivers/staging/iio/gyro/adxrs450_core.c:216:16: warning: =E2=80=98adxrs4=
50_read_quad=E2=80=99 defined but not used

Please test your patches before you send them out, it wastes everyone's
time when you don't :(

thanks,

greg k-h
