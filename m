Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D5C4338F
	for <linux-iio@archiver.kernel.org>; Sun, 15 Aug 2021 06:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259B961042
	for <linux-iio@archiver.kernel.org>; Sun, 15 Aug 2021 06:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhHOGew (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Aug 2021 02:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhHOGew (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 02:34:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18EF4604AC;
        Sun, 15 Aug 2021 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629009262;
        bh=avbH21Z6Un7290nhkxWHRoXY3PjrArOaCjkwcJ2o6qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltkFxJUctCLoxAeeYC/ayGntiqnWKTlCA7V2kAiMAL/f+uhM8+eTg55VokplF4rn9
         qiCGAnac3Pyp23nqMda+o4Tu8AFreeH8BWx+0WlwsujoOklCmrOji/ARB4dsrvjhIg
         RV8fTu6uXw/qlNoO0UgD/u1qKGDlbWsTTNMQ8ymA=
Date:   Sun, 15 Aug 2021 08:32:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO + counter new device support, cleanups etc
 for 5.15
Message-ID: <YRi1FJjh5nHA3HBM@kroah.com>
References: <20210814181547.5f3471ec@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814181547.5f3471ec@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 14, 2021 at 06:15:47PM +0100, Jonathan Cameron wrote:
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.15a

Pulled and pushed out, thanks.

greg k-h
