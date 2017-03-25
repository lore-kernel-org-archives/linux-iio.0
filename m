Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43517 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYRDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:03:13 -0400
Subject: Re: [PATCH] staging: iio: accel: remove unneeded braces around single
 statements
To: Mark Stenglein <mark@stengle.in>, lars@metafoo.de
References: <20170323061812.7316-1-mark@stengle.in>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7be79d2b-fd27-e495-aa8f-710dfb5019f7@kernel.org>
Date: Sat, 25 Mar 2017 17:02:56 +0000
MIME-Version: 1.0
In-Reply-To: <20170323061812.7316-1-mark@stengle.in>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/17 06:18, Mark Stenglein wrote:
> Fixes three checkpatch warnings due to braces used when single
> statements are sufficient.
> 
> Signed-off-by: Mark Stenglein <mark@stengle.in>
Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 3 +--
>  drivers/staging/iio/accel/adis16240.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 52fa2e0511be..8485c024e3f5 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -255,9 +255,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		}
>  		addr = adis16209_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> +		if (ret)
>  			return ret;
> -		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 6e3c95c9c3f6..109cd94b5ac3 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -290,9 +290,8 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][0];
>  		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> +		if (ret)
>  			return ret;
> -		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> @@ -301,9 +300,8 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
>  		bits = 10;
>  		addr = adis16240_addresses[chan->scan_index][1];
>  		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> +		if (ret)
>  			return ret;
> -		}
>  		val16 &= (1 << bits) - 1;
>  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
>  		*val = val16;
> 

