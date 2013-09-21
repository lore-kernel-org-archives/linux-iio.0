Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56234 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3IUKVk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:21:40 -0400
Message-ID: <523D8158.4090402@kernel.org>
Date: Sat, 21 Sep 2013 12:22:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Pass scan mask as unsigned long
References: <1379538649-9675-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379538649-9675-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 22:10, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/industrialio-buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 58180ec..2361fbc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -429,8 +429,8 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
>  	return NULL;
>  }
>  
> -static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
> -				  bool timestamp)
> +static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
> +				const unsigned long *mask, bool timestamp)
>  {
>  	const struct iio_chan_spec *ch;
>  	unsigned bytes = 0;
> 
