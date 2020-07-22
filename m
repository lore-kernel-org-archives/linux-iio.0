Return-Path: <SRS0=Obq9=BB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE195C433E7
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE4B20787
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595429640;
	bh=mZTGXao4zF1hRHchhomppOIGFbJuDLZGhvw+BYcF2m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pDn8uASLQWu356QMhLKdv7p0Pl+PoN5Dgav+Smr3lsYi/kxYs8/2ZjuwONn/24yqz
	 xrdIQgHYTapB5jLd7CJxxtdQpqbrBo9XibQeFs7QvgfzQjzcez9yde6sUC3dWNPhTv
	 +O0QPmWoTJitgENe0AeJoOOs30Cte8zeJk5Nytt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgGVOyA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbgGVOyA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 10:54:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C6520729;
        Wed, 22 Jul 2020 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595429639;
        bh=mZTGXao4zF1hRHchhomppOIGFbJuDLZGhvw+BYcF2m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioAVB12fy+pen2cxe/BX1PRrdMKeyxJl1GFJS1e0w7d6X3z9hEnuSIMsK1MAFCMUQ
         dBxK/R3A1eA8Tr5JAmemqHQCEVZBkpHKaABh6sEn0nOHAuEIjMG+GdIV8kECf5bLp9
         W5Rsuzw+fGYlh5zpN0OcBBxy2lUzqT2dMyFjgnDU=
Date:   Wed, 22 Jul 2020 16:53:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO cleanups, features etc for the 5.9
 cycle.
Message-ID: <20200722145346.GA3859405@kroah.com>
References: <20200722151639.1bde9bfb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722151639.1bde9bfb@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 03:16:39PM +0100, Jonathan Cameron wrote:
> The following changes since commit 263771dbc85bc6573b344c193351980c27fd2faa:
> 
>   Merge 5.8-rc6 into staging-next (2020-07-20 09:37:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.9b

Pulled and pushed out, thanks.

greg k-h
