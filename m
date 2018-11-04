Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbeKECGx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 21:06:53 -0500
Date: Sun, 4 Nov 2018 16:51:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 6/6] staging:iio:ad2s90: Check channel type at
 read_raw
Message-ID: <20181104165113.3549cd4d@archlinux>
In-Reply-To: <20181103224948.31014-7-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-7-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:48 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds a channel type check at the beginning of the
> ad2s90_read_raw function. Since ad2s90 has only one channel, it just
> checks if the given channel is the expected one and if not, return
> -EINVAL.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

Given you can't actually get here with another channel type by any
valid means, this is more a form of code as documentation than anything
else.  Still it does no harm and arguably does make it easier to read.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

A nice little clean up series.  Thanks!

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 9c168b7410d0..3e257ac46f7a 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -34,6 +34,9 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
> +	if (chan->type != IIO_ANGL)
> +		return -EINVAL;
> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
>  		/* 2 * Pi / 2^12 */
