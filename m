Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45697 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2JMJnJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:43:09 -0400
Message-ID: <507937AD.5000108@kernel.org>
Date: Sat, 13 Oct 2012 10:43:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix spelling of Accelerometer in Kconfig
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net> <1350115595-7107-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2012 09:06 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Added to togreg branch of iio.git

(I'd have picked all these up today from the original thread, but
this nice series with acks etc does make life easier - thanks!)

> ---
>  drivers/iio/accel/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b2510c4..fe4bcd7 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -8,7 +8,7 @@ config HID_SENSOR_ACCEL_3D
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select HID_SENSOR_IIO_COMMON
> -	tristate "HID Acelerometers 3D"
> +	tristate "HID Accelerometers 3D"
>  	help
>  	  Say yes here to build support for the HID SENSOR
>  	  accelerometers 3D.
> 
