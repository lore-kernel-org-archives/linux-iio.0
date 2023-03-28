Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE79C761A6
	for <linux-iio@archiver.kernel.org>; Tue, 28 Mar 2023 11:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjC1LcN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Mar 2023 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjC1LcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 07:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379483D9
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 04:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0DB6616D5
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 11:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F8C433EF;
        Tue, 28 Mar 2023 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680003124;
        bh=IwQ2/xx9g4/k5ebXRLk4/W7Lje5FHqaomC8MC0WDTGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLAM2kK7zYmuPZMV8BSQ0kQhcEauryNdu5GeFO75QY5lFS/3mIxs5m2CHtPFxt4rE
         XAzNf2EO++11MM0PCFelarHZYq2H4j0RtWC/4emeic9LqgcREsRnYTJg6/lCh/Aab0
         8JF7oAIteZeAWAGRva6h1AQJ7+AsJSh8IeeMELlo=
Date:   Tue, 28 Mar 2023 13:31:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 6.3 - set 1
Message-ID: <ZCLQGsx8hAzxYEnv@kroah.com>
References: <20230326181442.3475d522@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326181442.3475d522@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 26, 2023 at 06:14:42PM +0100, Jonathan Cameron wrote:
> The following changes since commit 2acd031347f645871959a799238a7caf6803aa18:
> 
>   iio: imu: fxos8700: fix MAGN sensor scale and unit (2023-01-21 18:15:19 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.3a

Pulled and pushed out, thanks.

greg k-h
