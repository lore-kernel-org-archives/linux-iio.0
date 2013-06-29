Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42950 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab3F2MQF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 08:16:05 -0400
Message-ID: <51CECFFF.2060803@kernel.org>
Date: Sat, 29 Jun 2013 13:15:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: remove mention of ring buffer from  CONFIG_IIO_KFIFO_BUF,
 CONFIG_IIO_TRIGGER description
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net> <1372022900-18670-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 10:28 PM, Peter Meerwald wrote:
> ring buffers are only in staging, don't mention them here
Actually they aren't there either any more.  Long killed off.

> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index be8e303..524380c 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -30,8 +30,7 @@ config IIO_KFIFO_BUF
>  	select IIO_TRIGGER
>  	tristate "Industrial I/O buffering based on kfifo"
>  	help
> -	  A simple fifo based on kfifo.  Use this if you want a fifo
> -	  rather than a ring buffer. Note that this currently provides
> +	  A simple fifo based on kfifo.  Note that this currently provides
>  	  no buffer events so it is up to userspace to work out how
>  	  often to read from the buffer.
>  
> @@ -49,7 +48,7 @@ config IIO_TRIGGER
>  	help
>  	  Provides IIO core support for triggers.  Currently these
>  	  are used to initialize capture of samples to push into
> -	  ring buffers.  The triggers are effectively a 'capture
> +	  buffers.  The triggers are effectively a 'capture
>  	  data now' interrupt.
>  
>  config IIO_CONSUMERS_PER_TRIGGER
> 
