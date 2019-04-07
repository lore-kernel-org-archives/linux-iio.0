Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A52EC10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3104920B1F
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554636719;
	bh=+LGgrUqhOWx6g05GrKpB5/S9S0IpI7MSjoAIPEA/Znc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RFsrYO+2qoK2ZiIX/Dc7ebiKjEry1hVfqZzbpO09naZDZJafEBPyoaDaJOQmHFr0t
	 +7Vx/+YowEuywcSaDX/YgoCvcRJpFsUF/dVfNrAAazDlPVj5pqy3tCJisjPXUDV/az
	 AJuamXO1/sV86teBk+grNaWi7wC0Nw7npjI96atQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDGLb6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLb6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Apr 2019 07:31:58 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996CE20879;
        Sun,  7 Apr 2019 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554636717;
        bh=+LGgrUqhOWx6g05GrKpB5/S9S0IpI7MSjoAIPEA/Znc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HKcDLUHM70VnuR4a03EpVYwUhl6KPR8Lyp9BogK5m8pZm48gpMNCG6yVRBpxcYGc8
         iN8jKfwd07J1O3b3sTDwbWupg/AvDr9vjPJYr70tYGcgwtOygDHPyHIAOQF9+3Lc5M
         BCThH7pBeVf3Ec+8cz6OcjmGef2IhpngvcehMYjU=
Date:   Sun, 7 Apr 2019 12:31:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/4] staging: iio: ad9832: organize includes
Message-ID: <20190407123152.79fa8e8a@archlinux>
In-Reply-To: <20190401143710.ruubi2knbjsjzdm7@smtp.gmail.com>
References: <20190401143710.ruubi2knbjsjzdm7@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Apr 2019 11:37:10 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Organize includes to list them in lexicographic order.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
There are a few headers in there that I'd expect to be unnecessary once
cleanup on the driver is finished, but good to get them in a nice
order to start with.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index a3ce50427724..50a583020072 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -6,22 +6,24 @@
>   * Licensed under the GPL-2.
>   */
>  
> +#include <asm/div64.h>
> +
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/err.h>
> -#include <linux/module.h>
> -#include <asm/div64.h>
> +#include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dds.h"
>  
>  #include "ad9832.h"
>  
> +#include "dds.h"
> +
>  /* Registers */
>  
>  #define AD9832_FREQ0LL		0x0

