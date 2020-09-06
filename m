Return-Path: <SRS0=IeKv=CP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B3C433E2
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551E520759
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599404178;
	bh=23EIjwEgqGfq8Ev5GaDBcL6pb5NE3FNHLLXEY8pI8aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rmxHKKfu1weitgm3eOcQyRCG4KTvHwYtXgfKAY3iPVPS/L6I6jZEzJSFCGhbmg/gM
	 pggWt7RmJ5n77E6D0jvP7eAd3HxDfhNGDVQyvMxMRTsHq7FOQpq4CJRzjSJkzhWtGV
	 lkxAwE8rfVeYf6NrKgrmWELDAZahsREAluC/tEL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIFO4R (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFO4M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:56:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EACD320714;
        Sun,  6 Sep 2020 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599404172;
        bh=23EIjwEgqGfq8Ev5GaDBcL6pb5NE3FNHLLXEY8pI8aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeiBgu+M2bDRqOVYTSJAvdpJ4gZk3++1rhcot4PfXduIZhmcWs9R1YZ2ocIl4AXCU
         hY7a1ECd6Y9d9ut6c/jZwhW1lAtNt2ymioXHd0cFdXHJObMDmN9/19aqYVW11S5uaZ
         rXoYRicZ/jWzWCy2/KO5w6CQE3T9Eoq7DuFynlGI=
Date:   Sun, 6 Sep 2020 16:56:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support etc for the 5.10
 cycle
Message-ID: <20200906145628.GA290336@kroah.com>
References: <20200906133958.6fec0a17@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906133958.6fec0a17@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 06, 2020 at 01:39:58PM +0100, Jonathan Cameron wrote:
> The following changes since commit bc752d2f345bf55d71b3422a6a24890ea03168dc:
> 
>   staging: hikey9xx: Kconfig: add regulator dependency (2020-08-18 19:15:47 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10a

Pulled and pushed out, thanks.

greg k-h
