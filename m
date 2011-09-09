Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 9 Sep 2011 12:49:46 +0100
Subject: RE: [PATCH] staging:iio:tree wide.  abi fixup for in_ out_ prefix
 introduction.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7118EBF@LIMKCMBX1.ad.analog.com>
References: <1315568739-6752-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1315568739-6752-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-09:
> This patch set should bring all the attributes created outside
> of chan_spec registration inline with the new abi.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/accel/adis16204_core.c      |   12 ++--
>  drivers/staging/iio/accel/adis16240_core.c      |    4 +-
>  drivers/staging/iio/accel/sca3000_core.c        |   10 ++--
>  drivers/staging/iio/accel/sca3000_ring.c        |    4 +-
>  drivers/staging/iio/adc/ad7192.c                |    9 ++--
>  drivers/staging/iio/adc/ad7280a.c               |   12 ++--
>  drivers/staging/iio/adc/ad7745.c                |   36 +++++++-------
>  drivers/staging/iio/adc/ad799x_core.c           |   60 +++++++++++----
>  ------- drivers/staging/iio/dac/ad5446.c                |   26
>  +++++----- drivers/staging/iio/dac/ad5504.c                |   43
>  ++++++++------- - drivers/staging/iio/dac/ad5624r_spi.c           |
>  30 ++++++------ drivers/staging/iio/dac/ad5686.c                |   30
>  ++++++----- drivers/staging/iio/dac/dac.h                   |    2 +-
>  drivers/staging/iio/dac/max517.c                |   25 +++++----
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   32 ++++++------
>  drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
>  drivers/staging/iio/meter/ade7753.c             |   10 ++--
>  drivers/staging/iio/meter/ade7754.c             |   10 ++--
>  drivers/staging/iio/meter/ade7758_core.c        |   10 ++--
>  drivers/staging/iio/meter/ade7759.c             |   10 ++--
>  drivers/staging/iio/sysfs.h                     |    6 +- 21 files
>  changed, 196 insertions(+), 189 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
