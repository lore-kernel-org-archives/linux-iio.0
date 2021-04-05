Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F861C433ED
	for <linux-iio@archiver.kernel.org>; Mon,  5 Apr 2021 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F24F6136A
	for <linux-iio@archiver.kernel.org>; Mon,  5 Apr 2021 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhDEVAW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237300AbhDEVAW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 17:00:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D875D6136A;
        Mon,  5 Apr 2021 21:00:14 +0000 (UTC)
Date:   Mon, 5 Apr 2021 22:00:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.12 cycle
Message-ID: <20210405220029.7c8c2ef4@jic23-huawei>
In-Reply-To: <YGtCCHz7wIbTE/UN@kroah.com>
References: <20210405152057.3157af41@jic23-huawei>
        <YGtCCHz7wIbTE/UN@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Apr 2021 18:59:52 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 05, 2021 at 03:20:57PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:
> > 
> >   Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12b  
> 
> It's late, it's -rc6, are these really needed for 5.12-final or can they
> wait for 5.13-rc1?
> 
> thanks,
> 
> greg k-h

They can wait.

Thanks,

Jonathan
