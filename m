Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWZN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:25:13 -0500
Date: Sun, 11 Nov 2018 12:36:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] staging: iio: ad7816: Set RD/WR pin and CONVST
 pin as outputs.
Message-ID: <20181111123640.0195c7fd@archlinux>
In-Reply-To: <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 13:07:18 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> The RD/WR pin and CONVST pin are logical inputs to the AD78xx
> chip as per the datasheet. Hence convert them to outputs.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Hi Nishad,

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

This is the sort of patch we might want to think about backporting
for stable, but it is sufficiently complex to do that I' think we'll
wait for someone to actually request it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 3cda5cd09365..a2fead85cd46 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -369,14 +369,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		chip->oti_data[i] = 203;
>  
>  	chip->id = spi_get_device_id(spi_dev)->driver_data;
> -	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
>  		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>  			ret);
>  		return ret;
>  	}
> -	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
> +	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
> +					   GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->convert_pin)) {
>  		ret = PTR_ERR(chip->convert_pin);
>  		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
