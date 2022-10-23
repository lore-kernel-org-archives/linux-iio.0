Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C61ECAAA1
	for <linux-iio@archiver.kernel.org>; Sun, 23 Oct 2022 16:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJWQHL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 23 Oct 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJWQHK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 12:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A068CC1
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 09:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54B8DB80DB3
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 16:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5ECC433C1;
        Sun, 23 Oct 2022 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666541226;
        bh=6ArfMQ4J5EpVQ7knNnCEzMmKaxJijvnld/Kv9UpbgDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgmApSe+5aCLTumwEem5skQsjq6Ira563i6W0r8Cey4svSEdpmODGmn/+EaaQ3LXS
         O2dBQj56/ZGgd/29bwu9oBhwhGvwKx6zCKo6YZdNkaiZVlfOie99aEbwlyF+BMrap/
         7talNJ8AHmJ6VEKxcVGtuBRfVSQ5+BeQ3/jM6jtk=
Date:   Sun, 23 Oct 2022 18:06:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 6.1
Message-ID: <Y1VmhTISH3ZzTyKo@kroah.com>
References: <20221023115848.148744b1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023115848.148744b1@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 23, 2022 at 11:58:48AM +0100, Jonathan Cameron wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1a

Pulled and pushed out, thanks.

greg k-h
