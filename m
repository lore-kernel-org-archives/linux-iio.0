Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59421 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbJYNk0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:40:26 -0400
Subject: Re: [PATCH] iio:ad7793: Fix ad7785 product ID
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1444654588-25350-1-git-send-email-lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CDBC9.9090409@kernel.org>
Date: Sun, 25 Oct 2015 13:40:25 +0000
MIME-Version: 1.0
In-Reply-To: <1444654588-25350-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/15 13:56, Lars-Peter Clausen wrote:
> While the datasheet for the AD7785 lists 0xXB as the product ID the actual
> product ID is 0xX3.
> 
> Fix the product ID otherwise the driver will reject the device due to non
> matching IDs.
> 
> Fixes: e786cc26dcc5 ("staging:iio:ad7793: Implement stricter id checking")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/adc/ad7793.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b84922a..710aee8 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -101,7 +101,7 @@
>  #define AD7795_CH_AIN1M_AIN1M	8 /* AIN1(-) - AIN1(-) */
>  
>  /* ID Register Bit Designations (AD7793_REG_ID) */
> -#define AD7785_ID		0xB
> +#define AD7785_ID		0x3
>  #define AD7792_ID		0xA
>  #define AD7793_ID		0xB
>  #define AD7794_ID		0xF
> 

