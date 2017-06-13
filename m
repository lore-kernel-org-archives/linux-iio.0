Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMTyu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 15:54:50 -0400
Date: Tue, 13 Jun 2017 20:54:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: buffer-dma: Add missing header buffer_impl.h
Message-ID: <20170613205445.3b6ceac9@kernel.org>
In-Reply-To: <1497321096-77903-1-git-send-email-preid@electromag.com.au>
References: <1497321096-77903-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 10:31:36 +0800
Phil Reid <preid@electromag.com.au> wrote:

> Add buffer_impl.h as buffer.h was split into interface for using and
> for internals. Without this industrialio-buffer-dma.c fails
> to compile.
> 
> Fixes:
> commit 33dd94cb972175249258329c4aaffddcc82c2005 ("iio:buffer.h - split
> into buffer.h and buffer_impl.h")
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
Good find.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index dd99d27..ff03324 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched.h>
>  #include <linux/poll.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer_impl.h>
>  #include <linux/iio/buffer-dma.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/sizes.h>

