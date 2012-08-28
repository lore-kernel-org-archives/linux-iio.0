Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40329 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab2H1Tms (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Aug 2012 15:42:48 -0400
Message-ID: <503D1F37.3050109@kernel.org>
Date: Tue, 28 Aug 2012 20:42:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: whitespace cleanup and removal of semicolon after
 functions
References: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net> <1345985019-24288-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1345985019-24288-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/2012 01:43 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
merged to togreg branch.

Thanks for this set Peter.  Nice to clean up these bits and bobs!
> ---
>  drivers/iio/industrialio-buffer.c |   10 +++++-----
>  drivers/iio/industrialio-core.c   |    2 +-
>  include/linux/iio/iio.h           |    8 ++++----
>  include/linux/iio/trigger.h       |    8 ++++----
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4add9bb..774891c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -422,7 +422,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = indio_dev->setup_ops->preenable(indio_dev);
>  			if (ret) {
>  				printk(KERN_ERR
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "buffer preenable failed\n");
>  				goto error_ret;
>  			}
> @@ -431,12 +431,12 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = buffer->access->request_update(buffer);
>  			if (ret) {
>  				printk(KERN_INFO
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "buffer parameter update failed\n");
>  				goto error_ret;
>  			}
>  		}
> -		/* Definitely possible for devices to support both of these.*/
> +		/* Definitely possible for devices to support both of these. */
>  		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED) {
>  			if (!indio_dev->trig) {
>  				printk(KERN_INFO
> @@ -456,7 +456,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  			ret = indio_dev->setup_ops->postenable(indio_dev);
>  			if (ret) {
>  				printk(KERN_INFO
> -				       "Buffer not started:"
> +				       "Buffer not started: "
>  				       "postenable failed\n");
>  				indio_dev->currentmode = previous_mode;
>  				if (indio_dev->setup_ops->postdisable)
> @@ -657,7 +657,7 @@ EXPORT_SYMBOL_GPL(iio_scan_mask_query);
>  /**
>   * struct iio_demux_table() - table describing demux memcpy ops
>   * @from:	index to copy from
> - * @to:	index to copy to
> + * @to:		index to copy to
>   * @length:	how many bytes to copy
>   * @l:		list head used for management
>   */
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 47c1ffa..a288792 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -29,7 +29,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  
> -/* IDA to assign each registered device a unique id*/
> +/* IDA to assign each registered device a unique id */
>  static DEFINE_IDA(iio_ida);
>  
>  static dev_t iio_devt;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f966a7e..3530a0c 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -371,10 +371,10 @@ struct iio_info {
>   *			scan mask is valid for the device.
>   */
>  struct iio_buffer_setup_ops {
> -	int				(*preenable)(struct iio_dev *);
> -	int				(*postenable)(struct iio_dev *);
> -	int				(*predisable)(struct iio_dev *);
> -	int				(*postdisable)(struct iio_dev *);
> +	int (*preenable)(struct iio_dev *);
> +	int (*postenable)(struct iio_dev *);
> +	int (*predisable)(struct iio_dev *);
> +	int (*postdisable)(struct iio_dev *);
>  	bool (*validate_scan_mask)(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask);
>  };
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index f0af267..20239da 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -29,7 +29,7 @@ struct iio_subirq {
>   * instances of a given device.
>   **/
>  struct iio_trigger_ops {
> -	struct module			*owner;
> +	struct module *owner;
>  	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>  	int (*try_reenable)(struct iio_trigger *trig);
>  	int (*validate_device)(struct iio_trigger *trig,
> @@ -76,19 +76,19 @@ struct iio_trigger {
>  static inline struct iio_trigger *to_iio_trigger(struct device *d)
>  {
>  	return container_of(d, struct iio_trigger, dev);
> -};
> +}
>  
>  static inline void iio_trigger_put(struct iio_trigger *trig)
>  {
>  	module_put(trig->ops->owner);
>  	put_device(&trig->dev);
> -};
> +}
>  
>  static inline void iio_trigger_get(struct iio_trigger *trig)
>  {
>  	get_device(&trig->dev);
>  	__module_get(trig->ops->owner);
> -};
> +}
>  
>  /**
>   * iio_trigger_register() - register a trigger with the IIO core
> 
