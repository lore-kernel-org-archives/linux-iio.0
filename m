Return-Path: <SRS0=0Ig8=SE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FAFC43381
	for <linux-iio@archiver.kernel.org>; Tue,  2 Apr 2019 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE3920857
	for <linux-iio@archiver.kernel.org>; Tue,  2 Apr 2019 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554189296;
	bh=PIx2i63rkh976Ackp6gJB1ukHD7WbpX0/NKont6NwAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qm3N5lfS4q4MkXAJWudLFWR+W0vQvImIVbd8EzJSFxPRMyeWP9d3BBsGfe4zQPlXI
	 HQ+k1FQLQ/fhVk6w77177imxmEyPt1CIZ/JotyRYJacqkF6tDWSy42tio3+ZUYM8OX
	 zuYNR7EtP5HVhNqj0Z7/sFJQRQT+/1QGZ61t6/to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDBHO4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfDBHO4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Apr 2019 03:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991A620856;
        Tue,  2 Apr 2019 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554189295;
        bh=PIx2i63rkh976Ackp6gJB1ukHD7WbpX0/NKont6NwAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxDHCccaOnMUJTmw196/EEP3Gh6Knk7DMm9UI+ICf3SVDUeuBeYEx8kw/Nl/9thnc
         ZLinVv5VXmf67R3MYPzPwhAcdUkw+HUx5zqJqXP/PMwwWz15RxOf6RJwcwqtjJenJu
         hWQjxxG3+8uTHFwNTSNWiMj8K7SDmGbj6pXbmkgY=
Date:   Tue, 2 Apr 2019 09:14:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First round of new device support, cleanups and fixes for
 IIO in the 5.2 cycle.
Message-ID: <20190402071452.GA22035@kroah.com>
References: <20190401215936.3d6a460d@archlinux>
 <20190401220407.78d9b19c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401220407.78d9b19c@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 01, 2019 at 10:04:07PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> There is a merge conflict in here against the previous fixes branch
> in industrialio-buffer.c.  The resolution I would suggest is to take
> the cleanup from Andy that is in this branch that moves the
> code over to bitmap_kzalloc avoiding the issue that was fixed in
> the other branch.  I'd not noticed this one sneaking in until I
> did a test merge a few minutes ago. Sorry about that.
> 
> Thanks for your help (for this and in general!)

Odd, all I had merge problems with was drivers/iio/adc/stmpe-adc.c due
to a patch that was in my tree already for it.

I do have a bunch of "signed-off-by not present warnings" in your tree,
when I try to do this merge:

Commit ddb27e1bf24c8db0a8803201aa46b9d26cc815ff
        committer SOB missing
        stefan@agner.ch Jonathan.Cameron@huawei.com
        Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit e909fb9e1beec6968ad7dda3081556526a641ea3
        committer SOB missing
        stefan@agner.ch Jonathan.Cameron@huawei.com
        Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit 8af18b62c593560c7ce360244fb47be27bb50a32
        committer SOB missing
        philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
        Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit d848b89bae04ade886320367f510d9f64c3a6e20
        committer SOB missing
        stefan@agner.ch Jonathan.Cameron@huawei.com
        Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit ac7358ded6a5f1b6bf29031301bb9f774bf05372
        committer SOB missing
        philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
        Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit 0af69b0a78eac5a7041674be1736929a91758256
        committer SOB missing
        philippe.schenker@toradex.com Jonathan.Cameron@huawei.com
        Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Commit 6c038d0bded5da24f13c509de7f47aba58a3bfc1
        author SOB missing
        c.cantanheide@gmail.com Jonathan.Cameron@huawei.com
        Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors in tree with signed-off-by, please fix!

Which is a bunch of errors :(

Can you fix these up for those that you can (i.e. the committers not
signing off) and for those patches from authors without a s-o-b at all,
we need that before we can take those.

thanks,

greg k-h
