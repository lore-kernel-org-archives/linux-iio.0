Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMTzS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 15:55:18 -0400
Date: Tue, 13 Jun 2017 20:55:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: buffer-dmaengine: Add missing header
 buffer_impl.h
Message-ID: <20170613205514.536a3336@kernel.org>
In-Reply-To: <1497330755-30742-1-git-send-email-preid@electromag.com.au>
References: <1497330755-30742-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 13:12:35 +0800
Phil Reid <preid@electromag.com.au> wrote:

> Add buffer_impl.h as buffer.h was split into interface for using and
> for internals. Without this industrialio-buffer-dmaengine.c fails
> to compile.
> 
> Fixes:
> commit 33dd94cb972175249258329c4aaffddcc82c2005 ("iio:buffer.h - split
> into buffer.h and buffer_impl.h")
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 9fabed4..2b5a320 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer_impl.h>
>  #include <linux/iio/buffer-dma.h>
>  #include <linux/iio/buffer-dmaengine.h>
>  

