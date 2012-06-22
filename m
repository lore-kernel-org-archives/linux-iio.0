Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43867 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761451Ab2FVHjs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jun 2012 03:39:48 -0400
Message-ID: <4FE4213E.5060104@cam.ac.uk>
Date: Fri, 22 Jun 2012 08:39:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio staging: fix typo, improve timestamp alignment
 comment
References: <1340312559-32753-1-git-send-email-pmeerw@pmeerw.net> <1340312559-32753-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340312559-32753-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

And there goes my olde worlde englishe.
:)

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/iio_simple_dummy_buffer.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index f4415da..b9e6093 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -83,7 +83,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>   			len += 2;
>   		}
>   	}
> -	/* Store a timestampe at an 8 byte boundary */
> +	/* Store the timestamp at an 8 byte aligned offset */
>   	if (indio_dev->scan_timestamp)
>   		*(s64 *)((phys_addr_t)data + ALIGN(len, sizeof(s64)))
>   			= iio_get_time_ns();
>


