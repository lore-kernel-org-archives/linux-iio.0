Return-Path: <SRS0=ud0C=5H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1A5C4332B
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611A620736
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584900527;
	bh=Z6+DFLpmI8qPusJHwHdtho2a8EPAJFkPxfNDWfgMXaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D2lHElu6Xlw+L4lw0A6htDgQJCknNlSzcEhNaxZLUFUEdlXCo0hZ+COCSMOEAciEJ
	 4KfdFiqkiMLEbeIJyFl9lZu0gPQe4Yfu7WZUEe8jyka+KYXLAkMd+4/O1jokSkUujj
	 gxwJZdNxPInn/5FJy3T/j9cZVi23fcQFydEWd0XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCVSIq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgCVSIq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 14:08:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7822072E;
        Sun, 22 Mar 2020 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584900526;
        bh=Z6+DFLpmI8qPusJHwHdtho2a8EPAJFkPxfNDWfgMXaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZUZHrixWittUIbVT/4E3Rt1bjtOXYKBNzj4bvKJa+Wm4yUBbHrPEZ2udZSM0PzA1s
         IkwPc1y1tUp0PSNXK8f4eGQSgjWoWApM7Tl1V9ka5Fqe0h+SOjVoXbiDMY+05sDrv2
         DjCfDcxNsaFqZb+NLRDSsH60VpMQFE/zntdMXcww=
Date:   Sun, 22 Mar 2020 18:08:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: tsl2772: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200322180842.3a796160@archlinux>
In-Reply-To: <20200316162026.GB1526@onstation.org>
References: <20200316124941.8010-1-tiwai@suse.de>
        <20200316124941.8010-3-tiwai@suse.de>
        <20200316162026.GB1526@onstation.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 12:20:26 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Mon, Mar 16, 2020 at 01:49:41PM +0100, Takashi Iwai wrote:
> > snprintf() is a hard-to-use function, it's especially difficult to use
> > it for concatenating substrings in a buffer with a limited size.
> > Since snprintf() returns the would-be-output size, not the actual
> > size, the subsequent use of snprintf() may go beyond the given limit
> > easily.  Although the current code doesn't actually overflow the
> > buffer, it's an incorrect usage.
> > 
> > This patch replaces such snprintf() calls with a safer version,
> > scnprintf().
> > 
> > Also this fixes the incorrect argument of the buffer limit size passed
> > to snprintf(), too.  The size has to be decremented for the remaining
> > length.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>  
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>
Applied.  Thanks for sorting this out.

Jonathan

