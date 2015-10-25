Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59495 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbJYNu7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:50:59 -0400
Subject: Re: [PATCH v3 2/6] iio:iio_buffer_init(): Only set watermark if not
 already set
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1444752629-3532-1-git-send-email-lars@metafoo.de>
 <1444752629-3532-3-git-send-email-lars@metafoo.de>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CDE3E.8060100@kernel.org>
Date: Sun, 25 Oct 2015 13:50:54 +0000
MIME-Version: 1.0
In-Reply-To: <1444752629-3532-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/10/15 17:10, Lars-Peter Clausen wrote:
> Only initialize the watermark field if it is still 0. This allows drivers
> to provide a custom default watermark value. E.g. some driver might have a
> fixed watermark or can only support watermarks within a certain range and
> the initial value for the watermark should be within this range.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/iio/industrialio-buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 7340922..5f2c8c8 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -193,7 +193,8 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  	INIT_LIST_HEAD(&buffer->buffer_list);
>  	init_waitqueue_head(&buffer->pollq);
>  	kref_init(&buffer->ref);
> -	buffer->watermark = 1;
> +	if (!buffer->watermark)
> +		buffer->watermark = 1;
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>  
> 

