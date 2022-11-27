Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7526C4332F
	for <linux-iio@archiver.kernel.org>; Sun, 27 Nov 2022 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiK0OEX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK0OEV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2022 09:04:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB551004E
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 06:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2514360CBA
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 14:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F324C433D6;
        Sun, 27 Nov 2022 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669557855;
        bh=HKdiX6HWCoSlT4+tWZoGhXfpFaAY3rn0DKnTw1eoDJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQQzj0BpbAjszCCTQMa10I9ZlZJM352GyagVpLymVzf73LIRTEbHYFiJyB9h9GTBS
         0aTqVhw1GI1YHnRtHZXbAIIEHS+YJUbzYcSaSZFTejRg8+lH0GmcwV4Jz0VjCDrpZ0
         ucCKCCvKknpKJ9v8buevHlu1t19cxz1qUmWUjjks=
Date:   Sun, 27 Nov 2022 15:02:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 4th set of IIO fixes for 6.1
Message-ID: <Y4Nt/XrG/2jM9UWv@kroah.com>
References: <20221126183721.0fad0779@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126183721.0fad0779@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 26, 2022 at 06:37:21PM +0000, Jonathan Cameron wrote:
> The following changes since commit 398e3479874f381cca8726ca5d8a31e1bf35a3cd:
> 
>   dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid" (2022-11-14 20:20:19 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1d
> 
> for you to fetch changes up to 86fdd15e10e404e70ecb2a3bff24d70356d42b36:
> 
>   iio: fix memory leak in iio_device_register_eventset() (2022-11-16 19:14:37 +0000)
> 
> ----------------------------------------------------------------
> 4th set of IIO fixes for 6.1
> 
> Single patch fixing a memory leak in an error path.
> Fine to queue either for 6.2 if too late for 6.1

This just missed my "hopefully last" pull request to Linus for this
branch, so I'll take it into my queue for 6.2-rc1, thanks.

greg k-h
