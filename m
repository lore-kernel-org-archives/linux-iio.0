Return-Path: <SRS0=lja0=QU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62234C282CE
	for <linux-iio@archiver.kernel.org>; Wed, 13 Feb 2019 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AE1222C2
	for <linux-iio@archiver.kernel.org>; Wed, 13 Feb 2019 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550042822;
	bh=dvPzqkIPsQ4y3W2ec2AsKHs3c6sh3GSp24vMHYp6fUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TpWple+PXTIJ/mF89av+ThnLgwieIKU0Nwq/yEbayVTn4+1z5ZdO3b8iNFRwylKZr
	 InRgcnYzN677PfrGngrXSfuGEqSZQ2RVYpgCmpQmpCGAl2UQtspPbC2SFKumXAYpiM
	 IRdBO3FKrQPcDYU9DDqTuVNtl5H0qoShVMcFJxNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfBMH1B (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbfBMH1B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Feb 2019 02:27:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4392222C2;
        Wed, 13 Feb 2019 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550042821;
        bh=dvPzqkIPsQ4y3W2ec2AsKHs3c6sh3GSp24vMHYp6fUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNW188HmGgaIZivDVGlPbyyUVTKjBd6ucwsBsspTRnmpMQqB5hxO6q2ytKOdQTxXI
         58+5hLkQrUmPZHP0ANI9DrBvWnr64AsdvJz9A5a2qJiR5+CFSIQTjNm5VY7BOLLMG5
         OIHE3k67SYJXq9sGgB+hYeIoSR3C+qqDSUKtmAZc=
Date:   Wed, 13 Feb 2019 08:26:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO second set of new device support, cleanups and
 features for the 5.1 cycle.
Message-ID: <20190213072600.GB10225@kroah.com>
References: <20190212211510.5707e70f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212211510.5707e70f@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 12, 2019 at 09:15:10PM +0000, Jonathan Cameron wrote:
> The following changes since commit c2f4dd4364b71ef4eb43925b402377aefe9c1ca0:
> 
>   staging: wlan-ng: formatting change in cfg80211.c (2019-02-08 10:31:14 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.1b

Pulled and pushed out, thanks.

greg k-h
