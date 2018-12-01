Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:52:24 -0500
Date: Sat, 1 Dec 2018 15:39:32 +0000
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
Subject: Re: [PATCH v3 6/7] staging:iio:ad2s90: Add comment to device state
 mutex
Message-ID: <20181201153932.45e218f5@archlinux>
In-Reply-To: <20181124002312.6923-7-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-7-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Nov 2018 22:23:11 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> From: Victor Colombo <victorcolombo@gmail.com>
> 
> Fix the checkpatch.pl issue:
> "CHECK: struct mutex definition without comment".
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied, thanks

Jonathan
> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Patch added in v2
> 
>  drivers/staging/iio/resolver/ad2s90.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 678351dabe6b..a41f5cb10da5 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -22,7 +22,7 @@
>  #define AD2S90_MAX_SPI_FREQ_HZ  830000
>  
>  struct ad2s90_state {
> -	struct mutex lock;
> +	struct mutex lock; /* lock to protect rx buffer */
>  	struct spi_device *sdev;
>  	u8 rx[2] ____cacheline_aligned;
>  };
