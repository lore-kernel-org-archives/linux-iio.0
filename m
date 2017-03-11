Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37118 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933258AbdCKSlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:41:04 -0500
Subject: Re: [PATCH v1 06/10] staging: iio: adis16201: Remove exceptional & on
 function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-7-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f881fc7d-1e68-c874-8d14-40184aa3bf99@kernel.org>
Date: Sat, 11 Mar 2017 18:41:01 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-7-git-send-email-singhalsimran0@gmail.com>
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
>  drivers/staging/iio/accel/adis16201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index d6c8658..7565268 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -285,8 +285,8 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  };
>  
>  static const struct iio_info adis16201_info = {
> -	.read_raw = &adis16201_read_raw,
> -	.write_raw = &adis16201_write_raw,
> +	.read_raw = adis16201_read_raw,
> +	.write_raw = adis16201_write_raw,
>  	.update_scan_mode = adis_update_scan_mode,
>  	.driver_module = THIS_MODULE,
>  };
> 

