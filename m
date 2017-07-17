Return-Path: <SRS0=mhKp=6U=gmail.com=gehariprasath@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170717121923.24546-1-gehariprasath@gmail.com>
References: <20170717121923.24546-1-gehariprasath@gmail.com>
From: hari prasath <gehariprasath@gmail.com>
Date: Mon, 17 Jul 2017 18:04:03 +0530
Message-ID: <CAHHWPbdv9teGxVByPKmNWUzPXQu_NV_VARGMHscFemO_oMCtxQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: adc: add missing of_node references to iio_dev
To: lars@metafoo.de
Cc: Hari Prasath <gehariprasath@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Kindly discard this patch versions. I will send a new one.

On 17 July 2017 at 17:49, Hari Prasath <gehariprasath@gmail.com> wrote:
> Adding missing indio_dev->dev.of_node references to allow iio consumers
> to access the device channels.
>
> Signed-off-by: Hari Prasath <gehariprasath@gmail.com>
> ---
>         v2: Wrong from email ID in first version of patch
>
> ---
>  drivers/staging/iio/adc/ad7192.c | 1 +
>  drivers/staging/iio/adc/ad7780.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de..78308a5 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -668,6 +668,7 @@ static int ad7192_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>         st->devid = spi_get_device_id(spi)->driver_data;
>         indio_dev->dev.parent = &spi->dev;
> +       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index dec3ba6..e38d2ab9 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -195,6 +195,7 @@ static int ad7780_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>
>         indio_dev->dev.parent = &spi->dev;
> +       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = &st->chip_info->channel;
> --
> 2.10.0.GIT
>



-- 
Regards,
G.E.Hari Prasath
