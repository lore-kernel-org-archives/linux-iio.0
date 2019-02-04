Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE0C282D7
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D521871
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549260451;
	bh=op3NEy6RcprohD3PINJ8vG39eKhPqmnaay4knEKRGEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qdLaUtnPQ9kQNTZDJw6zrO14vNlN5rLBByPUsC6mn56q5Dw0ll8GqH3vpEFey0Nfq
	 pAzKkol9n6F5Tw/89LEjbD6aZIet7/3R9nIjkLuvUmHRCOQmjEN1zKNye95mb/UkdY
	 vTP5sne7Cv08hDTXNEh9fwxmO7YTHSz57ja6rkaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfBDGHb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBDGHb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Feb 2019 01:07:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260F521871;
        Mon,  4 Feb 2019 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549260450;
        bh=op3NEy6RcprohD3PINJ8vG39eKhPqmnaay4knEKRGEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKKTqeRidiynerHVpuLC/EKVS+0vEDHkCYT6LDcPbOx/YAVACMPhuWyD6qGRUZ07u
         WLL2Md8ga112mf/OlDOMRuu38x00Au5jE/tCbSZVDcm6L75lWLq5tAhnV70asU+IUM
         Am27LCQbSny0mIqYJqD4lnWSdnOXQwVFi300YPHg=
Date:   Mon, 4 Feb 2019 07:07:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO new device support etc for 5.1
Message-ID: <20190204060728.GA3226@kroah.com>
References: <20190203211753.7b2d02cd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203211753.7b2d02cd@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 03, 2019 at 09:17:53PM +0000, Jonathan Cameron wrote:
> The following changes since commit c6cbcdea7ab94120b676a4865e9782ed3c06dc80:
> 
>   Merge tag 'iio-for-4.21b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2018-12-13 13:37:24 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.1a

Pulled and pushed out, thanks.

greg k-h
