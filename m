Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdIJQMM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 12:12:12 -0400
Date: Sun, 10 Sep 2017 17:12:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: adc: mcp320x: Document struct mcp320x
Message-ID: <20170910171206.28b2b9af@archlinux>
In-Reply-To: <726672ba351fe3b706f7d1c34d6fd2b130815349.1504807204.git.lukas@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
        <726672ba351fe3b706f7d1c34d6fd2b130815349.1504807204.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 9 Sep 2017 20:32:41 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied.
> ---
> Changes since v1:
> - Move kerneldoc to separate patch. (Jonathan)
> 
>  drivers/iio/adc/mcp320x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index bf4794009413..32859188d653 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -59,6 +59,17 @@ struct mcp320x_chip_info {
>  	unsigned int resolution;
>  };
>  
> +/**
> + * struct mcp320x - Microchip SPI ADC instance
> + * @spi: SPI slave (parent of the IIO device)
> + * @msg: SPI message to select a channel and receive a value from the ADC
> + * @transfer: SPI transfers used by @msg
> + * @reg: regulator generating Vref
> + * @lock: protects read sequences
> + * @chip_info: ADC properties
> + * @tx_buf: buffer for @transfer[0] (not used on single-channel converters)
> + * @rx_buf: buffer for @transfer[1]
> + */
>  struct mcp320x {
>  	struct spi_device *spi;
>  	struct spi_message msg;

