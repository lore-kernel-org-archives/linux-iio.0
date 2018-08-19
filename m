Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeHSUCF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 16:02:05 -0400
Date: Sun, 19 Aug 2018 17:49:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: explicitly cast gain_selectors
Message-ID: <20180819174956.73ae1d90@archlinux>
In-Reply-To: <20180811091219.5048-1-stefan@agner.ch>
References: <20180811091219.5048-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 11:12:19 +0200
Stefan Agner <stefan@agner.ch> wrote:

> After finding a reasonable gain, the function converts the configured
> gain to a gain configuration option selector enum max9611_csa_gain.
> Make the conversion clearly visible by using an explicit cast. This
> also avoids a warning seen with clang:
>   drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
>       enumeration type 'enum max9611_conf_ids' to different enumeration
>       type 'enum max9611_csa_gain' [-Wenum-conversion]
>                         *csa_gain = gain_selectors[i];
>                                   ~ ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Hmm. This is a somewhat odd code construct, but it kind of makes sense
as it enforces that we are using a subset of one enum for the other.

Not terribly pretty but not awful I guess.

This patch is fine given that.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 0538ff8c4ac1..643a4e66eb80 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -289,7 +289,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>  			return ret;
>  
>  		if (*adc_raw > 0) {
> -			*csa_gain = gain_selectors[i];
> +			*csa_gain = (enum max9611_csa_gain)gain_selectors[i];
>  			return 0;
>  		}
>  	}
