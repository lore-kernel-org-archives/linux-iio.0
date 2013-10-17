Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab3JQVme (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:42:34 -0400
Message-ID: <526067DF.3020801@kernel.org>
Date: Thu, 17 Oct 2013 23:42:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Beomho Seo <beomho.seo@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, myungjoo.ham@samsung.com,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Peter Meerwald l <pmeerw@pmeerw.net>
Subject: Re: [PATCH v7 1/2] iio: cm36651: Add CM36651 proximity/light sensor
References: <525F49F8.70604@samsung.com>
In-Reply-To: <525F49F8.70604@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/17/13 03:22, Beomho Seo wrote:
> 
> This patch adds a new driver for Capella CM36651 proximity and RGB sensor.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
I have fixed the typo in the makefile and applied this to the
togreg branch of iio.git.

It does make me a little nervous that you clearly have not tested
the last few versions, but the changes have been simple enough, I'm
assuming that nothing has broken from the point of view of the driver
actually working.

Thanks,
> ---
>  drivers/iio/light/Kconfig   |   11 +
>  drivers/iio/light/Makefile  |    1 +
>  drivers/iio/light/cm36651.c |  708 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 720 insertions(+)
>  create mode 100644 drivers/iio/light/cm36651.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 0a25ae6..f98c2b5 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -27,6 +27,17 @@ config APDS9300
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called apds9300.
>  
> +config CM36651
> +	depends on I2C
> +	tristate "CM36651 driver"
> +	help
> +	 Say Y here if you use cm36651.
> +	 This option enables proximity & RGB sensor using
> +	 Capella cm36651 device driver.
> +
> +	 To compile this driver as a module, choose M here:
> +	 the module will be called cm36651.
> +
>  config GP2AP020A00F
>  	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index cef590f..b615cf3 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -5,6 +5,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
> +obj-$(CONFIG_COM36651)		+= cm36651.o
CONFIG_CM36651
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> new file mode 100644
> index 0000000..ff4bcd2
