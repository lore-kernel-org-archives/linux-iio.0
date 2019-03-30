Return-Path: <SRS0=wc2U=SB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E6C43381
	for <linux-iio@archiver.kernel.org>; Sat, 30 Mar 2019 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B506218A6
	for <linux-iio@archiver.kernel.org>; Sat, 30 Mar 2019 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553958271;
	bh=y2icFHnZrG7tTz605p17LuzuWCt3LgKIsNrojbcOd54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=frGOhqhMjg7/XxFR12GGHlqwHkffCi36Wqr5/qOFe11QbHHMYhKNyeGd9iIp0wZIK
	 6oCgmYlOaV+zZlpQHt5OXPkcw40br9M+3R/ZvIu3oURRSSwcWgzhQlE50yVjDUe67V
	 mcNJXpCtR2bBg5+oH/VT0wQLc9LztbNHeuGdM5Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfC3PEa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfC3PEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Mar 2019 11:04:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1706218A3;
        Sat, 30 Mar 2019 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553958270;
        bh=y2icFHnZrG7tTz605p17LuzuWCt3LgKIsNrojbcOd54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SLOWaKWF4vVJyxabw+o5b0rRlFUIYs+dhSfcNAooNA9v150xoSsRHYeWLKib/h07n
         Y3gDOryIj0+nuAFDyJwMcMvKOsZJ0paIUVH/C67OgdCUbhaq2ZoKsqBsCJ2kwr92Jo
         h9e5fr40sgmzKz4SWhXw8WlwoiqnY5HQLdbVJaeA=
Date:   Sat, 30 Mar 2019 15:04:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: Make possible to include driver.h first
Message-ID: <20190330150423.538d2476@archlinux>
In-Reply-To: <20190326134700.24800-1-andriy.shevchenko@linux.intel.com>
References: <20190326134700.24800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Mar 2019 15:47:00 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> If we put headers alphabetically sorted in the IIO driver,
> the compilation will abort because of unknown type to handle.
> 
> Simple add a forward declaration of opaque struct iio_dev.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied, 

Thanks,

Jonathan

> ---
>  include/linux/iio/driver.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iio/driver.h b/include/linux/iio/driver.h
> index 7dfb10ee2669..f54a7bcdefe3 100644
> --- a/include/linux/iio/driver.h
> +++ b/include/linux/iio/driver.h
> @@ -11,6 +11,7 @@
>  #ifndef _IIO_INKERN_H_
>  #define _IIO_INKERN_H_
>  
> +struct iio_dev;
>  struct iio_map;
>  
>  /**

