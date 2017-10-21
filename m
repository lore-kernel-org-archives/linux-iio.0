Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbdJURob (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:44:31 -0400
Date: Sat, 21 Oct 2017 18:44:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 11/13] staging: iio: tsl2x7x: fix alignment of break
 statements
Message-ID: <20171021184426.1841183d@archlinux>
In-Reply-To: <20171019200632.25820-12-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:30 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Correct the alignment of the break statements to match the alignment of
> the rest of the code within the case statements.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index bb9fb60509cf..f12ab1239a46 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -466,7 +466,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2771:
>  		if (!(ret & TSL2X7X_STA_ADC_VALID))
>  			goto prox_poll_err;
> -	break;
> +		break;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
> @@ -474,7 +474,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2772:
>  		if (!(ret & TSL2X7X_STA_PRX_VALID))
>  			goto prox_poll_err;
> -	break;
> +		break;
>  	}
>  
>  	for (i = 0; i < 2; i++) {

