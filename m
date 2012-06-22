Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43418 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761451Ab2FVHit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jun 2012 03:38:49 -0400
Message-ID: <4FE42104.3030201@cam.ac.uk>
Date: Fri, 22 Jun 2012 08:38:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio staging: fix trigger handler of iio_simple_dummy
 driver
References: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/21/2012 10:02 PM, Peter Meerwald wrote:
> accessing first and last channel fails:
> fakedata[0] is never accessed, out-of-bound access for last channel
oops. Strange I never spotted this whilst testing.  Ah well, one of 
those wierd ones!
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/iio_simple_dummy_buffer.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index fa4939c..d911960 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -75,9 +75,9 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>   		for (i = 0, j = 0;
>   		     i < bitmap_weight(indio_dev->active_scan_mask,
>   				       indio_dev->masklength);
> -		     i++) {
> +		     i++, j++) {
>   			j = find_next_bit(buffer->scan_mask,
> -					  indio_dev->masklength, j + 1);
> +					  indio_dev->masklength, j);
>   			/* random access read from the 'device' */
>   			data[i] = fakedata[j];
>   			len += 2;
>


