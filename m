Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35320 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUOoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:44:30 -0500
Subject: Re: [PATCH v2 11/15] staging: iio: isl29028: remove unnecessary
 parenthesis
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-12-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4f88e38e-9704-76fd-dda8-cea2b1de9e75@kernel.org>
Date: Sat, 21 Jan 2017 14:43:57 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-12-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> isl29028_write_raw() contains unnecessary parenthesis when checking to
> see if the passed in lux scale is valid. This patch removes the
> unnecessary parenthesis.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
hmm. Not sure I really care about this either way.

Ah well, applied.

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index e93077b..bc9c01d 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -327,7 +327,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		if ((val != 125) && (val != 2000)) {
> +		if (val != 125 && val != 2000) {
>  			dev_err(dev,
>  				"%s(): light: Lux scale %d is not in the set {125, 2000}\n",
>  				__func__, val);
> 

