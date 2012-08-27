Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56245 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2H0RrF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 13:47:05 -0400
Message-ID: <503BB295.8010105@kernel.org>
Date: Mon, 27 Aug 2012 18:47:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:consumer.h: Fix include guard
References: <1345219066-5338-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1345219066-5338-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/2012 04:57 PM, Lars-Peter Clausen wrote:
> The symbol name for the #ifndef and the #define of the include guard do not
> match and thus it becomes quite ineffective. Add the missing '_' to fix this.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged
> ---
>  include/linux/iio/consumer.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index e2657e6..06ab4ec 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -8,7 +8,7 @@
>   * the Free Software Foundation.
>   */
>  #ifndef _IIO_INKERN_CONSUMER_H_
> -#define _IIO_INKERN_CONSUMER_H
> +#define _IIO_INKERN_CONSUMER_H_
>  #include <linux/iio/types.h>
>  
>  struct iio_dev;
> 
