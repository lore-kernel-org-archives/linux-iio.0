Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48369 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3K3LNJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:13:09 -0500
Message-ID: <5299C844.4040007@kernel.org>
Date: Sat, 30 Nov 2013 11:13:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/15] staging:iio:ad7746: Mark transfer buffer as __be32
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:42, Lars-Peter Clausen wrote:
> Fixes the following warnings from sparse:
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/cdc/ad7746.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 862d68d..01e15e2 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -567,7 +567,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  	u8 regval, reg;
>  
>  	union {
> -		u32 d32;
> +		__be32 d32;
>  		u8 d8[4];
>  	} data;
>  
> 
