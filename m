Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49945 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbbITKnj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:43:39 -0400
Subject: Re: [PATCH] Staging: iio: cdc: Remove unused macro
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Julia Lawall <julia.lawall@lip6.fr>
References: <1442407453-6030-1-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE8DD8.10809@kernel.org>
Date: Sun, 20 Sep 2015 11:43:36 +0100
MIME-Version: 1.0
In-Reply-To: <1442407453-6030-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/09/15 13:44, Shraddha Barke wrote:
> Remove the macro since it's not used anywhere throughout the kernel
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Whilst I have no objection to cleanup patches like this in general,
I would prefer a more thorough look at the driver.  For example, the
macro 2 lines above isn't used either.

So I'm not going to take this patch as it adds unnecessary noise.
If you want to take a good look at the whole driver and see what
else needs cleaning up then that would be great!

Speaking of which.  Lars, do you guys have any plans to get these devices
out of staging anytime soon? (or know of anyone else who does).
If not perhaps some guidance would help Shradda make that move if he is
interested in doing so?

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 10fa372..f5a807c 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -43,7 +43,6 @@
>  #define AD7746_REG_CAP_GAINH		15
>  #define AD7746_REG_CAP_GAINL		16
>  #define AD7746_REG_VOLT_GAINH		17
> -#define AD7746_REG_VOLT_GAINL		18
>  
>  /* Status Register Bit Designations (AD7746_REG_STATUS) */
>  #define AD7746_STATUS_EXCERR		BIT(3)
> 

