Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55752 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab3LBVNR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2013 16:13:17 -0500
Message-ID: <529CF7EA.6090500@kernel.org>
Date: Mon, 02 Dec 2013 21:13:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Fix build failure for gp2ap020a00f.c
References: <20131202112558.GF16735@n2100.arm.linux.org.uk>
In-Reply-To: <20131202112558.GF16735@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/13 11:25, Russell King - ARM Linux wrote:
> drivers/built-in.o: In function `gp2ap020a00f_thresh_event_handler':
> powercap_sys.c:(.text+0x15f90c): undefined reference to `irq_work_queue'
> make[1]: *** [vmlinux] Error 1
> make[1]: Target `uImage' not remade because of errors.
> make: *** [sub-make] Error 2
> make: Target `uImage' not remade because of errors.
> 
> You need the IRQ work support, but GP2AP020A00F is not selecting this
> symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Thanks Russell,

Applied to the fixes-togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Jonathan
> ---
>  drivers/iio/light/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index b0d65df3ede2..a022f27c6690 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -43,6 +43,7 @@ config GP2AP020A00F
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IRQ_WORK
>  	help
>  	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
>  	  hooked to an I2C bus.
> 
