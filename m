Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48004 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3GGP3w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jul 2013 11:29:52 -0400
Message-ID: <51D9896A.5080701@kernel.org>
Date: Sun, 07 Jul 2013 16:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Relange <alexandre@relange.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: mechanical: new category of sensors
References: <1370962336-20739-1-git-send-email-alexandre@relange.org> <1370962336-20739-2-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-2-git-send-email-alexandre@relange.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2013 03:52 PM, Alexandre Relange wrote:
> adds the category of mechanical sensors (switches,...)
> 
> Signed-off-by: Alexandre Relange <alexandre@relange.org>
Support like this should be introduced with the first driver, i.e.
in the same patch in my view.

The outstanding issue not answered yet for these is how a mechanical
switch is different from a general purpose input?

> ---
>  drivers/iio/Kconfig             | 1 +
>  drivers/iio/Makefile            | 1 +
>  drivers/iio/mechanical/Kconfig  | 6 ++++++
>  drivers/iio/mechanical/Makefile | 3 +++
>  4 files changed, 11 insertions(+)
>  create mode 100644 drivers/iio/mechanical/Kconfig
>  create mode 100644 drivers/iio/mechanical/Makefile
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b2f963b..dbed2f1 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -70,5 +70,6 @@ source "drivers/iio/gyro/Kconfig"
>  source "drivers/iio/imu/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
> +source "drivers/iio/mechanical/Kconfig"
>  
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index a0e8cdd..78ec75b 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -21,3 +21,4 @@ obj-y += frequency/
>  obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
> +obj-y += mechanical/
> diff --git a/drivers/iio/mechanical/Kconfig b/drivers/iio/mechanical/Kconfig
> new file mode 100644
> index 0000000..b536fa2
> --- /dev/null
> +++ b/drivers/iio/mechanical/Kconfig
> @@ -0,0 +1,6 @@
> +#
> +# Mechanical sensors
> +#
> +menu "Mechanical sensors"
> +
> +endmenu
> diff --git a/drivers/iio/mechanical/Makefile b/drivers/iio/mechanical/Makefile
> new file mode 100644
> index 0000000..716098f
> --- /dev/null
> +++ b/drivers/iio/mechanical/Makefile
> @@ -0,0 +1,3 @@
> +#
> +# Makefile for IIO Mechanical sensors
> +#
> 
