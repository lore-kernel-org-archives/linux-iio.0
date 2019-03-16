Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC8C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40330218FE
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552757015;
	bh=/M/9pfkEQ7WjNyCQ+8ogcpDvRVdjYFgkYJFB8AungcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZFkOs+ggD8++jI4/7ATSU4CIOrNf1pwdvSMcF2MHeEWrc9OMqnAOJ9Zd2ROCiKKtQ
	 Al+TyIJdxOsSA8BdDXjAVo8NscmdVaIZkpkWnVLzU4Dy2cLrmsaFtRHCCcvAHTWOsL
	 4pWbQDtyBWjJjH9n7rBjM1iRPwbK7u76Ymd6iwjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfCPRXe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPRXe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 13:23:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20718218AC;
        Sat, 16 Mar 2019 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552757013;
        bh=/M/9pfkEQ7WjNyCQ+8ogcpDvRVdjYFgkYJFB8AungcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GzFpm5TnWJtJlrCyBbOSNGWNwC3hwgxyGgBVj7B/9upRVpjDyCJ+BTdsnU96AdqSu
         t0I4I4wz8nzuOSX3b023kk/dVGUimNH27cIgwHuYEXBUlZVwd5L3zpQrzNrdJnC7QG
         2OBXxQ6cO5bsqkm0yEjdoVhex2RocZ33keE3d1KY=
Date:   Sat, 16 Mar 2019 17:23:27 +0000
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
Subject: Re: [PATCH v2 2/4] iio: adc: lpc32xx: Cleanup headers
Message-ID: <20190316172327.2c1d7751@archlinux>
In-Reply-To: <20190315095231.17001-3-gregory.clement@bootlin.com>
References: <20190315095231.17001-1-gregory.clement@bootlin.com>
        <20190315095231.17001-3-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 10:52:29 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> A few headers is useless: remove them.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/iio/adc/lpc32xx_adc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 7084f804504e..f391c1e10136 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -9,17 +9,11 @@
>  
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
 -EINVAL comes from asm/errno.h I believe. IS_ERR
is also in this header.  Otherwise, they are fine, so
I'll just leave this one.

>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
>  
>  /*
>   * LPC32XX registers definitions

