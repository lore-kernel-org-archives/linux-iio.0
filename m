Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47230 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbHONwF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 09:52:05 -0400
Subject: Re: [PATCH 2/2] iio: Move generic buffer implementations to
 sub-directory
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1439564095-7352-1-git-send-email-lars@metafoo.de>
 <1439564095-7352-3-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF4404.3030700@kernel.org>
Date: Sat, 15 Aug 2015 14:52:04 +0100
MIME-Version: 1.0
In-Reply-To: <1439564095-7352-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/15 15:54, Lars-Peter Clausen wrote:
> For generic IIO trigger implementations we already have a sub-directory,
> but the generic buffer implementations currently reside in the IIO
> top-level directory. The main reason is that things have historically grown
> into this form.
> 
> With more generic buffer implementations on its way now is the perfect time
> to clean this up and introduce a sub-directory for generic buffer
> implementations to avoid too much clutter in the top-level directory.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Makes sense.

Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/Kconfig                                | 22 +-------------------
>  drivers/iio/Makefile                               |  5 +----
>  drivers/iio/buffer/Kconfig                         | 24 ++++++++++++++++++++++
>  drivers/iio/buffer/Makefile                        |  8 ++++++++
>  drivers/iio/{ => buffer}/industrialio-buffer-cb.c  |  0
>  .../{ => buffer}/industrialio-triggered-buffer.c   |  0
>  drivers/iio/{ => buffer}/kfifo_buf.c               |  0
>  7 files changed, 34 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/iio/buffer/Kconfig
>  create mode 100644 drivers/iio/buffer/Makefile
>  rename drivers/iio/{ => buffer}/industrialio-buffer-cb.c (100%)
>  rename drivers/iio/{ => buffer}/industrialio-triggered-buffer.c (100%)
>  rename drivers/iio/{ => buffer}/kfifo_buf.c (100%)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b52c8a3..3c6c6e2 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -19,27 +19,7 @@ config IIO_BUFFER
>  	  acquisition methods.
>  
>  if IIO_BUFFER
> -
> -config IIO_BUFFER_CB
> -	tristate "IIO callback buffer used for push in-kernel interfaces"
> -	help
> -	  Should be selected by any drivers that do in-kernel push
> -	  usage.  That is, those where the data is pushed to the consumer.
> -
> -config IIO_KFIFO_BUF
> -	tristate "Industrial I/O buffering based on kfifo"
> -	help
> -	  A simple fifo based on kfifo.  Note that this currently provides
> -	  no buffer events so it is up to userspace to work out how
> -	  often to read from the buffer.
> -
> -config IIO_TRIGGERED_BUFFER
> -	tristate
> -	select IIO_TRIGGER
> -	select IIO_KFIFO_BUF
> -	help
> -	  Provides helper functions for setting up triggered buffers.
> -
> +	source "drivers/iio/buffer/Kconfig"
>  endif # IIO_BUFFER
>  
>  config IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 09d8ec5..7ddb988 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -7,13 +7,10 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  
> -obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
> -obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
> -obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
> -
>  obj-y += accel/
>  obj-y += adc/
>  obj-y += amplifiers/
> +obj-y += buffer/
>  obj-y += common/
>  obj-y += dac/
>  obj-y += gyro/
> diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
> new file mode 100644
> index 0000000..0a7b2fd
> --- /dev/null
> +++ b/drivers/iio/buffer/Kconfig
> @@ -0,0 +1,24 @@
> +#
> +# Industrial I/O generic buffer implementations
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +config IIO_BUFFER_CB
> +	tristate "IIO callback buffer used for push in-kernel interfaces"
> +	help
> +	  Should be selected by any drivers that do in-kernel push
> +	  usage.  That is, those where the data is pushed to the consumer.
> +
> +config IIO_KFIFO_BUF
> +	tristate "Industrial I/O buffering based on kfifo"
> +	help
> +	  A simple fifo based on kfifo.  Note that this currently provides
> +	  no buffer events so it is up to userspace to work out how
> +	  often to read from the buffer.
> +
> +config IIO_TRIGGERED_BUFFER
> +	tristate
> +	select IIO_TRIGGER
> +	select IIO_KFIFO_BUF
> +	help
> +	  Provides helper functions for setting up triggered buffers.
> diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
> new file mode 100644
> index 0000000..4d193b9
> --- /dev/null
> +++ b/drivers/iio/buffer/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for the industrial I/O buffer implementations
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_IIO_BUFFER_CB) += industrialio-buffer-cb.o
> +obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
> +obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
> diff --git a/drivers/iio/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> similarity index 100%
> rename from drivers/iio/industrialio-buffer-cb.c
> rename to drivers/iio/buffer/industrialio-buffer-cb.c
> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> similarity index 100%
> rename from drivers/iio/industrialio-triggered-buffer.c
> rename to drivers/iio/buffer/industrialio-triggered-buffer.c
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> similarity index 100%
> rename from drivers/iio/kfifo_buf.c
> rename to drivers/iio/buffer/kfifo_buf.c
> 

