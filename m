Return-Path: <SRS0=UNU4=QK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E717C169C4
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9356218A6
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549201026;
	bh=mOEWzj20J40FxHQh5mT1NS2Vn/8Lp+282C/oKYpZxU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmK52wp0+AZmE89P408guf5QsbUQ8who+5BV1NGYAdZB0X2HxWyY8av4okiuO9LVC
	 dH7gEqnHh5Ij/Cvq6U7gPOXdeSS5/Z0UPdFIT312UP8YOY3XCDIR9YcsP8DpGJ8fTA
	 jpKKHP4XjmMoJropYiqEvjXXmkxCsJozuij+Kz3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfBCNhF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfBCNhF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Feb 2019 08:37:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC1F218A6;
        Sun,  3 Feb 2019 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549201024;
        bh=mOEWzj20J40FxHQh5mT1NS2Vn/8Lp+282C/oKYpZxU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2fkkuj8oFQLXr1ZJ7+5REUmSC2CQ71W8Tkjg+BSjh9qZMNUcJxDJjTVuYjFIYDHpY
         fZ4mqWQA95f7beNWbW4VT3MP64rsHR5hUD1B3mKZv7R+1mnPctj+p8vw0q5Htns+Jl
         8FH9PQ7GpYlUSNnC7g9BYsSCsyIXV17v0KvftDvw=
Date:   Sun, 3 Feb 2019 14:37:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.0 cycle.
Message-ID: <20190203133702.GA17601@kroah.com>
References: <20190202174111.23e868c2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202174111.23e868c2@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 02, 2019 at 05:41:11PM +0000, Jonathan Cameron wrote:
> The following changes since commit 06382deac2b8a49bbc5aaa3c9118fed6da4a1ac1:
> 
>   Revert "staging: rtl8723bs: Mark ACPI table declaration as used" (2019-01-11 10:40:13 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.0a

Pulled and pushed out, thanks.

greg k-h
