Return-Path: <SRS0=pYim=44=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E01C10F27
	for <linux-iio@archiver.kernel.org>; Wed, 11 Mar 2020 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B64E2146E
	for <linux-iio@archiver.kernel.org>; Wed, 11 Mar 2020 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583931920;
	bh=Cx+gOZIgKknGIdPl+0Nfn9VKXwKcGh9NBh6FXMSvHUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8+/WHd9kF7M6GOWKDs2STJj/UdLSWi459UtY4kABvJNk3pxt2HWDF/+13I0rMUBb
	 GEKsQGGcQCmFxHHlKV39ThTQY4RCXDr5VBiyJBxySxl1cYa2aMyWAFgiAZTciEY/J2
	 vEShZow1xStx06pcpKQk8bLWrzSl+ZuAibz4lUmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgCKNFU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbgCKNFT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 09:05:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4842146E;
        Wed, 11 Mar 2020 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583931917;
        bh=Cx+gOZIgKknGIdPl+0Nfn9VKXwKcGh9NBh6FXMSvHUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfkqkQlixftkurJ7VriRJAsuscTbNeI8pFMzOp458I4zbmDsgpTj84waelnttSoJ+
         e6lJangj4aZFHzbvcZuv4U8+/oXCRJKMb7/0/a8XhFwYmZHHftshuk9YAV/yuXkEZI
         Nc91TFBsb2DmARCHSM9gC8P0UT1b+wFY7pQzNr3Q=
Date:   Wed, 11 Mar 2020 14:05:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enrique Vargas <jevargas@seas.upenn.edu>
Cc:     Chas Williams <3chas3@gmail.com>, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] remove unnecessary newline for brace
Message-ID: <20200311130515.GB3823904@kroah.com>
References: <20200311125507.GA9347@evX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125507.GA9347@evX1>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 11, 2020 at 06:55:07AM -0600, Enrique Vargas wrote:
> put brace at the end of line following coding conventions
> 
> Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
> ---
>  drivers/atm/adummy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
> index 8157925af824..6eeaa1b21f3b 100644
> --- a/drivers/atm/adummy.c
> +++ b/drivers/atm/adummy.c
> @@ -131,8 +131,7 @@ adummy_proc_read(struct atm_dev *dev, loff_t *pos, char *page)
>  	return 0;
>  }
>  
> -static const struct atmdev_ops adummy_ops =
> -{
> +static const struct atmdev_ops adummy_ops = {
>  	.open =		adummy_open,
>  	.close =	adummy_close,	
>  	.send =		adummy_send,
> -- 
> 2.17.1
> 

This is an outreachy application patch?  You need to do work in
drivers/staging/ only.  Also, the iio mailing list is not the correct
one at all.

greg k-h
