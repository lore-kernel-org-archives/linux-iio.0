Return-Path: <jic23@kernel.org>
Message-ID: <4EE08325.5070301@kernel.org>
Date: Thu, 08 Dec 2011 09:28:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio: Fix sw_ring memory corruption
References: <1323263262-11935-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1323263262-11935-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/07/2011 01:07 PM, Lars-Peter Clausen wrote:
> The sw_ring does not properly handle the case where the write pointer already
> has wrapped around, the read pointer has not and the remaining buffer space at
> the end is enough to fill the read buffer:
> 
>   +-----------------------------------+
>   |     |              |##data##|     |
>   +-----------------------------------+
>      write_p        read_p
> 
> In this case the current code will copy all available data to the buffer and
> as a result will write beyound the bounds of the buffer and cause a memory
> corruption.
> 
> To address this issue this patch adds code to calculate the available buffer
> space and makes sure that the number of bytes to copy does not exceed this
> number. This allows the code which copies the data around to be simplified as
> it only has to consider two cases: Read wraps around and read does not wrap
> around.
oops.  I always said there were probably some bugs hiding in here.

Nice explanation btw. Made it easy to find the issue you were pointing
out.  One trivial suggestion inline.  Take it or leave it as you like.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/ring_sw.c |   58 ++++++++++++++++------------------------
>  1 files changed, 23 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index c476e23..c28872a 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -174,6 +174,7 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
>  	u8 *initial_read_p, *initial_write_p, *current_read_p, *end_read_p;
>  	u8 *data;
>  	int ret, max_copied, bytes_to_rip, dead_offset;
> +	size_t data_available, buffer_size;
>  
>  	/* A userspace program has probably made an error if it tries to
>  	 *  read something that is not a whole number of bpds.
> @@ -186,9 +187,11 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
>  		       n, ring->buf.bytes_per_datum);
>  		goto error_ret;
>  	}
> +
> +	buffer_size = ring->buf.bytes_per_datum*ring->buf.length;
> +
>  	/* Limit size to whole of ring buffer */
> -	bytes_to_rip = min((size_t)(ring->buf.bytes_per_datum*ring->buf.length),
> -			   n);
> +	bytes_to_rip = min_t(size_t, buffer_size, n);
nice. Another useful function I never realized existed..
>  
>  	data = kmalloc(bytes_to_rip, GFP_KERNEL);
>  	if (data == NULL) {
> @@ -217,38 +220,24 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
>  		goto error_free_data_cpy;
>  	}
>  
> -	if (initial_write_p >= initial_read_p + bytes_to_rip) {
> -		/* write_p is greater than necessary, all is easy */
> -		max_copied = bytes_to_rip;
> -		memcpy(data, initial_read_p, max_copied);
> -		end_read_p = initial_read_p + max_copied;
> -	} else if (initial_write_p > initial_read_p) {
> -		/*not enough data to cpy */
> -		max_copied = initial_write_p - initial_read_p;
> +	if (initial_write_p >= initial_read_p)
> +		data_available = initial_write_p - initial_read_p;
> +	else
> +		data_available = buffer_size - (initial_read_p - initial_write_p);
> +
could use min() here for slightly more obvious code.
> +	if (data_available < bytes_to_rip)
> +		bytes_to_rip = data_available;
> +
> +	if (initial_read_p + bytes_to_rip >= ring->data + buffer_size) {
> +		max_copied = ring->data + buffer_size - initial_read_p;
>  		memcpy(data, initial_read_p, max_copied);
> -		end_read_p = initial_write_p;
> +		memcpy(data + max_copied, ring->data, bytes_to_rip - max_copied);
> +		end_read_p = ring->data + bytes_to_rip - max_copied;
>  	} else {
> -		/* going through 'end' of ring buffer */
> -		max_copied = ring->data
> -			+ ring->buf.length*ring->buf.bytes_per_datum - initial_read_p;
> -		memcpy(data, initial_read_p, max_copied);
> -		/* possible we are done if we align precisely with end */
> -		if (max_copied == bytes_to_rip)
> -			end_read_p = ring->data;
> -		else if (initial_write_p
> -			 > ring->data + bytes_to_rip - max_copied) {
> -			/* enough data to finish */
> -			memcpy(data + max_copied, ring->data,
> -			       bytes_to_rip - max_copied);
> -			max_copied = bytes_to_rip;
> -			end_read_p = ring->data + (bytes_to_rip - max_copied);
> -		} else {  /* not enough data */
> -			memcpy(data + max_copied, ring->data,
> -			       initial_write_p - ring->data);
> -			max_copied += initial_write_p - ring->data;
> -			end_read_p = initial_write_p;
> -		}
> +		memcpy(data, initial_read_p, bytes_to_rip);
> +		end_read_p = initial_read_p + bytes_to_rip;
>  	}
> +
>  	/* Now to verify which section was cleanly copied - i.e. how far
>  	 * read pointer has been pushed */
>  	current_read_p = ring->read_p;
> @@ -256,15 +245,14 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
>  	if (initial_read_p <= current_read_p)
>  		dead_offset = current_read_p - initial_read_p;
>  	else
> -		dead_offset = ring->buf.length*ring->buf.bytes_per_datum
> -			- (initial_read_p - current_read_p);
> +		dead_offset = buffer_size - (initial_read_p - current_read_p);
>  
>  	/* possible issue if the initial write has been lapped or indeed
>  	 * the point we were reading to has been passed */
>  	/* No valid data read.
>  	 * In this case the read pointer is already correct having been
>  	 * pushed further than we would look. */
> -	if (max_copied - dead_offset < 0) {
> +	if (bytes_to_rip - dead_offset < 0) {
>  		ret = 0;
>  		goto error_free_data_cpy;
>  	}
> @@ -280,7 +268,7 @@ static int iio_read_first_n_sw_rb(struct iio_buffer *r,
>  	while (ring->read_p != end_read_p)
>  		ring->read_p = end_read_p;
>  
> -	ret = max_copied - dead_offset;
> +	ret = bytes_to_rip - dead_offset;
>  
>  	if (copy_to_user(buf, data + dead_offset, ret))  {
>  		ret =  -EFAULT;
