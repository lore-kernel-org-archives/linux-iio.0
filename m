Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56261 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2H0RrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 13:47:25 -0400
Message-ID: <503BB2AB.6040904@kernel.org>
Date: Mon, 27 Aug 2012 18:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio:trigger_consumer.h: Add missing includes and
 forward declarations
References: <1345219066-5338-1-git-send-email-lars@metafoo.de> <1345219066-5338-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1345219066-5338-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/2012 04:57 PM, Lars-Peter Clausen wrote:
> Add includes and forward declarations for types used in this file. This avoids
> compile errors if the other files have not been included before.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged to togreg
> ---
>  include/linux/iio/trigger_consumer.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 762a3d3..c4f8c74 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -10,6 +10,12 @@
>  #ifndef __LINUX_IIO_TRIGGER_CONSUMER_H__
>  #define __LINUX_IIO_TRIGGER_CONSUMER_H__
>  
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +
> +struct iio_dev;
> +struct iio_trigger;
> +
>  /**
>   * struct iio_poll_func - poll function pair
>   *
> 
