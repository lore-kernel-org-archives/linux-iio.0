Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56635 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdDNPNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 11:13:51 -0400
Subject: Re: [PATCH] Staging: iio: accel: adis16203: fixed a brace coding
 style issue
To: =?UTF-8?Q?Ren=c3=a9_Hickersberger?= <renehickersberger@gmx.net>
References: <20170413135137.4494-1-renehickersberger@gmx.net>
Cc: knaack.h@gmx.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cf5e1783-f040-6615-8d43-e630ea374e88@kernel.org>
Date: Fri, 14 Apr 2017 16:13:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170413135137.4494-1-renehickersberger@gmx.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/17 14:51, René Hickersberger wrote:
> From: René Hickersberger?= <renehickersberger@gmx.net>
> 
> Fixed a brace coding style issue.
> 
> Signed-off-by: René Hickersberger <renehickersberger@gmx.net>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16203.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index faa2869..4e3fa75 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -205,9 +205,8 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
>  		bits = 14;
>  		addr = adis16203_addresses[chan->scan_index];
>  		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> +		if (ret)
>  			return ret;
> -		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> 

