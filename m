Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E570AC2B9F4
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6970610A5
	for <linux-iio@archiver.kernel.org>; Thu, 17 Jun 2021 16:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhFQQ1R (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFQQ1R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Jun 2021 12:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 667D2613BF;
        Thu, 17 Jun 2021 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623947109;
        bh=SOokfpvzeq9a9JZcSQ7HkRJOupZR/QJlnXw139mXBgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnUcahgfaAyA64qwdXfgbYJ0FPwTV+oD6E2i4qydi65ItwnQ2g0ml1jiqes2W0hXv
         MVqASdqBH7ux7/rUQ0RMj7sz0JWljo5HJ2ovAOcrXsFvHVah6OputZh7iOrVbtOzdm
         wlG7oetJXKc3zKsDk8Hyn9uNwZ+1A/j4+3HWdgq0=
Date:   Thu, 17 Jun 2021 18:24:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO and Counter features, cleanups etc for the
 5.14 cycle.
Message-ID: <YMt3QuRzE9dRPgu2@kroah.com>
References: <20210617153132.495691a1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617153132.495691a1@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 17, 2021 at 03:31:32PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6771fb0b940eb74f1a68fe3f180a7668103397d3:
> 
>   Merge tag 'iio-for-5.14a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-06-09 12:11:49 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.14b

Pulled and pushed out, thanks.

greg k-h
