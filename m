Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35099 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdAUOSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:18:44 -0500
Subject: Re: [PATCH] iio: health: max30100: fixed parenthesis around FIFO
 count check
To: Matt Ranostay <matt@ranostay.consulting>
References: <20170117020418.23359-1-matt@ranostay.consulting>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <16c409d4-7d51-355f-a397-375aae301305@kernel.org>
Date: Sat, 21 Jan 2017 14:18:04 +0000
MIME-Version: 1.0
In-Reply-To: <20170117020418.23359-1-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 02:04, Matt Ranostay wrote:
> FIFO was being read every sample after the "almost full" state was
> reached. This was due to an incorrect placement of the parenthesis
> in the while condition check.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Fixes tags please in future.  I've applied this to the fixes-togreg
branch and marked for stable with a fixes tag of the last patch to
touch that line (which isn't really correct, but a backport would require
that patch anyway in addition to this one).

Jonathan
> ---
>  drivers/iio/health/max30100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 90ab8a2d2846..183c14329d6e 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -238,7 +238,7 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
>  
>  	mutex_lock(&data->lock);
>  
> -	while (cnt || (cnt = max30100_fifo_count(data) > 0)) {
> +	while (cnt || (cnt = max30100_fifo_count(data)) > 0) {
>  		ret = max30100_read_measurement(data);
>  		if (ret)
>  			break;
> 

