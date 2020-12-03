Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FDDC4361A
	for <linux-iio@archiver.kernel.org>; Thu,  3 Dec 2020 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00148207D0
	for <linux-iio@archiver.kernel.org>; Thu,  3 Dec 2020 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLCSUE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgLCSUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Dec 2020 13:20:03 -0500
Date:   Thu, 3 Dec 2020 19:20:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607019563;
        bh=eEnEl6D0C7XrIpGhtgP19HiKoBPYk2QWxRJg2ZES1sA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=wN0ywvyVb35c1yrg3UF92oR+WoZN6jzk6b3rsTMsF9yXQmJKWmHbKBrLELeq7CGhk
         40TZSRSam+rEfiFpBgYtwB1eFiydBJua2vPsVhMjb9KcF1Zyd400eoKbf6jcVSCfDh
         mP1rhWi0KFVgMB4/kmOjIovKyV3AgznNzolNcxvk=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO new device support, cleanups and yaml
 conversions for the 5.11 cycle
Message-ID: <X8ksbapSAzhum4V6@kroah.com>
References: <20201202130752.530970c6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202130752.530970c6@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 02, 2020 at 01:07:52PM +0000, Jonathan Cameron wrote:
> The following changes since commit 749c1e1481e1d242ded9dd1bf210ddb7c0d22a4f:
> 
>   Merge tag 'iio-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-11-24 08:30:08 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.11b

I get the following errors when pulling this.  You seem to have not
signed off on two patches:

Commit 474830eb350d ("dt-bindings:iio:adc:remove atmel, adc-res and atmel, adc-res-names")
	committer Signed-off-by missing
	author email:    alexandre.belloni@bootlin.com
	committer email: Jonathan.Cameron@huawei.com
	Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Commit 38829b4e5a07 ("iio: adc: ad7298: check regulator for null in ad7298_get_ref_voltage()")
	committer Signed-off-by missing
	author email:    alexandru.ardelean@analog.com
	committer email: Jonathan.Cameron@huawei.com
	Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

If I took these, you would get the same warnings from linux-next, but
without the ability to fix them up :(

thanks,

greg k-h
