Return-Path: <SRS0=n2n1=W6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781ABC3A5A2
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 20:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4502122CF7
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 20:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567542573;
	bh=2VQio1nvnm01YS3exu5HEgtVPHBkFKm1OqeetIDYzxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dXr9xAOVP1PBQv+7B6oLeGmRk3EY9YRXD40A9awCRj3dBrpf0mjd9OeipiwNq59iX
	 mWrD9XMhdJ8qrH9FBBEcgVAQrGYg69bWsHrJasV9SG569z2zJ7l/YcEquyUZh5lac7
	 dkH8oY6Zo970anB2OtnkE/LeZhK0BTlYTimfjlrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICU3c (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfICU3c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 16:29:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ED722CED;
        Tue,  3 Sep 2019 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567542571;
        bh=2VQio1nvnm01YS3exu5HEgtVPHBkFKm1OqeetIDYzxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DF30d+fvJ/8XszE/vP5nnvLvPx9F9oWpCiaUkeuZzza7q18ix+T86rUUVbPZRWYaH
         KdY1r+xwd5SGE8B2lCbvtMwMP215N3DReoh/FqFRqrewLeefRU//+yHS01C0zATkep
         Xv1r+jW/1XglgE+yI0FrsSQY+2eFEuQ4B4GQ/F0c=
Date:   Tue, 3 Sep 2019 22:28:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v3] Second set of new device support, cleanups etc for IIO
 in the 5.4 cycle.
Message-ID: <20190903202837.GA32202@kroah.com>
References: <20190903211708.2ba07358@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903211708.2ba07358@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 03, 2019 at 09:17:29PM +0100, Jonathan Cameron wrote:
> The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> 
>   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take3

This one worked :)

Now pulled and pushed out, thanks.

greg k-h
