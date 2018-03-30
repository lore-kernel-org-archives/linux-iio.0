Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Lco (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 07:32:44 -0400
Date: Fri, 30 Mar 2018 12:32:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 2/6] Staging: iio: adis16209: Prefer reverse
 christmas tree ordering
Message-ID: <20180330123238.51d9b2a5@archlinux>
In-Reply-To: <3f021293e6183f6fefb597a9a01b762b73d69bc3.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
        <3f021293e6183f6fefb597a9a01b762b73d69bc3.1522306893.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Mar 2018 14:43:23 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Prefer reverse christmas tree ordering of declarations to
> improve readability.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 0e6366a..8f4fa6b 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -270,9 +270,9 @@ static const struct adis_data adis16209_data = {
>  
>  static int adis16209_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)

