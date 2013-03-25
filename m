Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60495 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3CYVK3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Mar 2013 17:10:29 -0400
Message-ID: <5150BD44.9030303@kernel.org>
Date: Mon, 25 Mar 2013 21:10:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio:trigger: Use dev_{set,get}_drvdata for private
 data management
References: <1364201906-30884-1-git-send-email-lars@metafoo.de> <1364201906-30884-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1364201906-30884-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/2013 08:58 AM, Lars-Peter Clausen wrote:
> Use dev_{set,get}_drvdata for managing private data attached to a trigger
> instead of using a custom field in the iio_trigger struct.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied to togreg branch of iio.git
> ---
>  drivers/staging/iio/Documentation/trigger.txt | 3 ---
>  include/linux/iio/trigger.h                   | 6 ++----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
> index 75cc37f..64e2e08 100644
> --- a/drivers/staging/iio/Documentation/trigger.txt
> +++ b/drivers/staging/iio/Documentation/trigger.txt
> @@ -10,9 +10,6 @@ struct iio_trig *trig = iio_trigger_alloc("<trigger format string>", ...);
>  allocates a trigger structure.  The key elements to then fill in within
>  a driver are:
>  
> -trig->private_data
> -	Device specific private data.
> -
>  trig->owner
>  	Typically set to THIS_MODULE. Used to ensure correct
>  	ownership of core allocated resources.
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index b81948a..3869c52 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -44,7 +44,6 @@ struct iio_trigger_ops {
>   * @id:			[INTERN] unique id number
>   * @name:		[DRIVER] unique name
>   * @dev:		[DRIVER] associated device (if relevant)
> - * @private_data:	[DRIVER] device specific data
>   * @list:		[INTERN] used in maintenance of global trigger list
>   * @alloc_list:		[DRIVER] used for driver specific trigger list
>   * @use_count:		use count for the trigger
> @@ -60,7 +59,6 @@ struct iio_trigger {
>  	const char			*name;
>  	struct device			dev;
>  
> -	void				*private_data;
>  	struct list_head		list;
>  	struct list_head		alloc_list;
>  	int use_count;
> @@ -101,7 +99,7 @@ static inline void iio_trigger_get(struct iio_trigger *trig)
>   */
>  static inline void iio_trigger_set_drvdata(struct iio_trigger *trig, void *data)
>  {
> -	trig->private_data = data;
> +	dev_set_drvdata(&trig->dev, data);
>  }
>  
>  /**
> @@ -112,7 +110,7 @@ static inline void iio_trigger_set_drvdata(struct iio_trigger *trig, void *data)
>   */
>  static inline void *iio_trigger_get_drvdata(struct iio_trigger *trig)
>  {
> -	return trig->private_data;
> +	return dev_get_drvdata(&trig->dev);
>  }
>  
>  /**
> 
