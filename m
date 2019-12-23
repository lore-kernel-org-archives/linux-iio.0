Return-Path: <SRS0=L16q=2N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1AC2D0C0
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B420715
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577122338;
	bh=2rDgXwuhvZDpIhLSEhOfmXGzaHSH8W7rnF14GxUhkqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zv4VHxLXMTF/Zr5uGUCWBf4R+Fb2z2yKVJTI+veomJo3y8MDqeQbLLaB/SmX80HB7
	 yNZr+2txfnFtq4TC/HR8jXJIi15aU2Xln3LE3SMllq1F7vO+juSNktbHcB0rKvGm24
	 cz9ZPWj7E91i2m5sX4PxtlCxpTevmAMkbfnSESew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWRcR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRcR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:32:17 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC27206CB;
        Mon, 23 Dec 2019 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577122336;
        bh=2rDgXwuhvZDpIhLSEhOfmXGzaHSH8W7rnF14GxUhkqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4kwWoL0Xs+RDGoxhIqMxDkt6SM14omwRZj1EwM1Mmea9kn5Cj/yCgGvrDVDps2uB
         CePJ6iaLMf5Z+v4pine5eG4RrsGfifYbTG3U2hal9BT6OKSOn4zhUPeLq8kxMwHFOk
         YW/cjbKxg0V5dK3Xc4wsXMYkT2++jtVLfJVx9yL4=
Date:   Mon, 23 Dec 2019 17:32:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add module information
Message-ID: <20191223173212.58608ffe@archlinux>
In-Reply-To: <20191211104147.13368-1-alexandru.ardelean@analog.com>
References: <20191211104147.13368-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 12:41:47 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Make sure that the industrialio-buffer-dmaengine has proper license
> information so it can be build as a module and loaded without tainting the
> kernel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index b7b5a934e9b2..e0b92f3dec0e 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -206,3 +207,7 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  	iio_buffer_put(buffer);
>  }
>  EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("DMA buffer for the IIO framework");
> +MODULE_LICENSE("GPL");

