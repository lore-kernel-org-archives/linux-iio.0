Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42760 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbFNKUX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 06:20:23 -0400
Message-ID: <557D5562.8020209@kernel.org>
Date: Sun, 14 Jun 2015 11:20:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: Re: [PATCH] iio: Fix parameters in iio_triggered_buffer_setup
References: <20150611120635.GA15709@Inspiron>
In-Reply-To: <20150611120635.GA15709@Inspiron>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/15 13:06, Cristina Opriceana wrote:
> This patch renames the top half handler and the bottom half handler
> of iio_triggered_buffer_setup() in accordance with their usage.
> The names of the parameters were swapped, thus creating confusion.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Good point.  This is definitely misleading.  I wonder if the _th naming
is a good idea anymore though given that the bottom half (in the traditional
sense) is now a thread based call and hence the th might be confusing? 
Perhaps the h and thread naming used in the pollfunc code would be clearer?

Lars, this bit was yours originally.  Any thoughts?
 
> ---
>  drivers/iio/industrialio-triggered-buffer.c | 8 ++++----
>  include/linux/iio/triggered_buffer.h        | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
> index 15a5341..fd057e4 100644
> --- a/drivers/iio/industrialio-triggered-buffer.c
> +++ b/drivers/iio/industrialio-triggered-buffer.c
> @@ -24,8 +24,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
>  /**
>   * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
>   * @indio_dev:		IIO device structure
> - * @pollfunc_bh:	Function which will be used as pollfunc bottom half
>   * @pollfunc_th:	Function which will be used as pollfunc top half
> + * @pollfunc_bh:	Function which will be used as pollfunc bottom half
>   * @setup_ops:		Buffer setup functions to use for this device.
>   *			If NULL the default setup functions for triggered
>   *			buffers will be used.
> @@ -42,8 +42,8 @@ static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
>   * iio_triggered_buffer_cleanup().
>   */
>  int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
> -	irqreturn_t (*pollfunc_bh)(int irq, void *p),
>  	irqreturn_t (*pollfunc_th)(int irq, void *p),
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
>  	const struct iio_buffer_setup_ops *setup_ops)
>  {
>  	struct iio_buffer *buffer;
> @@ -57,8 +57,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
>  
>  	iio_device_attach_buffer(indio_dev, buffer);
>  
> -	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
> -						 pollfunc_th,
> +	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_th,
> +						 pollfunc_bh,
>  						 IRQF_ONESHOT,
>  						 indio_dev,
>  						 "%s_consumer%d",
> diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
> index c378ebe..f6f70d9 100644
> --- a/include/linux/iio/triggered_buffer.h
> +++ b/include/linux/iio/triggered_buffer.h
> @@ -7,8 +7,8 @@ struct iio_dev;
>  struct iio_buffer_setup_ops;
>  
>  int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
> -	irqreturn_t (*pollfunc_bh)(int irq, void *p),
>  	irqreturn_t (*pollfunc_th)(int irq, void *p),
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
>  	const struct iio_buffer_setup_ops *setup_ops);
>  void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
>  
> 

