Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35857 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbbFAVRK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:10 -0400
Message-ID: <556C3546.4020300@kernel.org>
Date: Mon, 01 Jun 2015 11:34:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Require strict scan mask matching in hardware
 mode
References: <1432916062-15195-1-git-send-email-lars@metafoo.de> <1432916062-15195-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1432916062-15195-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/05/15 17:14, Lars-Peter Clausen wrote:
> In hardware mode we can not use the software demuxer, this means that the
> selected scan mask needs to match one of the available scan masks exactly.
> 
> It also means that all attached buffers need to use the same scan mask.
> Given that when operating in hardware mode there is typically only a single
> buffer attached to the device this not an issue. Add a sanity check to make
> sure that only a single buffer is attached in hardware mode nevertheless.
> 
That pretty much sums up why devices supporting only hardware buffers
are probably not going to be a long term feature!
Mind you for fast devices we may want to allow forced bypassing of the
demux (i.e. a hardware buffer).

Out of curiosity is this series a precursor to another hardware buffered
device or just a useful intellectual exercise?


Applied. 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/iio/industrialio-buffer.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4250e97..e174fcc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -239,13 +239,19 @@ static ssize_t iio_scan_el_show(struct device *dev,
>  /* Note NULL used as error indicator as it doesn't make sense. */
>  static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
>  					  unsigned int masklength,
> -					  const unsigned long *mask)
> +					  const unsigned long *mask,
> +					  bool strict)
>  {
>  	if (bitmap_empty(mask, masklength))
>  		return NULL;
>  	while (*av_masks) {
> -		if (bitmap_subset(mask, av_masks, masklength))
> -			return av_masks;
> +		if (strict) {
> +			if (bitmap_equal(mask, av_masks, masklength))
> +				return av_masks;
> +		} else {
> +			if (bitmap_subset(mask, av_masks, masklength))
> +				return av_masks;
> +		}
>  		av_masks += BITS_TO_LONGS(masklength);
>  	}
>  	return NULL;
> @@ -295,7 +301,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	if (indio_dev->available_scan_masks) {
>  		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
>  					   indio_dev->masklength,
> -					   trialmask);
> +					   trialmask, false);
>  		if (!mask)
>  			goto err_invalid_mask;
>  	}
> @@ -602,6 +608,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  {
>  	unsigned long *compound_mask;
>  	const unsigned long *scan_mask;
> +	bool strict_scanmask = false;
>  	struct iio_buffer *buffer;
>  	bool scan_timestamp;
>  	unsigned int modes;
> @@ -631,7 +638,14 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
>  		config->mode = INDIO_BUFFER_TRIGGERED;
>  	} else if (modes & INDIO_BUFFER_HARDWARE) {
> +		/*
> +		 * Keep things simple for now and only allow a single buffer to
> +		 * be connected in hardware mode.
> +		 */
> +		if (insert_buffer && !list_empty(&indio_dev->buffer_list))
> +			return -EINVAL;
>  		config->mode = INDIO_BUFFER_HARDWARE;
> +		strict_scanmask = true;
>  	} else if (modes & INDIO_BUFFER_SOFTWARE) {
>  		config->mode = INDIO_BUFFER_SOFTWARE;
>  	} else {
> @@ -666,7 +680,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	if (indio_dev->available_scan_masks) {
>  		scan_mask = iio_scan_mask_match(indio_dev->available_scan_masks,
>  				    indio_dev->masklength,
> -				    compound_mask);
> +				    compound_mask,
> +				    strict_scanmask);
>  		kfree(compound_mask);
>  		if (scan_mask == NULL)
>  			return -EINVAL;
> 

