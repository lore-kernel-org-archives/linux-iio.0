Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbeCXOQH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 10:16:07 -0400
Date: Sat, 24 Mar 2018 14:16:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com
Subject: Re: [PATCH 2/4] Staging: iio: accel: adis16201: Use GENMASK
Message-ID: <20180324141601.7faf0c8e@archlinux>
In-Reply-To: <1521745965-26972-2-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
        <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
        <1521745965-26972-2-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 00:42:43 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use GENMASK to improve readability and remove the local variables used to
> store intermediate data.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index b04dbb3..e7593fa 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -185,28 +185,24 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  			       long mask)
>  {
>  	struct adis *st = iio_priv(indio_dev);
> -	int bits;
> -	s16 val16;
> -	u8 addr;
> +	int m;
>  
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -			bits = 12;
> -			break;
> -		case IIO_INCLI:
> -			bits = 9;
> -			break;
> -		default:
> -			return -EINVAL;
> +	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		m = GENMASK(11, 0);
> +		break;
> +	case IIO_INCLI:
> +		m = GENMASK(8, 0);
> +		break;
> +	default:
> +		return -EINVAL;
>  		}
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16201_addresses[chan->scan_index];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
>  
> -	return -EINVAL;
> +	return adis_write_reg_16(st, adis16201_addresses[chan->scan_index],
> +				 val & m);
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {

