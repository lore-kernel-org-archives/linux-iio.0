Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE1DC282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917362192C
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549732225;
	bh=WOmQaS5VPNzAcPQ7/iJiwT5l0YByEqy/yDhL6g59PuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oaHtf1lIG3MPqLqV/f7HUC3hcqBZfKY7hg1lV376r8dVMCb7pZxMbNcfwys041QLH
	 zt70bH0t+KEitG05MQ3ibfryr4PrJH1z30asRQ67Lly6nkeMDi4J0n1TM+CjilX3cn
	 ZEytYsD/28NvuwWhWAGKTm/OuTNvmT2UiH5Tf+6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBIRKZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfBIRKZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 12:10:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFE421929;
        Sat,  9 Feb 2019 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549732224;
        bh=WOmQaS5VPNzAcPQ7/iJiwT5l0YByEqy/yDhL6g59PuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=000vqSfeoZqGcVFBVl8TsCsc9ga/PaUr/uCpE4V1fm33dGt9VUvzySzW+bHH6HLu/
         Hri5wTtv5m0741h9vk60E8A6xAZBqgzJTXX++SYirgE6hjIXOE6wUsTLmoJ3fMwtcp
         YYvE1xYlvw9GlBCrTQO0GTAuc8FMxWrNtFg/lgNo=
Date:   Sat, 9 Feb 2019 17:10:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio:adc:lpc32xx use SPDX-License-Identifier
Message-ID: <20190209171004.0741f68e@archlinux>
In-Reply-To: <20190208160944.13281-4-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
        <20190208160944.13281-4-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Feb 2019 17:09:42 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Convert the driver to SPDX license description which allow removing
> several lines in the file.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/lpc32xx_adc.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 20b36690fa4f..e361c1532a75 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -1,23 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  lpc32xx_adc.c - Support for ADC in LPC32XX
>   *
>   *  3-channel, 10-bit ADC
>   *
>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  #include <linux/module.h>

