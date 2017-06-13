Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbdFMUN1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 16:13:27 -0400
Date: Tue, 13 Jun 2017 21:13:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexander Wuerstlein <arw@arw.name>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio hid-sensor-trigger: add Kconfig depends on
 IIO_BUFFER
Message-ID: <20170613211322.5ed84610@kernel.org>
In-Reply-To: <20170612115608.28058-1-arw@arw.name>
References: <20170612115608.28058-1-arw@arw.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Jun 2017 13:56:05 +0200
Alexander Wuerstlein <arw@arw.name> wrote:

> Building a kernel with my configuration failed with:
> > drivers/built-in.o: In function `hid_sensor_setup_batch_mode': staging/drivers/iio/common/hid-sensors/hid-sensor-trigger.c:104: undefined reference to `iio_buffer_set_attrs'  
> which is fixed by this patch.
> 
> Signed-off-by: Alexander Wuerstlein <arw@arw.name>
Added a fixes tag as the issue was only introduced very recently.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/common/hid-sensors/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
> index 39188b72cd3b..80105378b0ba 100644
> --- a/drivers/iio/common/hid-sensors/Kconfig
> +++ b/drivers/iio/common/hid-sensors/Kconfig
> @@ -16,7 +16,7 @@ config HID_SENSOR_IIO_COMMON
>  
>  config HID_SENSOR_IIO_TRIGGER
>  	tristate "Common module (trigger) for all HID Sensor IIO drivers"
> -	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON
> +	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON && IIO_BUFFER
>  	select IIO_TRIGGER
>  	help
>  	  Say yes here to build trigger support for HID sensors.

