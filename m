Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 9 Feb 2012 10:10:56 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, guenter.roeck@ericsson.com,
	khali@linux-fr.org, dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20120209181056.GA957@kroah.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-2-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327837614-24176-2-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Lifted from proposal for in kernel interface built on the out of staging
> branch.
> 
> Two elements here:
> * Map as defined in "inkern.h"
> * Matching code to actually get the iio_dev and channel
> that we want from the global list of IIO devices.
> 
> V2: As per Greg KH suggestion, move over to registration by passing
> the tables into the provider drivers (how regulator does it).
> This does not prevent us using the original more flexible approach
> if at a later date there is a usecase that demands it.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Kconfig             |    7 +-
>  drivers/staging/iio/Makefile            |    2 +-
>  drivers/staging/iio/consumer.h          |  103 +++++++++++++
>  drivers/staging/iio/driver.h            |   34 ++++
>  drivers/staging/iio/iio_core.h          |    3 +
>  drivers/staging/iio/industrialio-core.c |    2 +-
>  drivers/staging/iio/inkern.c            |  256 +++++++++++++++++++++++++++++++
>  drivers/staging/iio/machine.h           |   30 ++++
>  8 files changed, 434 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 90162aa..65c2a8e 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -10,8 +10,14 @@ menuconfig IIO
>  	  drivers for many different types of embedded sensors using a
>  	  number of different physical interfaces (i2c, spi, etc). See
>  	  drivers/staging/iio/Documentation for more information.
> +
>  if IIO
>  
> +config IIO_INKERN
> +	bool "In kernel support for IIO"
> +	help
> +	  Support in kernel users of IIO device drivers.

Of course you want this, all of the code in the kernel.org tree is "in
kernel users" :)

Seriously, I still fail to understand what is so special here that makes
this a totally different design pattern from all other busses,
especially when you aren't even a bus at all, but rather a "interface"
to userspace for different device types.

Why can't a driver just depend on this interface type, like all other
interface types are, that way the built-in vs. as-a-module issues are
all handled "automagically" by the config and build system.

confused,

greg k-h
