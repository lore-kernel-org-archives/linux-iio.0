Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833AbcAJLxJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jan 2016 06:53:09 -0500
Subject: Re: [PATCH] staging: iio: cdc: Prefer using the BIT macro
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
References: <20160110062018.GA22031@Karyakshetra>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56924621.4010906@kernel.org>
Date: Sun, 10 Jan 2016 11:53:05 +0000
MIME-Version: 1.0
In-Reply-To: <20160110062018.GA22031@Karyakshetra>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/16 06:20, Bhaktipriya Shridhar wrote:
> Replace all occurences of (1<<x) by BIT(x) in the file ad7150.c to get rid
> of checkpatch.pl "CHECK" output "Prefer using the BIT macro"
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Hi,

I'm afraid that a similar patch was sent by Shraddha Barke back at the end
of December.  It just missed the last merge window so can currently only
be found in the testing branch of iio.git.

Thanks anyway. It is always amazing how long code can sit in a given state
before several patches turn up for it in a couple of weeks!

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7150.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index e8d0ff2..0b934f7 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -21,8 +21,8 @@
>   */
> 
>  #define AD7150_STATUS              0
> -#define AD7150_STATUS_OUT1         (1 << 3)
> -#define AD7150_STATUS_OUT2         (1 << 5)
> +#define AD7150_STATUS_OUT1         BIT(3)
> +#define AD7150_STATUS_OUT2         BIT(5)
>  #define AD7150_CH1_DATA_HIGH       1
>  #define AD7150_CH2_DATA_HIGH       3
>  #define AD7150_CH1_AVG_HIGH        5
> @@ -36,7 +36,7 @@
>  #define AD7150_CH2_TIMEOUT         13
>  #define AD7150_CH2_SETUP           14
>  #define AD7150_CFG                 15
> -#define AD7150_CFG_FIX             (1 << 7)
> +#define AD7150_CFG_FIX             BIT(7)
>  #define AD7150_PD_TIMER            16
>  #define AD7150_CH1_CAPDAC          17
>  #define AD7150_CH2_CAPDAC          18
> --
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

