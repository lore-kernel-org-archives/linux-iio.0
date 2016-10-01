Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45359 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbcJAQJq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 12:09:46 -0400
Subject: Re: [PATCH] io: adc: ad7606_core: fix signed/unsigned number
 comparison
To: Ico Doornekamp <ico@pruts.nl>
References: <20160928134149.2563-1-ico@pruts.nl>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c4a0a801-14d6-7ea9-ec4f-958449a9dcb6@kernel.org>
Date: Sat, 1 Oct 2016 17:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <20160928134149.2563-1-ico@pruts.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/09/16 14:41, Ico Doornekamp wrote:
> reported by 'make W=2' in ad7606_oversampling_get_index()
> 
> Signed-off-by: Ico Doornekamp <ico@pruts.nl>
hmm. It's pretty much a non problem in the first place as we know
it can't cause issues (can see it is 7).   Also this really just
moves to typecasting it later when we return i.

So unless I'm missing something I'm not going to apply this one.

If Greg picks it up I don't mind though as doesn't do any harm
really.

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index f79ee61..681389a 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -158,7 +158,7 @@ static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
>  static int ad7606_oversampling_get_index(unsigned int val)
>  {
>  	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
> -	int i;
> +	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(supported); i++)
>  		if (val == supported[i])
> 

