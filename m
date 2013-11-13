Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56602 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585Ab3KMTgC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 14:36:02 -0500
Message-ID: <5283E2EE.5090204@kernel.org>
Date: Wed, 13 Nov 2013 20:37:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Remove redundant check that new trigger is different
 from old
References: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net> <1384292987-6250-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384292987-6250-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/13 21:49, Peter Meerwald wrote:
> same check is performed a new lines above
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Good catch, applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 021d735..5bf13ed 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -356,7 +356,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  
>  	indio_dev->trig = trig;
>  
> -	if (oldtrig && indio_dev->trig != oldtrig)
> +	if (oldtrig)
>  		iio_trigger_put(oldtrig);
>  	if (indio_dev->trig)
>  		iio_trigger_get(indio_dev->trig);
> 
