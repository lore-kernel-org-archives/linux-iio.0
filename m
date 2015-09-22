Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32976 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbbIVMLc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 22 Sep 2015 08:11:32 -0400
Date: Tue, 22 Sep 2015 07:10:54 -0500
From: Andreas Dannenberg <dannenberg@ti.com>
To: Peter Rosin <peda@lysator.liu.se>
CC: <linux-iio@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: mcp4xxx_dpot: Driver for Microchip digital
 potentiometers
Message-ID: <20150922121054.GA4491@borg>
References: <1442870306-26128-1-git-send-email-peda@lysator.liu.se>
 <1442870306-26128-2-git-send-email-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442870306-26128-2-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 21, 2015 at 11:18:26PM +0200, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Add support for Microchip digital potentiometers and rheostats
> 	MCP4531, MCP4532, MCP4551, MCP4552,
> 	MCP4631, MCP4632, MCP4651, MCP4652
> 
> These are either single (45xx) or dual (46xx) wipers with either
> 129 (4x3x) or 257 (4x5x) steps, and configured either as
> potentiometers (4xx1) or rheostats (4xx2).
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS                    |    5 +
>  drivers/iio/Kconfig            |    1 +
>  drivers/iio/Makefile           |    1 +
>  drivers/iio/pot/Kconfig        |   20 ++++
>  drivers/iio/pot/Makefile       |    6 ++
>  drivers/iio/pot/mcp4xxx_dpot.c |  218 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 251 insertions(+)
>  create mode 100644 drivers/iio/pot/Kconfig
>  create mode 100644 drivers/iio/pot/Makefile
>  create mode 100644 drivers/iio/pot/mcp4xxx_dpot.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60e2b2369d2..2a34b75b3034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6600,6 +6600,11 @@ W:	http://linuxtv.org
>  S:	Maintained
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MCP4XXX MICROCHIP DIGITAL POTENTIOMETER DRIVER
> +M:	Peter Rosin <peda@axentia.se>
> +S:	Maintained
> +F:	drivers/iio/pot/mcp4xxx_dpot.*
> +
>  MEDIA DRIVERS FOR RENESAS - VSP1
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011effe4c05..837aabad4b9a 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -73,6 +73,7 @@ source "drivers/iio/orientation/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> +source "drivers/iio/pot/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2d17ce..df026289309f 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -23,6 +23,7 @@ obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
>  obj-y += orientation/
> +obj-y += pot/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += temperature/
> diff --git a/drivers/iio/pot/Kconfig b/drivers/iio/pot/Kconfig
> new file mode 100644
> index 000000000000..48ebc7ef6b6b
> --- /dev/null
> +++ b/drivers/iio/pot/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Potentiometer drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Digital potentiometers"
> +
> +config MCP4XXX_DPOT
> +	tristate "Microchip MCP45xx/MCP46xx Digital Potentiometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Microship

Microchip?

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

