Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeCJRVv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 12:21:51 -0500
Date: Sat, 10 Mar 2018 17:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio:ad2s1210: Remove old_data from
 ad2s1210_state
Message-ID: <20180310172145.19f2dc00@archlinux>
In-Reply-To: <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
        <c622bde87a9e1ed5ddf89b999231c69579b7d2e6.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Mar 2018 20:46:25 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The variable old_data is a bool type, which only receives the value
> 'true' in the function ad2s1210_config_write and ad2s1210_config_read.
> There is no other use for this variable. This patch removes old_data
> from the ad2s1210_state and from all the function that use it.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 79cb56670fc2..ac13b99bd9cb 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -76,7 +76,6 @@ struct ad2s1210_state {
>  	unsigned int fclkin;
>  	unsigned int fexcit;
>  	bool hysteresis;
> -	bool old_data;
>  	u8 resolution;
>  	enum ad2s1210_mode mode;
>  	u8 rx[2] ____cacheline_aligned;
> @@ -107,7 +106,6 @@ static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
>  	ret = spi_write(st->sdev, st->tx, 1);
>  	if (ret < 0)
>  		return ret;
> -	st->old_data = true;
>  
>  	return 0;
>  }
> @@ -129,7 +127,6 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
>  	ret = spi_sync_transfer(st->sdev, &xfer, 1);
>  	if (ret < 0)
>  		return ret;
> -	st->old_data = true;
>  
>  	return st->rx[1];
>  }

