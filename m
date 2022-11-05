Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A915C4332F
	for <linux-iio@archiver.kernel.org>; Sat,  5 Nov 2022 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKEKeC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Nov 2022 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEKeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2022 06:34:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17922AE38
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 03:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE2CB81CD0
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 10:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C2FC433C1;
        Sat,  5 Nov 2022 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667644438;
        bh=vMYnruqEdgWjNnd6vRwSLtRSM8OKwWWHoVOZOJFV+EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0WDKpyaKG4xdTHSTTWLOoizIrqQ8m6pZq6M8wbCv2GDlP/Ll2ucA9NAOt0G9Z5v6
         Sbj7b/Ky3776ATHH4k6lmqEz3Aww0O/P3JCvwQUDEmZagbN2uCtdWnidmmtO8GXA+7
         wU8ulp93MtBDU2ZzDPYE5ZgfYewfngqcZaH602Rs=
Date:   Sat, 5 Nov 2022 11:33:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for 6.1
Message-ID: <Y2Y8E68DhSGRy+xo@kroah.com>
References: <20221103211016.1ddd0e9b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103211016.1ddd0e9b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 03, 2022 at 09:10:16PM +0000, Jonathan Cameron wrote:
> The following changes since commit d76308f03ee1574b0deffde45604252a51c77f6d:
> 
>   Revert "coresight: cti: Fix hang in cti_disable_hw()" (2022-10-24 08:33:45 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.1b
> 
> for you to fetch changes up to 7c919b619bcc68158921b1bd968f0e704549bbb6:
> 
>   tools: iio: iio_generic_buffer: Fix read size (2022-11-01 08:48:13 +0000)

Pulled and pushed out.

thanks,

greg k-h
