Return-Path: <lars@metafoo.de>
Message-ID: <5650B4C5.2050803@metafoo.de>
Date: Sat, 21 Nov 2015 19:15:33 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>, jic23@kernel.org
CC: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
 octavian.purdila@intel.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Move IIO Dummy Driver out of staging
References: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com>
In-Reply-To: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/09/2015 03:31 PM, Cristina Opriceana wrote:
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 6d5b38d..85de198 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -17,32 +17,32 @@ source "drivers/staging/iio/meter/Kconfig"
>  source "drivers/staging/iio/resolver/Kconfig"
>  source "drivers/staging/iio/trigger/Kconfig"
>  
> -config IIO_DUMMY_EVGEN
> -       tristate
> -
> -config IIO_SIMPLE_DUMMY
> -       tristate "An example driver with no hardware requirements"
> -       help
> -	 Driver intended mainly as documentation for how to write
> -	 a driver. May also be useful for testing userspace code
> -	 without hardware.
> -
> -if IIO_SIMPLE_DUMMY
> -
> -config IIO_SIMPLE_DUMMY_EVENTS
> -       bool "Event generation support"
> -       select IIO_DUMMY_EVGEN
> -       help
> -         Add some dummy events to the simple dummy driver.
> -
> -config IIO_SIMPLE_DUMMY_BUFFER
> -	bool "Buffered capture support"
> -	select IIO_BUFFER
> -	select IIO_TRIGGER
> -	select IIO_KFIFO_BUF
> -	help
> -	  Add buffered data capture to the simple dummy driver.
> -
> -endif # IIO_SIMPLE_DUMMY
> +#config IIO_DUMMY_EVGEN
> +#       tristate
> +#
> +#config IIO_SIMPLE_DUMMY
> +#       tristate "An example driver with no hardware requirements"
> +#       help
> +#	 Driver intended mainly as documentation for how to write
> +#	 a driver. May also be useful for testing userspace code
> +#	 without hardware.
> +
> +#if IIO_SIMPLE_DUMMY
> +
> +#config IIO_SIMPLE_DUMMY_EVENTS
> +#       bool "Event generation support"
> +#       select IIO_DUMMY_EVGEN
> +#      help
> +#        Add some dummy events to the simple dummy driver.
> +
> +#config IIO_SIMPLE_DUMMY_BUFFER
> +#	bool "Buffered capture support"
> +#	select IIO_BUFFER
> +# select IIO_TRIGGER
> +#	select IIO_KFIFO_BUF
> +#	help
> +#	  Add buffered data capture to the simple dummy driver.

Any particular reason why those where commented out rather than removed?
