Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37136 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbdCKSlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:41:50 -0500
Subject: Re: [PATCH v1 08/10] staging: iio: adis16203: Remove exceptional & on
 function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-9-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d3a6fc75-bf67-f562-c6c8-2dbe19bafc8f@kernel.org>
Date: Sat, 11 Mar 2017 18:41:48 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-9-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/17 14:26, simran singhal wrote:
> Remove & from function pointers to conform to the style found elsewhere
> in the file.  Done using the following semantic patch
> 
> // <smpl>
> @r@
> identifier f;
> @@
> 
> f(...) { ... }
> @@
> identifier r.f;
> @@
> 
> - &f
> + f
> // </smpl>
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.
> ---
>  drivers/staging/iio/accel/adis16203.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 68189ad..b59755a 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -233,8 +233,8 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  };
>  
>  static const struct iio_info adis16203_info = {
> -	.read_raw = &adis16203_read_raw,
> -	.write_raw = &adis16203_write_raw,
> +	.read_raw = adis16203_read_raw,
> +	.write_raw = adis16203_write_raw,
>  	.update_scan_mode = adis_update_scan_mode,
>  	.driver_module = THIS_MODULE,
>  };
> 

