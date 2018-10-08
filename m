Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIDfq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Oct 2018 23:35:46 -0400
Date: Mon, 8 Oct 2018 21:22:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad2s1210: fix 'assignment operator'
 style checks
Message-ID: <20181008212211.012a817c@archlinux>
In-Reply-To: <20181008032938.18801-1-matheus.bernardino@usp.br>
References: <20181008032938.18801-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  8 Oct 2018 00:29:38 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c with checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Great, thanks for sorting this out and coming back with a V2 so quickly.

Applied to the togreg branch of iio.git which is initially pushed out as
testing for the autobuilders to play with it.

We are late in the current kernel cycle, so this will probably not go
upstream until the merge window after the one that will open in a few
weeks time.

Thanks,

Jonathan

> ---
> Changes in v2: In v1, tabs were accidentally converted to whitespaces.
> Now, tabs were preserved.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..d4b1c2c010f2 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>  			"ad2s1210: write control register fail\n");
>  		goto error_ret;
>  	}
> -	st->resolution
> -		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +	st->resolution =
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>  	if (st->pdata->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)
> @@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  		dev_err(dev, "ad2s1210: setting resolution fail\n");
>  		goto error_ret;
>  	}
> -	st->resolution
> -		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +	st->resolution =
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
>  	if (st->pdata->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)
