Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47542 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3JLLdZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 07:33:25 -0400
Message-ID: <525941B4.9090101@kernel.org>
Date: Sat, 12 Oct 2013 13:33:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] staging:iio:spear_adc: Remove unused variable
References: <1381152374-16567-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381152374-16567-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 14:26, Lars-Peter Clausen wrote:
> Remove the scale_mv variable from the read_raw() callback. Fixes the following
> warning:
> 	drivers/staging/iio/adc/spear_adc.c: In function 'spear_read_raw':
> 	drivers/staging/iio/adc/spear_adc.c:149:6: warning: unused variable 'scale_mv'
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Stefan Roese <sr@denx.de>
Applied to the togreg branch of iio.git

Thanks.
> ---
>  drivers/staging/iio/adc/spear_adc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 657e01b..fc99598 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -146,7 +146,6 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>  			  long mask)
>  {
>  	struct spear_adc_info *info = iio_priv(indio_dev);
> -	u32 scale_mv;
>  	u32 status;
>  
>  	switch (mask) {
> 
