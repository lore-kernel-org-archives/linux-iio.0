Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbeLBCuU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:50:20 -0500
Date: Sat, 1 Dec 2018 15:37:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 3/7] staging:iio:ad2s90: Add max frequency check at
 probe
Message-ID: <20181201153728.387f4695@archlinux>
In-Reply-To: <20181124002312.6923-4-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-4-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Nov 2018 22:23:08 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> This patch adds a max frequency check at the beginning of ad2s90_probe
> function so that when it is set to a value above 0.83Mhz, dev_err is
> called with an appropriate message and -EINVAL is returned.
> 
> The defined limit is 0.83Mhz instead of 2Mhz, which is the chip's max
> frequency as specified in the datasheet, because, as also specified in
> the datasheet, a 600ns delay is expected between the application of a
> logic LO to CS and the application of SCLK. Since the delay is not
> implemented in the spi code, to satisfy it, SCLK's period should be at
> most 2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which
> gives roughly 830000Hz.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied,

Thanks,
> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Correctly credit Alexandru as the patch's author
> 
>  drivers/staging/iio/resolver/ad2s90.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index abb9b9147ee6..4721e9bbb8b0 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -19,6 +19,12 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +/*
> + * Although chip's max frequency is 2Mhz, it needs 600ns between CS and the
> + * first falling edge of SCLK, so frequency should be at most 1 / (2 * 6e-7)
> + */
> +#define AD2S90_MAX_SPI_FREQ_HZ  830000
> +
>  struct ad2s90_state {
>  	struct mutex lock;
>  	struct spi_device *sdev;
> @@ -78,6 +84,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
>  
> +	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
> +		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
> +			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
> +		return -EINVAL;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
