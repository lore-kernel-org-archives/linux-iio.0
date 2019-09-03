Return-Path: <SRS0=n2n1=W6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972CC3A5A2
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036F23711
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567517799;
	bh=SoPdV2nnitLnCHq2v4W6UN5gpR7xY/IyZscELKgSZ6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CPhNTn6rcvL70hDXfX41GvGDDJets0k1dpBpvfBdelRwyTXwuDdqh82n0VwRl7IdY
	 Kn25Kp6pJmku8hNhBDOF5X+W9ksrhw4H2Oyh3KIrsW07xzlMiFGjku+sVNVJym9DJU
	 TDGecbNFbAB1OCHRnr/jFgl/iGSwMSkS8ShKnr1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfICNgj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICNgj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 09:36:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928A023431;
        Tue,  3 Sep 2019 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567517798;
        bh=SoPdV2nnitLnCHq2v4W6UN5gpR7xY/IyZscELKgSZ6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U34tvm44XHJtwXnEdFuY9QQRQLMsWfdlPnOWfbR98z1+OXYRffX9RrHPnssJoZwfj
         8iIiuUTiFQAgsX1VuWqCw+J0VJdSjX6TsaVC0dHbD1o5RX3iwTQ8Aib+nrHtlG5hhS
         L3YrUHkAScOpN2lNqfpXCTIMF60PDOaiwojizZzc=
Date:   Tue, 3 Sep 2019 15:36:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of new device support, cleanups etc for IIO in
 the 5.4 cycle.
Message-ID: <20190903133635.GA8987@kroah.com>
References: <20190827220843.4462651e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827220843.4462651e@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 27, 2019 at 10:08:43PM +0100, Jonathan Cameron wrote:
> The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> 
>   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b

Looks like commit e77b014217ff ("iio: cros_ec: set calibscale for 3d
MEMS to unit vector") was not signed-off-by you, yet you committed it :(

Can you fix this up and add that one other patch to the tree and resend
the pull request?

thanks,

greg k-h
