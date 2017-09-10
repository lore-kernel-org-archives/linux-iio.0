Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdIJPOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 11:14:35 -0400
Date: Sun, 10 Sep 2017 16:14:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Daniel Mack <daniel@zonque.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: ad5446: Add IDs of compatible Texas
 Instruments chips
Message-ID: <20170910161430.59e9a3f9@archlinux>
In-Reply-To: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 5 Sep 2017 11:44:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The Texas Instruments DAC081S101, DAC101S101 and DAC121S101 have the
> exact same pinout, programming interface and power-down modes as the
> AD5300, AD5310 and AD5320, respectively, and their datasheets declare
> them "a direct replacement" for the Analog Devices chips.  This may
> not be immediately obvious to a casual observer, so add them to the
> supported modalias strings.
> 
> Datasheets:
> http://www.ti.com/lit/ds/symlink/dac081s101.pdf
> http://www.ti.com/lit/ds/symlink/dac101s101.pdf
> http://www.ti.com/lit/ds/symlink/dac121s101.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5300.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5320.pdf
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to the togreg branch of iio.git and will be pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/Kconfig  | 3 ++-
>  drivers/iio/dac/ad5446.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 716fcb1610dd..a411b2d59510 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -60,7 +60,8 @@ config AD5446
>  	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
>  	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
>  	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
> -	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs.
> +	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
> +	  as well as Texas Instruments DAC081S101, DAC101S101, DAC121S101.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5446.
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index c6c22f3520eb..3f6465de39de 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -460,6 +460,9 @@ static const struct spi_device_id ad5446_spi_ids[] = {
>  	{"ad5660-2500", ID_AD5660_2500},
>  	{"ad5660-1250", ID_AD5660_1250},
>  	{"ad5662", ID_AD5662},
> +	{"dac081s101", ID_AD5300}, /* compatible Texas Instruments chips */
> +	{"dac101s101", ID_AD5310},
> +	{"dac121s101", ID_AD5320},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);

