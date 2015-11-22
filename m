Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45194 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbKVMhx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2015 07:37:53 -0500
Subject: Re: [PATCH] staging:iio: Delete some commented out lines in Kconfig
 and Makefile.
To: linux-iio@vger.kernel.org
References: <1448136958-29917-1-git-send-email-jic23@kernel.org>
Cc: cristina.opriceana@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5651B71F.4000101@kernel.org>
Date: Sun, 22 Nov 2015 12:37:51 +0000
MIME-Version: 1.0
In-Reply-To: <1448136958-29917-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/15 20:15, Jonathan Cameron wrote:
> These should have been removed with the driver move out of staging
> but instead were commented out.  This was missed in reviews at the
> time so fixing it up now.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
I'm feeling cynical today and that no one will probably want to review this.
(and that it would be a waste of time if anyone did!)

Hence applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it!

Jonathan
> ---
>  drivers/staging/iio/Kconfig  | 28 ----------------------------
>  drivers/staging/iio/Makefile |  7 -------
>  2 files changed, 35 deletions(-)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 85de1985df8e..0e044cb0def8 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -17,32 +17,4 @@ source "drivers/staging/iio/meter/Kconfig"
>  source "drivers/staging/iio/resolver/Kconfig"
>  source "drivers/staging/iio/trigger/Kconfig"
>  
> -#config IIO_DUMMY_EVGEN
> -#       tristate
> -#
> -#config IIO_SIMPLE_DUMMY
> -#       tristate "An example driver with no hardware requirements"
> -#       help
> -#	 Driver intended mainly as documentation for how to write
> -#	 a driver. May also be useful for testing userspace code
> -#	 without hardware.
> -
> -#if IIO_SIMPLE_DUMMY
> -
> -#config IIO_SIMPLE_DUMMY_EVENTS
> -#       bool "Event generation support"
> -#       select IIO_DUMMY_EVGEN
> -#      help
> -#        Add some dummy events to the simple dummy driver.
> -
> -#config IIO_SIMPLE_DUMMY_BUFFER
> -#	bool "Buffered capture support"
> -#	select IIO_BUFFER
> -# select IIO_TRIGGER
> -#	select IIO_KFIFO_BUF
> -#	help
> -#	  Add buffered data capture to the simple dummy driver.
> -
> -#endif # IIO_SIMPLE_DUMMY
> -
>  endmenu
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 355824ab733b..3e616b4437f5 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -2,13 +2,6 @@
>  # Makefile for the industrial I/O core.
>  #
>  
> -#obj-$(CONFIG_IIO_SIMPLE_DUMMY) += iio_dummy.o
> -#iio_dummy-y := iio_simple_dummy.o
> -#iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_EVENTS) += iio_simple_dummy_events.o
> -#iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
> -
> -#obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
> -
>  obj-y += accel/
>  obj-y += adc/
>  obj-y += addac/
> 

