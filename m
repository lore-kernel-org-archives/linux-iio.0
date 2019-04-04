Return-Path: <SRS0=W9FC=SG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB9C4360F
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4FD2082E
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfDDTqJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:46:09 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38168 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfDDTqJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Apr 2019 15:46:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id ABE0C9E7493;
        Thu,  4 Apr 2019 20:46:06 +0100 (BST)
Date:   Thu, 4 Apr 2019 20:46:01 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] First round of new device support, cleanups and fixes
 for IIO in the 5.2 cycle.
Message-ID: <20190404204601.21db5ecb@archlinux>
In-Reply-To: <20190402105721.000020bb@huawei.com>
References: <20190401215936.3d6a460d@archlinux>
        <20190401220407.78d9b19c@archlinux>
        <20190402071452.GA22035@kroah.com>
        <20190402105721.000020bb@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Apr 2019 10:57:21 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue, 2 Apr 2019 09:14:52 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Apr 01, 2019 at 10:04:07PM +0100, Jonathan Cameron wrote:  
> > > Hi Greg,
> > > 
> > > There is a merge conflict in here against the previous fixes branch
> > > in industrialio-buffer.c.  The resolution I would suggest is to take
> > > the cleanup from Andy that is in this branch that moves the
> > > code over to bitmap_kzalloc avoiding the issue that was fixed in
> > > the other branch.  I'd not noticed this one sneaking in until I
> > > did a test merge a few minutes ago. Sorry about that.
> > > 
> > > Thanks for your help (for this and in general!)    
> > 
> > Odd, all I had merge problems with was drivers/iio/adc/stmpe-adc.c due
> > to a patch that was in my tree already for it.
> > 
> > I do have a bunch of "signed-off-by not present warnings" in your tree,
> > when I try to do this merge:
> > 
> > Commit ddb27e1bf24c8db0a8803201aa46b9d26cc815ff
> >         committer SOB missing
> >         stefan@agner.ch Jonathan.Cameron@huawei.com
> >         Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit e909fb9e1beec6968ad7dda3081556526a641ea3
> >         committer SOB missing
> >         stefan@agner.ch Jonathan.Cameron@huawei.com
> >         Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit 8af18b62c593560c7ce360244fb47be27bb50a32
> >         committer SOB missing
> >         philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
> >         Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit d848b89bae04ade886320367f510d9f64c3a6e20
> >         committer SOB missing
> >         stefan@agner.ch Jonathan.Cameron@huawei.com
> >         Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit ac7358ded6a5f1b6bf29031301bb9f774bf05372
> >         committer SOB missing
> >         philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
> >         Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit 0af69b0a78eac5a7041674be1736929a91758256
> >         committer SOB missing
> >         philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
> >         Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Commit 6c038d0bded5da24f13c509de7f47aba58a3bfc1
> >         author SOB missing
> >         c.cantanheide@gmail.com Jonathan.Cameron@huawei.com
> >         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Errors in tree with signed-off-by, please fix!
> > 
> > Which is a bunch of errors :(
> > 
> > Can you fix these up for those that you can (i.e. the committers not
> > signing off) and for those patches from authors without a s-o-b at all,
> > we need that before we can take those.  
> 
> Will do, I think I know what happened here.  I must have rebased across the
> merge to add a tag and not noticed.  So those are actually committed by Lee
> but I broke my history.
> 
> I'll sort out the mess and I completely missed the author one. Sorry about
> that.  Will drop that one until sorted.
Having fixed it up in the obvious way with the merge back to normal, I
realised that I was rebasing most the way back to the beginning of the set
anyway, so dropped that plan and just rebased on staging/staging-next.

Pull request shortly.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > thanks,
> > 
> > greg k-h  
> 
> 

