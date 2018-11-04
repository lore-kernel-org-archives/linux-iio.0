Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbeKEBzg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 20:55:36 -0500
Date: Sun, 4 Nov 2018 16:39:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 3/6] staging:iio:ad2s90: Remove always overwritten
 assignment
Message-ID: <20181104163958.1cb8f615@archlinux>
In-Reply-To: <20181103224948.31014-4-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-4-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:45 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch removes an initial assignment to the variable ret at probe,
> that was always overwritten.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing to
see if we are both wrong and there is something wrong with it that
build tests and static analysers can find!

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 4908c8a95fad..54ad85bd9dc6 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -62,7 +62,7 @@ static int ad2s90_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
> -	int ret = 0;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
