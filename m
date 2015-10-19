Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33884 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbbJSIQX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 04:16:23 -0400
MIME-Version: 1.0
In-Reply-To: <22609671.lgCfBiaFIf@wuerfel>
References: <22609671.lgCfBiaFIf@wuerfel>
Date: Mon, 19 Oct 2015 11:16:22 +0300
Message-ID: <CAEnQRZDTP6Xut9hGLe4QpgdZJvumY0fESMc_aYWJ4TW3oHeUJw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
From: Daniel Baluta <daniel.baluta@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	driverdev <devel@driverdev.osuosl.org>,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 17, 2015 at 1:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The iio dummy code was recently changed to use irq_work_queue, but
> that code is compiled into the kernel only if IRQ_WORK is set, so
> we can get a link error here:
>
> drivers/built-in.o: In function `iio_evgen_poke':
> (.text+0x208a04): undefined reference to `irq_work_queue'
>
> This changes the Kconfig file to match what other drivers do.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fd2bb310ca3d ("Staging: iio: Move evgen interrupt generation to irq_work")

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
> Found on ARM randconfig tests
>
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 6d5b38d69578..9d7f0004d2d7 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -18,7 +18,8 @@ source "drivers/staging/iio/resolver/Kconfig"
>  source "drivers/staging/iio/trigger/Kconfig"
>
>  config IIO_DUMMY_EVGEN
> -       tristate
> +       tristate
> +       select IRQ_WORK
>
>  config IIO_SIMPLE_DUMMY
>         tristate "An example driver with no hardware requirements"
>
> --
