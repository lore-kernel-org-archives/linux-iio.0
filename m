Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56248 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2H0RrO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 13:47:14 -0400
Message-ID: <503BB2A1.904@kernel.org>
Date: Mon, 27 Aug 2012 18:47:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: Add missing include guards to headers
References: <1345219066-5338-1-git-send-email-lars@metafoo.de> <1345219066-5338-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1345219066-5338-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/2012 04:57 PM, Lars-Peter Clausen wrote:
> Add include guards to the IIO headers where they are missing. This avoids
> compile errors due to redefined types if a file is included more than once.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merge to togreg
> 
> ---
> strictly speaking kfifo_buf.h does not need one, since it only declares
> functions, but I'd consider it to be good style to have them anyway.
> ---
>  include/linux/iio/kfifo_buf.h        |    3 +++
>  include/linux/iio/machine.h          |    5 +++++
>  include/linux/iio/trigger_consumer.h |    5 +++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> index 014d5a1..25eeac7 100644
> --- a/include/linux/iio/kfifo_buf.h
> +++ b/include/linux/iio/kfifo_buf.h
> @@ -1,3 +1,5 @@
> +#ifndef __LINUX_IIO_KFIFO_BUF_H__
> +#define __LINUX_IIO_KFIFO_BUF_H__
>  
>  #include <linux/kfifo.h>
>  #include <linux/iio/iio.h>
> @@ -6,3 +8,4 @@
>  struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
>  void iio_kfifo_free(struct iio_buffer *r);
>  
> +#endif
> diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
> index 400a453..809a3f0 100644
> --- a/include/linux/iio/machine.h
> +++ b/include/linux/iio/machine.h
> @@ -8,6 +8,9 @@
>   * the Free Software Foundation.
>   */
>  
> +#ifndef __LINUX_IIO_MACHINE_H__
> +#define __LINUX_IIO_MACHINE_H__
> +
>  /**
>   * struct iio_map - description of link between consumer and device channels
>   * @adc_channel_label:	Label used to identify the channel on the provider.
> @@ -22,3 +25,5 @@ struct iio_map {
>  	const char *consumer_dev_name;
>  	const char *consumer_channel;
>  };
> +
> +#endif
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 60d64b3..762a3d3 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -7,6 +7,9 @@
>   * the Free Software Foundation.
>   */
>  
> +#ifndef __LINUX_IIO_TRIGGER_CONSUMER_H__
> +#define __LINUX_IIO_TRIGGER_CONSUMER_H__
> +
>  /**
>   * struct iio_poll_func - poll function pair
>   *
> @@ -50,3 +53,5 @@ void iio_trigger_notify_done(struct iio_trigger *trig);
>   */
>  int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
>  int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
> +
> +#endif
> 
