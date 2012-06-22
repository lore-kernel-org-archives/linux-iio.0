Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:38191 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761526Ab2FVHgY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jun 2012 03:36:24 -0400
Message-ID: <4FE42073.4080102@cam.ac.uk>
Date: Fri, 22 Jun 2012 08:36:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio staging: simplify timestamp alignment in iio_simple_dummy
References: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net> <1340312559-32753-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340312559-32753-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/21/2012 10:02 PM, Peter Meerwald wrote:

Hmm. I wonder how many other hand rolled versions of this are kicking 
about..
  Good spot. Thanks,
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/iio_simple_dummy_buffer.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index d911960..f4415da 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -85,8 +85,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>   	}
>   	/* Store a timestampe at an 8 byte boundary */
>   	if (indio_dev->scan_timestamp)
> -		*(s64 *)(((phys_addr_t)data + len
> -				+ sizeof(s64) - 1) & ~(sizeof(s64) - 1))
> +		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))

>   	buffer->access->store_to(buffer, (u8 *)data, pf->timestamp);
>
>


