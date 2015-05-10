Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38147 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbbEJT2i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2015 15:28:38 -0400
Message-ID: <554FB161.4050809@kernel.org>
Date: Sun, 10 May 2015 20:28:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	marxin.liska@gmail.com, marex@denx.de, rui.zhang@intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	daniel.baluta@gmail.com
Subject: Re: [PATCH] iio: acpi-als: Fix Kconfig and remove unneeded pointer
 casting
References: <1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com> <1431199858-8066-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1431199858-8066-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/15 20:30, Gabriele Mazzotta wrote:
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Applied as a fixup to the original patch which is now in the
togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> This patch fixes the issues of:
> [PATCH v9] iio: acpi: Add support for ACPI0008 Ambient Light Sensor
> 
> Link: http://lkml.kernel.org/g/1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com
> 
>  drivers/iio/light/Kconfig    | 1 +
>  drivers/iio/light/acpi-als.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 898b2b5..fecd743 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -8,6 +8,7 @@ menu "Light sensors"
>  config ACPI_ALS
>  	tristate "ACPI Ambient Light Sensor"
>  	depends on ACPI
> +	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 9839c9a..1dafa07 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -138,8 +138,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
>  		goto out;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev,
> -					   (u8 *)als->evt_buffer, time_ns);
> +	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
>  
>  out:
>  	mutex_unlock(&als->lock);
> 

