Return-Path: <SRS0=0Ig8=SE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A2C43381
	for <linux-iio@archiver.kernel.org>; Tue,  2 Apr 2019 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08AC20833
	for <linux-iio@archiver.kernel.org>; Tue,  2 Apr 2019 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554187946;
	bh=a3bo0UVfFHX678WrTz8GACIrmZTKf1dYJ/EA1e7S1vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EUb9r0uGUlSpOH+YzsdK1nvcaJXUOzohfz73hSjL+pRbl72TeZsOymWNwaAm/fmfK
	 7FojzvortpkK+bJzosmk2fCfxkd95EpmHxfGvMBKQNkzHKoSSA0y21TMXswXIcgWmP
	 2N7b045x6N3tFveg086sHuRzf3C2fWaUvVsIfTCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDBGw0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfDBGw0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Apr 2019 02:52:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5721820833;
        Tue,  2 Apr 2019 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554187945;
        bh=a3bo0UVfFHX678WrTz8GACIrmZTKf1dYJ/EA1e7S1vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7QtmnjSOqVIXzci+cNKSEiiGLH84HKc8ZDmH/RcMMEb5L6yLIKuZaGaXht1IRlug
         dTpzKfIkS/TF0P0U0WYzHnhZVCce2nKvrt1TAgSYzvKTrZmr/7ED7z61RKZK/l8Emy
         VLM6Boc2k2Xxr3JK1xO4K98XldjsVf5V2DAC8eBM=
Date:   Tue, 2 Apr 2019 08:51:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.1 cycle
Message-ID: <20190402065149.GA30442@kroah.com>
References: <20190401202847.50491d1c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401202847.50491d1c@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 01, 2019 at 08:28:47PM +0100, Jonathan Cameron wrote:
> The following changes since commit 38e7571c07be01f9f19b355a9306a4e3d5cb0f5b:
> 
>   Merge tag 'io_uring-2019-03-06' of git://git.kernel.dk/linux-block (2019-03-08 14:48:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.1a
> 
> for you to fetch changes up to 7f75591fc5a123929a29636834d1bcb8b5c9fee3:
> 
>   iio: core: fix a possible circular locking dependency (2019-03-31 11:11:31 +0100)

Pulled and pushed out, thanks.

greg k-h
