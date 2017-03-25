Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43426 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYQsN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 12:48:13 -0400
Subject: Re: [PATCH] staging: iio: tsl2x7x_core: Fix standard deviation
 calculation
To: Eva Rachel Retuya <eraretuya@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
References: <1490009225-10268-1-git-send-email-eraretuya@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, abhiram@cs.utah.edu
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <93c079ae-26f2-5d99-36a3-8d8cffbd99ef@kernel.org>
Date: Sat, 25 Mar 2017 16:48:10 +0000
MIME-Version: 1.0
In-Reply-To: <1490009225-10268-1-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 11:27, Eva Rachel Retuya wrote:
> Standard deviation is calculated as the square root of the variance
> where variance is the mean of sample_sum and length. Correct the
> computation of statP->stddev in accordance to the proper calculation.
> 
> Fixes: 3c97c08b5735 ("staging: iio: add TAOS tsl2x7x driver")
> Reported-by: Abhiram Balasubramanian <abhiram@cs.utah.edu>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
I've applied this to the togreg branch of iio.git rather than sending
as a quick fix for the simple reason that nothing currently uses the
value once it has been computed that I can immediately see!

That whole chunk of code probably just wants to be ripped out in
the longer term.

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index ea15bc1..197201a 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -854,7 +854,7 @@ void tsl2x7x_prox_calculate(int *data, int length,
>  		tmp = data[i] - statP->mean;
>  		sample_sum += tmp * tmp;
>  	}
> -	statP->stddev = int_sqrt((long)sample_sum) / length;
> +	statP->stddev = int_sqrt((long)sample_sum / length);
>  }
>  
>  /**
> 

