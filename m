Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeETKxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:53:16 -0400
Date: Sun, 20 May 2018 11:53:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/12] staging: iio: ad2s1200: Remove unneeded
 initializations
Message-ID: <20180520115310.46786f3b@archlinux>
In-Reply-To: <b241956721e6f6df3234c42306935cb0aaaefc00.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <b241956721e6f6df3234c42306935cb0aaaefc00.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:21:23 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Remove 2 initializations which are unneeded, because the
> initialized values are never used.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied.
> ---
> Changes in v4:
>  - Introduced in this version.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index df3b34200a89..9bdcf0c86217 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -47,7 +47,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  			     long m)
>  {
>  	struct ad2s1200_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&st->lock);
>  	gpio_set_value(st->sample, 0);
> @@ -105,7 +105,7 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	unsigned short *pins = spi->dev.platform_data;
>  	struct ad2s1200_state *st;
>  	struct iio_dev *indio_dev;
> -	int pn, ret = 0;
> +	int pn, ret;
>  
>  	for (pn = 0; pn < AD2S1200_PN; pn++) {
>  		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,

