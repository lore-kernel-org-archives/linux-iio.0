Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45365 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbHBR1T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:27:19 -0400
Subject: Re: [PATCH 2/6] iio: buffer: Fix kernel docs warnings
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
 <b36f8de1969bd0650e07bbac57d7120d700a8d32.1437737942.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE52F6.7020608@kernel.org>
Date: Sun, 2 Aug 2015 18:27:18 +0100
MIME-Version: 1.0
In-Reply-To: <b36f8de1969bd0650e07bbac57d7120d700a8d32.1437737942.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:18, Cristina Opriceana wrote:
> Fix kernel docs for structures and functions in order to
> remove some warnings when the documentation gets generated.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Applied with another typo fixed up.
> ---
>  drivers/iio/industrialio-buffer.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b13f941..a671953 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -91,9 +91,16 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>  
>  /**
>   * iio_buffer_read_first_n_outer() - chrdev read for buffer access
> + * @filp:	File structure pointer for the char device
> + * @buf:	Destination buffer for iio buffer read
> + * @n:		First n bytes to read
> + * @f_ps:	Long offset provided by the user as a seek position
>   *
>   * This function relies on all buffer implementations having an
>   * iio_buffer as their first element.
> + *
> + * Return: negative values corresponding to error codes or ret != 0
> + *	   for ending the reading activity
>   **/
>  ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  				      size_t n, loff_t *f_ps)
> @@ -143,6 +150,12 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>  
>  /**
>   * iio_buffer_poll() - poll the buffer to find out if it has data
> + * @filp:	File structure poiner for device access
pointer
> + * @wait:	Poll table structure pointer for which the driver adds
> + *		a wait queue
> + *
> + * Return: (POLLIN | POLLRDNORM) if data is available for reading
> + *	   or 0 for other cases
>   */
>  unsigned int iio_buffer_poll(struct file *filp,
>  			     struct poll_table_struct *wait)
> @@ -1136,7 +1149,7 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
>  EXPORT_SYMBOL_GPL(iio_scan_mask_query);
>  
>  /**
> - * struct iio_demux_table() - table describing demux memcpy ops
> + * struct iio_demux_table - table describing demux memcpy ops
>   * @from:	index to copy from
>   * @to:		index to copy to
>   * @length:	how many bytes to copy
> 

