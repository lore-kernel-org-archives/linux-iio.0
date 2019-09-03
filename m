Return-Path: <SRS0=n2n1=W6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB56C3A5A2
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85144206BB
	for <linux-iio@archiver.kernel.org>; Tue,  3 Sep 2019 19:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567538199;
	bh=/yxZfPbfLHVlei/fiDAgGoUH0Ava9r84Fp4rg/KVgg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b1tZtaGY4f23IqvDGzaYTaTyVlKIRp9T3IH0bpVQ/hUoF41G0noxwD1GIA7UMtpyH
	 cRLmIDtv6Tx+Xdg7M501TUhHpFeuGLMDeaQrI24WEFT2w0sN0fuFxK4eat0g129wyK
	 b8oUQLkm78h7rRgqC98Uu80nL9qVfQzOEZVsMzkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfICTQj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfICTQi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 15:16:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7847A206BB;
        Tue,  3 Sep 2019 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567538198;
        bh=/yxZfPbfLHVlei/fiDAgGoUH0Ava9r84Fp4rg/KVgg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNslWif4TuBoE8XlRKJT1K2K4/EYxRO+FaatzzFDzZV9T9NycyDc/624BggdpJLB5
         0xs0x63Aao6ZJW2LZ0bRNM5N9lQHqTuqX7nN2FDGHA8pKaY2ULtqJ5yuPJ31zMUAIO
         HwYo23ArlUB66iHUL/mJojWzFJfBlT52vsnNY1as=
Date:   Tue, 3 Sep 2019 21:16:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] Second set of new device support, cleanups etc for IIO
 in the 5.4 cycle.
Message-ID: <20190903191635.GA27105@kroah.com>
References: <20190903193624.170e3c34@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903193624.170e3c34@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 03, 2019 at 07:36:24PM +0100, Jonathan Cameron wrote:
> The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> 
>   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take2

So close, I now have this error:

In commit
  9d8568e3d496 ("iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1")

Fixes tag
  Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")

has these problem(s):
  - Target SHA1 does not exist


Third try?
