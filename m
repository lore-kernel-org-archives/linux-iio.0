Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47010 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965570AbaLLKv3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:51:29 -0500
Message-ID: <548AC8AF.4080908@kernel.org>
Date: Fri, 12 Dec 2014 10:51:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/11] iio: Remove get_bytes_per_datum() from iio_buffer_access_funcs
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/11/14 17:55, Lars-Peter Clausen wrote:
> There haven't been any users of the get_bytes_per_datum() callback for a
> while. The core assumes that the number of bytes per datum can be calculated
> based on the enabled channels and the storage size of the channel and
> iio_compute_scan_bytes() is used to compute this number. So remove the
> callback.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - etc etc.
> ---
>  drivers/iio/kfifo_buf.c                    | 6 ------
>  drivers/staging/iio/Documentation/ring.txt | 4 ++--
>  drivers/staging/iio/accel/sca3000_ring.c   | 7 -------
>  include/linux/iio/buffer.h                 | 2 --
>  4 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 7134e8a..1258b4e 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -66,11 +66,6 @@ static struct attribute_group iio_kfifo_attribute_group = {
>  	.name = "buffer",
>  };
>  
> -static int iio_get_bytes_per_datum_kfifo(struct iio_buffer *r)
> -{
> -	return r->bytes_per_datum;
> -}
> -
>  static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
>  {
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> @@ -159,7 +154,6 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.read_first_n = &iio_read_first_n_kfifo,
>  	.data_available = iio_kfifo_buf_data_available,
>  	.request_update = &iio_request_update_kfifo,
> -	.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
>  	.get_length = &iio_get_length_kfifo,
>  	.set_length = &iio_set_length_kfifo,
> diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
> index e1da433..434d63a 100644
> --- a/drivers/staging/iio/Documentation/ring.txt
> +++ b/drivers/staging/iio/Documentation/ring.txt
> @@ -39,8 +39,8 @@ request_update
>    If parameters have changed that require reinitialization or configuration of
>    the buffer this will trigger it.
>  
> -get_bytes_per_datum, set_bytes_per_datum
> -  Get/set the number of bytes for a complete scan. (All samples + timestamp)
> +set_bytes_per_datum
> +  Set the number of bytes for a complete scan. (All samples + timestamp)
>  
>  get_length / set_length
>    Get/set the number of complete scans that may be held by the buffer.
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 1578276..aa0e5d8 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -135,12 +135,6 @@ static int sca3000_ring_get_length(struct iio_buffer *r)
>  	return 64;
>  }
>  
> -/* only valid if resolution is kept at 11bits */
> -static int sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
> -{
> -	return 6;
> -}
> -
>  static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
>  {
>  	return r->stufftoread;
> @@ -278,7 +272,6 @@ static void sca3000_ring_release(struct iio_buffer *r)
>  static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
>  	.read_first_n = &sca3000_read_first_n_hw_rb,
>  	.get_length = &sca3000_ring_get_length,
> -	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
>  	.data_available = sca3000_ring_buf_data_available,
>  	.release = sca3000_ring_release,
>  };
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index b0e006c..79cdb3d 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -25,7 +25,6 @@ struct iio_buffer;
>   *			available.
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
> - * @get_bytes_per_datum:get current bytes per datum
>   * @set_bytes_per_datum:set number of bytes per datum
>   * @get_length:		get number of datums in buffer
>   * @set_length:		set number of datums in buffer
> @@ -49,7 +48,6 @@ struct iio_buffer_access_funcs {
>  
>  	int (*request_update)(struct iio_buffer *buffer);
>  
> -	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
>  	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
>  	int (*get_length)(struct iio_buffer *buffer);
>  	int (*set_length)(struct iio_buffer *buffer, int length);
> 

