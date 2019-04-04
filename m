Return-Path: <SRS0=W9FC=SG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC14C4360F
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89C205C9
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554410117;
	bh=XMKhqpKYQIgnxT9teDcHr2ghX/jS09rkD2ZgG8F2sWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LnIYu6DH0fT6jhyVgV5Tx79q59X8zfpqb3BFSzWt/ZWr5gz4tQrFtxxvHLQJFd3F4
	 9LTshFN3j/ivBpiDWrnGDk4iFQnmkSWHre6m53wkwAzx9sKRrDQhWSKB8VZwQrou3h
	 dycsaNOv62bGz8x3BSGr9M5+/3fSxai/Pf7RPvMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfDDUfQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfDDUfQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Apr 2019 16:35:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1AC205C9;
        Thu,  4 Apr 2019 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554410116;
        bh=XMKhqpKYQIgnxT9teDcHr2ghX/jS09rkD2ZgG8F2sWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7S15pmd5QW+rDEwC/tHhoFuuh3M8pWW87kZ/DOxAZSimzn5d0c4YbGHpavQLVute
         DaphyDbTQC0NuQm9oO7Epx+FDB6R9eiWLKgEdlwQGkKST0xqA2fGFj8GD7R3ZxfcoG
         b4cGVhdEM6dYwsIYcg/kHwdpi4YWJb9NRPWzYG0o=
Date:   Thu, 4 Apr 2019 22:33:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V2] First round of new device support, cleanups and fixes
 for IIO in the 5.2 cycle.
Message-ID: <20190404203348.GA13409@kroah.com>
References: <20190404205720.66804920@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404205720.66804920@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 04, 2019 at 08:57:20PM +0100, Jonathan Cameron wrote:
> The following changes since commit b397f82585c3101dcf92642dd359891e66d00c55:
> 
>   Merge 5.1-rc3 into staging-next (2019-04-01 07:49:24 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.2a-2

Looks good, now pulled and pushed out.

greg k-h
