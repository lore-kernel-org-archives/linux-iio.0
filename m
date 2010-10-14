Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39847 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0JNTlc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2010 15:41:32 -0400
Message-ID: <4CB75E48.2050901@cam.ac.uk>
Date: Thu, 14 Oct 2010 20:47:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: linux-iio@vger.kernel.org, matthias <mensch0815@googlemail.com>
Subject: Re: [RFC 1/2] iio - add support for digital barometer devices
References: <4CB745C8.4050804@gmail.com>
In-Reply-To: <4CB745C8.4050804@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/10 19:02, Matthias Brugger wrote:
> ---
>  drivers/staging/iio/Kconfig            |    1 +
>  drivers/staging/iio/Makefile           |    1 +
>  drivers/staging/iio/barometer/Kconfig  |    5 +++++
>  drivers/staging/iio/barometer/Makefile |    4 ++++
>  drivers/staging/iio/barometer/baro.h   |    8 ++++++++
>  5 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/barometer/Kconfig
>  create mode 100644 drivers/staging/iio/barometer/Makefile
>  create mode 100644 drivers/staging/iio/barometer/baro.h
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index ed48815..d5ca09a 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -46,6 +46,7 @@ source "drivers/staging/iio/gyro/Kconfig"
>  source "drivers/staging/iio/imu/Kconfig"
>  source "drivers/staging/iio/light/Kconfig"
>  source "drivers/staging/iio/magnetometer/Kconfig"
> +source "drivers/staging/iio/barometer/Kconfig"
>  
>  source "drivers/staging/iio/trigger/Kconfig"
>  
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index e909674..73112b2 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -16,3 +16,4 @@ obj-y += imu/
>  obj-y += light/
>  obj-y += trigger/
>  obj-y += magnetometer/
> +obj-y += barometer/

One for me to fix, but we should probably put these in alphabetical order.  Tends to make
for fewer merge conflicts than adding new ones at the end.
> diff --git a/drivers/staging/iio/barometer/Kconfig b/drivers/staging/iio/barometer/Kconfig
> new file mode 100644
> index 0000000..588325c
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/Kconfig
> @@ -0,0 +1,5 @@
> +#
> +# IIO Digital Barometer Sensor drivers configuration
> +#
> +comment "Digital barometer sensors"
> +
> diff --git a/drivers/staging/iio/barometer/Makefile b/drivers/staging/iio/barometer/Makefile
> new file mode 100644
> index 0000000..2963d72
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/Makefile
> @@ -0,0 +1,4 @@
> +#
> +# Makefile for digital gyroscope sensor drivers
You are going to want to change that comment :)
> +#
> +
> diff --git a/drivers/staging/iio/barometer/baro.h b/drivers/staging/iio/barometer/baro.h
> new file mode 100644
> index 0000000..e3b73a1
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/baro.h
> @@ -0,0 +1,8 @@
> +
> +#include "../sysfs.h"
> +
> +/* Barometer types of attribute */
> +
> +#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
> +	IIO_DEVICE_ATTR(baro_pressure, _mode, _show, NULL, _addr)
> +
It think I recall the fact that Kconfig has issues with empty Makefiles,
so this will need to be merged into your second patch.  This stuff always
goes in with the first driver to need it.

