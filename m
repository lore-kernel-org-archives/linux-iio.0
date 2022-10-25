Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A58C04A95
	for <linux-iio@archiver.kernel.org>; Tue, 25 Oct 2022 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJYRJ4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYRJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2022 13:09:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B339DDA8
        for <linux-iio@vger.kernel.org>; Tue, 25 Oct 2022 10:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C6C4CE1E03
        for <linux-iio@vger.kernel.org>; Tue, 25 Oct 2022 17:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05434C433D6;
        Tue, 25 Oct 2022 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666717789;
        bh=91EEXZ4WGiTzaUBPEytJUG/bQKt2k10QR5aGR4H8DhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4M17dWbFBvxONb45YeYiGleqsEsVWGEES3RbXfTqetHwyt4ePFaaviE6RYzOr/YI
         pshqv7U8gfyn6q6lEwOtpY1vviSI0mh8w4QL/t53VtZ07Kc471sfxCO+wU9b9LIoCZ
         8S2QDUrzdBPhnug0vKiGmpjwyMlGjXGangX50260=
Date:   Tue, 25 Oct 2022 19:09:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter fixes for 6.1 cycle
Message-ID: <Y1gYU7roknYVP8sA@kroah.com>
References: <Y1bBTQTBCrR/hUqQ@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1bBTQTBCrR/hUqQ@ishi>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 12:46:05PM -0400, William Breathitt Gray wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.1a

Pulled and pushed out, thanks.

greg k-h
