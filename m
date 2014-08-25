Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46704 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbaHYUfm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:35:42 -0400
Message-ID: <53FB9E19.8070300@kernel.org>
Date: Mon, 25 Aug 2014 21:35:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/8] iio:trigger: modify return value for iio_trigger_get
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/14 21:48, Srinivas Pandruvada wrote:
> Instead of a void function, return the trigger pointer.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks for doing this,

Applied to the fixes-togreg branch of iio.git.

Jonathan
> ---
>  include/linux/iio/trigger.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 4b79ffe..fa76c79 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -84,10 +84,12 @@ static inline void iio_trigger_put(struct iio_trigger *trig)
>  	put_device(&trig->dev);
>  }
>  
> -static inline void iio_trigger_get(struct iio_trigger *trig)
> +static inline struct iio_trigger *iio_trigger_get(struct iio_trigger *trig)
>  {
>  	get_device(&trig->dev);
>  	__module_get(trig->ops->owner);
> +
> +	return trig;
>  }
>  
>  /**
> 
