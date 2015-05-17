Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58931 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbEQJBg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 05:01:36 -0400
Message-ID: <555858EB.30500@kernel.org>
Date: Sun, 17 May 2015 10:01:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: __iio_update_buffers: Perform request_update()
 only for new buffers
References: <1431525891-19285-1-git-send-email-lars@metafoo.de> <1431525891-19285-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 15:04, Lars-Peter Clausen wrote:
> We only have to call the request_update() callback for a newly inserted
> buffer. The configuration of the already previously active buffers will not
> have changed.
> 
> This also allows us to move the request_update() call to the beginning of
> __iio_update_buffers(), before any currently active buffers are stopped.
> This makes the error handling a lot easier since no changes were made to
> the buffer list and no rollback needs to be performed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Good spot. If I were guessing I would think this probably dates back to early stages
of implementing the demux when it was possible for buffers to change as a result
of others being added.  Mind you that was probably fixed before I even posted
this beast ;)

Whilst looking at this I notice that currently the call to request_update, in event
of not changing the size of the kfifo, calls kfifo_reset_out which seems undesirable
if we are not actually modifying this buffer (your change here prevents this anyway).

Anyhow, I think this side effect is desirable and I doubt anyone will notice given
the rather small set of systems actually using this code in the way that would hit
it.

Hence applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2afe3db..21ed316 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -575,6 +575,25 @@ static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
>  	buffer->access->set_bytes_per_datum(buffer, bytes);
>  }
>  
> +static int iio_buffer_request_update(struct iio_dev *indio_dev,
> +	struct iio_buffer *buffer)
> +{
> +	int ret;
> +
> +	iio_buffer_update_bytes_per_datum(indio_dev, buffer);
> +	if (buffer->access->request_update) {
> +		ret = buffer->access->request_update(buffer);
> +		if (ret) {
> +			dev_dbg(&indio_dev->dev,
> +			       "Buffer not started: buffer parameter update failed (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void iio_free_scan_mask(struct iio_dev *indio_dev,
>  	const unsigned long *mask)
>  {
> @@ -593,6 +612,12 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  	unsigned long *compound_mask;
>  	const unsigned long *old_mask;
>  
> +	if (insert_buffer) {
> +		ret = iio_buffer_request_update(indio_dev, insert_buffer);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* Wind down existing buffers - iff there are any */
>  	if (!list_empty(&indio_dev->buffer_list)) {
>  		if (indio_dev->setup_ops->predisable) {
> @@ -678,17 +703,6 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		iio_compute_scan_bytes(indio_dev,
>  				       indio_dev->active_scan_mask,
>  				       indio_dev->scan_timestamp);
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list) {
> -		iio_buffer_update_bytes_per_datum(indio_dev, buffer);
> -		if (buffer->access->request_update) {
> -			ret = buffer->access->request_update(buffer);
> -			if (ret) {
> -				dev_dbg(&indio_dev->dev,
> -				       "Buffer not started: buffer parameter update failed (%d)\n", ret);
> -				goto error_run_postdisable;
> -			}
> -		}
> -	}
>  	if (indio_dev->info->update_scan_mode) {
>  		ret = indio_dev->info
>  			->update_scan_mode(indio_dev,
> 

