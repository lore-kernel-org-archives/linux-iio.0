Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-096.synserver.de ([212.40.185.96]:1117 "EHLO
	smtp-out-093.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753932Ab2DYJAI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 05:00:08 -0400
Message-ID: <4F97BDAB.9050506@metafoo.de>
Date: Wed, 25 Apr 2012 11:02:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/14] staging:iio:buffers switch select kconfig elements
 to depends.
References: <1335096819-19565-1-git-send-email-jic23@kernel.org> <1335096819-19565-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-10-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/22/2012 02:13 PM, Jonathan Cameron wrote:
> As we are moving the IIO core out of staging, we need to
> stop drivers in staging controlling whether elements of the
> core are built.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index fe15867..e644508 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -28,7 +28,7 @@ config IIO_BUFFER
>  if IIO_BUFFER
>  
>  config IIO_SW_RING
> -       select IIO_TRIGGER
> +        depends on IIO_TRIGGER
>  	tristate "Industrial I/O lock free software ring"
>  	help
>  	  Example software ring buffer implementation.  The design aim
> @@ -37,7 +37,7 @@ config IIO_SW_RING
>  	  in interrupt context.
>  
>  config IIO_KFIFO_BUF
> -	select IIO_TRIGGER
> +	depends on IIO_TRIGGER
>  	tristate "Industrial I/O buffering based on kfifo"
>  	help
>  	  A simple fifo based on kfifo.  Use this if you want a fifo


Is there actually anything in the code which gets enabled by these config
symbols that depends on IIO_TRIGGER?

- Lars
