Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F1C43217
	for <linux-iio@archiver.kernel.org>; Tue, 22 Nov 2022 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiKVRTj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKVRTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2022 12:19:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C386E576
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2022 09:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF06617CF
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2022 17:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E2C433C1;
        Tue, 22 Nov 2022 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669137577;
        bh=wj2n/ICourSvMDjGVAixlU7yEbmALDHxQjU36tMBA2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8iNjF6OKAlOi2omo0357MyL54n4/qE+tFircr201qCVz+yH+f7ZlThbcrVkZRE2+
         EcfoCkBke7SmsWhXgKrqWppOFIEEuFmNq0UWBGy+kzJoIF01UFqblu6PKB4nNhF0fP
         7XDmgmCHjuFYdM7g02uoKpEvwHhAvBNRchtHfiZ4=
Date:   Tue, 22 Nov 2022 18:19:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 3rd set of IIO fixes for 6.1
Message-ID: <Y30EjF22SC/wfpL/@kroah.com>
References: <20221116185610.4efb044b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116185610.4efb044b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 16, 2022 at 06:56:10PM +0000, Jonathan Cameron wrote:
> The following changes since commit 38e9f21f648ed3f9125fe09378da9b2eb08b12d9:
> 
>   Merge tag 'iio-fixes-for-6.1b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2022-11-05 11:29:29 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1c

Pulled and pushed out, thanks.

greg k-h
