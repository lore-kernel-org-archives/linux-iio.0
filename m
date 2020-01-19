Return-Path: <SRS0=bPBV=3I=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C1CC33CB1
	for <linux-iio@archiver.kernel.org>; Sun, 19 Jan 2020 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F06206D7
	for <linux-iio@archiver.kernel.org>; Sun, 19 Jan 2020 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579442527;
	bh=kLIsjqeQy/pjqylz2DCA6bu9V1trUyO8J/mxrZgumrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YKUz9PvQucdBlRtJhWAC0s11w7V3NgAWOR27rr20ZLrjxnUBd+wDBk72TpiA/GUg9
	 B/L1aUFoZo8XcT79UfTqIorIOJInK4cU7cbWeum5HMxNpN5w0To9CemCyEJgiM1mS+
	 DkHXMXb8xqNxx/3BL9YfPph21nXtVaDSQzF0ob5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgASOCH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASOCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Jan 2020 09:02:07 -0500
Received: from localhost (unknown [84.241.197.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA2D206D7;
        Sun, 19 Jan 2020 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579442526;
        bh=kLIsjqeQy/pjqylz2DCA6bu9V1trUyO8J/mxrZgumrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZU1wpQbPY1ZpjYkAbOSJ15ufDUnt2v66EM2+ENYvTxZzlAeetObGWmVKbb9YLJlkH
         09oeRdFBSr8t2EILYKPkC/P5tMtgTvVXms2st2EgCJekLzgTbhKy4eRZsOQUFhfktt
         bsBbPqJB4eOAt+S4HF4t0CtfFr9mLL9MosCMOtVc=
Date:   Sun, 19 Jan 2020 15:01:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO new device support, cleanups and minor
 fixes for the 5.6 cycle.
Message-ID: <20200119140140.GA227931@kroah.com>
References: <20200118193627.2a384228@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118193627.2a384228@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 18, 2020 at 07:36:27PM +0000, Jonathan Cameron wrote:
> The following changes since commit e895bc1ebb31750f3baa74e074617d3cc5d0cee2:
> 
>   staging: vc04_services: remove header include path to vc04_services (2020-01-10 17:33:41 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.6b

PUlled and pushed out, thanks.

greg k-h
