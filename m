Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99CC636D7
	for <linux-iio@archiver.kernel.org>; Tue, 31 Jan 2023 12:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAaMCf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAaMCf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:02:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B21CADD
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 04:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED019B81BE0
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 12:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F6C433D2;
        Tue, 31 Jan 2023 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675166551;
        bh=4pglpT3uErUjn4AT5U+kzveukXH74LByZCN6H7xvBo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijpg34JYdo4u9br2EGgkjPC1KiASxCuGN+ZIUir2GTW48G3pYn7/5t08Flwz5CcKt
         1PKAsQ4Hx8Q6WNeg/pSR8v5XYrY9Q8nJbaAJTAqqS240V/WDarpbuwj3BY/XPb/TX/
         ZwR40rLEoI2ApAJPgMH9Ku0W6wN39ERn+Bz4VJLY=
Date:   Tue, 31 Jan 2023 13:02:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: Re: First set of Counter updates for the 6.3 cycle
Message-ID: <Y9kDVVi3uhczE1U8@kroah.com>
References: <Y9kAHziPNDke+LS4@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kAHziPNDke+LS4@ishi>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 06:48:47AM -0500, William Breathitt Gray wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.3a

Pulled and pushed out, thanks.

greg k-h
