Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2AC7619A
	for <linux-iio@archiver.kernel.org>; Wed, 12 Apr 2023 07:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLHsT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDLHsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Apr 2023 03:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3BB1FEB
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 00:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B2AD616C2
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 07:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4904FC433EF;
        Wed, 12 Apr 2023 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681285696;
        bh=uw5ODsEGbRZwcQbKSKCQ9ZbMtGvKqaAgUW30GWMvSpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACIZqlvC7x3I6U9HJy/DhoJrI6yasebA8+sEqIKAtxlu9nnEasbaiTOBCCa2edpX1
         E+4s63YtT1CIopocajW0cz6bA11wqQvBTbjoE3a00AnQQkvcY7CPlf5/aPSglBkkTW
         rcd8Z8PF4nlFYjRLR2QiulqHalq+kg4tmQTNlEX8=
Date:   Wed, 12 Apr 2023 09:47:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanup
 for 6.4
Message-ID: <2023041210-munchkin-attention-8339@gregkh>
References: <20230411183206.6490be47@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411183206.6490be47@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 11, 2023 at 06:32:06PM +0100, Jonathan Cameron wrote:
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.4a

Pulled and pushed out, thanks,

greg k-h
