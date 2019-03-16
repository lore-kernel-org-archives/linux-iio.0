Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F9C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E904921905
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552756675;
	bh=l2CXdru/nn4Alzxe5xmMUf7X4OpDGT2/+cktjkeFOy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l81MEonMSHxva8UsgrpwJrRe6RjwUTfZLSPQaiJ6oq/wmtq2sNNOj3BLAz4ds7NHE
	 kYin2U13vRL0RQf/rky8fFTfRlPRSz6rinsy3y65YxqU0DhEiYIsABFqdPZ9GUE5ux
	 tsClRPxcfkRNBkFvGYp7f8HgCMj25CtclczmacQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCPRRy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPRRy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 13:17:54 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129E221904;
        Sat, 16 Mar 2019 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552756673;
        bh=l2CXdru/nn4Alzxe5xmMUf7X4OpDGT2/+cktjkeFOy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=orJdDBFQVb+aJI2tFHY8glUX1ApzCMZdTb9Xxw6Cdb/MUDdXt5gTrXWTO/zZMmbvx
         z/8GyPWpnGmSCdpFj3bOcqj1JG8/XSb0Bl9o+nTlZsDDNvwnWaPtiKBpLoHJmhIigc
         kkTTkD/qokQiZaIN04X2GvDI0q+8Jqu0DxIEtSTQ=
Date:   Sat, 16 Mar 2019 17:17:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] iio: adc: lpc32xx: Sort headers
Message-ID: <20190316171747.34be37ab@archlinux>
In-Reply-To: <20190315095231.17001-2-gregory.clement@bootlin.com>
References: <20190315095231.17001-1-gregory.clement@bootlin.com>
        <20190315095231.17001-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 10:52:28 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Sort the headers in alphabetic order in order to ease the maintenance for
> this part.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/lpc32xx_adc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index e361c1532a75..7084f804504e 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -7,20 +7,19 @@
>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
>   */
>  
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
>  #include <linux/completion.h>
> -#include <linux/of.h>
> -
> +#include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  /*
>   * LPC32XX registers definitions

