Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12076 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2JCSNw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Oct 2012 14:13:52 -0400
Message-ID: <1349288035.2400.0.camel@spandruv-ideapad.jf.intel.com>
Subject: Re: [PATCH] iio: fix spelling of Accelerometer in Kconfig
From: Srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@intel.com
Date: Wed, 03 Oct 2012 11:13:55 -0700
In-Reply-To: <1348999413-19042-1-git-send-email-pmeerw@pmeerw.net>
References: <1348999413-19042-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks for catching this. Agreed.

On Sun, 2012-09-30 at 12:03 +0200, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: srinivas.pandruvada@intel.com
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


