Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59512 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbbJYNwv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:52:51 -0400
Subject: Re: [PATCH v3 4/6] iio: Add buffer enable/disable callbacks
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1444752629-3532-1-git-send-email-lars@metafoo.de>
 <1444752629-3532-5-git-send-email-lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CDEB1.9030005@kernel.org>
Date: Sun, 25 Oct 2015 13:52:49 +0000
MIME-Version: 1.0
In-Reply-To: <1444752629-3532-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/10/15 17:10, Lars-Peter Clausen wrote:
> This patch adds a enable and disable callback that is called when the
> buffer is enabled/disabled. This can be used by buffer implementations that
> need to do some setup or teardown work. E.g. a DMA based buffer can use
> this to start/stop the DMA transfer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/iio/buffer.h        |  8 ++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 98a6447..a4b164a 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -568,6 +568,22 @@ static void iio_buffer_deactivate_all(struct iio_dev *indio_dev)
>  		iio_buffer_deactivate(buffer);
>  }
>  
> +static int iio_buffer_enable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev)
> +{
> +	if (!buffer->access->enable)
> +		return 0;
> +	return buffer->access->enable(buffer, indio_dev);
> +}
> +
> +static int iio_buffer_disable(struct iio_buffer *buffer,
> +	struct iio_dev *indio_dev)
> +{
> +	if (!buffer->access->disable)
> +		return 0;
> +	return buffer->access->disable(buffer, indio_dev);
> +}
> +
>  static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
>  	struct iio_buffer *buffer)
>  {
> @@ -719,6 +735,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	struct iio_device_config *config)
>  {
> +	struct iio_buffer *buffer;
>  	int ret;
>  
>  	indio_dev->active_scan_mask = config->scan_mask;
> @@ -753,6 +770,12 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		indio_dev->info->hwfifo_set_watermark(indio_dev,
>  			config->watermark);
>  
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		ret = iio_buffer_enable(buffer, indio_dev);
> +		if (ret)
> +			goto err_disable_buffers;
> +	}
> +
>  	indio_dev->currentmode = config->mode;
>  
>  	if (indio_dev->setup_ops->postenable) {
> @@ -760,12 +783,16 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		if (ret) {
>  			dev_dbg(&indio_dev->dev,
>  			       "Buffer not started: postenable failed (%d)\n", ret);
> -			goto err_run_postdisable;
> +			goto err_disable_buffers;
>  		}
>  	}
>  
>  	return 0;
>  
> +err_disable_buffers:
> +	list_for_each_entry_continue_reverse(buffer, &indio_dev->buffer_list,
> +					     buffer_list)
> +		iio_buffer_disable(buffer, indio_dev);
>  err_run_postdisable:
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  	if (indio_dev->setup_ops->postdisable)
> @@ -778,6 +805,7 @@ err_undo_config:
>  
>  static int iio_disable_buffers(struct iio_dev *indio_dev)
>  {
> +	struct iio_buffer *buffer;
>  	int ret = 0;
>  	int ret2;
>  
> @@ -798,6 +826,12 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  			ret = ret2;
>  	}
>  
> +	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> +		ret2 = iio_buffer_disable(buffer, indio_dev);
> +		if (ret2 && !ret)
> +			ret = ret2;
> +	}
> +
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  
>  	if (indio_dev->setup_ops->postdisable) {
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 4d99a53..2ec3ad5 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -33,6 +33,11 @@ struct iio_buffer;
>   *			storage.
>   * @set_bytes_per_datum:set number of bytes per datum
>   * @set_length:		set number of datums in buffer
> + * @enable:             called if the buffer is attached to a device and the
> + *                      device starts sampling. Calls are balanced with
> + *                      @disable.
> + * @disable:            called if the buffer is attached to a device and the
> + *                      device stops sampling. Calles are balanced with @enable.
>   * @release:		called when the last reference to the buffer is dropped,
>   *			should free all resources allocated by the buffer.
>   * @modes:		Supported operating modes by this buffer type
> @@ -58,6 +63,9 @@ struct iio_buffer_access_funcs {
>  	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
>  	int (*set_length)(struct iio_buffer *buffer, int length);
>  
> +	int (*enable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
> +	int (*disable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
> +
>  	void (*release)(struct iio_buffer *buffer);
>  
>  	unsigned int modes;
> 

