Return-Path: <SRS0=4pMd=73=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0EC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jun 2020 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34E720714
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jun 2020 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592142380;
	bh=QbBE4shFaNYjMdGoSGuJ5GF3khrICZukXMlsb5/RyVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oyZqu95iOWtWy6qXSZR9+ONWGKo4l2uc1mhhPR9hPq0kbGWPARnMef6rs/jhAWFn/
	 fkZZOpbzEtbvyqeipYvGug1I8G+7F5AoRIA97g1rkl5umRvm6TPlB9zaZDyLWP37q9
	 kRubgdIrf0mqhsJPPBcC8ja6MM/vHavC6QmrPso0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFNNqU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNqU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:46:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A248520714;
        Sun, 14 Jun 2020 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592142379;
        bh=QbBE4shFaNYjMdGoSGuJ5GF3khrICZukXMlsb5/RyVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wQBJOSnZqLXrDdsCeMpoXkSXLbllgtIQ2WhNeu0o3yve6umC++S3ONi1uoQ7wwW2g
         y/LPVsobpzxDHY0ycaMlYMWU4k5zNYuN30IbuGsKsSLjDWKE8AUiPxNjqfxI8B12es
         4F5LxM8htSB3pIj733Xq6NlNsaz72Dz3GyBAnQtw=
Date:   Sun, 14 Jun 2020 14:46:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] counter: 104-quad-8: Add lock guards -
 differential encoder
Message-ID: <20200614144615.3d3dbbee@archlinux>
In-Reply-To: <CACG_h5qwXxA0EthdCjz3jNbW0Lgtdy7ycCvt8xCHLh8dog-Xqw@mail.gmail.com>
References: <20200316125006.GA415@syed.domain.name>
        <20200318021802.GB45571@icarus>
        <CACG_h5qwXxA0EthdCjz3jNbW0Lgtdy7ycCvt8xCHLh8dog-Xqw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 10:52:57 +0530
Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> On Wed, Mar 18, 2020 at 7:48 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Mon, Mar 16, 2020 at 06:20:06PM +0530, Syed Nayyar Waris wrote:  
> > > Add lock protection from race conditions to 104-quad-8 counter driver
> > > for differential encoder status code changes. Mutex lock calls used for
> > > protection.
> > >
> > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > > ---
> > > Changes in v5:
> > >  - Change spin lock calls to mutex lock calls.
> > >  - Modify the title description.  
> >
> > Looks like the Fixes tags were dropped in these last two patches. I
> > suppose they aren't really necessary though since these features haven't
> > yet made it out of the IIO tree, so no need to backport these fixes.
> >
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> 
> Adding the 'Fixes' tag:
> 
> Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential
> Encoder Cable Status")
That doesn't seem to be the correct hash upstream though it exists in my
local tree. I'm not sure quite what happened here (and don't care enough
to try and figure it out), so I've fixed to match the upstream hash.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> Regards
> Syed Nayyar Waris

