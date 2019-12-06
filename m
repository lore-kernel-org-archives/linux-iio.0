Return-Path: <SRS0=Jt3Z=Z4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF49AC43603
	for <linux-iio@archiver.kernel.org>; Fri,  6 Dec 2019 17:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D15324673
	for <linux-iio@archiver.kernel.org>; Fri,  6 Dec 2019 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575654499;
	bh=eMse2k/BQ/bmieQOECywIK5kP7R5h5NRESYh+mz6IC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oNPQBLPkkVlb0jYCRL0riUQGbQPoAGmpmqCyItKUQ7Y42+SWXf8L4i38H0V/puuZ7
	 jpM8H7kn/ElZW9vzUv2WQ+yGql5tlVFaNqZdUp35RTcpIK6OUMpvL7s0LkSJCuvPJH
	 V2NkoyPFsNTO3/d6Xa/blil357cTzuuH/uO/ilCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFRsT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfLFRsT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:48:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AE524670;
        Fri,  6 Dec 2019 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575654498;
        bh=eMse2k/BQ/bmieQOECywIK5kP7R5h5NRESYh+mz6IC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mYZy6kre31WjBgxKyu+oFJiPoUyVDROpYn8ueb8NCO5efQxoomf2fZ276qK4SjYcb
         ykSXdbkt/M2AS9kpu2uSAXkWbsn7eOltCriRXaS5jbcQSabGzi9aFPjSNmU/vSr4fH
         Stg+m5lcnjKCuAlwcuPNt6Nn8zIaNwcNtibTEtNY=
Date:   Fri, 6 Dec 2019 17:48:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: si1145: Drop GPIO include
Message-ID: <20191206174814.5c0786c3@archlinux>
In-Reply-To: <20191202082123.62350-1-linus.walleij@linaro.org>
References: <20191202082123.62350-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:21:23 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The driver include <linux/gpio.h> yet does not use any
> of the symbols from the header, so drop the include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/si1145.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 982bba0c54e7..0476c2bc8138 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -17,7 +17,6 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

