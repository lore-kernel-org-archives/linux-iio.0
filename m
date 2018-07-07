Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932546AbeGGRBk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Jul 2018 13:01:40 -0400
Date: Sat, 7 Jul 2018 18:01:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:imu:adis: Mark expected switch fall-throughs
Message-ID: <20180707180135.01ac79e9@archlinux>
In-Reply-To: <20180703193550.GA12565@embeddedor.com>
References: <20180703193550.GA12565@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 3 Jul 2018 14:35:50 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to hopefully ignore!

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index ad6f91d..c771ae6 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -81,9 +81,11 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  		adis->tx[9] = (value >> 24) & 0xff;
>  		adis->tx[6] = ADIS_WRITE_REG(reg + 2);
>  		adis->tx[7] = (value >> 16) & 0xff;
> +		/* fall through */
>  	case 2:
>  		adis->tx[4] = ADIS_WRITE_REG(reg + 1);
>  		adis->tx[5] = (value >> 8) & 0xff;
> +		/* fall through */
>  	case 1:
>  		adis->tx[2] = ADIS_WRITE_REG(reg);
>  		adis->tx[3] = value & 0xff;
> @@ -167,6 +169,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  		adis->tx[2] = ADIS_READ_REG(reg + 2);
>  		adis->tx[3] = 0;
>  		spi_message_add_tail(&xfers[1], &msg);
> +		/* fall through */
>  	case 2:
>  		adis->tx[4] = ADIS_READ_REG(reg);
>  		adis->tx[5] = 0;

