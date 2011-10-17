Return-Path: <alexander.stein@systec-electronic.com>
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/6] IIO: Core sysfs only support.
Date: Mon, 17 Oct 2011 15:42:23 +0200
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de
References: <1318857381-13787-1-git-send-email-jic23@cam.ac.uk> <1318857381-13787-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318857381-13787-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201110171542.24673.alexander.stein@systec-electronic.com>
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

On Monday 17 October 2011 15:16:16 you wrote:
> Add support for simple sysfs only interfaces.
> 
> Bulk of patch is concerned with taking struct iio_chan_spec
> arrays and generating all the relevant interfaces from them.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/Kconfig           |    2 +
>  drivers/Makefile          |    3 +
>  drivers/iio/Kconfig       |   11 +
>  drivers/iio/Makefile      |    6 +
>  drivers/iio/iio.c         |  591
> +++++++++++++++++++++++++++++++++++++++++++++ include/linux/iio/iio.h   | 
> 250 +++++++++++++++++++
>  include/linux/iio/sysfs.h |   68 +++++
>  7 files changed, 931 insertions(+), 0 deletions(-)
> 
> [...]
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> new file mode 100644
> index 0000000..5d9a97d
> --- /dev/null
> +++ b/drivers/iio/Kconfig
> @@ -0,0 +1,11 @@
> +#
> +# Industrial I/O subsystem
> +#
> +
> +menuconfig IIO
> +	tristate "Industrial I/O support"
> +	depends on GENERIC_HARDIRQS
> +	help
> +	  The Industrial input / output subsystem provides a unified
> +	  framework for many different types of embedded sensor.
> +	  See Documentation/iio for more information.

I don't know much about iio so I want to read about it. But where does 
Documentation/iio come from?

Regards,
Alexander
