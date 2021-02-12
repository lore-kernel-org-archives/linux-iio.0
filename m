Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBAC433E0
	for <linux-iio@archiver.kernel.org>; Fri, 12 Feb 2021 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0AA60241
	for <linux-iio@archiver.kernel.org>; Fri, 12 Feb 2021 19:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhBLTPf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231981AbhBLTPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 14:15:33 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B1C64DF0;
        Fri, 12 Feb 2021 19:14:51 +0000 (UTC)
Date:   Fri, 12 Feb 2021 19:14:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: proximity: Fix a spelling postive to
 positive in the file sx9500.c
Message-ID: <20210212191447.26215a80@archlinux>
In-Reply-To: <b19d9d8e-206e-757f-46ab-5fa159a30a88@infradead.org>
References: <20210210085704.1228068-1-unixbhaskar@gmail.com>
        <b19d9d8e-206e-757f-46ab-5fa159a30a88@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Feb 2021 08:16:36 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 2/10/21 12:57 AM, Bhaskar Chowdhury wrote:
> > 
> > s/postive/positive/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
Applied with a tweaked patch title to the togreg branch of iio.git which
I'll push out shortly as testing to the let the autobuilders poke at it
and see what they can find that we missed.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/proximity/sx9500.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> > index acb821cbad46..67353d33af94 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -758,7 +758,7 @@ static const struct sx9500_reg_default sx9500_default_regs[] = {
> >  		.reg = SX9500_REG_PROX_CTRL5,
> >  		/*
> >  		 * Debouncer off, lowest average negative filter,
> > -		 * highest average postive filter.
> > +		 * highest average positive filter.
> >  		 */
> >  		.def = 0x0f,
> >  	},
> > --  
> 
> 

