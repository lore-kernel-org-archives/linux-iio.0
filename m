Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48149 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936184AbdCVT3m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 15:29:42 -0400
Subject: Re: [PATCH] staging: iio: resolver: ad2s1210: Coding style fix
To: Olivier Leveque <o_leveque@orange.fr>, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
References: <1490200631-4415-1-git-send-email-o_leveque@orange.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b19b7bba-6d6d-c880-bdc0-ee8ccde3bb51@kernel.org>
Date: Wed, 22 Mar 2017 19:29:40 +0000
MIME-Version: 1.0
In-Reply-To: <1490200631-4415-1-git-send-email-o_leveque@orange.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 16:37, Olivier Leveque wrote:
> Apply proper indentation in order to follow the linux kernel coding style
> 
> Signed-off-by: Olivier Leveque <o_leveque@orange.fr>
Hi Oliver.

Already a fix in place for this one.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 90b57c0..a6a8393 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -490,8 +490,8 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  		ad2s1210_set_mode(MOD_VEL, st);
>  		break;
>  	default:
> -	       ret = -EINVAL;
> -	       break;
> +		ret = -EINVAL;
> +		break;
>  	}
>  	if (ret < 0)
>  		goto error_ret;
> 

