Return-Path: <SRS0=LfXA=VO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B0C76192
	for <linux-iio@archiver.kernel.org>; Wed, 17 Jul 2019 21:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2E021851
	for <linux-iio@archiver.kernel.org>; Wed, 17 Jul 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563397971;
	bh=9gkQNMTt4n23pJsnoavhbM+aU4xlRyb7/5V0jirwA8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RJdeZhSoktFK1Y1YLae0BQWbdEM7TDBHDxgPJTxbw7tnfMopl4avMoLOyfCDbB4Xn
	 +fbKrjYrq4q8MU1JnDJzEFyEWOwTSaiDOdKhkr33My27swM2dne9sIzBCkeQC/Wr5U
	 d7DIYvmHp4uN5rLyqjM+jerZTE1fn6U96V+grLV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGQVMu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfGQVMu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jul 2019 17:12:50 -0400
Received: from localhost (unknown [113.157.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B95C21783;
        Wed, 17 Jul 2019 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563397968;
        bh=9gkQNMTt4n23pJsnoavhbM+aU4xlRyb7/5V0jirwA8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bwu9tZNB5g6KKkE5V6zL8O/kwlVGHKP1K2eNwAWqFw529eP4a4A4MhZEXNpqEV2Wa
         /dQ4ilDg6uL/xinKOKXY8AS8lm7MGF8CRBkEU4YO7YymPGVTHqZ8Y+ZM47UHDFBEnH
         a0ZiH5som6oslSj2IQD2R2ZF57UBakTA8N5UBpkY=
Date:   Thu, 18 Jul 2019 06:12:46 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH 13/14] iio: trig-loop: SPDX headers GPL-v2
Message-ID: <20190717211246.GA13989@kroah.com>
References: <20190622145516.3231-1-jic23@kernel.org>
 <20190622145516.3231-14-jic23@kernel.org>
 <20190717175837.GA31268@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717175837.GA31268@himanshu-Vostro-3559>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 17, 2019 at 11:28:37PM +0530, Himanshu Jha wrote:
> On Sat, Jun 22, 2019 at 03:55:15PM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Not exactly standard license text, but clear in intent and it's
> > my copyright anyway.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/trigger/iio-trig-loop.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> > index 9258d3cf149b..f0205a9e47d0 100644
> > --- a/drivers/iio/trigger/iio-trig-loop.c
> > +++ b/drivers/iio/trigger/iio-trig-loop.c
> > @@ -1,8 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> I think it should be:
> 
> 	// SPDX-License-Identifier: GPL-2.0-only
> 
> https://spdx.org/licenses/
> https://spdx.org/licenses/GPL-2.0-only.html
> 
> I don't know if `spdxcheck.py` points out about
> such a mismatch.
> 
> Yes, documentation and sanity checkers needs to be updated.
> https://lore.kernel.org/lkml/CAHk-=wipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLUa0VrS_Eg@mail.gmail.com/

Please read the in-kernel documentation about this.  We support both
types of tags now and have done so since the beginning.

thanks,

greg k-h
