Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54657 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCRaB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 13:30:01 -0400
Message-ID: <4FF32C18.1050907@kernel.org>
Date: Tue, 03 Jul 2012 18:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: cleanup buffer.h comments
References: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net> <1341096463-13789-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341096463-13789-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2012 11:47 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
merged thanks.
> ---
>  include/linux/iio/buffer.h |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index ad4fb1a..2a2b6b4 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -85,7 +85,7 @@ struct iio_buffer {
>  
>  /**
>   * iio_buffer_init() - Initialize the buffer structure
> - * @buffer: buffer to be initialized
> + * @buffer:		buffer to be initialized
>   **/
>  void iio_buffer_init(struct iio_buffer *buffer);
>  
> @@ -107,8 +107,9 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
>  
>  /**
>   * iio_scan_mask_set() - set particular bit in the scan mask
> - * @buffer: the buffer whose scan mask we are interested in
> - * @bit: the bit to be set.
> + * @indio_dev		IIO device structure
> + * @buffer:		the buffer whose scan mask we are interested in
> + * @bit:		the bit to be set.
>   **/
>  int iio_scan_mask_set(struct iio_dev *indio_dev,
>  		      struct iio_buffer *buffer, int bit);
> @@ -116,8 +117,8 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>  /**
>   * iio_push_to_buffer() - push to a registered buffer.
>   * @buffer:		IIO buffer structure for device
> - * @scan:		Full scan.
> - * @timestamp:
> + * @data:		the data to push to the buffer
> + * @timestamp:		timestamp to associate with the data
>   */
>  int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
>  		       s64 timestamp);
> @@ -126,7 +127,9 @@ int iio_update_demux(struct iio_dev *indio_dev);
>  
>  /**
>   * iio_buffer_register() - register the buffer with IIO core
> - * @indio_dev: device with the buffer to be registered
> + * @indio_dev:		device with the buffer to be registered
> + * @channels:		the channel descriptions used to construct buffer
> + * @num_channels:	the number of channels
>   **/
>  int iio_buffer_register(struct iio_dev *indio_dev,
>  			const struct iio_chan_spec *channels,
> @@ -134,7 +137,7 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>  
>  /**
>   * iio_buffer_unregister() - unregister the buffer from IIO core
> - * @indio_dev: the device with the buffer to be unregistered
> + * @indio_dev:		the device with the buffer to be unregistered
>   **/
>  void iio_buffer_unregister(struct iio_dev *indio_dev);
>  
> 


