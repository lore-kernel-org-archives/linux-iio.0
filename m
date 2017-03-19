Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48596 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdCSLHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:07:31 -0400
Subject: Re: [PATCH] Staging: iio: resolver: Fix warning, statements should
 start on a tabstop
To: Miguel Robles <miguel.robles@farole.net>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1489674509-9641-1-git-send-email-miguel.robles@farole.net>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b7dcb4e2-f393-26d1-f8c0-756be9d966c0@kernel.org>
Date: Sun, 19 Mar 2017 11:07:28 +0000
MIME-Version: 1.0
In-Reply-To: <1489674509-9641-1-git-send-email-miguel.robles@farole.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/17 14:28, Miguel Robles wrote:
> Fix checkpatch warning:
> Statements should start on a tabstop.
> 
> Signed-off-by: Miguel Robles <miguel.robles@farole.net>
Applied with the part name added to the patch title.

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

