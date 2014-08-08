Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-196.synserver.de ([212.40.185.196]:1053 "EHLO
	smtp-out-196.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaHHIvM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Aug 2014 04:51:12 -0400
Message-ID: <53E48F7D.5030402@metafoo.de>
Date: Fri, 08 Aug 2014 10:51:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer: Wrong sized allocation of demux table elements.
References: <1407487392-1671-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1407487392-1671-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/08/2014 10:43 AM, Jonathan Cameron wrote:
> The size of the allocation is currently set to the size of the pointer
> rather than the structure we should actually be allocating.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild@01.org
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Ok, that answers the earlier question.

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/industrialio-buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 84a952931f9f..ec82cb0bea38 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -951,7 +951,7 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
>   		(*p)->to + (*p)->length == out_loc) {
>   		(*p)->length += length;
>   	} else {
> -		*p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		*p = kmalloc(sizeof(**p), GFP_KERNEL);
>   		if (*p == NULL)
>   			return -ENOMEM;
>   		(*p)->from = in_loc;
>

