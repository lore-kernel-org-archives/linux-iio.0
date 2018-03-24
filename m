Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbeCXOQv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 10:16:51 -0400
Date: Sat, 24 Mar 2018 14:16:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com
Subject: Re: [PATCH 3/4] Staging: iio: accel: adis16201: Fix 80 character
 line limit
Message-ID: <20180324141646.5d76637b@archlinux>
In-Reply-To: <1521745965-26972-3-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
        <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
        <1521745965-26972-3-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 00:42:44 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Split the line over 80 characters limit to fix checkpatch
> warning.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index e7593fa..51e1afb 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -206,7 +206,8 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0,
> +			 12),
>  	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
>  	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),

